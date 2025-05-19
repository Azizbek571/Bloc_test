import 'package:bloc_projects/bloc/counter_event.dart';
import 'package:bloc_projects/bloc/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc()  : super (CounterState(count: 0)){
    on<CounterIncrementEvent>((event, emit)=> emit(CounterState(count: state.count + 1)));
    on<CounterDecrementEvent>((event, emit)=> emit(CounterState(count: state.count - 1)));
  }
  // @override
  // void onChange(Change<CounterState> change) {
  //   // TODO: implement onChange
  //   super.onChange(change);
  //   print(change.currentState.count.toString());
  //   print(change.nextState.count.toString());
  // }

  // @override
  // void onTransition(Transition<CounterEvent, CounterState> transition) {
  //   // TODO: implement onTransition
  //   super.onTransition(transition);
  //   print(transition.toString());
  // }
  // @override
  // void onError(Object error, StackTrace stackTrace) {
  //   // TODO: implement onError
  //   super.onError(error, stackTrace);
  //   print(error.toString());
  // }
  // @override
  // void onEvent(CounterEvent event) {
  //   // TODO: implement onEvent
  //   super.onEvent(event);
  //   print(event.toString());
  // }
}