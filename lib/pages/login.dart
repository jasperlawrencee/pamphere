import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pamphere/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:pamphere/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:pamphere/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:pamphere/components/constants.dart';
import 'package:pamphere/components/widgets.dart';
import 'package:pamphere/pages/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool signInRequired = false;
  bool obscureText = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInSuccess) {
          setState(() {
            signInRequired = false;
          });
          ToastNotifications().sucessToast(message: "Logged In");
        } else if (state is SignInProcess) {
          setState(() {
            signInRequired = true;
          });
        } else if (state is SignInFailure) {
          setState(() {
            signInRequired = false;
          });
          ToastNotifications().failToast(message: "Error: Failure Logging In");
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
                    'Login',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Welcome back to PampHere',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  SizedBox(height: defaultPadding * 3),
                  Text(
                    'Email Address',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: defaultPadding / 2),
                  MyTextFormField(
                    prefixIcon: CupertinoIcons.mail,
                    controller: emailController,
                    hintText: "hello@email.com",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!emailRegEx.hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    obscureText: false,
                  ),
                  SizedBox(height: defaultPadding),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Password',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: primaryColor),
                      )
                    ],
                  ),
                  SizedBox(height: defaultPadding / 2),
                  MyTextFormField(
                    controller: passwordController,
                    hintText: 'Your Password',
                    validator: (value) {
                      return null;
                    },
                    obscureText: obscureText,
                    prefixIcon: CupertinoIcons.lock,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        icon: Icon(obscureText
                            ? CupertinoIcons.eye_fill
                            : CupertinoIcons.eye_slash_fill)),
                  ),
                  Spacer(),
                  PrimaryButton(
                    ontap: !signInRequired
                        ? () {
                            if (formKey.currentState!.validate()) {
                              context.read<SignInBloc>().add(SignInRequired(
                                    emailController.text,
                                    passwordController.text,
                                  ));
                            }
                          }
                        : () {
                            null;
                          },
                    child: !signInRequired
                        ? Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          )
                        : SizedBox.square(
                            dimension: 20,
                            child:
                                CircularProgressIndicator(color: Colors.white),
                          ),
                  ),
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
                        //google login here
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
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => SignUpBloc(
                                userRepository: context
                                    .read<AuthenticationBloc>()
                                    .userRepository),
                            child: Signup(),
                          ),
                        ));
                      },
                      child: Text(
                        'Create an account',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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
