part of 'update_user_info_bloc.dart';

abstract class UpdateUserInfoEvent extends Equatable {
  const UpdateUserInfoEvent();

  @override
  List<Object> get props => [];
}

class UploadPicutre extends UpdateUserInfoEvent {
  final String file;
  final String userId;

  const UploadPicutre(this.file, this.userId);

  @override
  List<Object> get props => [file, userId];
}
