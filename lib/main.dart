import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase1/firebase_exercise_3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase1/firebase_exersice_1.dart';
import 'package:flutter_firebase1/firebase_exercise_2.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FirebaseExercise',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //この部分を問題に合わせて適時変更してください。
      home:
      //const home(),
      const Posts(),
      //const AuthExercise(),

    );
  }
}

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();

}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: (){
                addUser();
              },
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))
              ), 
            child: const Text('user1の追加', style: TextStyle(color: Colors.white),),
          ),
          TextButton(
              onPressed: () => {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return FireStoreExercise(userId: 'user1');
                }))
              },
              child: Text("進む", style: TextStyle(fontSize: 50)))
        ],
      ),
    ),
    );
  }

  void addUser()async{
    await FirebaseFirestore.instance.collection('users').doc('user1').set({
      'name':'user1',
      'age':10
    });
  }
}

