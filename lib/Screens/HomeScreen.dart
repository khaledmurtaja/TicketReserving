import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:ticketreserving/Components/components.dart';
import 'package:ticketreserving/Screens/HomeScreenCubit/Cubit.dart';
import 'package:ticketreserving/Screens/HomeScreenCubit/states.dart';
import '../Style/Colors.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocConsumer<HomeScreenCubit, HomeScreenStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeScreenCubit.get(context);
        if (state is ConnectToNetworkFailed) {
          print("khaled");
          return Scaffold(
              body: Center(
                child: BasicDialogAlert(
                  title: Text("No internet connection"),
                  content: Text(
                      "This app is using realtime data\nplease check your network connection"),
                  actions: <Widget>[
                    BasicDialogAction(
                      title: Text("OK"),
                      onPressed: () {
                        cubit.getWalletBalance();
                      },
                    ),
                  ],
                ),
              ));
        } else if (state is SuccessGettingForData) {
          return Scaffold(
            key: scaffoldKey,
            floatingActionButton: FloatingActionButton(
              child: _buildNAppBarButton(Icons.add,context),
              onPressed: () {
                scaffoldKey.currentState!
                    .showBottomSheet((context) => myBottomSheet(context));
              },
            ),
            backgroundColor: primaryColor,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 55),
                child: SingleChildScrollView(
                  //physics:  NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      myCardView(context, cubit.walletBalance),
                      SizedBox(
                        height: 20,
                      ),
                      listOfTransactions()
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}

// Row BuildAppNavBar(BuildContext context) => Row(
//       children: [
//         Spacer(),
//         _buildNAppBarButton(Icons.add, context),
//       ],
//     );
Container _buildNAppBarButton(IconData iconData, BuildContext context) =>
    Container(
      height: 80,
      width: 80,
      child: Icon(
        iconData,
        color: Colors.black,
      ),
      decoration: getBoxDecoration(context),
    );
