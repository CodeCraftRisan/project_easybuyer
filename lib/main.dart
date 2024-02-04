import 'package:bus_ticket_booking_app/pages/loginpage.dart';
import 'package:bus_ticket_booking_app/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AwesomeNotifications().initialize(null, [
    // Create the notification channel
    NotificationChannel(
      channelKey: 'basic_channel',
      channelName: 'Basic notifications',
      channelDescription: 'Notification channel for basic tests',
      defaultColor: Color(0xFF9D50DD),
      ledColor: Colors.white,
    )
  ]);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}
/*void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}*/

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: MyTheme.lighttheme(context),
      darkTheme: MyTheme.darktheme(context),
      home: LoginPage(),
      /*  initialRoute: "login",
      routes: {
        "/": (context) => LoginPage(),
      //  "home": (context) => HomePage(),
        "login": (context) => LoginPage(),
        "signup": (context) => SignupPage(),
      },*/
    );
  }
}

// Notification functions
void Notify() async {
  // Create a local notification
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 10,
      channelKey: 'basic_channel',
      title: 'Simple Notification',
      body: 'Simple body',
      // Uncomment if you have the image asset:
      // bigPicture: 'assets://images/protocoderlogo.png'
    ),
  );
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  await AwesomeNotifications().createNotificationFromJsonData(message.data);
}
