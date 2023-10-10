import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user.flutterfire_gen.dart';
part 'user.g.dart';

@riverpod
Future<void> user(UserRef ref) async {
  await Future.value();
}

@FirestoreDocument(
  path: 'users/{userId}/user',
  documentName: 'setting',
)
class User {
  final String user;
  const User({
    required this.user,
  });
}
