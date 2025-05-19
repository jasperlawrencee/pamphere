import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pamphere/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:pamphere/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:pamphere/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:pamphere/components/constants.dart';
import 'package:pamphere/components/widgets.dart';
import 'package:pamphere/pages/home.dart';
import 'package:pamphere/pages/login.dart';
import 'package:user_repository/user_repository.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool signUpRequired = false;
  bool obscureText = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          setState(() {
            signUpRequired = false;
          });
          ToastNotifications().sucessToast(message: "Created Account");
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
            (route) => false,
          );
        } else if (state is SignupProcess) {
          setState(() {
            signUpRequired = true;
          });
        } else if (state is SignupFailure) {
          ToastNotifications().failToast(message: "Error Creating Account");
          return;
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Container(
              padding: EdgeInsets.all(defaultPadding * 2),
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 100),
                  Text(
                    'Create an account',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: defaultPadding * 3),
                  Text(
                    'Full Name',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: defaultPadding / 2),
                  MyTextFormField(
                    controller: nameController,
                    hintText: "Jose Rizal",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: defaultPadding),
                  Text(
                    'Email Address',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: defaultPadding / 2),
                  MyTextFormField(
                      controller: emailController,
                      hintText: "hello@email.com",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email";
                        } else if (!emailRegEx.hasMatch(value)) {
                          return "Please enter a valid email";
                        }
                        return null;
                      }),
                  SizedBox(height: defaultPadding),
                  Text(
                    'Password',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: defaultPadding / 2),
                  MyTextFormField(
                      controller: passwordController,
                      hintText: "Your Password",
                      obscureText: obscureText,
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          icon: Icon(obscureText
                              ? CupertinoIcons.eye_fill
                              : CupertinoIcons.eye_slash_fill)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter a password";
                        }
                        if (!value.contains(RegExp(r'[A-Za-z]'))) {
                          return 'Include at least 1 letter';
                        }
                        if (!value.contains(RegExp(r'[0-9]'))) {
                          return 'Include at least 1 number';
                        }
                        if (value.length < 8) {
                          return 'Password must have at least 8 characters';
                        }
                        return null;
                      }),
                  Spacer(),
                  PrimaryButton(
                      ontap: !signUpRequired
                          ? () {
                              if (formKey.currentState!.validate()) {
                                // Declare MyUser variable
                                MyUser myUser = MyUser.emptyUser;

                                // Gives variable values to give to firestore
                                myUser = myUser.copyWith(
                                  email: emailController.text,
                                  name: nameController.text,
                                  password: passwordController.text,
                                );

                                // Logs user in
                                setState(() {
                                  context.read<SignUpBloc>().add(SignUpRequired(
                                      myUser, passwordController.text));
                                });

                                nameController.clear();
                                emailController.clear();
                                passwordController.clear();
                              }
                            }
                          : () {
                              null;
                            },
                      child: !signUpRequired
                          ? Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            )
                          : SizedBox.square(
                              dimension: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )),
                  SizedBox(height: defaultPadding),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Divider(
                        color: Colors.grey,
                      )),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding),
                        child: Text(
                          'or',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Expanded(
                          child: Divider(
                        color: Colors.grey,
                      )),
                    ],
                  ),
                  SizedBox(height: defaultPadding),
                  SecondaryButton(
                      ontap: () {
                        //google signup here
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.google),
                          SizedBox(width: defaultPadding),
                          Text("Continue with Google"),
                        ],
                      )),
                  SizedBox(height: defaultPadding * 2),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => SignInBloc(
                                    userRepository: context
                                        .read<AuthenticationBloc>()
                                        .userRepository),
                                child: LoginPage(),
                              ),
                            ));
                          },
                          child: Text(
                            'Sign in here',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
