import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:ticketreserving/BlocObserver.dart';
import 'package:ticketreserving/Screens/HomeScreenCubit/Cubit.dart';
import 'package:ticketreserving/SmartContract/TicketContract.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';
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
      create: (context)=>HomeScreenCubit()..networkConnection(),//..getWalletBalance(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen()
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   late Client httpClient;
//   late Web3Client ethClient;
//   final credentials = EthPrivateKey.fromHex("b9a16190ee9cafb212c4f27cfbf466e6672abc29b6d04451893e0894174aa755");
//   final EthereumAddress ethereumAddress=EthereumAddress.fromHex("0x5672a07d469A5d0E9c61525575Fa03622Bd79623");
//   @override
//   void initState() {
//     String? abi;
//     super.initState();
//     httpClient=Client();
//     ethClient=Web3Client("https://ropsten.infura.io/v3/d068a0effe174aea890f8d8b307225df", httpClient);
//     final address=credentials.address;
//     // ethClient.getBalance(address).then((value){
//     //   print(value);
//     // });
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//  getNumberOfTickets(ethClient,[EthereumAddress.fromHex("0x5672a07d469A5d0E9c61525575Fa03622Bd79623")]);
//     return Scaffold(
//       appBar: AppBar(
//           title:Text("kha")
//       ),
//       body:Column(
//         children: [
//           TextButton(
//               onPressed: ()
//               {
//                 print(getNumberOfTickets(ethClient,[EthereumAddress.fromHex("0x5672a07d469A5d0E9c61525575Fa03622Bd79623")]));
//               },
//               child: Text("press me"))
//
//         ],
//       )
//     );
//   }
// }
