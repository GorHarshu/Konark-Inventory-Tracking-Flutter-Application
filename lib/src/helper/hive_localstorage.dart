import 'package:hive/hive.dart';

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    return User(
      reader.readString(),
      reader.readString(),
      reader.readString(),
      reader.readString(),
      reader.readString(),
      reader.readString(),
      reader.readString(),
      reader.readString(),
      reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer.writeString(obj.userID);
    writer.writeString(obj.name);
    writer.writeString(obj.email);
    writer.writeString(obj.password);
    writer.writeString(obj.accestoken);
    writer.writeString(obj.whatsappNumber);
    writer.writeString(obj.empCode);
    writer.writeString(obj.role);
    writer.writeString(obj.roleId);
  }
}

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String userID;

  @HiveField(1)
  String name;

  @HiveField(2)
  String email;

  @HiveField(3)
  String password;

  @HiveField(4)
  String accestoken;

  @HiveField(5)
  String whatsappNumber;

  @HiveField(6)
  String empCode;

  @HiveField(7)
  String role;

  @HiveField(8)
  String roleId;

  User(
    this.userID,
    this.name,
    this.email,
    this.password,
    this.accestoken,
    this.whatsappNumber,
    this.empCode,
    this.role,
    this.roleId,
  );
}

Future<void> storeUserData(
  String userID,
  String name,
  String email,
  String password,
  String accestoken,
  String whatsappNumber,
  String empCode,
  String role,
  String roleId,
) async {
  final userBox = await Hive.openBox<User>('userBox');
  final user = User(
    userID,
    name,
    email,
    password,
    accestoken,
    whatsappNumber,
    empCode,
    role,
    roleId,
  );
  userBox.add(user);
}

Future<User?> getUserData() async {
  final userBox = await Hive.openBox<User>('userBox');
  if (userBox.isNotEmpty) {
    return userBox.getAt(0);
  }
  return null;
}

Future<void> logout() async {
  print("user data cleared");
  final userBox = await Hive.openBox<User>('userBox');
  await userBox.clear();
}
