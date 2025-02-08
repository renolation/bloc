

import 'package:bloc_reno/core/services/injection_container.dart';
import 'package:bloc_reno/src/auth/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DashboardUtils {
  const DashboardUtils._();

  static Stream<LocalUserModel> get userDataStream => sl<FirebaseFirestore>()
      .collection('users').doc(sl<FirebaseAuth>().currentUser!.uid)
      .snapshots().map((event) => LocalUserModel.fromMap(event.data()!));
}