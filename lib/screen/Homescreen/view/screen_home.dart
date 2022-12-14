import 'package:flutter/material.dart';
import 'package:moneywallet/screen/Homescreen/controller/provider/home_screen_provider.dart';
import 'package:moneywallet/screen/Homescreen/view/widget/home_card_widget.dart';
import 'package:moneywallet/screen/Homescreen/view/widget/home_transaction_list.dart';
import 'package:moneywallet/widget/scrool_dissable.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../category/controller/provider/category_provider.dart';
import '../../transaction/controller/provider/transaction_provider.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<HomeScreenProvider>(context, listen: false);
    final categoryData = Provider.of<CategoryProvider>(context, listen: false);
    final transactionData =
        Provider.of<TransactionProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      transactionData.transactionRefresh();
      data.getName();
      categoryData.refreshUI();
    });

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            data.naviagtorPushAdd(context);
          },
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
          child: Padding(
            padding:
                EdgeInsets.only(left: 5.w, right: 5.w, bottom: 5.h, top: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer(
                  builder: (BuildContext context, HomeScreenProvider value,
                      Widget? child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          value.greeting(),
                        ),
                        Text(
                          value.name.toUpperCase(),
                          style: TextStyle(
                              fontSize: 15.sp, fontWeight: FontWeight.bold),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: 2.h,
                ),
                const HomeCardWidget(),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    const Text('RECENT TRANSACTIONS'),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: () {
                        data.naviagtorPushView(context);
                      },
                      icon: const Icon(
                        Icons.remove_red_eye_rounded,
                        color: Colors.blue,
                      ),
                      label: const Text(
                        'View All',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: Consumer<TransactionProvider>(
                      builder: (BuildContext context, TransactionProvider newList,
                          Widget? _) {
                        if (newList.allTransactionList.isEmpty) {
                          return Center(
                            child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/no-data-unscreen.gif'),
                                ),
                              ),
                              width: 300,
                              height: 300,
                              child: const Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  'No Transactions',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container(
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(221, 246, 238, 238),
                              borderRadius: BorderRadius.circular(8.sp),
                            ),
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                final value = newList.allTransactionList[index];
                                return Center(
                                  child: HomeTransactionList(
                                    value: value,
                                    index: index,
                                  ),
                                );
                              },
                              itemCount: newList.allTransactionList.length >= 4
                                  ? 4
                                  : newList.allTransactionList.length,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
