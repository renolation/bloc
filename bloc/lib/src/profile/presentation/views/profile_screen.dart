import 'package:bloc_reno/core/common/widgets/gradient_background.dart';
import 'package:bloc_reno/core/res/media_res.dart';
import 'package:bloc_reno/src/profile/presentation/refactors/profile_header.dart';
import 'package:bloc_reno/src/profile/presentation/widgets/profile_app_bar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: const ProfileAppBar(),
      body: GradientBackground(
        image: MediaRes.profileGradientBackground,
        child: ListView(
          children: [
              ProfileHeader(),
          ],
        ),
      ),
    );
  }
}
