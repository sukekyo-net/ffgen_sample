// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

class ReadUser {
  const ReadUser({
    required this.settingId,
    required this.path,
    required this.user,
  });

  final String settingId;

  final String path;

  final String user;

  factory ReadUser._fromJson(Map<String, dynamic> json) {
    final extendedJson = <String, dynamic>{
      ...json,
    };
    return ReadUser(
      settingId: extendedJson['settingId'] as String,
      path: extendedJson['path'] as String,
      user: extendedJson['user'] as String,
    );
  }

  factory ReadUser.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;
    return ReadUser._fromJson(<String, dynamic>{
      ...data,
      'settingId': ds.id,
      'path': ds.reference.path,
    });
  }
}

class CreateUser {
  const CreateUser({
    required this.user,
  });

  final String user;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'user': user,
    };
    final jsonPostProcessors = <({String key, dynamic value})>[];
    return {
      ...json,
      ...Map.fromEntries(jsonPostProcessors
          .map((record) => MapEntry(record.key, record.value))),
    };
  }
}

class UpdateUser {
  const UpdateUser({
    this.user,
  });

  final String? user;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      if (user != null) 'user': user,
    };
    final jsonPostProcessors = <({String key, dynamic value})>[];
    return {
      ...json,
      ...Map.fromEntries(jsonPostProcessors
          .map((record) => MapEntry(record.key, record.value))),
    };
  }
}

class DeleteUser {}

/// Provides a reference to the user collection for reading.
CollectionReference<ReadUser> readUserCollectionReference({
  required String userId,
}) =>
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('user')
        .withConverter<ReadUser>(
          fromFirestore: (ds, _) => ReadUser.fromDocumentSnapshot(ds),
          toFirestore: (_, __) => throw UnimplementedError(),
        );

/// Provides a reference to a setting document for reading.
DocumentReference<ReadUser> readUserDocumentReference({
  required String userId,
  required String settingId,
}) =>
    readUserCollectionReference(userId: userId).doc(settingId);

/// Provides a reference to the user collection for creating.
CollectionReference<CreateUser> createUserCollectionReference({
  required String userId,
}) =>
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('user')
        .withConverter<CreateUser>(
          fromFirestore: (_, __) => throw UnimplementedError(),
          toFirestore: (obj, _) => obj.toJson(),
        );

/// Provides a reference to a setting document for creating.
DocumentReference<CreateUser> createUserDocumentReference({
  required String userId,
  required String settingId,
}) =>
    createUserCollectionReference(userId: userId).doc(settingId);

/// Provides a reference to the user collection for updating.
CollectionReference<UpdateUser> updateUserCollectionReference({
  required String userId,
}) =>
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('user')
        .withConverter<UpdateUser>(
          fromFirestore: (_, __) => throw UnimplementedError(),
          toFirestore: (obj, _) => obj.toJson(),
        );

/// Provides a reference to a setting document for updating.
DocumentReference<UpdateUser> updateUserDocumentReference({
  required String userId,
  required String settingId,
}) =>
    updateUserCollectionReference(userId: userId).doc(settingId);

/// Provides a reference to the user collection for deleting.
CollectionReference<DeleteUser> deleteUserCollectionReference({
  required String userId,
}) =>
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('user')
        .withConverter<DeleteUser>(
          fromFirestore: (_, __) => throw UnimplementedError(),
          toFirestore: (_, __) => throw UnimplementedError(),
        );

/// Provides a reference to a setting document for deleting.
DocumentReference<DeleteUser> deleteUserDocumentReference({
  required String userId,
  required String settingId,
}) =>
    deleteUserCollectionReference(userId: userId).doc(settingId);

/// Manages queries against the user collection.
class UserQuery {
  /// Fetches [ReadUser] documents.
  Future<List<ReadUser>> fetchDocuments({
    required String userId,
    GetOptions? options,
    Query<ReadUser>? Function(Query<ReadUser> query)? queryBuilder,
    int Function(ReadUser lhs, ReadUser rhs)? compare,
  }) async {
    Query<ReadUser> query = readUserCollectionReference(userId: userId);
    if (queryBuilder != null) {
      query = queryBuilder(query)!;
    }
    final qs = await query.get(options);
    final result = qs.docs.map((qds) => qds.data()).toList();
    if (compare != null) {
      result.sort(compare);
    }
    return result;
  }

  /// Subscribes [User] documents.
  Stream<List<ReadUser>> subscribeDocuments({
    required String userId,
    Query<ReadUser>? Function(Query<ReadUser> query)? queryBuilder,
    int Function(ReadUser lhs, ReadUser rhs)? compare,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
  }) {
    Query<ReadUser> query = readUserCollectionReference(userId: userId);
    if (queryBuilder != null) {
      query = queryBuilder(query)!;
    }
    var streamQs =
        query.snapshots(includeMetadataChanges: includeMetadataChanges);
    if (excludePendingWrites) {
      streamQs = streamQs.where((qs) => !qs.metadata.hasPendingWrites);
    }
    return streamQs.map((qs) {
      final result = qs.docs.map((qds) => qds.data()).toList();
      if (compare != null) {
        result.sort(compare);
      }
      return result;
    });
  }

  /// Fetches a specific [ReadUser] document.
  Future<ReadUser?> fetchDocument({
    required String userId,
    required String settingId,
    GetOptions? options,
  }) async {
    final ds = await readUserDocumentReference(
      userId: userId,
      settingId: settingId,
    ).get(options);
    return ds.data();
  }

  /// Subscribes a specific [User] document.
  Stream<ReadUser?> subscribeDocument({
    required String userId,
    required String settingId,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
  }) {
    var streamDs = readUserDocumentReference(
      userId: userId,
      settingId: settingId,
    ).snapshots(includeMetadataChanges: includeMetadataChanges);
    if (excludePendingWrites) {
      streamDs = streamDs.where((ds) => !ds.metadata.hasPendingWrites);
    }
    return streamDs.map((ds) => ds.data());
  }

  /// Adds a [User] document.
  Future<DocumentReference<CreateUser>> add({
    required String userId,
    required CreateUser createUser,
  }) =>
      createUserCollectionReference(userId: userId).add(createUser);

  /// Sets a [User] document.
  Future<void> set({
    required String userId,
    required String settingId,
    required CreateUser createUser,
    SetOptions? options,
  }) =>
      createUserDocumentReference(
        userId: userId,
        settingId: settingId,
      ).set(createUser, options);

  /// Updates a specific [User] document.
  Future<void> update({
    required String userId,
    required String settingId,
    required UpdateUser updateUser,
  }) =>
      updateUserDocumentReference(
        userId: userId,
        settingId: settingId,
      ).update(updateUser.toJson());

  /// Deletes a specific [User] document.
  Future<void> delete({
    required String userId,
    required String settingId,
  }) =>
      deleteUserDocumentReference(
        userId: userId,
        settingId: settingId,
      ).delete();
}
