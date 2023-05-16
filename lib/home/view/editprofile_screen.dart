
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:nb_utils/nb_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wink/controller/membership_controller.dart';
import 'package:wink/utils/constant.dart';
import 'package:wink/utils/images.dart';
import 'package:wink/utils/space.dart';

import '../../utils/colors.dart';
import '../../utils/widgets.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  final editFormKey = GlobalKey<FormState>();
  MembershipController membershipController = Get.find();
  // TextEditingController userNameController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? imageFile;
  // String email = 'camreronedwards@gmail.com';
  // String fName = 'camreron';
  // String lName = 'Edwards';
  // String phone = '8998898';
  RxString userName = ''.obs;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    membershipController.userNameController.text = membershipController.userData?.userName;
    userName.value = membershipController.userData?.userName;
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    membershipController.userNameController.clear();
    super.dispose();
  }

  void profileUpdate() {
    if (editFormKey.currentState!.validate()) {

    }
    // userNameController.text = email;
    // fNameController.text = fName;
    // lNameController.text = lName;
    // phoneController.text = phone;
    // setState(() {});
  }

  Future<void> requestPhotoPermission() async {
    print('strat request photo permission');
    ///ios Photo permission
    if (GetPlatform.isIOS) {
      print('is IOS');
      PermissionStatus status = await Permission.photos.request();
      if (status.isGranted) {
        // 권한이 허용된 경우
        print('사진 권한이 허용되었습니다.');
        if (kIsWeb) {
          //image_picker_for_web 추가
          print('웹에서는 사용할 수 없습니다');
          return;
        } else {
          var picker = ImagePicker();
          var image = await picker.pickImage(source: ImageSource.gallery);
          if (image != null) {
            setState(() {
              imageFile =File(image.path);
            });
          }
        }

      } else if (status.isDenied) {
        // 권한이 거부된 경우
        print('사진 권한이 거부되었습니다.');
      } else if (status.isPermanentlyDenied) {
        // 권한이 영구적으로 거부된 경우
        print('사진 권한이 영구적으로 거부되었습니다. 설정에서 권한을 변경해주세요.');
        openAppSettings();
      }
    } else if (GetPlatform.isAndroid) {
      print('is Android');
      PermissionStatus status = await Permission.storage.request();
      if (status.isGranted) {
        // 권한이 허용된 경우
        print('사진 권한이 허용되었습니다.');
        if (kIsWeb) {
          //image_picker_for_web 추가
          print('웹에서는 사용할 수 없습니다');
          return;
        } else {
          var picker = ImagePicker();
          var image = await picker.pickImage(source: ImageSource.gallery);
          if (image != null) {
            setState(() {
              imageFile =File(image.path);
            });
          }
        }

      } else if (status.isDenied) {
        // 권한이 거부된 경우
        print('사진 권한이 거부되었습니다.');
      } else if (status.isPermanentlyDenied) {
        // 권한이 영구적으로 거부된 경우
        print('사진 권한이 영구적으로 거부되었습니다. 설정에서 권한을 변경해주세요.');
        openAppSettings();
      }
    }
  }
  int? _sliding = 0;
  List<String> gender = ['남자', '여자', '미공개'];
  final List<bool> _selectedMenu = <bool>[false, false, false];

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme.apply(
      // bodyColor: colorScheme.onPrimaryContainer,
      // displayColor: colorScheme.onPrimaryContainer,
    );


    return GetBuilder<MembershipController>(
      builder: (controller) {
        return Scaffold(
          bottomNavigationBar: BottomElevatedButton(
            onPressed: () {
              print('update');
              profileUpdate();
            },
            textContent: '업데이트',
          ).marginAll(appPadding),
          appBar: AppBar(
            backgroundColor: colorScheme.primaryContainer,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Get.back();
              },
            ),
            title: Text("프로필 수정"),
          ),
          backgroundColor: colorScheme.primaryContainer,
          body: Form(
            key: editFormKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                vertical: appPadding,
                horizontal: appPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: requestPhotoPermission,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        FittedBox(
                          fit: BoxFit.fill,
                          child: CircleAvatar(
                            backgroundImage: imageFile == null ? AssetImage(loading) as ImageProvider : FileImage(imageFile!),
                            radius: 70,
                            backgroundColor: colorScheme.primary
                          ),
                          // child: commonSHCachedNetworkImage(
                          //   'https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg',
                          //   height: 100,
                          //   width: 100,
                          // ).cornerRadiusWithClipRRect(50),
                        ),
                        Positioned(
                          bottom: 3,
                          right: 3,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(circularRadius), color: colorScheme.primary),
                            child: Icon(Icons.camera_alt_outlined, color: white),
                          ),
                        )
                      ],
                    ).center(),
                  ),
                  Space(buttonMargin),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text('닉네임', style: boldTextStyle(color: colorScheme.onPrimaryContainer)),
                          Text('*', style: boldTextStyle(color: Colors.red)),
                        ],
                      ),
                      Obx(() => Text('${userName.value.length.toString()}/15', style: secondaryTextStyle(color: colorScheme.onSecondaryContainer),),),

                    ],
                  ),
                  Space(buttonMargin),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: controller.userNameController,
                    textInputAction: TextInputAction.done,
                    onChanged: (value) => userName.value = value,
                    inputFormatters: [LengthLimitingTextInputFormatter(15)],
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return '닉네임을 입력해주세요';
                      }
                      return null;
                    },
                    decoration: commonInputDecoration(
                      prefixIcon: Icon(Icons.person_outline_rounded),
                      hintText: '닉네임을 입력해주세요',
                    ),
                  ),
                  Space(buttonMargin),
                  CupertinoSlidingSegmentedControl(
                      children: {
                        0: Container(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              '남자',
                              style: primaryTextStyle(color: _sliding == 0 ? Colors.black : grey),
                            )),
                        1: Container(padding: EdgeInsets.all(8), child: Text('여자', style: primaryTextStyle(color: _sliding == 1 ? Colors.black : grey))),
                        2: Container(padding: EdgeInsets.all(8), child: Text('미공개', style: primaryTextStyle(color: _sliding == 2 ? Colors.black : grey))),
                      },
                      groupValue: _sliding,
                      onValueChanged: (dynamic newValue) {
                        setState(() {
                          print(newValue);
                          _sliding = newValue;
                        });
                      },
                  ),
                  Space(buttonMargin),
                  Center(
                    child: Container(
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        color: colorScheme.secondaryContainer,
                        border: Border.all(color: colorScheme.secondaryContainer),
                        borderRadius: BorderRadius.all(Radius.circular(circularRadius)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: ToggleButtons(
                        onPressed: (index){
                          setState(() {
                            for (int i = 0; i < _selectedMenu.length; i++) {
                              _selectedMenu[i] = i == index;
                            }
                            // if(index == 0){
                            //   controller.gender = gender[0].obs;
                            // } else if(index == 1){
                            //   controller.gender = gender[1].obs;
                            // } else{
                            //   controller.gender = gender[2].obs;
                            // }
                          });
                        },
                        borderColor: transparent,
                        selectedBorderColor: transparent,
                        selectedColor: colorScheme.onPrimary,
                        fillColor: transparent,
                        color: colorScheme.onPrimaryContainer,

                        isSelected: _selectedMenu,
                        children: [
                          for(int i = 0; i < gender.length; i++)
                            toggleContainer(gender[i], colorScheme, _selectedMenu[i]),
                        ],
                      ),
                    ),
                  ),
                  Space(buttonMargin),
                  AppTextField(
                    // textStyle: primaryTextStyle(color: white),
                    textFieldType: TextFieldType.USERNAME,
                    controller: fNameController,
                    decoration: commonInputDecoration(
                      prefixIcon: Text('userName'),
                      labelText: 'First Name'
                    ),
                  ),
                  Space(buttonMargin),
                  AppTextField(
                    textStyle: primaryTextStyle(color: white),
                    cursorColor: white,
                    textFieldType: TextFieldType.NAME,
                    controller: lNameController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 16),
                      labelText: 'Last Name',
                      labelStyle: secondaryTextStyle(color: white),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                        borderSide: BorderSide(color: grey, width: 0.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                        borderSide: BorderSide(color: grey, width: 0.5),
                      ),
                    ),
                  ),
                  Space(buttonMargin),
                  AppTextField(
                    textStyle: primaryTextStyle(color: white),
                    cursorColor: white,
                    textFieldType: TextFieldType.PHONE,
                    controller: phoneController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 16),
                      labelText: 'Phone Number',
                      labelStyle: secondaryTextStyle(),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                        borderSide: BorderSide(color: grey, width: 0.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                        borderSide: BorderSide(color: grey, width: 0.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
