
import 'dart:typed_data';

abstract class StorageRepo {
  // upload profile image - Mobile Platform
  Future<String?> uploadProfileImageMobile(String path, String filename);

  // upload profile image - WEB Platform
  Future<String?> uploadProfileImageWeb(Uint8List fileBytes, String filename);
}
