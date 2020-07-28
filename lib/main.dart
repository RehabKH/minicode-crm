// import 'package:animated_splash/animated_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minicode_crm/translation/localHelper.dart';
import 'package:minicode_crm/translation/localizations.dart';
// import 'package:minicode_crm/ui/bd.dart';
import 'package:minicode_crm/ui/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SpecificLocalizationDelegate _specificLocalizationDelegate;

@override void initState() {
   
    super.initState();
    helper.onLocaleChanged = onLocaleChange;
    _specificLocalizationDelegate =  SpecificLocalizationDelegate(new Locale("en"));
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent)
    );
  //  SystemChrome.setSystemUIOverlayStyle(
  //     SystemUiOverlayStyle(statusBarColor: Colors.white24)
  //   );
   //SystemChrome.setEnabledSystemUIOverlays([]);
  }

 onLocaleChange(Locale locale){
    setState((){
      
      _specificLocalizationDelegate = new SpecificLocalizationDelegate(locale);
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MiniCode CRM',     
       localizationsDelegates: [
       GlobalMaterialLocalizations.delegate,
       GlobalWidgetsLocalizations.delegate,
     new FallbackCupertinoLocalisationsDelegate(),
       _specificLocalizationDelegate
     ],

      supportedLocales: [Locale('en'),Locale('ar')],
     locale: _specificLocalizationDelegate.overriddenLocale ,
      theme: ThemeData(
      primaryColor: Colors.indigo,
       textTheme: GoogleFonts.solwayTextTheme(
            Theme.of(context).textTheme,
          ),
             visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashPage(),
    
      debugShowCheckedModeBanner: false,

    );
  }
}

