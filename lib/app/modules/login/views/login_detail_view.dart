import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/app/utils/widgets/controller_widget/account_controller.dart';
import 'package:project/app/routes/app_pages.dart';
import '../controllers/firebase_controller.dart';

class LoginDetail extends StatefulWidget {
  const LoginDetail({Key? key}) : super(key: key);

  @override
  _LoginDetailState createState() => _LoginDetailState();
}

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    // 'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class _LoginDetailState extends State<LoginDetail> {
  bool isObsecure = true;
  bool? checked = false;
  final AuthController _authController = Get.put(AuthController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void initState() {
    _googleSignIn.onCurrentUserChanged.listen((event) {
      setState(() {});
    });
    _googleSignIn.signInSilently();
    super.initState();
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      if (_googleSignIn.currentUser != null) {
        _authController.setCurrentUser(_googleSignIn.currentUser as User?);
        Get.toNamed(Routes.HOME);
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GetBuilder<LoginController>(builder: (controller) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              'Sign In',
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
            child: SizedBox(
              height: height,
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.08),
                  Image(
                    image: AssetImage('lib/aset/images/Luskins.png'),
                    width: 200.0,
                    height: 100.0,
                  ),
                  SizedBox(height: height * 0.08),
                  Container(
                    width: width * 0.9,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(44, 187, 185, 185),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: TextField(
                        controller: _emailController,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        decoration: const InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "Email",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Container(
                    width: width * 0.9,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(44, 187, 185, 185),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: TextField(
                        controller: _passwordController,
                        obscureText:
                            isObsecure, // Gunakan nilai isObsecure di sini
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "Password",
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
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
                  SizedBox(height: height * 0.01),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: checked,
                              onChanged: (value) {
                                setState(() {
                                  checked = value;
                                });
                              },
                            ),
                            const Text(
                              "Remember me",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Forgotten password?",
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Obx(() {
                    return ElevatedButton(
                      onPressed: _authController.isLoading.value
                          ? null
                          : () async {
                              await _authController.loginUser(
                                _emailController.text,
                                _passwordController.text,
                              );

                              // Setelah login berhasil, navigasi ke halaman beranda
                              if (_authController.isLoading.value) {
                                Get.toNamed(Routes.HOME);
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black, // Warna coklat
                      ).copyWith(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                          : Text(
                              'Sign In',
                              style: TextStyle(
                                color: Colors.white, // Warna teks putih
                              ),
                            ),
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
                          onTap: () {
                            signInWithGoogle().then((result) {
                              if (result != null) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return HomeView();
                                    },
                                  ),
                                );
                              }
                            });
                            // _handleSignIn();
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Image.asset(
                              "lib/aset/logo/g.png",
                              width: 30, // Atur lebar gambar
                              height: 30, // Atur tinggi gambar
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
                  SizedBox(height: height * 0.02),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "You don't have an account yet?",
                            style: TextStyle(color: Colors.black),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.toNamed(Routes.SIGNUPDETAIL);
                            },
                            child: Text(
                              "Sign Up",
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
          ));
    });
  }
}
