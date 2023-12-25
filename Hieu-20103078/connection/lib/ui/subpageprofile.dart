import 'dart:io';

import 'package:connection/models/profile.dart';
import 'package:connection/providers/profileviewmodel.dart';
import 'package:connection/repositories/diachimodel.dart';
import 'package:connection/ui/custom_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../providers/mainviewmodel.dart';
import 'AppConstant.dart';

class SubPageProfile extends StatelessWidget {
  SubPageProfile({super.key});
  static int idpage = 1;
  XFile? image;
  Future<void> init(DiachiModel dcmodel, ProfileViewmodel viewmodel) async {
    Profile profile = Profile();
    if (dcmodel.listCity.isEmpty ||
        dcmodel.curCityId != profile.user.provinceid ||
        dcmodel.curDistId != profile.user.districtid ||
        dcmodel.curWardId != profile.user.wardid) {
      viewmodel.dislayspinner();
      await dcmodel.initialize(profile.user.provinceid, profile.user.districtid,
          profile.user.wardid);
      print("finish");
      viewmodel.hidespinner();
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<ProfileViewmodel>(context);
    final dcmodel = Provider.of<DiachiModel>(context);
    final size = MediaQuery.of(context).size;
    final profile = Profile();

    Future.delayed(Duration.zero, () => init(dcmodel, viewmodel));
    return GestureDetector(
      onTap: () => MainViewModel().CloseMenu(),
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Column(
              children: [
                // start header
                createHeader(size, profile, viewmodel),
                // end
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomInputTextFromField(
                              width: size.width * 0.45,
                              title: "Điện thoại",
                              value: profile.user.phone,
                              callback: (output) {
                                profile.user.phone = output;
                                viewmodel.setModified();
                                viewmodel.updateScreen();
                              },
                              type: TextInputType.phone),
                          CustomInputTextFromField(
                            width: size.width * 0.45,
                            title: "Ngày sinh",
                            value: profile.user.birthday,
                            callback: (output) {
                              if (AppConstant.isDate(output)) {
                                profile.user.birthday = output;
                              }
                              viewmodel.setModified();
                              viewmodel.updateScreen();
                            },
                            type: TextInputType.datetime,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomPlaceDropDown(
                              width: size.width * 0.45,
                              title: 'Thành phố/tỉnh',
                              valueId: profile.user.provinceid,
                              callback: (ouputId, outputName) async {
                                viewmodel.dislayspinner();
                                profile.user.provinceid = ouputId;
                                profile.user.provincename = outputName;
                                await dcmodel.SetCity(ouputId);
                                profile.user.districtid = 0;
                                profile.user.wardid = 0;
                                profile.user.districtname = "";
                                profile.user.wardname = "";
                                viewmodel.setModified();
                                viewmodel.hidespinner();
                              },
                              list: dcmodel.listCity,
                              valueName: profile.user.provincename),
                          CustomPlaceDropDown(
                              width: size.width * 0.45,
                              title: 'Quận/huyện',
                              valueId: profile.user.districtid,
                              callback: (ouputId, outputName) async {
                                viewmodel.dislayspinner();
                                profile.user.districtid = ouputId;
                                profile.user.districtname = outputName;
                                await dcmodel.SetDistrict(ouputId);
                                profile.user.wardid = 0;
                                profile.user.wardname = "";
                                viewmodel.setModified();
                                viewmodel.hidespinner();
                              },
                              list: dcmodel.listDistrict,
                              valueName: profile.user.districtname),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomPlaceDropDown(
                              width: size.width * 0.45,
                              title: 'Huyện/xã',
                              valueId: profile.user.wardid,
                              callback: (ouputId, outputName) async {
                                viewmodel.dislayspinner();
                                profile.user.wardid = ouputId;
                                profile.user.wardname = outputName;
                                await dcmodel.SetWard(ouputId);
                                viewmodel.setModified();
                                viewmodel.hidespinner();
                              },
                              list: dcmodel.listward,
                              valueName: profile.user.wardname),
                          CustomInputTextFromField(
                              width: size.width * 0.45,
                              title: "Tên đường/số nhà",
                              value: profile.user.address,
                              callback: (output) {
                                profile.user.address = output;
                                viewmodel.setModified();
                                viewmodel.updateScreen();
                              },
                              type: TextInputType.streetAddress),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: size.width * 0.3,
                        width: size.width * 0.3,
                        child: QrImageView(
                          data: '{userid:' + profile.user.id.toString() + '}',
                          version: QrVersions.auto,
                          gapless: false,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            viewmodel.status == 1 ? CustomSpinner(size: size) : Container(),
          ],
        ),
      ),
    );
  }

  Container createHeader(
      Size size, Profile profile, ProfileViewmodel viewmodel) {
    return Container(
      height: size.height * 0.20,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppConstant.appbarcolor,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(60))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Color.fromARGB(255, 255, 153, 0),
                  ),
                  Text(
                    profile.student.diem.toString(),
                    style: AppConstant.textbodyfocuswhite,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: viewmodel.updateavatar == 1 && image != null
                    ? Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: SizedBox(
                              height: 100,
                              width: 100,
                              child: Image.file(
                                File(image!.path),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Container(
                            height: 100,
                            width: 100,
                            alignment: Alignment.center,
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  viewmodel.uploadAvatar(image!);
                                },
                                child: Container(
                                    color: Colors.white,
                                    child: Icon(size: 25, Icons.save)),
                              ),
                            ),
                          ),
                        ],
                      )
                    : GestureDetector(
                        onTap: () async {
                          final ImagePicker _picker = ImagePicker();
                          image = await _picker.pickImage(
                              source: ImageSource.gallery);
                          viewmodel.setupdateavatar();
                        },
                        child: CustomAvartar1(size: size)),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.user.first_name,
                style: AppConstant.textbodywhite,
              ),
              Row(
                children: [
                  Text(
                    "MSSV:",
                    style: AppConstant.textbodyfocuswhite,
                  ),
                  Text(
                    profile.student.mssv,
                    style: AppConstant.textbodyfocuswhite,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Lớp:",
                    style: AppConstant.textbodyfocuswhite,
                  ),
                  Text(
                    profile.student.tenlop,
                    style: AppConstant.textbodyfocuswhite,
                  ),
                  profile.student.duyet == 0
                      ? Text(
                          " --Chưa duyệt--",
                          style: AppConstant.textbodyfocuswhite,
                        )
                      : Text(""),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Vai trò:",
                    style: AppConstant.textbodyfocuswhite,
                  ),
                  profile.user.role_id == 4
                      ? Text(
                          "Sinh viên",
                          style: AppConstant.textbodyfocuswhite,
                        )
                      : Text(
                          "Giảng viên",
                          style: AppConstant.textbodyfocuswhite,
                        ),
                ],
              ),
              SizedBox(
                width: size.width * 0.4,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: viewmodel.modified == 1
                      ? GestureDetector(
                          onTap: () {
                            viewmodel.updateProfile();
                          },
                          child: Icon(Icons.save))
                      : Container(),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
