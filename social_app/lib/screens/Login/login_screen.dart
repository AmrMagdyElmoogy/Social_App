import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/screens/Home/home.dart';
import 'package:social_app/shared/local/cacheHelper.dart';
import '../../business_logic/cubit/social_cubit/login_cubit.dart';
import '../../business_logic/cubit/social_states/social_states.dart';
import '../Register/register_screen.dart';

enum ToastOptions { Success, Error, Warning }

class Login extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialSuccessLoginState) {
          CacheHelper.setData(key: 'uid', value: state.uid).then((value) => {
                print(state.uid),
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Home()),
                    (route) => false)
              });
          buildToast(message: 'Welcome', to: ToastOptions.Success);
        }
      },
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipPath(
                        clipper: WaveClipperTwo(),
                        child: Container(
                          height: 200,
                          color: Colors.blue,
                          child: Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(children: [
                        Text(
                          'Welcome Back!',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter your email address';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            prefixIcon: Icon(Icons.email_outlined),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (value) {
                            if (formKey.currentState.validate()) {
                              cubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          obscureText: cubit.isPassword,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.remove_red_eye_outlined),
                              onPressed: () {
                                cubit.changePasswordObsecure();
                              },
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          height: 40,
                          child: state is SocialLoadingLoginState
                              ? Center(child: CircularProgressIndicator())
                              : MaterialButton(
                                  color: Colors.black,
                                  child: Text(
                                    'LOGIN',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    if (formKey.currentState.validate()) {
                                      cubit.userLogin(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  },
                                ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account ?',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Register()));
                              },
                              child: Text(
                                'Register',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void buildToast({String message, ToastOptions to}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: chooseColorOfToast(to),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Color chooseColorOfToast(ToastOptions to) {
    Color color;
    if (to == ToastOptions.Success) {
      color = Colors.green;
    } else if (to == ToastOptions.Error) {
      color = Colors.red;
    } else {
      color = Colors.amber;
    }
    return color;
  }
}
