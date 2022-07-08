import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase1/home.dart';
import 'package:flutter_firebase1/sign_up.dart';
import 'package:flutter/material.dart';

class AuthExercise extends StatefulWidget {
  const AuthExercise({Key? key}) : super(key: key);

  @override
  State<AuthExercise> createState() => _AuthExerciseState();
}

class _AuthExerciseState extends State<AuthExercise> {
  bool _isSignedIn = false;
  String userId = '';

  //問３
  void checkSignInState(){
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (User == null){
        setState((){
          _isSignedIn = false;
        });
      } else {
        userId = user!.uid;
        setState ((){
          _isSignedIn = true;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //リスナーの実行を忘れないようにしましょう。
    checkSignInState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: _isSignedIn?Home(userId: userId):const SignUp(),
    );
  }
}
