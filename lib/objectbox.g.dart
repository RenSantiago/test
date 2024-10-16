// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again
// with `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'
    as obx_int; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart' as obx;
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'Training/Models/UserEntity.dart';
import 'Training/MyGate.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <obx_int.ModelEntity>[
  obx_int.ModelEntity(
      id: const obx_int.IdUid(1, 2675707286429501678),
      name: 'MyGate',
      lastPropertyId: const obx_int.IdUid(3, 6660735259298248147),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 6777215889151115074),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 5392347940086593285),
            name: 'name',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 6660735259298248147),
            name: 'location',
            type: 9,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(2, 4413375761110694143),
      name: 'UserEntity',
      lastPropertyId: const obx_int.IdUid(4, 8649148722950950088),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 6041772183299711527),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 5531819482818069729),
            name: 'username',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 1944184112387654529),
            name: 'email',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 8649148722950950088),
            name: 'password',
            type: 9,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[])
];

/// Shortcut for [obx.Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [obx.Store.new] for an explanation of all parameters.
///
/// For Flutter apps, also calls `loadObjectBoxLibraryAndroidCompat()` from
/// the ObjectBox Flutter library to fix loading the native ObjectBox library
/// on Android 6 and older.
Future<obx.Store> openStore(
    {String? directory,
    int? maxDBSizeInKB,
    int? maxDataSizeInKB,
    int? fileMode,
    int? maxReaders,
    bool queriesCaseSensitiveDefault = true,
    String? macosApplicationGroup}) async {
  await loadObjectBoxLibraryAndroidCompat();
  return obx.Store(getObjectBoxModel(),
      directory: directory ?? (await defaultStoreDirectory()).path,
      maxDBSizeInKB: maxDBSizeInKB,
      maxDataSizeInKB: maxDataSizeInKB,
      fileMode: fileMode,
      maxReaders: maxReaders,
      queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
      macosApplicationGroup: macosApplicationGroup);
}

/// Returns the ObjectBox model definition for this project for use with
/// [obx.Store.new].
obx_int.ModelDefinition getObjectBoxModel() {
  final model = obx_int.ModelInfo(
      entities: _entities,
      lastEntityId: const obx_int.IdUid(2, 4413375761110694143),
      lastIndexId: const obx_int.IdUid(0, 0),
      lastRelationId: const obx_int.IdUid(0, 0),
      lastSequenceId: const obx_int.IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, obx_int.EntityDefinition>{
    MyGate: obx_int.EntityDefinition<MyGate>(
        model: _entities[0],
        toOneRelations: (MyGate object) => [],
        toManyRelations: (MyGate object) => {},
        getId: (MyGate object) => object.id,
        setId: (MyGate object, int id) {
          object.id = id;
        },
        objectToFB: (MyGate object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          final locationOffset = fbb.writeString(object.location);
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addOffset(2, locationOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final nameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final locationParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 8, '');
          final object =
              MyGate(id: idParam, name: nameParam, location: locationParam);

          return object;
        }),
    UserEntity: obx_int.EntityDefinition<UserEntity>(
        model: _entities[1],
        toOneRelations: (UserEntity object) => [],
        toManyRelations: (UserEntity object) => {},
        getId: (UserEntity object) => object.id,
        setId: (UserEntity object, int id) {
          object.id = id;
        },
        objectToFB: (UserEntity object, fb.Builder fbb) {
          final usernameOffset = fbb.writeString(object.username);
          final emailOffset = fbb.writeString(object.email);
          final passwordOffset = fbb.writeString(object.password);
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, usernameOffset);
          fbb.addOffset(2, emailOffset);
          fbb.addOffset(3, passwordOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final usernameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final emailParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 8, '');
          final passwordParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 10, '');
          final object = UserEntity(
              id: idParam,
              username: usernameParam,
              email: emailParam,
              password: passwordParam);

          return object;
        })
  };

  return obx_int.ModelDefinition(model, bindings);
}

/// [MyGate] entity fields to define ObjectBox queries.
class MyGate_ {
  /// See [MyGate.id].
  static final id =
      obx.QueryIntegerProperty<MyGate>(_entities[0].properties[0]);

  /// See [MyGate.name].
  static final name =
      obx.QueryStringProperty<MyGate>(_entities[0].properties[1]);

  /// See [MyGate.location].
  static final location =
      obx.QueryStringProperty<MyGate>(_entities[0].properties[2]);
}

/// [UserEntity] entity fields to define ObjectBox queries.
class UserEntity_ {
  /// See [UserEntity.id].
  static final id =
      obx.QueryIntegerProperty<UserEntity>(_entities[1].properties[0]);

  /// See [UserEntity.username].
  static final username =
      obx.QueryStringProperty<UserEntity>(_entities[1].properties[1]);

  /// See [UserEntity.email].
  static final email =
      obx.QueryStringProperty<UserEntity>(_entities[1].properties[2]);

  /// See [UserEntity.password].
  static final password =
      obx.QueryStringProperty<UserEntity>(_entities[1].properties[3]);
}
