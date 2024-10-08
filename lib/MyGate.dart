import 'package:objectbox/objectbox.dart';
@Entity()
class MyGate {
  @Id()
  int id;
  String name;
  String location;
  MyGate({this.id = 0, required this.name, required this.location});
}