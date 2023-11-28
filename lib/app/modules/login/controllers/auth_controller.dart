import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project/app/modules/login/views/signup_detail_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final SharedPreferences _prefs = Get.find<SharedPreferences>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  RxBool isLoading = false.obs;
  RxBool isLoggedIn = false.obs;
  Rx<User?> _currentUser = Rx<User?>(null);

  User? get currentUser => _currentUser.value;

  void setCurrentUser(User? user) {
    _currentUser.value = user;
  }

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus(); // Cek status login saat controller diinisialisasi
  }

  Future<void> checkLoginStatus() async {
    final String? userToken = _prefs.getString('user_token');
    isLoggedIn.value = userToken != null && userToken.isNotEmpty;
  }

  Future<void> registerUser(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Get.snackbar('Success', 'Registration successful',
          backgroundColor: Colors.green);

      Get.off(const SignupDetail()); //Navigate ke Login Page
    } catch (error) {
      Get.snackbar('Error', 'Registration failed: $error',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _prefs.setString(
          'user_token', _auth.currentUser!.uid); // Simpan token autentikasi
      Get.snackbar('Success', 'Login successful',
          backgroundColor: Colors.green);
      isLoggedIn.value = true; // Set status login menjadi true
      Get.offAllNamed(
          '/home'); // Navigate ke HomePage dan hapus semua halaman sebelumnya
    } catch (error) {
      Get.snackbar('Error', 'Login failed: $error',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    _prefs.remove('user_token'); // Hapus token autentikasi dari penyimpanan
    isLoggedIn.value = false; // Set status login menjadi false
    _auth.signOut(); // Sign out dari Firebase Authentication
    Get.offAllNamed(
        '/login_detail'); // Navigate ke HomePage dan hapus semua halaman sebelumnya
  }
}
