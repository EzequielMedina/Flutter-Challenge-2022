import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge_2022/Home/ui/widgets/StateApp.dart';
import 'package:flutter_challenge_2022/Router/routes.dart';
import 'package:flutter_challenge_2022/bloc/home_page_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final int _selectedIndex = 0;
  final HomePageBloc _homePageBloc = HomePageBloc();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
      bloc: _homePageBloc,
      builder: (context, state) {
        return Scaffold(
            backgroundColor: const Color.fromARGB(66, 122, 122, 122),
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(31, 129, 127, 127),
              title: const Text(
                'EL PLANETA TIERRA ESTA SIENDO INVADIDO',
                style: TextStyle(fontSize: 15),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.menu_outlined),
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.menu);
                  },
                )
              ],
            ),
            body: StateApp(
              homePageBloc: _homePageBloc,
            ),
            bottomNavigationBar: state.isDetailPeople == false
                ? BottomNavigationBar(
                    items: const [
                        BottomNavigationBarItem(
                            icon: Icon(Icons.arrow_left), label: 'Prev'),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.arrow_right), label: 'Next'),
                      ],
                    currentIndex: _selectedIndex,
                    selectedItemColor: Colors.amber[800],
                    onTap: (index) {
                      _onTapPage(index, state);
                    })
                : null);
      },
    );
  }

  void _onTapPage(int index, HomePageState state) {
    if (index == 0) {
      if (state.welcome!.previous != null) {
        _homePageBloc.add(HomePageChangePage(state.welcome!.previous!));
      }
    } else {
      if (state.welcome!.next != null) {
        _homePageBloc.add(HomePageChangePage(state.welcome!.next!));
      }
    }
  }
}
