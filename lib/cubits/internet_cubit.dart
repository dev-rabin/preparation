// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum InternetState {Initial, Lost, Gained}


class InternetCubit extends Cubit<InternetState>{
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? streamSubscription;

  InternetCubit() : super(InternetState.Initial){
    streamSubscription = _connectivity.onConnectivityChanged.listen((result) { 
      if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
        emit(InternetState.Gained);
      }else{
        emit(InternetState.Lost);
      }
    });
  }

  @override
  Future<void> close() {
    streamSubscription!.cancel();
    return super.close();
  }
}