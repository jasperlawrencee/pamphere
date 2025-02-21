part of 'update_user_info_bloc.dart';

sealed class UpdateUserInfoState extends Equatable {
  const UpdateUserInfoState();

  @override
  List<Object> get props => [];
}

final class UpdateUserInfoInitial extends UpdateUserInfoState {}

class UploadPicutreFailure extends UpdateUserInfoState {}

class UploadPicutreLoading extends UpdateUserInfoState {}

class UploadPicutreSucess extends UpdateUserInfoState {
  final String userImage;

  const UploadPicutreSucess(this.userImage);

  @override
  List<Object> get props => [userImage];
}
