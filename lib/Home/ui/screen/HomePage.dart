import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge_2022/Helper/HttpResponse.dart';
import 'package:flutter_challenge_2022/Home/model/PeopleStarWartModel.dart';
import 'package:flutter_challenge_2022/Home/repository/PeopleStarWart.dart';
import 'package:flutter_challenge_2022/bloc/home_page_bloc.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int _selectedIndex = 0;
  final HomePageBloc _homePageBloc = HomePageBloc();

  @override
  void initState() {
    super.initState();
    _homePageBloc.add(HomePageSetEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(66, 122, 122, 122),
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(31, 129, 127, 127),
          title: const Text(
            'EL PLANETA TIERRA ESTA SIENDO INVADIDO',
            style: TextStyle(fontSize: 16),
          )),
      body: BlocBuilder<HomePageBloc, HomePageState>(
        bloc: _homePageBloc,
        builder: (context, state) {
          if (state is HomePageInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomePageLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomePageLoaded) {
            return _listPeople(state);
          } else if (state is HomePageError) {
            return Center(
              child: Text(state.message!),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Stack _listPeople(HomePageLoaded state) {
    return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _buildList(state.welcome),
              const SizedBox(height: 20),
              BottomNavigationBar(
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.arrow_left), label: 'Prev'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.arrow_right), label: 'Next'),
                  ],
                  currentIndex: _selectedIndex,
                  selectedItemColor: Colors.amber[800],
                  onTap: (index) {
                    if (index == 0) {
                      if (state.welcome.previous != null) {
                        _homePageBloc
                            .add(HomePageChangePage(state.welcome.previous!));
                      }
                    } else {
                      if (state.welcome.next != null) {
                        _homePageBloc
                            .add(HomePageChangePage(state.welcome.next!));
                      }
                    }
                  }),
            ],
          );
  }

  Widget _buildList(Welcome welcome) {
    return ListView.builder(
      itemCount: welcome.results!.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(6.0),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: const Color.fromARGB(255, 196, 193, 193), width: 0.5)),
          child: CupertinoButton(
            alignment: Alignment.centerLeft,
            onPressed: () {
              _popup(context, welcome.results![index]);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      "People: ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black),
                    ),
                    Text(
                      welcome.results![index].name!,
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Text(
                      "gender: ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black),
                    ),
                    Text(
                      welcome.results![index].gender!,
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _popup(BuildContext context, Result people) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Personaje "),
            content: Column(
              children: [
                Text(people.birthYear.toString()),
                Text(people.eyeColor.toString()),
                Text(people.gender.toString()),
                Text(people.hairColor.toString()),
                Text(people.height.toString()),
                Text(people.homeworld.toString()),
                Text(people.mass.toString()),
                Text(people.name.toString()),
                Text(people.starships.toString()),
                Text(people.vehicles.toString())
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'))
            ],
          );
        });
  }

  Widget _buildListPeople() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (context) => HomePageBloc(),
        child: BlocListener<HomePageBloc, HomePageState>(
          listener: (context, state) {
            if (state is HomePageError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<HomePageBloc, HomePageState>(
            builder: (context, state) {
              if (state is HomePageInitial) {
                return _buildLoading();
              } else if (state is HomePageLoading) {
                return _buildLoading();
              } else if (state is HomePageLoaded) {
                return _buildCard(context, state.welcome);
              } else if (state is HomePageError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, Welcome model) {
    return ListView.builder(
      itemCount: model.results!.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: const Color.fromARGB(255, 196, 193, 193), width: 0.5)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "People: ${model.results![index].name}".toUpperCase(),
              ),
              const SizedBox(height: 10),
              Text(
                "gender: ${model.results![index].gender}".toUpperCase(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
