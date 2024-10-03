import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:groceryapp/firebase/Auth/Authpage.dart';  
import 'package:groceryapp/keys/keys.dart';
import 'package:groceryapp/provider/cartitemsprovider.dart';
import 'package:groceryapp/provider/user%20provider.dart';
import 'package:groceryapp/screens/login.dart';
import 'package:provider/provider.dart';  
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Stripe.publishableKey = Publishablekey;
  await Stripe.instance.applySettings();
  runApp(groceryApp());
}

class groceryApp extends StatelessWidget {
  const groceryApp({super.key});
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => userprovider()),
        ChangeNotifierProvider(create: (context) => cartitemsprovider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Grocery App',
        home: Authpage(),
        routes: {
          '/login': (context) => Login(),
          // other routes
        },
      ),
    );
  }
}
