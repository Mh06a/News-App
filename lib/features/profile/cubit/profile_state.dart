part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  //step1 -->> class's variables :
  final UserModel user;

  //step2 -->> Constructor :
  const ProfileState({
    this.user = const UserModel(
      userId: "",
      userName: "",
      email: "",
      password: "",
      countryName: "",
      countryCode: "",
      imagePath: null,
    ),
  });

  //step3 -->> create copy function :
  ProfileState copyWith({UserModel? user}) {
    return ProfileState(user: user ?? this.user);
  }

  //step4 -->> use Equatable
  @override
  List<Object?> get props => [user];
}
