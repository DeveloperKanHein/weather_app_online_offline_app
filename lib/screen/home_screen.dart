import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/extensions/uc_first.dart';
import 'package:weather_app/screen/notification/screen/notification_screen.dart';
import 'package:weather_app/service/notification_services.dart';
import 'package:page_transition/page_transition.dart';
import '../bloc/weather_bloc.dart';
import '../service/firestore_service.dart';
import '../service/get_device_token.dart';
import '../widgets/image_widget_builder.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final notificationService = NotificationServices();
  final fireStoreService = FireStoreService();
  final _bloc = WeatherBloc();
  final search = TextEditingController();


  Future<void> setup() async {
    String token = await getDeviceToken();
    await fireStoreService.checkToken(token: token);
    await notificationService.setup();
}

  final OutlineInputBorder inputBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(color: Colors.white, width: 1),
  );

  @override
  void initState() {
    super.initState();
    _bloc.add(GetWeatherData(location: "Mandalay"));
    setup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 30, right: 30),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: search,
                      onSubmitted: (val) {
                        _bloc.add(GetWeatherData(location: search.text));
                      },
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                            onTap: () {
                              _bloc.add(GetWeatherData(location: search.text));
                            },
                            child: const Icon(Icons.search)),
                        hintText: "Search city",
                        filled: true,
                        fillColor: Colors.white,
                        border: inputBorder,
                        focusedBorder: inputBorder,
                        enabledBorder: inputBorder,
                        disabledBorder: inputBorder,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  InkWell(
                      onTap: () async {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: const NotificationScreen(),
                                duration: const Duration(microseconds: 500)
                            ));
                      },
                      child: const Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: 28,
                      )),
                ],
              ),
            ),
            Expanded(
              child: BlocProvider(
                create: (_) => _bloc,
                child: BlocListener<WeatherBloc, WeatherState>(
                  listener: (context, state) {
                    //
                  },
                  child: BlocBuilder<WeatherBloc, WeatherState>(
                    builder: (context, state) {
                      if (state is WeatherLoading) {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.white,),
                        );
                      } else if (state is WeatherEmpty) {
                        return const Center(child: Text("Empty Data!"));
                      } else if (state is WeatherError) {
                        return const Center(child: Text("Network Error :("));
                      } else if (state is WeatherLoaded) {
                        final weather = state.weather;
                        return ListView(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 50),
                          physics: const BouncingScrollPhysics(),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
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
                                            weather.location!.name!
                                                .ucFirst(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 24),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        "${weather.current!.tempC!}° C",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 40),
                                      ),
                                    ],
                                  ),
                                  state.isOnLine
                                      ? Image.network(
                                    "https:${weather.current!.condition!.icon!}",
                                    //weather.current!.condition!.icon!
                                    scale: 0.6,
                                  )
                                      : Image.file(File(weather
                                      .current!.condition!.icon!)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 50.0, top: 50),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {

                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType.rightToLeft,
                                              child: DetailScreen(weather: weather, isOnLine: state.isOnLine),
                                              duration: const Duration(microseconds: 500)
                                          ));
                                    },
                                    child: Container(
                                      width: 150,
                                      height: 50,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "View Detail",
                                            style: TextStyle(
                                                color: Colors.grey[600]!,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          const SizedBox(width: 8),
                                          const Icon(Icons.arrow_forward,
                                              color: Colors.grey)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(
                                  left: 30, right: 30, bottom: 50),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                              ),
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  for (var forecastDay
                                  in weather.forecast!.forecastDays!)
                                    ListTile(
                                      leading: imageWidgetBuilder(isOnline: state.isOnLine, link: forecastDay.day!.condition!.icon!),
                                      title: Text(
                                        DateFormat('EEEE').format(
                                            DateTime.parse(forecastDay.date!)),
                                      ),
                                      subtitle: Text(
                                          forecastDay.day!.condition!.text!),
                                      trailing: Column(
                                        children: [
                                          Text(
                                              "${forecastDay.day!.avgTempC}°C"),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              "${forecastDay.day!.avgTempF}°F"),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
