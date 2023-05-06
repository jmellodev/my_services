import 'package:flutter/foundation.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:my_services/constants/firebase_constants.dart';
import 'package:my_services/models/user_model.dart';
import 'package:my_services/screens/auth/login.dart';
import 'package:my_services/screens/home.dart';
import 'package:my_services/utils/helper_notification.dart';

class AuthController extends GetxController {
  static AuthController authInstance = Get.find();

  late Rx<User?> firebaseUser;
  final box = GetStorage();
  String? token;

  @override
  void onReady() async {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
    token = await firebaseMessaging.getToken();
    FlutterNativeSplash.remove();
  }

  _setInitialScreen(User? user) {
    if (user != null) {
      // user is logged in
      Get.offAll(() => HomeView());
    } else {
      // user is null as in user is not available or not logged in
      Get.offAll(() => LoginPage());
    }
  }

  Future<UserCredential> signInWithGoogleA() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    // return await FirebaseAuth.instance.signInWithCredential(credential);
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    //Get user data
    final user = userCredential.user;
    final displayName = user?.displayName;
    final email = user?.email;
    final photoUrl = user?.photoURL;

    // Save user data
    box.write('displayName', displayName ?? '');
    box.write('email', email ?? '');
    box.write('photoUrl', photoUrl ?? '');

    return userCredential;
  }

  Future<UserModel?> signInWithGoogle(String? type) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return null;
    }
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Once signed in, return the UserCredential
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final user = UserModel(
      id: userCredential.user!.uid,
      name: userCredential.user!.displayName ?? '',
      email: userCredential.user!.email ?? '',
      photoUrl: userCredential.user!.photoURL,
      deviceId: token,
      type: type,
    );
    await box.write('user', user.toJson());
    await usersCollection.doc(user.id).set(user.toJson());
    HelperNotification().senPushNotification(
        token, userCredential.user!.displayName, 'Fez login com sucesso!');
    return user;
  }

  void loginA(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      await box.write('email', email);
    } on FirebaseAuthException catch (e) {
      // this is solely for the Firebase Auth Exception
      // for example : password did not match
      debugPrint(e.message);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      /* final user = UserModel(
        id: userCredential.user!.uid,
        email: userCredential.user!.email,
        name: userCredential.user!.displayName,
        photoUrl: userCredential.user!.photoURL,
      );
      await usersCollection.doc(user.id).set(user.toJson());
      await box.write('user', user.toJson()); */
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void register(String name, String email, String password, String type) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      final user = UserModel(
        id: userCredential.user!.uid,
        email: userCredential.user!.email,
        name: name,
        // photoUrl: userCredential.user!.photoURL,
        type: type,
        deviceId: token,
      );
      await box.write('user', user.toJson());
      await usersCollection.doc(user.id).set(user.toJson()).then((value) async {
        debugPrint('Usuário $name registrado com sucesso!');
        debugPrint(box.read('user').toString());
      });
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      Get.snackbar(
        "Error",
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      // Sign out of Firebase
      auth.signOut();
      // Sign out of Google
      await GoogleSignIn().signOut();
      // Clear user data from GetStorage
      await box.remove('user');
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
