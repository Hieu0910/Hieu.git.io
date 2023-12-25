import 'package:connection/repositories/place_repository.dart';
import 'package:flutter/material.dart';

import '../models/place.dart';

class DiachiModel with ChangeNotifier {
  List<City> listCity = [];
  List<District> listDistrict = [];
  List<Ward> listward = [];
  int curCityId = 0;
  int curDistId = 0;
  int curWardId = 0;
  String address = "";
  Future<void> initialize(int Cid, int Did, int Wid) async {
    curCityId = Cid;
    curDistId = Did;
    curWardId = Wid;
    final repo = PlaceRepository();
    listCity = await repo.getListCity();
    if (curCityId != 0) {
      listDistrict = await repo.getListDistrict(curCityId);
    }
    if (curDistId != 0) {
      listward = await repo.getListWard(curDistId);
    }
  }

  Future<void> SetCity(int Cid) async {
    if (Cid != curCityId) {
      curCityId = Cid;
      curDistId = 0;
      curWardId = 0;
      final repo = PlaceRepository();
      listDistrict = await repo.getListDistrict(curCityId);
      listward.clear();
    }
  }

  Future<void> SetDistrict(int Did) async {
    if (Did != curCityId) {
      curDistId = Did;
      curWardId = 0;
      final repo = PlaceRepository();
      listward = await repo.getListWard(curCityId);
    }
  }

  Future<void> SetWard(int Wid) async {
    if (Wid != curCityId) {
      curWardId = Wid;
    }
  }
}
