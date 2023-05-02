import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wink/utils/constant.dart';
import 'package:wink/utils/images.dart';

import '../../utils/widgets.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String email = 'camreronedwards@gmail.com';
  String fName = 'camreron';
  String lName = 'Edwards';
  String phone = '8998898';

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  void setValue() {
    emailController.text = email;
    fNameController.text = fName;
    lNameController.text = lName;
    phoneController.text = phone;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme.apply(
      // bodyColor: colorScheme.onPrimaryContainer,
      // displayColor: colorScheme.onPrimaryContainer,
    );


    return Scaffold(
      bottomNavigationBar: BottomElevatedButton(
        onPressed: () {
          print('update');
          setValue();
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
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: appPadding,
            horizontal: appPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                //overflow: Overflow.visible,
                alignment: Alignment.topCenter,
                children: [
                  FittedBox(
                    fit: BoxFit.fill,
                    child: CircleAvatar(backgroundImage: AssetImage(splashLogo), radius: 70,backgroundColor: colorScheme.primary),
                    // child: commonSHCachedNetworkImage(
                    //   'https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg',
                    //   height: 100,
                    //   width: 100,
                    // ).cornerRadiusWithClipRRect(50),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(circularRadius), color: colorScheme.primary),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.camera_alt_outlined, color: white),
                      ),
                    ),
                  )
                ],
              ).center(),
              16.height,
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: commonInputDecoration(
                  hintText: 'Email',
                ),
              ),
              16.height,
              AppTextField(
                // textStyle: primaryTextStyle(color: white),
                textFieldType: TextFieldType.USERNAME,
                controller: fNameController,
                decoration: commonInputDecoration(
                  prefixIcon: Text('userName'),
                  labelText: 'First Name'
                ),
              ),
              16.height,
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
              16.height,
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
}
