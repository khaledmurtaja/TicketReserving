

import 'package:flutter/material.dart';
import 'package:ticketreserving/Style/Colors.dart';

//this is a constant decoration which has been used many times as a decoration for many widgets in this project
BoxDecoration getBoxDecoration(BuildContext context,
        {isPressed = false, borderRadius = 15.0, blurRadius = 6.0}) =>
    BoxDecoration(
        color: primaryColor,
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
Widget myCardView(BuildContext context,dynamic balance) => Padding(
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
                      Text(
                        "${balance} ethers",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
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
Widget myBottomSheet(BuildContext context){
  return Container(
      height: 200,
      width: double.infinity,
      alignment: Alignment.center,
    decoration: getBoxDecoration(context),

  );
}
//Transaction item
Widget transactionItem(BuildContext context){
  return Container(
   // width: double.infinity,
    //height: 50,
    decoration: getBoxDecoration(context),
    child:Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Column(
            children: [
              Text("Apple music"),
              Text("22 feb,10:12 pm")
            ],
          ),
          Spacer(),
          Text("25\$")
        ],
      ),
    ),
  );

}
Widget listOfTransactions(){
  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    itemCount: 51,
      itemBuilder:(context,index){
        return transactionItem(context);

  }
  );
}

