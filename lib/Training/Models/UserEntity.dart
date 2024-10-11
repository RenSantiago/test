import 'package:objectbox/objectbox.dart';
@Entity()
class UserEntity {
  @Id()
  int id;
  String username;
  String email;
  String password;
  UserEntity({this.id = 0, required this.username, required this.email , required this.password});
}