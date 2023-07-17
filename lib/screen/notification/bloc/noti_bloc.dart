import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/service/firestore_service.dart';

import '../../../model/notification.dart';

part 'noti_event.dart';
part 'noti_state.dart';

class NotiBloc extends Bloc<NotiEvent, NotiState> {
  NotiBloc() : super(NotiLoading()) {
    final fireStore = FireStoreService();
    on<GetNotiEvent>((event, emit) async {
      try{
        emit(NotiLoading());
        final notis = await fireStore.getAllNoti();
        emit(NotiLoaded(notis: notis));
        if(notis.isEmpty)
        {
          emit(NotiEmpty());
        }
      }catch(e){
        emit(NotiError());
      }
    });
  }
}
