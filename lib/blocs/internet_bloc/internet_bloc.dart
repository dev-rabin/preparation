import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preparation/blocs/internet_bloc/internet_events.dart';
import 'package:preparation/blocs/internet_bloc/internet_states.dart';

class InternetBloc extends Bloc<InternetEvents,InternetStates>{

  final Connectivity _connectivity = Connectivity();
  StreamSubscription? connectivitySubsription ;

  InternetBloc() : super(InternetInitialState()) {
    on<InternetLostEvent>((event, emit) => emit( InterLostState()));
    on<InternetGainedEvent>((event, emit) => emit(InternetGainedState()));

   connectivitySubsription = _connectivity.onConnectivityChanged.listen((result) { 
      if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
        add(InternetGainedEvent());
      } else {
        add(InternetLostEvent());
      }
    });
  }
  @override
  Future<void> close() {
   connectivitySubsription?.cancel();
    return super.close();
  }
}