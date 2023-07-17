import 'dart:io';

import 'package:flutter/material.dart';
import 'package:weather_app/extensions/uc_first.dart';
import 'package:weather_app/widgets/image_widget_builder.dart';

import '../database/save_to_local_db.dart';
import '../model/weather_model.dart';
import '../widgets/alert_dialog_box.dart';

class DetailScreen extends StatefulWidget {
  final WeatherModel weather;
  final bool isOnLine;

  const DetailScreen({Key? key, required this.weather, required this.isOnLine})
      : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late WeatherModel weather;

  @override
  void initState() {
    super.initState();
    weather = widget.weather;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(weather.location!.country!),
        centerTitle: true,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: InkWell(
                onTap: () {
                  showFavAlertBox(
                    context: context,
                    onPressedSaved: () {
                      showLoading(context: context);
                      saveToLocalDB(weather).then((isCompleted) {
                        if (isCompleted) {
                          Navigator.pop(context);
                        }
                      });
                    },
                  );
                },
                child: const Icon(Icons.favorite, color: Colors.white)),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          // padding: const EdgeInsets.only(
          //     left: 30, right: 30, top: 20),
          // physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 20, bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_sharp,
                            color: Colors.amber,
                            size: 28,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            weather.location!.name!.ucFirst(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 24),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${weather.current!.tempC!}° C",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 40),
                      ),
                    ],
                  ),
                  widget.isOnLine
                      ? Image.network(
                          "https:${weather.current!.condition!.icon!}",
                          //weather.current!.condition!.icon!
                          scale: 0.6,
                        )
                      : Image.file(File(weather.current!.condition!.icon!)),
                ],
              ),
            ),
            Expanded(
                child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (int i = 0;
                      i < weather.forecast!.forecastDays!.length;
                      i++)
                    Expanded(
                      flex: 3,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount:
                              weather.forecast!.forecastDays![i].hours!.length,
                          itemBuilder: (context, int index) {
                            var hour = weather
                                .forecast!.forecastDays![i].hours![index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6.0),
                              child: Column(
                                children: [
                                  Text("${hour.tempC}°C",
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text("${hour.tempF}°F",
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  imageWidgetBuilder(
                                      isOnline: widget.isOnLine,
                                      link: hour.condition!.icon!),
                                  Text(hour.time ?? "",
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
