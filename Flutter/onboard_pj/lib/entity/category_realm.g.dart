// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_realm.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class _CategoryRealm extends $_CategoryRealm
    with RealmEntity, RealmObjectBase, RealmObject {
  _CategoryRealm(
    ObjectId id,
    String name, {
    int? iconCodePoint,
    String? iconColorHex,
    String? backgroundColorHex,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'iconCodePoint', iconCodePoint);
    RealmObjectBase.set(this, 'iconColorHex', iconColorHex);
    RealmObjectBase.set(this, 'backgroundColorHex', backgroundColorHex);
  }

  _CategoryRealm._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int? get iconCodePoint =>
      RealmObjectBase.get<int>(this, 'iconCodePoint') as int?;
  @override
  set iconCodePoint(int? value) =>
      RealmObjectBase.set(this, 'iconCodePoint', value);

  @override
  String? get iconColorHex =>
      RealmObjectBase.get<String>(this, 'iconColorHex') as String?;
  @override
  set iconColorHex(String? value) =>
      RealmObjectBase.set(this, 'iconColorHex', value);

  @override
  String? get backgroundColorHex =>
      RealmObjectBase.get<String>(this, 'backgroundColorHex') as String?;
  @override
  set backgroundColorHex(String? value) =>
      RealmObjectBase.set(this, 'backgroundColorHex', value);

  @override
  Stream<RealmObjectChanges<_CategoryRealm>> get changes =>
      RealmObjectBase.getChanges<_CategoryRealm>(this);

  @override
  _CategoryRealm freeze() => RealmObjectBase.freezeObject<_CategoryRealm>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(_CategoryRealm._);
    return const SchemaObject(
        ObjectType.realmObject, _CategoryRealm, '_CategoryRealm', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('iconCodePoint', RealmPropertyType.int, optional: true),
      SchemaProperty('iconColorHex', RealmPropertyType.string, optional: true),
      SchemaProperty('backgroundColorHex', RealmPropertyType.string,
          optional: true),
    ]);
  }
}
