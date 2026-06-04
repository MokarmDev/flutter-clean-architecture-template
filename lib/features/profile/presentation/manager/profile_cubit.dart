import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future<void> loadData() async {
    emit(ProfileLoading());
    // TODO: implement logic
    emit(ProfileLoaded());
  }
}
