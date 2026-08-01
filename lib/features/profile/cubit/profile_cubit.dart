import 'package:bloc/bloc.dart';
import 'package:country_picker/country_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/features/user/model/user_model.dart';
import 'package:news_app/features/user/repository/user_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  //step1 -->> class's variables :
  final UserRepository _userRepo;
  final ImagePicker _picker = ImagePicker();

  ProfileCubit(this._userRepo) : super(ProfileState());

  //step2 -->> init function :
  Future<void> init() async {
    await loadUserData();
  }

  //step3 -->> loadUserData function :
  Future<void> loadUserData() async {
    final stored = _userRepo.getCurrentUser();

    if (stored != null) {
      emit(state.copyWith(user: stored));
    }
  }

  //step4 -->> updateUser function :
  Future<void> updateUser({
    required String userName,
    required String email,
  }) async {
    final updatedUser = state.user.copyWith(userName: userName, email: email);

    await _userRepo.updateUser(updatedUser);

    emit(state.copyWith(user: updatedUser));
  }

  //step5 -->> changeCountry function :
  Future<void> changeCountry(Country country) async {
    final updatedUser = state.user.copyWith(
      countryName: country.name,
      countryCode: country.countryCode,
    );

    await _userRepo.updateUser(updatedUser);

    emit(state.copyWith(user: updatedUser));
  }

  //step6 -->> pickImage function :
  Future<void> pickImage(ImageSource source) async {
    final image = await _picker.pickImage(source: source);

    if (image == null) return;

    final updatedUser = state.user.copyWith(imagePath: image.path);

    await _userRepo.updateUser(updatedUser);

    emit(state.copyWith(user: updatedUser));
  }

  //step7 -->> logout function :
  Future<void> logout() async {
    await _userRepo.logout();
  }
}
