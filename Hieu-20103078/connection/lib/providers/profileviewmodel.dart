import 'package:connection/models/profile.dart';
import 'package:connection/models/user.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../repositories/user_repository.dart';

class ProfileViewmodel with ChangeNotifier {
  int status = 0;
  int modified = 0;
  int updateavatar = 0;
  void updateScreen() {
    status = 0;
    notifyListeners();
  }

  void setupdateavatar() {
    updateavatar = 1;
    notifyListeners();
  }

  Future<void> uploadAvatar(XFile image) async {
    status = 1;
    notifyListeners();
    await UserRepository().upLoadAvatar(image);
    var user = await UserRepository().getUserInfo();
    Profile().user = User.fromUser(user);
    updateavatar = 0;
    status = 0;
    notifyListeners();
  }

  void dislayspinner() {
    status = 1;
    notifyListeners();
  }

  void setModified() {
    if (modified == 0) {
      modified = 1;
      notifyListeners();
    }
  }

  void hidespinner() {
    status = 0;
    notifyListeners();
  }

  Future<void> updateProfile() async {
    status = 1;
    notifyListeners();
    await UserRepository().UpdateProfile();
    status = 0;
    modified = 0;
    notifyListeners();
  }
}
