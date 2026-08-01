part of 'auth_cubit.dart';

class AuthState extends Equatable {
  //step1 -->> class's variables :
  final bool isLoading;
  final String? errorMessage;

  //step2 -->> Constructor :
  const AuthState({this.isLoading = false, this.errorMessage});

  //step3 -->> create copy function :
  AuthState copyWith({bool? isLoading, String? errorMessage}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  //step4 -->> use Equatable :
  @override
  List<Object?> get props => [isLoading, errorMessage];
}
