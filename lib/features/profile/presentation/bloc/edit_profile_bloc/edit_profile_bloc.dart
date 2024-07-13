import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborly_flutter_app/features/profile/domain/usecases/edit_profile_usecase.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final EditProfileUsecase _editProfileUsecase;

  EditProfileBloc({required EditProfileUsecase editProfileUsecase})
      : _editProfileUsecase = editProfileUsecase,
        super(EditProfileInitialState()) {
    on<EditProfileButtonPressedEvent>((EditProfileButtonPressedEvent event,
        Emitter<EditProfileState> emit) async {
      emit(EditProfileLoadingState());

      final result = await _editProfileUsecase.call(
          username: event.username,
          gender: event.gender,
          // homeCoordinates: event.homeCoordinates,
          bio: event.bio,
          image: event.image);

      result.fold(
          (error) => emit(EditProfileFailureState(error: error.toString())),
          (response) => emit(EditProfileSuccessState()));
    });
  }
}