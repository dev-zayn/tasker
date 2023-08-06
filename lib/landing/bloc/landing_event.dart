part of 'landing_bloc.dart';

abstract class LandingEvent extends Equatable {
  const LandingEvent();
}

class TabChangedEvent extends LandingEvent {
  final int index;
  const TabChangedEvent({required this.index});
  @override
  List<Object> get props => [index];
}
