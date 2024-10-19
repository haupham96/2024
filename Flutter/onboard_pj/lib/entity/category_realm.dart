import 'package:realm/realm.dart';
part 'category_realm.g.dart';

@RealmModel()
class $_CategoryRealm {
  @PrimaryKey()
  late ObjectId id;
  late String name;
  
  late int? iconCodePoint;
  late String? iconColorHex; // color hex string
  
  late String? backgroundColorHex; // color hex string
}