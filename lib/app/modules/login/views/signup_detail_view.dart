import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/app/modules/login/controllers/login_controller.dart';
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
                SizedBox(height: height * 0.05),
                Image(
                  image: AssetImage('lib/aset/images/Luskins.png'),
                  width: 200.0,
                  height: 100.0,
                ),
                SizedBox(height: height * .05),
                SizedBox(height: height * .02),
                Container(
                  width: width * .9,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(44, 187, 185, 185),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: TextField(
                      controller: _emailController,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      decoration: InputDecoration(
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
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
              ],
            ),
          ),
        ),
      );
    });
  }
}
