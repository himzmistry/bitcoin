import 'dart:convert';

import 'package:bitcoin/constants/app_colors.dart';
import 'package:bitcoin/constants/app_images.dart';
import 'package:bitcoin/models/bitcoin_model.dart';
import 'package:bitcoin/models/currency_model.dart';
import 'package:bitcoin/utility/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../network/api_network.dart';
import '../widgets/scroll_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = false;
  ApiNetwork apiNetwork = ApiNetwork();
  BitcoinModel bitcoinModel = BitcoinModel();
  List<CurrencyModel> currencyList = [];
  String currentValue = 'Price';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  fetchData() async {
    try {
      print('fetchData called');
      loading = true;
      setState(() {});
      var response = await apiNetwork.getLocation();
      bitcoinModel = BitcoinModel.fromJson(jsonDecode(response.data));
      currencyList.add(CurrencyModel(
          countryCode: bitcoinModel.bpi?.eUR?.code ?? '',
          rate: bitcoinModel.bpi?.eUR?.rateFloat ?? 0.0));
      currencyList.add(CurrencyModel(
          countryCode: bitcoinModel.bpi?.gBP?.code ?? '',
          rate: bitcoinModel.bpi?.gBP?.rateFloat ?? 0.0));
      currencyList.add(CurrencyModel(
          countryCode: bitcoinModel.bpi?.uSD?.code ?? '',
          rate: bitcoinModel.bpi?.uSD?.rateFloat ?? 0.0));
      print('homeResponse: ${response.data}');
      setState(() {});
    } catch (e) {
      print('fetchData: $e');
    } finally {
      loading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  currentValue,
                  style: Utils.normalTextStyle(),
                ),
                Image.asset(AppImages.bitcoin),
                ScrollConfiguration(
                  child: Expanded(
                    child: CupertinoPicker.builder(
                      onSelectedItemChanged: (value) {
                        currentValue = currencyList[value].rate.toString();
                        setState(() {});
                      },
                      magnification: 1,
                      itemBuilder: (context, index) {
                        return Text(currencyList[index].countryCode);
                      },
                      childCount: currencyList.length,
                      itemExtent: 50,
                    ),
                  ),
                  behavior: MyCustomScrollBehavior(),
                ),
              ],
            ),
    );
  }
}
