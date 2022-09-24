import 'dart:io';

import 'package:Ess_Conn/Application/Staff_Providers/Attendencestaff.dart';
import 'package:Ess_Conn/Application/Staff_Providers/MarkEntryProvider.dart';
import 'package:Ess_Conn/Application/Staff_Providers/StaffProfile.dart';
import 'package:Ess_Conn/Application/Staff_Providers/StudListProvider.dart';
import 'package:Ess_Conn/Application/Staff_Providers/TimetableProvider.dart';
import 'package:Ess_Conn/Application/StudentProviders/GalleryProvider.dart';
import 'package:Ess_Conn/Application/StudentProviders/PasswordChangeProvider.dart';
import 'package:Ess_Conn/Application/StudentProviders/ProfileProvider.dart';
import 'package:Ess_Conn/Application/StudentProviders/ReportCardProvider.dart';
import 'package:Ess_Conn/Application/StudentProviders/SiblingsProvider.dart';
import 'package:Ess_Conn/Application/StudentProviders/TimetableProvider.dart';
import 'package:Ess_Conn/Presentation/Admin/AdminHome.dart';
import 'package:Ess_Conn/Presentation/Staff/StaffHome.dart';
import 'package:Ess_Conn/routes.dart';
import 'package:Ess_Conn/utils/constants.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Application/StudentProviders/AttendenceProvider.dart';
import 'Application/StudentProviders/FeesProvider.dart';
import 'Application/StudentProviders/LoginProvider.dart';

import 'Application/StudentProviders/NoticProvider.dart';
import 'Presentation/Login_Activation/ActivatePage.dart';
import 'Presentation/Login_Activation/LoginPageWeb.dart';
import 'Presentation/Login_Activation/Login_page.dart';
import 'Presentation/Student/Student_home.dart';

import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (Platform.isAndroid) {
    //await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(GjInfoTech()));

  await FlutterDownloader.initialize(debug: true);
  //await Permission.storage.request();

  runApp(GjInfoTech());
}

class GjInfoTech extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<GjInfoTech> createState() => _GjInfoTechState();
}

class _GjInfoTechState extends State<GjInfoTech> {
  SharedPreferences? prefs;
  _checkSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('activated') != null) {
      activated = true;
    }
  }

  bool? activated;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getBool('activated') != null) {
        activated = true;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => NoticeProvider()),
        ChangeNotifierProvider(create: (context) => AttendenceProvider()),
        ChangeNotifierProvider(create: (context) => FeesProvider()),
        ChangeNotifierProvider(create: (context) => GalleryProvider()),
        ChangeNotifierProvider(create: (context) => ReportCardProvider()),
        ChangeNotifierProvider(create: (context) => Timetableprovider()),
        ChangeNotifierProvider(create: (context) => PasswordChangeprovider()),
        ChangeNotifierProvider(create: (context) => SibingsProvider()),
        ChangeNotifierProvider(create: (context) => StaffProfileProvider()),
        ChangeNotifierProvider(
            create: (context) => StudReportListProvider_stf()),
        ChangeNotifierProvider(create: (context) => MarkEntryProvider()),
        ChangeNotifierProvider(create: (context) => StaffTimetableProvider()),
        ChangeNotifierProvider(create: (context) => AttendenceStaffProvider()),
      ],
      child: MaterialApp(
        title: 'Ess Connect',
        theme: ThemeData(
          primaryColor: UIGuide.PRIMARY,

          inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.black))),
          // primarySwatch: Colors.deepOrange,
        ),
        // home: MyHomePage(title: 'Flutter Demo Home Page'),
        routes: routes,
        home: SplashFuturePage(),
        // home: LoginPage(),
        debugShowCheckedModeBanner: false,
        //home : MyHomepage(),
        //home:LoginSecondPage(),
      ),
    );
  }
}

class SplashFuturePage extends StatefulWidget {
  SplashFuturePage({Key? key}) : super(key: key);

  @override
  _SplashFuturePageState createState() => _SplashFuturePageState();
}

class _SplashFuturePageState extends State<SplashFuturePage> {
  SharedPreferences? prefs;
  Future<Widget> _checkSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('activated') != null) {
      if (prefs.getString('accesstoken') != null) {
        var data = await parseJWT();
        if (data['role'] == "SystemAdmin") {
          return Future.value(AdminHome());
        } else if (data['role'] == "Teacher") {
          return Future.value(StaffHome());
        } else {
          return Future.value(StudentHome());
        }
      } else {
        return Future.value(LoginPage());
      }
    } else {
      return Future.value(const ActivatePage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      durationInSeconds: 2,
      logo: Image.asset('assets/logo.png'),
      title: const Text(
        "Ess Online",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.grey.shade400,
      showLoader: true,
      loadingText: Text("Loading..."),
      futureNavigator: _checkSession(),
    );
  }
}
