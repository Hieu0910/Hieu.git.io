import 'dart:io';

import 'package:connection/services/api_service.dart';
import 'package:image_picker/image_picker.dart';

import '../models/user.dart';
import 'package:image/image.dart' as img;

class UserRepository {
  Future<User> getUserInfo() async {
    User user = User();
    final response = await Apiservice().getUserInfo();
    if (response != null) {
      var json = response.data['data'];
      user = User.fromJson(json);
    }
    return user;
  }

  Future<bool> UpdateProfile() async {
    bool kq = false;
    var response = await Apiservice().getUpdateProfile();
    if (response != null) {
      kq = true;
    }
    return kq;
  }

  Future<void> upLoadAvatar(XFile image) async {
    Apiservice api = Apiservice();
    if (image != null) {
      final img.Image origimalImage =
          img.decodeImage(File(image.path).readAsBytesSync())!;
      final img.Image resizedImage = img.copyResize(origimalImage, width: 300);

      final File resizedFile =
          File(image.path.replaceAll('.jpg', '_resized.jpg'))
            ..writeAsBytesSync(img.encodeJpg(resizedImage));

      await api.uploadAvatarToServer(File(resizedFile.path));
    }
  }
}
