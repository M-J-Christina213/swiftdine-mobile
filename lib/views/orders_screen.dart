import 'package:flutter/material.dart';
import 'package:swiftdine_mobile/themes/app_theme.dart';
import 'package:swiftdine_mobile/views/orders/current_orders_tab.dart';
import 'package:swiftdine_mobile/views/orders/past_orders_tab.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppTheme.primaryColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Text(
            "Your Orders",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Container(
              color: Colors.white,
              child: TabBar(
                labelColor: AppTheme.primaryColor,
                unselectedLabelColor: Colors.grey,
                indicator: UnderlineTabIndicator(
                  borderSide:
                      BorderSide(width: 3.0, color: AppTheme.primaryColor),
                  insets: const EdgeInsets.symmetric(horizontal: 80.0),
                ),
                tabs: const [
                  Tab(text: 'Past Orders'),
                  Tab(text: 'Current Orders'),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            PastOrdersTab(),
            CurrentOrdersTab(),
          ],
        ),
      ),
    );
  }
}
