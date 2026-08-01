import 'package:hive/hive.dart';
import 'package:news_app/features/user/model/user_model.dart';

class UserAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0; // stable id for UserModel

  @override
  UserModel read(BinaryReader reader) {
    final userId = reader.readString();
    final userName = reader.readString();
    final email = reader.readString();
    final password = reader.readString();
    final countryName = reader.readString();
    final countryCode = reader.readString();
    final hasImage = reader.readBool();
    final imagePath = hasImage ? reader.readString() : null;

    return UserModel(
      userId: userId,
      userName: userName,
      email: email,
      password: password,
      countryName: countryName.isEmpty ? null : countryName,
      countryCode: countryCode,
      imagePath: imagePath,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer.writeString(obj.userId);
    writer.writeString(obj.userName);
    writer.writeString(obj.email);
    writer.writeString(obj.password);
    writer.writeString(obj.countryName ?? '');
    writer.writeString(obj.countryCode);
    if (obj.imagePath != null) {
      writer.writeBool(true);
      writer.writeString(obj.imagePath!);
    } else {
      writer.writeBool(false);
    }
  }
}
