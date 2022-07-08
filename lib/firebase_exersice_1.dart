import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireStoreExercise extends StatefulWidget {
  const FireStoreExercise({Key? key, required this.userId}) : super(key: key);
  final String userId;

  @override
  _FireStoreExerciseState createState() => _FireStoreExerciseState();
}
class _FireStoreExerciseState extends State<FireStoreExercise> {

  TextEditingController nameEditingController = TextEditingController();
  TextEditingController ageEditingController = TextEditingController();

  String name = '';
  int age = 0;

  void setProfile() async{
    name = nameEditingController.text;
    age = int.parse(ageEditingController.text);
    await FirebaseFirestore.instance.collection('users').doc(widget.userId).set({
      'name':name,
      'age':age
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection('users').doc(widget.userId).get(),
          builder: (context, snapshot) {
            if(snapshot.hasData&&snapshot.data!.exists){

              Map<String,dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
              name = data['name'];
              age = data['age'];
              //テキストフィールドに初期値を与えている
              nameEditingController = TextEditingController(text: name);
              ageEditingController = TextEditingController(text: age.toString());
              return Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width/2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: nameEditingController,
                        decoration: const InputDecoration(labelText: '名前', border: OutlineInputBorder()),
                      ),
                      const SizedBox(height: 20,),
                      TextField(
                        controller: ageEditingController,
                        decoration: const InputDecoration(labelText: '年齢', border: OutlineInputBorder()),
                      ),
                      const SizedBox(height: 20,),
                      ElevatedButton(
                        onPressed: (){
                          setProfile();
                        },
                        child: const Text('データ更新', style: TextStyle(color: Colors.white),),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }else{
              return const Center(child: CircularProgressIndicator(),);
            }
          }
      ),
    );
  }
}
