import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/contracts.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';

import 'constants.dart';

Future<DeployedContract> loadContract() async {
  String abi = await rootBundle.loadString("assets/abi.json");
  EthereumAddress ethereumAddress =
      EthereumAddress.fromHex("0x420521E1660986a70A7AdAc9e8594446254E5cC5");
  final contract = DeployedContract(
      ContractAbi.fromJson(
        abi,
        'Ticket',
      ),
      ethereumAddress);
  return contract;
}

Future<List<dynamic>> query(List<dynamic> param, Web3Client ethClient) async {
  final contract = await loadContract();
  final credentials1 = EthPrivateKey.fromHex(
      "b9a16190ee9cafb212c4f27cfbf466e6672abc29b6d04451893e0894174aa755");
  final result= await ethClient.call(contract: contract,
      function: contract.function("_TicketHolders"), params: param);
  // final result = await ethClient.sendTransaction(
  //   credentials1,
  //
  //   Transaction.callContract(
  //       contract: contract,
  //       function: contract.function("_TicketHolders"),
  //       parameters: param),
  //   chainId: 3,
  // );
  return result;
}

Future<void> getNumberOfTickets(
    Web3Client web3client, List<dynamic> param) async {
  final result = await query(param, web3client);
  print(result);
}
// void getWalletBalance() async {
//   Web3Client web3client=Web3Client(ethClient, Client());
//    web3client.getBalance(address).then((value){
//      balance=value;
//    });
//
//
// }
