import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_scan_parser/controllers/stocks_controller.dart';
import 'package:stock_scan_parser/utils/routes.dart';

import '../utils/dotted_divider.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final StocksController stocksController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Scan Parser'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          stocksController.getStocksData();
        },
        child: const Icon(
          Icons.replay_rounded,
        ),
      ),
      body: Obx(
        () => stocksController.isLoading.isTrue
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : stocksController.stocksList.isEmpty
                ? const Center(
                    child: Text('No Data Found'),
                  )
                : ListView.separated(
                    separatorBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: DottedDivider(),
                    ),
                    itemCount: stocksController.stocksList.length,
                    itemBuilder: (context, index) {
                      var stock = stocksController.stocksList[index];
                      return ListTile(
                        onTap: () => Get.toNamed(
                          AppRoutes.stockDetails,
                          arguments: stock,
                        ),
                        minLeadingWidth: 10,
                        leading: const SizedBox(
                          height: 20,
                          width: 10,
                          child: Center(
                            child: CircleAvatar(
                              radius: 3,
                              backgroundColor: Colors.grey,
                            ),
                          ),
                        ),
                        title: Text(
                          stock.name!,
                          textScaleFactor: 1.0,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          stock.tag!,
                          style: TextStyle(
                            color: stock.color == 'red'
                                ? Colors.red
                                : Colors.green,
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
