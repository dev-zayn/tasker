import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'landing_event.dart';
part 'landing_state.dart';

class LandingBloc extends Bloc<LandingEvent, LandingState> {
  LandingBloc() : super(const LandingInitial(0)) {
    on<LandingEvent>((event, emit) {
      if (event is TabChangedEvent) {
        log('state is $state event is $event');
        emit(LandingInitial(event.index));
      }
    });
  }
}
