
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:web3dart/credentials.dart';
//This is the Api where you can find your node in the ropsten blockchain
final ethClient="https://ropsten.infura.io/v3/d068a0effe174aea890f8d8b307225df";
//private key for the wallet
final credentials = EthPrivateKey.fromHex("b9a16190ee9cafb212c4f27cfbf466e6672abc29b6d04451893e0894174aa755");
// final address
final address =credentials.address;
final ConnectivityResult noNetwork=ConnectivityResult.none;


