import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoffee/screen/register/register_controller.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      init: RegisterController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFF674109),
          appBar: AppBar(
            backgroundColor: const Color(0xFF362204),
            title: const Text(
              'Register',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
            ),
          ),
          body: Center(
            child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: const BorderSide(color: Colors.black),
                      ),
                      margin: const EdgeInsets.only(
                          top: 25, left: 15, right: 15, bottom: 25),
                      child: Form(
                        key: controller.formKeyRegister,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Nama',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: TextFormField(
                                  cursorColor: Colors.black,
                                  controller: controller.namaRegisterController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (name) {
                                    if (name == null || name.isEmpty) {
                                      return 'Name cannot be empty';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Masukan Nama Lengkap Anda',
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
                                margin: const EdgeInsets.only(top: 10),
                                child: const Text(
                                  'Email',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
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
                                      controller.emailRegisterController,
                                  validator: (email) {
                                    if (email == null || email.isEmpty) {
                                      return 'Email cannot be empty';
                                    } else if (!RegExp(
                                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                        .hasMatch(email)) {
                                      return 'Enter email correctly';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Masukan Email Anda',
                                    filled: true,
                                    fillColor: Colors.white,
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
                                      controller.isObscurePasswordRegister,
                                  cursorColor: Colors.black,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller:
                                      controller.passwordRegisterController,
                                  validator: (password) {
                                    if (password == null || password.isEmpty) {
                                      return 'Password cannot be empty';
                                    } else if (password.length < 8) {
                                      return 'Password tidak boleh kurang dari 8';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Masukan Password Anda',
                                    filled: true,
                                    fillColor: Colors.white,
                                    // errorText: 'Password Salah',
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        controller.isObscurePasswordRegister =
                                            !controller
                                                .isObscurePasswordRegister;
                                        controller.update();
                                      },
                                      child: Icon(
                                        controller.isObscurePasswordRegister
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color:
                                            controller.isErrorPasswordRegister
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
                                margin: const EdgeInsets.only(top: 20),
                                child: const Text(
                                  'Confirm Password',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 10,
                                  bottom: 20,
                                ),
                                child: TextFormField(
                                  obscureText: controller
                                      .isObscureConfirmPasswordRegister,
                                  cursorColor: Colors.black,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: controller
                                      .confirmPasswordRegisterController,
                                  validator: (confirmPassword) {
                                    if (confirmPassword == null ||
                                        confirmPassword.isEmpty) {
                                      return 'Confirm password tidak boleh kosong';
                                    } else if (confirmPassword !=
                                        controller
                                            .passwordRegisterController.text) {
                                      return 'Password tidak sama';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Masukan password sekali lagi',
                                    filled: true,
                                    fillColor: Colors.white,
                                    // errorText: 'Password Salah',
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        controller
                                                .isObscureConfirmPasswordRegister =
                                            !controller
                                                .isObscureConfirmPasswordRegister;
                                        controller.update();
                                      },
                                      child: Icon(
                                        controller
                                                .isObscureConfirmPasswordRegister
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: controller.isErrorConfirmRegister
                                            ? Colors.red
                                            : Colors.black,
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
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                  onPressed: () {
                                    final form =
                                        controller.formKeyRegister.currentState;
                                    if (form!.validate()) {
                                      controller.doRegister(
                                        name: controller
                                            .namaRegisterController.text,
                                        email: controller
                                            .emailRegisterController.text,
                                        password: controller
                                            .passwordRegisterController.text,
                                      );
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
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
