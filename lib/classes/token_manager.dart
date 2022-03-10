import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:scratch_me/locators/service_locator.dart';
import 'package:web3dart/contracts.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';

class TokenManager {
  Future<DeployedContract> loadContract() async {
    String abiCode = await rootBundle
        .loadString("scracth_me_contracts/build/contracts/TokenManager.json");
    String? contractAddress = dotenv.env["TOKEN_MANAGER_ADDRESS"];
    String? privateKey = dotenv.env["ADMIN_PRIVATE_KEY"];
    String? tokenName = dotenv.env["TOKEN_NAME"];
    var contractABI = jsonDecode(abiCode);
    contractABI = contractABI["abiDefinition"];
    var credentials = await EthPrivateKey.fromHex(privateKey!).extractAddress();
    final contract = DeployedContract(
        ContractAbi.fromJson(jsonEncode(contractABI), tokenName!),
        EthereumAddress.fromHex(contractAddress!));
    return contract;
  }

  Future<String> submit(String functionName, List<dynamic> args) async {
    Client httpClient = new Client();
    String? privateKey = dotenv.env["ADMIN_PRIVATE_KEY"];
    String? tokenName = dotenv.env["TOKEN_NAME"];
    String? rpcUrl = dotenv.env["RPC_NETWORK_URL"];
    Web3Client ethClient = new Web3Client(rpcUrl!, httpClient);
    ;
    DeployedContract contract = await loadContract();
    final ethFunction = contract.function(functionName);
    EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey!);
    var result = await ethClient.sendTransaction(
      credentials,
      Transaction.callContract(
        contract: contract,
        function: ethFunction,
        parameters: args,
      ),
    );
    print("results of sending transaction: $result");
    return result;
  }

  Future<List<dynamic>> query(String functionName, List<dynamic> args) async {
    final contract = await loadContract();
    final ethFunction = contract.function(functionName);
    Client httpClient = new Client();
    String? rpcURL = dotenv.env["RPC_NETWORK_URL"];
    Web3Client ethClient = new Web3Client(rpcURL!, httpClient);
    print("before call args: $args");
    String? privateKey = dotenv.env["ADMIN_PRIVATE_KEY"];

    EthereumAddress credentials =
        await EthPrivateKey.fromHex(privateKey!).extractAddress();
    final data = await ethClient.call(
        sender: credentials,
        contract: contract,
        function: ethFunction,
        params: args);
    print("data returned: ${data.toString()} ");
    return data;
  }
}
