import 'package:flutter/material.dart';
import 'package:ticketreserving/Components/components.dart';
import 'package:ticketreserving/Screens/HomeScreenCubit/Cubit.dart';

abstract class HomeScreenStates {
  Widget newState({required BuildContext context});
}

class InitialState extends HomeScreenStates {
  @override
  Widget newState({required BuildContext context}) {
    return Center(child: CircularProgressIndicator());
  }
}

class LoadingDataFromContract extends HomeScreenStates {
  @override
  Widget newState({required BuildContext context}) {
    return Center(child: CircularProgressIndicator());
  }
}

class SuccessGettingForData extends HomeScreenStates {
  @override
  Widget newState({required BuildContext context}) {
    HomeScreenCubit cubit = HomeScreenCubit.get(context);
    return screen(context, cubit);
  }
}

class ErrorGettingForData extends HomeScreenStates {
  @override
  Widget newState({required BuildContext context}) {
    return Container(
      height: 0,
      width: 0,
    );
  }
}

class SuccessSendingTransactionToSmartContract extends HomeScreenStates {
  @override
  Widget newState({required BuildContext context}) {
    toast("transaction success");
    HomeScreenCubit cubit = HomeScreenCubit.get(context);
    return screen(context, cubit);
  }
}

class FailedSendingTransactionToSmartContract extends HomeScreenStates {
  @override
  Widget newState({required BuildContext context}) {
    toast("transaction failed");
    HomeScreenCubit cubit = HomeScreenCubit.get(context);
    return screen(context,cubit);
  }
}

class LoadingSendingTransactionToSmartContract extends HomeScreenStates {
  @override
  Widget newState({required BuildContext context}) {
    return Center(child: CircularProgressIndicator());
  }
}

class ConnectToNetworkFailed extends HomeScreenStates {
  @override
  Widget newState({required BuildContext context}) {
    return dialog(
        "no network connection",
        "This app is using realtime data\nplease check your network connection",
        "refrersh", () {
      HomeScreenCubit.get(context).getContractData();
    });
  }
}
