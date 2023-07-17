part of 'noti_bloc.dart';

abstract class NotiState extends Equatable
{
  @override
  List<Object> get props => [];
}

class NotiLoading extends NotiState
{
  //
}

class NotiLoaded extends NotiState
{
  final List<Notification> notis;
  NotiLoaded({ required this.notis });
}

class NotiEmpty extends NotiState
{
  //
}

class NotiError extends NotiState
{
  //
}