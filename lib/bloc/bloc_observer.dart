import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBlocObserver extends BlocObserver with ChangeNotifier{

  @override
  void onEvent(Bloc bloc, Object? event) {
    // TODO: implement onEvent
    debugPrint("Bloc Event ==> ${bloc.runtimeType}, $event");
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    // TODO: implement onChange
    debugPrint("Bloc Event ==> ${bloc.runtimeType}, $change");
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    // TODO: implement onTransition
    debugPrint("Bloc Event ==> ${bloc.runtimeType}, $transition");
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // TODO: implement onError
    debugPrint("Bloc Event ==> ${bloc.runtimeType}, $stackTrace");
    super.onError(bloc, error, stackTrace);
  }

}