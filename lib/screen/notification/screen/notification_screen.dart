
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/noti_bloc.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final _bloc = NotiBloc();
  @override
  void initState() {
    super.initState();
    _bloc.add(GetNotiEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text("Notifications"),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocProvider(
              create: (_) => _bloc,
              child: BlocListener<NotiBloc, NotiState>(
                listener: (context, state){
                  //
                },
                child: BlocBuilder<NotiBloc, NotiState>(
                  builder: (context, state){
                    if(state is NotiLoading){
                      return const Center(child: CircularProgressIndicator(),);
                    }else if(state is NotiEmpty){
                      return const Center(child: Text("Empty Data!"));
                    }else if(state is NotiError){
                      return const Center(child: Text("Network Error :("));
                    }else if(state is NotiLoaded){
                      final notis = state.notis;
                      print(notis[0].title);
                      return ListView.builder(
                          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10,),
                          physics: const BouncingScrollPhysics(),
                          itemCount: notis.length,
                          itemBuilder: (context, index){
                            return ListTile(
                              title: Text(notis[index].title ?? ""),
                              subtitle: Text(notis[index].body ?? ""),
                            );
                          });
                    }
                    return Container();
                  },
                ),
              ),
            ),
    );
  }
}
