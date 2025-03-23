import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widgets/expenses_List/expenses.dart';

var kcolorScheme=ColorScheme.fromSeed(seedColor: Color.fromARGB(255,96,59,181));
var kDarkColorScheme=ColorScheme.fromSeed(brightness:Brightness.dark,seedColor: Color.fromARGB(255,5,99,125));
void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([///app will run only on portrait mode
  //   DeviceOrientation.portraitUp,
  // ]).then((fn){
    runApp(const MyApp());
  // });


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
        darkTheme:ThemeData.dark().copyWith(colorScheme:kDarkColorScheme,///dark color
          cardTheme:CardTheme(color:kDarkColorScheme.secondaryContainer,margin:EdgeInsets.all(8)),
          elevatedButtonTheme:ElevatedButtonThemeData(
              style:ElevatedButton.styleFrom(backgroundColor:kDarkColorScheme.primaryContainer)),),
      theme: ThemeData(///light color
      ).copyWith(
          colorScheme:kcolorScheme,
          appBarTheme:AppBarTheme(backgroundColor:kcolorScheme.onPrimaryContainer, foregroundColor:kcolorScheme.primaryContainer),
          cardTheme:CardTheme(color:kcolorScheme.secondaryContainer,margin:EdgeInsets.all(8)),
              elevatedButtonTheme:ElevatedButtonThemeData(
                  style:ElevatedButton.styleFrom(backgroundColor:kcolorScheme.primaryContainer)),
          textTheme:ThemeData().textTheme.copyWith(labelSmall:TextStyle(color:Colors.purple))),
        themeMode:ThemeMode.system,
      home:  Expenses(),
    );
  }
}

