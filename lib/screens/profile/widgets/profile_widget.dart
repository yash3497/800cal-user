import 'package:eight_hundred_cal/backend/profile/profile_backend.dart';
import 'package:eight_hundred_cal/model/profile/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';

class ProfileWidget extends StatefulWidget {
  final String token;
  const ProfileWidget({super.key, required this.token});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  String image =
      'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60';

  _fetchProfileData() async {
    ProfileModel model =
        await Get.put(ProfileBackend()).fetchProfileData2(widget.token);
    setState(() {
      image = model.image;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 114,
      height: 114,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppColor.secondaryColor, width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.network(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
