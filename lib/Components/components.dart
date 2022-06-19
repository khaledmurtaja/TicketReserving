import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ticketreserving/Screens/HomeScreenCubit/Cubit.dart';
import 'package:ticketreserving/Style/Colors.dart';
import 'package:ticketreserving/TicketTransaction.dart';

import '../constants.dart';

//this is a constant decoration which has been used many times as a decoration for many widgets in this project
BoxDecoration getBoxDecoration(BuildContext context,
        {isPressed = false, borderRadius = 15.0, blurRadius = 6.0, color=primaryColor}) =>
    BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            offset: isPressed ? Offset(-3, -3) : Offset(4, 4),
            color: Colors.black12,
            blurRadius: blurRadius,
          ),
          BoxShadow(
            offset: isPressed ? Offset(3, 3) : Offset(-3, -3),
            color: Colors.white,
            blurRadius: blurRadius,
          )
        ]);
// this is the code for the card view which is used in the homeScreen.dart
Widget myCardView(BuildContext context, dynamic balance) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ticket booking",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            decoration: getBoxDecoration(context),
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Wallet info",
                        style: TextStyle(color: Colors.blueGrey[300]),
                      ),
                      Spacer(),
                      Text(
                        "Ropston network",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Balance",
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${balance} ethers",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                          IconButton(
                              onPressed:(){
                                HomeScreenCubit.get(context).getContractData();

                              },
                              icon:Icon(Icons.refresh_rounded)
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
// bottom sheet will be shown after clicking on the floating action button in the home screen
Widget myBottomSheet(BuildContext context) {
  TextEditingController _movie=TextEditingController();
  TextEditingController _numOfTickets=TextEditingController();
  return Container(
    height: 330,
    width: double.infinity,
    alignment: Alignment.center,
    decoration: getBoxDecoration(context,color: Colors.white24),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            "Cinema 4 up",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22
            ),
          ),
          SizedBox(height: 30,),
          Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: Colors.grey,width: 2),
                right: BorderSide(color: Colors.grey,width: 2),
                top: BorderSide(color: Colors.grey,width: 2),
                bottom: BorderSide(color: Colors.grey,width: 5),
              )
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller:_movie,
                    readOnly: true,
                    decoration: InputDecoration(
                      label: Text("movie")
                    ),
                  ),
                ),
                Container(
                  child: DropdownButton(
                      items:<DropdownMenuItem<String>> [
                        DropdownMenuItem(
                            value: "strangers",
                            child: Text("strangers")
                        ),
                        DropdownMenuItem(
                            value: "who am i",
                            child: Text("who am i")
                        ),
                        DropdownMenuItem(
                            value: "me & you",
                            child: Text("me & you")
                        ),
                        DropdownMenuItem(
                            value: "war 3",
                            child: Text("war 3")
                        ),
                        DropdownMenuItem(
                            value: "mr robot",
                            child: Text("mr robot")
                        ),
                        DropdownMenuItem(
                            value: "honest",
                            child: Text("honest")
                        ),
                        DropdownMenuItem(
                            value: "kissing booth",
                            child: Text("kissing booth")
                        ),
                        DropdownMenuItem(
                            value: "underwater",
                            child: Text("underwater")
                        ),

                      ],
                      onChanged:(value){
                        _movie.text=value.toString();

                      }
                  ),
                ),


              ],
            ),
          ),

          SizedBox(height: 30,),
          TextField(
            controller:_numOfTickets ,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'number of tickets to buy',
            ),
          ),
          SizedBox(height: 30,),
          Container(
            width: 200,
            child: OutlinedButton(
                onPressed:(){
                  List<dynamic> list=[BigInt.parse(_numOfTickets.text),_movie.text,];
                  HomeScreenCubit cubit=HomeScreenCubit.get(context);
                  cubit.buyTicket(list);
                },
                child: Text("buy now")
            ),
          )
        ],
      ),
    ),
  );
}

//Transaction item
Widget transactionItem(BuildContext context,TicketTransaction ticketTransaction) {
  return Container(
    decoration: getBoxDecoration(context),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Movie :${ticketTransaction.movieName}",
              ),
              SizedBox(height: 5,),
              Text("number of reserved tickets:${ticketTransaction.numOfTickets}")],
          ),
          Spacer(),
          Text(
              "price:${double.parse("${ticketTransaction.numOfTickets}")*0.01}",
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
          )
        ],
      ),
    ),

  );
}

Widget listOfTransactions(HomeScreenCubit cubit) {
  return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: cubit.numOfTickets.length,
      itemBuilder: (context, index) {
        TicketTransaction ticketTransaction=TicketTransaction(movieName: cubit.movies.elementAt(index), numOfTickets:cubit.numOfTickets.elementAt(index));
        return transactionItem(context,ticketTransaction);
      });
}

// customToast
void toast(String message) {
  Fluttertoast.showToast(msg: "$message",backgroundColor: Colors.blueGrey);
}

// dialog box
Widget dialog(String title, String content, String action, Function function) {
  return Scaffold(
      body: Center(
    child: BasicDialogAlert(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        BasicDialogAction(
          title: Text(action),
          onPressed: () {
            function();
            //cubit.getWalletBalance();
          },
        ),
      ],
    ),
  ));
}

//HomeScreen in the normal state of the application
Widget screen(BuildContext context, HomeScreenCubit cubit) {
cubit.showBottomSheet=false;
  return Scaffold(
    key: scaffoldKey,
    floatingActionButton: FloatingActionButton(
      child: _buildNAppBarButton(Icons.add, context),
      onPressed: () {
        if(cubit.showBottomSheet==false) {
          PersistentBottomSheetController p= scaffoldKey.currentState!
              .showBottomSheet((context) => myBottomSheet(context));
          cubit.showBottomSheet=true;
          p.closed.then((value){
            cubit.showBottomSheet=false;
          });
        }else{
          Navigator.pop(context);
          cubit.showBottomSheet=false;
        }

      },
    ),
    backgroundColor: primaryColor,
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 55),
        child: SingleChildScrollView(
          //physics:  NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                myCardView(context, cubit.walletBalance),
                SizedBox(
                  height: 20,
                ),
                Text(
                    "List of transactions",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                listOfTransactions(cubit)
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

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
