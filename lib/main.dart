import 'package:abstracto_frontend/pages/home%20page/home_page.dart';
// import 'package:firebase/firebase.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// void main() async {
//   // WidgetsFlutterBinding.ensureInitialized();
//   // await Firebase.initializeApp();
//   runApp(MyApp());
//   // runApp(MyApp());
// }
void main() {
  runApp(MyApp());
}
// void main() {
//   initializeApp(
//       apiKey: "AIzaSyAcxOlrZYOVDiA3KWQi_A8EBxb-EAgsgqg",
//       authDomain: "abstracto-8a700.firebaseapp.com",
//       projectId: "abstracto-8a700",
//       appId: "1:342812500873:web:daa41c51be1786086bf758",
//       storageBucket: "abstracto-8a700.appspot.com");
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Abstracto',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'AvenirNext',
            ),
      ),
      home: HomePage(),
    );
  }
}
