import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketreserving/Screens/HomeScreenCubit/states.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import '../../SmartContract/constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class HomeScreenCubit extends Cubit<HomeScreenStates> {
  HomeScreenCubit() : super(InitialState());
  static HomeScreenCubit get(BuildContext context) => BlocProvider.of(context);
  var walletBalance;
  void getWalletBalance() async {
    emit(LoadingDataFromContract());
    Web3Client web3client = Web3Client(ethClient, Client());
    web3client.getBalance(address).then((value) {
      walletBalance = value.getInEther;
      print(value);
      emit(SuccessGettingForData());
    }).catchError((onError) {
      emit(ErrorGettingForData());
      networkConnection();
    });
  }

  void networkConnection() async {
    Connectivity connectivity = Connectivity();
    var connectivityResult = await (connectivity.checkConnectivity());
    if (connectivityResult == noNetwork) {
      emit(ConnectToNetworkFailed());
    }
    connectivity.onConnectivityChanged.listen((event) async {
      var connectivityResult = await (connectivity.checkConnectivity());
      if (connectivityResult == noNetwork) {
        emit(ConnectToNetworkFailed());
      } else {
        getWalletBalance();
      }
    });
  }
}
