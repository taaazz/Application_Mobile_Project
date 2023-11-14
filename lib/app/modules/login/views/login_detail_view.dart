import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/app/modules/login/controllers/login_controller.dart';
import 'package:project/app/routes/app_pages.dart';

import '../controllers/auth_controller.dart';

class LoginDetail extends StatefulWidget {
  const LoginDetail({Key? key}) : super(key: key);

  @override
  _LoginDetailState createState() => _LoginDetailState();
}

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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GetBuilder<LoginController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Log In',
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
        body: SizedBox(
          height: height,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.05),
              Image(
                image: AssetImage('lib/aset/images/Luskins.png'),
                width: 200.0,
                height: 100.0,
              ),
              SizedBox(height: height * 0.05),
              Container(
                width: width * 0.9,
                decoration: BoxDecoration(
                  color: Color.fromARGB(44, 187, 185, 185),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: TextField(
                    controller: _emailController,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: "Email or Username",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: isObsecure, // Gunakan nilai isObsecure di sini
                    style: const TextStyle(color: Colors.black, fontSize: 18),
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
                          isObsecure ? Icons.visibility_off : Icons.visibility,
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
                          style: TextStyle(color: Colors.black, fontSize: 12),
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
                          if (!_authController.isLoading.value) {
                            Get.toNamed(Routes.HOME);
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.brown, // Warna coklat
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
                      : Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white, // Warna teks putih
                          ),
                        ),
                );
              }),
              SizedBox(height: height * 0.02),
              Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 19),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                          "https://www.google.com/url?sa=i&url=https%3A%2F%2Fid.m.wikipedia.org%2Fwiki%2FBerkas%3AGoogle_%2522G%2522_Logo.svg&psig=AOvVaw1sHp-X3jjvNiqS9OJpIg3C&ust=1700066022925000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCLCj_8z1w4IDFQAAAAAdAAAAABAE"),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        "Sign In with Google",
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    "You don't have an account yet? ",
                  ),
                  Text(
                    "Sign Up",
                  ),
                ],
              )
              // GestureDetector(
              //   child: CustomButton(
              //     width: width * 0.9,
              //     text: "Create Account",
              //     btnColor: Colors.black,
              //     btnTextColor: Colors.white,
              //     route: Routes.SIGNUPDETAIL, // Isi dengan rute yang diinginkan
              //   ),
              // ),
            ],
          ),
        ),
      );
    });
  }
}
