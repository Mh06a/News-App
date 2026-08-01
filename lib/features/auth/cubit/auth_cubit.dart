import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/core/datasource/local_data/preferences_manager.dart';
import 'package:news_app/core/datasource/local_data/storage_key.dart';
import 'package:news_app/features/user/model/user_model.dart';
import 'package:news_app/features/user/repository/user_repository.dart';
import 'package:uuid/uuid.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  //step1 -->> class's variables :
  final UserRepository userRepository;
  final uuid = Uuid();

  AuthCubit(this.userRepository) : super(const AuthState());

  //step2 -->> create login function :
  Future<bool> login({required String email, required String password}) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final user = userRepository.login(email, password);

      if (user == null) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: "Incorrect email or password",
          ),
        );
        return false;
      }

      await PreferencesManager().setBool(StorageKey.isLoggedIn, true);

      await userRepository.setCurrentUser(user.userId);

      emit(state.copyWith(isLoading: false));

      return true;
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));

      return false;
    }
  }

  //step3 -->> create register function :
  Future<bool> register({
    required String userName,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      if (userRepository.emailExists(email)) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: "User already registered",
          ),
        );
        return false;
      }

      final user = UserModel(
        userId: uuid.v4(),
        userName: userName,
        email: email,
        password: password,
        countryName: null,
        countryCode: "",
        imagePath: null,
      );

      await userRepository.registerUser(user);
      await userRepository.setCurrentUser(user.userId);

      await PreferencesManager().setBool(StorageKey.isLoggedIn, true);

      emit(state.copyWith(isLoading: false));

      return true;
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));

      return false;
    }
  }

  //step4 -->> create checkLogin function :
  Future<bool> checkLogin() async {
    final isLoggedIn =
        PreferencesManager().getBool(StorageKey.isLoggedIn) ?? false;

    if (!isLoggedIn) return false;

    return userRepository.getCurrentUser() != null;
  }

  //step5 -->> create logout function :
  Future<void> logout() async {
    await userRepository.logout();
  }

  //step6 -->> create setError function :
  void setError(String message) {
    emit(state.copyWith(errorMessage: message));
  }

  //step7 -->> create clearError function :
  void clearError() {
    emit(state.copyWith(errorMessage: null));
  }
}
