import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testsampleproject/Models/UserFirestore.dart';

const String USER_COLLECTION_REF = 'users';

class UserFirestoreService {
  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference _usersRef;

  UserFirestoreService() {
    _usersRef = _firestore
        .collection(USER_COLLECTION_REF)
        .withConverter<UserFirestore>(
        fromFirestore: (snapshots , _) => UserFirestore.fromJson(snapshots.data()!),
        toFirestore: (user , _) => user.toJson());
  }

  Future<UserFirestore> getUser(String username) async {
   final users = await _usersRef.where('username' , isEqualTo: username).limit(1).get();
   final String id = users.docs.first.id;
   UserFirestore userdata = users.docs.first.data() as UserFirestore;
   return  UserFirestore(
        id: id,
        username: userdata.username,
        email: userdata.email,
        password: userdata.password
    );;
  }

  Future<UserFirestore> getUserById(String id) async {
    final user = await _usersRef.doc(id).get();
    final userData = user.data() as UserFirestore;
    return userData;
  }

  Stream<QuerySnapshot> getUsers() {
    return _usersRef.snapshots();
  }

  void addUser(UserFirestore user) async {
    _usersRef.add(user);
  }



}