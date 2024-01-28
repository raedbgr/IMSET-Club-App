import 'package:email_validator/email_validator.dart';
import 'package:imset_club_app/auth/login_page.dart';
import 'package:imset_club_app/components/animated_text.dart';
import 'package:imset_club_app/components/text_field.dart';
import 'package:imset_club_app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final AuthController _myController = Get.put(AuthController());
  bool _pwdVisibility = true;

  String? _validateEmail(String email) {
    if (email.isEmpty) {
      return 'Email is required';
    } else if (!EmailValidator.validate(email)) {
      return 'Enter a valid email';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            reverse: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.person,
                      size: 100,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const MyAnimatedText(text: 'Let\'s create an account'),
                    const SizedBox(height: 25),
                    // username Controller
                    MyTextField(
                      controller: _nameController,
                      hintText: 'Full Name',
                    ),
                    const SizedBox(height: 10),
                    // email controller
                    MyTextField(
                      controller: _emailController,
                      hintText: 'Email',
                    ),
                    const SizedBox(height: 10),
                    // email controller
                    MyTextField(
                      controller: _phoneController,
                      hintText: 'Phone Number',
                    ),
                    const SizedBox(height: 10),
                    // password controller
                    TextField(
                      controller: _pwdController,
                      obscureText: _pwdVisibility,
                      decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          suffixIcon: _pwdVisibility
                              ? IconButton(
                              onPressed: () {
                                setState(() {
                                  _pwdVisibility = false;
                                });
                              },
                              icon: Icon(
                                Icons.visibility_off,
                                color: Colors.grey.shade600,
                              ))
                              : IconButton(
                              onPressed: () {
                                setState(() {
                                  _pwdVisibility = true;
                                });
                              },
                              icon: Icon(
                                Icons.visibility,
                                color: Colors.grey.shade600,
                              ))),
                    ),
                    const SizedBox(height: 25),
                    MaterialButton(
                      onPressed: () {
                        if (_nameController.text.isEmpty || _emailController.text.isEmpty || _pwdController.text.isEmpty) {
                          const snackBar = SnackBar(content: Text('Please enter your fields !'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else if (!EmailValidator.validate(_emailController.text)) {
                          const snackBar = SnackBar(content: Text('Please enter a valid email !'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          _myController.signUp(_nameController.text,
                              _emailController.text.trim(), _phoneController.text.trim(), _pwdController.text.trim(), context);
                        }
                      },
                      child: Container(
                        width: 250,
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        'Already have an account ?',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.offAll(LoginPage());
                        },
                        child: const Text(
                          'Login now',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
