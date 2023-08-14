import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();
  var _enteredEmail = '';
  var _enteredPassowrd = '';
  var _enteredUsername = '';
  File? _selectedImage;

  // void _submit() async {
  //   setState(() {
  //     isAuthenticating = true;
  //   });

  //   bool isValid = _form.currentState!.validate();

  //   if (!isValid || _selectedImage == null && !isLogin) {
  //     setState(() {
  //       isAuthenticating = false;
  //     });
  //     return;
  //   }
  //   _form.currentState!.save();
  //   try {
  //     if (isLogin) {
  //       final userCredentials = await _firebase.signInWithEmailAndPassword(
  //           email: _enteredEmail, password: _enteredPassowrd);
  //     } else {
  //       final userCredentials = await _firebase.createUserWithEmailAndPassword(
  //         email: _enteredEmail,
  //         password: _enteredPassowrd,
  //       );
  //       final storageRef = FirebaseStorage.instance
  //           .ref()
  //           .child('user_images')
  //           .child('${userCredentials.user!.uid}.jpg');
  //       await storageRef.putFile(_selectedImage!);
  //       final imageUrl = await storageRef.getDownloadURL();
  //       print(imageUrl);
  //       await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(userCredentials.user!.uid)
  //           .set({
  //         'username': _enteredUsername,
  //         'email': _enteredEmail,
  //         'image_url': imageUrl,
  //       });
  //     }
  //   } on FirebaseAuthException catch (error) {
  //     setState(() {
  //       isAuthenticating = false;
  //     });
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text(error.message ?? 'Authentication failed'),
  //       backgroundColor: Theme.of(context).colorScheme.error,
  //     ));
  //   }
  // }

  var isLogin = true;
  var isAuthenticating = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                width: 200,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.asset('assets/images/OnBoardsq.jpg')),
              ),
              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  color: const Color(0xFFebebeb),
                  margin: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                          key: _form,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (!isLogin)
                                const CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.grey,
                                  backgroundImage: AssetImage(
                                      'assets/images/avat.png'),
                                ),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                textCapitalization: TextCapitalization.none,
                                autocorrect: false,
                                decoration: const InputDecoration(
                                  labelText: 'Email address',
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().isEmpty ||
                                      !value.contains('@')) {
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                },
                                onSaved: (newValue) {
                                  _enteredEmail = newValue!;
                                },
                              ),
                              if (!isLogin)
                                TextFormField(
                                  decoration: const InputDecoration(
                                      labelText: 'Username'),
                                  enableSuggestions: false,
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.length < 4) {
                                      return 'Username must be atleast 4 characters long';
                                    }
                                    return null;
                                  },
                                  onChanged: (newValue) {
                                    _enteredUsername = newValue;
                                  },
                                ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Password',
                                ),
                                obscureText: true,
                                onChanged: (newValue) {
                                  _enteredPassowrd = newValue;
                                },
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().isEmpty ||
                                      value.trim().length < 6) {
                                    return 'Password must be atleast 6 characters long.';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              isAuthenticating
                                  ? const CircularProgressIndicator()
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .primaryContainer),
                                      onPressed: () {},
                                      child: Text(isLogin ? 'Login' : 'Signup'),
                                    ),
                              if (!isAuthenticating)
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isLogin = !isLogin;
                                    });
                                  },
                                  child: Text(
                                    isLogin
                                        ? 'Create an account'
                                        : 'Already have an account? Login',
                                    style: const TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                )
                            ],
                          )),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
