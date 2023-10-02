import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:piduiteun/features/home/presentation/views/home_view.dart';

class BottomNavBarView extends StatelessWidget {
  const BottomNavBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BottomNavBarPage();
  }
}

class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({super.key});

  @override
  State<BottomNavBarPage> createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  int currentPageIndex = 0;

  static const List<Widget> body = <Widget>[
    HomeView(),
    Center(
      child: Text('halaman 2'),
    ),
    Center(
      child: Text('halaman 3'),
    ),
  ];

  static const List<NavigationDestination> navigatorDestination = [
    NavigationDestination(
      icon: Icon(Symbols.home_rounded),
      label: 'Beranda',
    ),
    NavigationDestination(
      icon: Icon(Symbols.analytics_rounded),
      label: 'Statistik',
    ),
    NavigationDestination(
      icon: Icon(Symbols.receipt_long_rounded),
      label: 'Transaksi',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: body[currentPageIndex],
      bottomNavigationBar: NavigationBar(
        destinations: navigatorDestination,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (value) {
          setState(() {
            currentPageIndex = value;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed('add_data');
        },
        elevation: 2,
        child: const Icon(Icons.add),
      ),
    );
  }
}
