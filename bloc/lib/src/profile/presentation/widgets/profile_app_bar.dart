import 'dart:async';

import 'package:bloc_reno/core/common/app/providers/tab_navigator.dart';
import 'package:bloc_reno/core/common/views/loading_view.dart';
import 'package:bloc_reno/core/common/views/popup_item.dart';
import 'package:bloc_reno/core/extensions/context_extension.dart';
import 'package:bloc_reno/core/res/colours.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/injection_container.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../views/edit_profile_view.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Account'),
      actions: [
        PopupMenuButton(
            offset: const Offset(0, 50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            icon: const Icon(Icons.more_horiz),
            itemBuilder: (_) => [
                  PopupMenuItem<void>(
                    onTap: () => context.push(
                      BlocProvider(
                        create: (_) => sl<AuthBloc>(),
                        child: const EditProfileView(),
                      ),
                    ),
                    child: const PopupItem(
                      title: 'Edit Profile',
                      icon: Icon(
                        Icons.edit_outlined,
                        color: Colours.neutralTextColour,
                      ),
                    ),
                  ),
                  PopupMenuItem<void>(
                    // onTap: context.read<TabNavigator>().push(TabItem(child: Placeholder())),
                    onTap: () => context.push(const Placeholder()),
                    child: const PopupItem(
                      title: 'Notifications',
                      icon: Icon(
                        Icons.notifications,
                        color: Colours.neutralTextColour,
                      ),
                    ),
                  ),
                  PopupMenuItem<void>(
                    // onTap: context.read<TabNavigator>().push(TabItem(child: Placeholder())),
                    onTap: () => context.push(const Placeholder()),
                    child: const PopupItem(
                      title: 'Help',
                      icon: Icon(
                        Icons.help_outline_outlined,
                        color: Colours.neutralTextColour,
                      ),
                    ),
                  ),
                   PopupMenuItem<void>(
                      height: 1,
                      padding: EdgeInsets.zero,
                      child: Divider(
                        height: 1,
                        color: Colors.grey.shade300,
                        endIndent: 16,
                        indent: 16,
                      )),
                  PopupMenuItem<void>(
                    // onTap: context.read<TabNavigator>().push(TabItem(child: Placeholder())),
                    onTap: () async {
                      final navigator = Navigator.of(context);
                      await FirebaseAuth.instance.signOut();
                      unawaited(navigator.pushNamedAndRemoveUntil('/', (route) => false));
                    },
                    child: const PopupItem(
                      title: 'Log out',
                      icon: Icon(
                        Icons.logout_outlined,
                        color: Colours.neutralTextColour,
                      ),
                    ),
                  ),
                ]),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
