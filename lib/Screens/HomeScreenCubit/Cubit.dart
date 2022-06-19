import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketreserving/Screens/HomeScreenCubit/states.dart';
import 'package:ticketreserving/constants.dart';
import 'package:web3dart/web3dart.dart';
import '../../SmartContract/constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class HomeScreenCubit extends Cubit<HomeScreenStates> {
  var walletBalance;
  bool showBottomSheet = false;
  List movies = [];
  List numOfTickets = [];
  var numberOfAvailableTickets;
  HomeScreenCubit() : super(InitialState());
  static HomeScreenCubit get(BuildContext context) => BlocProvider.of(context);
  //this function from line(17 to 59) for getting data from the smart contract before building the screen
  Future<void> getContractData() async {
    final contract = await loadContract();
    emit(LoadingDataFromContract());
    Web3Client web3client = ethClient;
    web3client.getBalance(address).then((value) {
     walletBalance= value.getValueInUnit(EtherUnit.ether);
      web3client.call(
          contract: contract,
          function: contract.function("getMoviesNamesArray"),
          params: []).then((value) {
        movies = value[0];
        print("success in getting movies array");
      }).catchError((onError) {
        print("error in getting movies array");
      });
     web3client.call(
         contract: contract,
         function: contract.function("getNumberOfAvailableTickets"),
         params: []).then((value) {
           numberOfAvailableTickets=value[0];
           print(numberOfAvailableTickets);
       print("success in getting number of available tickets");
     }).catchError((onError) {
       print("error in getting number of available tickets${onError}");
     });
      web3client.call(
          contract: contract,
          function: contract.function("getReservedTicketsArray"),
          params: []).then((value) {
        numOfTickets = value[0];
        print("success in getting reserved tickets array");
        emit(SuccessGettingForData());
      }).catchError((onError) {
        emit(ErrorGettingForData());
        print("error in getting movies array");
      });
    }).catchError((onError) {
      networkConnection();
    });
  }
  // this function uses a stream to observe network status

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
        getContractData();
      }
    });
  }

// this function is for loading the contract
  Future<DeployedContract> loadContract() async {
    String abi = await rootBundle.loadString("assets/abi.json");
    EthereumAddress ethereumAddress =
        EthereumAddress.fromHex("0x806fd196b8eA34C352DB4147bdF897BC0F37e149");
    final contract = DeployedContract(
        ContractAbi.fromJson(
          abi,
          'Ticket',
        ),
        ethereumAddress);
    return contract;
  }
  // this function is for buying tickets it takes a list of param(movieName,ticket number)

  Future<void> buyTicket(List<dynamic> param) async {
    emit(LoadingSendingTransactionToSmartContract());
    final contract = await loadContract();
    final credentials1 = EthPrivateKey.fromHex(
        "b9a16190ee9cafb212c4f27cfbf466e6672abc29b6d04451893e0894174aa755");
    final result = ethClient
        .sendTransaction(
      credentials1,
      Transaction.callContract(
        from:EthereumAddress.fromHex("0x5672a07d469A5d0E9c61525575Fa03622Bd79623"),
        value:  EtherAmount.fromUnitAndValue(EtherUnit.wei,"100000000000000000"),
          contract: contract,
          function: contract.function("BuyTicket"),
          parameters: param),
      chainId: 3,
    )
        .then((value) async {
          numOfTickets.add(param[0]);
          movies.add(param[1]);
      emit(SuccessSendingTransactionToSmartContract());
    }).catchError((error) {
      emit(FailedSendingTransactionToSmartContract());
      print(error);
    });
  }

}
