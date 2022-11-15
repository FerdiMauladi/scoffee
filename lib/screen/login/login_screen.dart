
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoffee/screen/login/login_controller.dart';
import 'package:scoffee/screen/register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFF674109),
          body: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(color: Colors.transparent),
                margin: const EdgeInsets.all(24.0),
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  'LOGIN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Card(
                elevation: 8,
                shadowColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: const BorderSide(color: Colors.black),
                ),
                margin: const EdgeInsets.only(
                    top: 25, left: 15, right: 15, bottom: 25),
                child: Form(
                  key: controller.formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Colors.black,
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            controller:
                            controller.emailLoginController,
                            validator: (email) {
                              if (email == null || email.isEmpty) {
                                return 'Email cannot be empty';
                              }
                              else if (!GetUtils.isEmail(email)) {
                                return 'Format email tidak sesuai';
                              }
                              else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Masukan Email Anda',
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 5,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: const Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: TextFormField(
                            obscureText:
                            controller.isObscurePasswordLogin,
                            cursorColor: Colors.black,
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            controller:
                            controller.passwordLoginController,
                            validator: (password) {
                              if (password == null || password.isEmpty) {
                                return 'Password cannot be empty';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Masukan Password Anda',
                              filled: true,
                              errorText: controller.isError
                                  ? 'Incorrect Password'
                                  : null,
                              fillColor: Colors.white,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  controller.isObscurePasswordLogin =
                                  !controller.isObscurePasswordLogin;
                                  controller.update();
                                },
                                child: Icon(
                                  controller.isObscurePasswordLogin
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: controller.isErrorPasswordLogin
                                      ? Colors.red
                                      : Colors.black,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 5,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.isRemember =
                                  !controller.isRemember;
                                  controller.update();
                                },
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Checkbox(
                                      value: controller.isRemember,
                                      onChanged: (bool? data) {
                                        controller.isRemember = data!;
                                        controller.update();
                                      },
                                    ),
                                    const Text(
                                      'Ingat Saya',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {
                              final form =
                                  controller.formKey.currentState;
                              if (form!.validate()) {
                                controller.doLogin(
                                  email:
                                    controller
                                        .emailLoginController.text,
                                    password:
                                    controller
                                        .passwordLoginController.text);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFBF8E2C),
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              elevation: 2,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(
                                  top: 14.0,
                                  bottom: 14.0,
                                  left: 40.0,
                                  right: 40.0),
                              child: Text(
                                'Masuk',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: Text(
                  'Belum punya akun?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => const RegisterScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFBF8E2C),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                elevation: 2,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.only(
                    top: 14.0,
                    bottom: 14.0,
                    left: 40.0,
                    right: 40.0),
                child: Text(
                  'Daftar',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
            ],
          ),
        );
      },
    );
  }
}
