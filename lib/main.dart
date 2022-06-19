import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:ticketreserving/BlocObserver.dart';
import 'package:ticketreserving/Screens/HomeScreenCubit/Cubit.dart';
import 'Screens/HomeScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
 BlocOverrides.runZoned(() => runApp(MyApp()),
   blocObserver: MyBlocObserver()
 );

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>HomeScreenCubit()..networkConnection(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen()
      ),
    );
  }
}


