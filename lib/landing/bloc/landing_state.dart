part of 'landing_bloc.dart';

abstract class LandingState extends Equatable {
  final int index;
  const LandingState(this.index);
}

class LandingInitial extends LandingState {
  const LandingInitial(super.index);

  @override
  List<Object> get props => [index];
}
