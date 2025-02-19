part of 'sign_up_bloc.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

final class SignUpInitial extends SignUpState {}

class SignupSuccess extends SignUpState {}

class SignupFailure extends SignUpState {}

class SignupProcess extends SignUpState {}
