import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project/app/modules/login/controllers/login_controller.dart';
import '../../../routes/app_pages.dart';
import '../controllers/auth_controller.dart';

class SignupDetail extends StatefulWidget {
  const SignupDetail({Key? key}) : super(key: key);

  @override
  _SignupDetailState createState() => _SignupDetailState();
}

class _SignupDetailState extends State<SignupDetail> {
  bool isObsecure = true;
  final AuthController _authController = Get.put(AuthController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GoogleSignIn _googleSignIn =
      GoogleSignIn(scopes: ['email']); // Initialize GoogleSignIn

  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        print('Login Berhasil: ${userCredential.user?.displayName}');
        // Setelah login berhasil, lakukan tindakan yang sesuai
      } else {
        print('Login Dibatalkan');
        // Handle jika user membatalkan login
      }
    } catch (error) {
      print('Login Error: $error');
      // Handle jika terjadi kesalahan saat login
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GetBuilder<LoginController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.08),
                const Image(
                  image: AssetImage('lib/aset/images/Luskins.png'),
                  width: 200.0,
                  height: 100.0,
                ),
                SizedBox(height: height * 0.08),
                Container(
                  width: width * .9,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(44, 187, 185, 185),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: TextField(
                      controller: _emailController,
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                      decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * .02),
                Container(
                  width: width * .9,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(44, 187, 185, 185),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: TextFormField(
                      // Ganti dengan TextFormField
                      controller: _passwordController,
                      obscureText:
                          isObsecure, // Gunakan nilai isObsecure di sini
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: "Password",
                        hintStyle:
                            const TextStyle(color: Colors.grey, fontSize: 16),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObsecure = !isObsecure;
                            });
                          },
                          icon: Icon(
                            isObsecure
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * .02),
                Obx(() {
                  return ElevatedButton(
                    onPressed: _authController.isLoading.value
                        ? null
                        : () {
                            _authController.registerUser(
                              _emailController.text,
                              _passwordController.text,
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black, // Warna coklat
                    ).copyWith(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all(
                        Size(width * 0.7, 50),
                      ),
                    ),
                    child: _authController.isLoading.value
                        ? CircularProgressIndicator()
                        : Text('Register'),
                  );
                }),
                SizedBox(height: height * .03),
                Text(
                  "or sign up with",
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: height * .02),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap:
                            _handleGoogleSignIn, // Panggil fungsi Google SignIn saat gambar pertama diklik
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Image.asset(
                            "lib/aset/logo/g.png",
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Aksi ketika gambar kedua diklik
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Image.asset(
                            "lib/aset/logo/fb.png",
                            width: 40, // Atur lebar gambar
                            height: 40, // Atur tinggi gambar
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        height:
                            height * 0.07), // Tambahkan jarak dari tombol Login
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "You already have account?",
                          style: TextStyle(color: Colors.black),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.toNamed(Routes.LOGINDETAIL);
                          },
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
