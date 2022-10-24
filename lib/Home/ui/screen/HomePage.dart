import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge_2022/Helper/HttpResponse.dart';
import 'package:flutter_challenge_2022/Home/model/PeopleStarWartModel.dart';
import 'package:flutter_challenge_2022/Home/repository/PeopleStarWart.dart';
import 'package:flutter_challenge_2022/Home/ui/widgets/ButtonsCIrcle.dart';
import 'package:flutter_challenge_2022/Router/pages.dart';
import 'package:flutter_challenge_2022/Router/pages.dart';
import 'package:flutter_challenge_2022/Router/routes.dart';
import 'package:flutter_challenge_2022/bloc/home_page_bloc.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatelessWidget {
  HomePage({key});
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
            body: _stateApp(state, context),
            bottomNavigationBar:
                state is HomePageLoaded || state is HomePageDetailPeopleBack
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
      if (state.welcome.previous != null) {
        _homePageBloc.add(HomePageChangePage(state.welcome.previous!));
      }
    } else {
      if (state.welcome.next != null) {
        _homePageBloc.add(HomePageChangePage(state.welcome.next!));
      }
    }
  }

  Widget _stateApp(HomePageState state, BuildContext context) {
    if (state is HomePageInitial) {
      _homePageBloc.add(HomePageSetEvent());
      return const Center(child: CircularProgressIndicator());
    } else if (state is HomePageLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is HomePageLoaded) {
      return _listPeople(state, context);
    } else if (state is HomePageError) {
      return Center(
        child: Text(state.message!),
      );
    } else if (state is HomePageDetailPeople) {
      return _detailsPeople(state, context);
    } else if (state is HomePageDetailPeopleBack) {
      return _listPeople(state, context);
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  Widget _detailsPeople(HomePageDetailPeople state, BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Image(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        fit: BoxFit.cover,
        image: const AssetImage('assest/fondo2.jpg'),
      ),
      Card(
        color: const Color.fromARGB(94, 243, 243, 243),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _textStyle("Nombre", state.peope.name.toString()),
              _textStyle("Cumpleaños", state.peope.birthYear.toString()),
              _textStyle("genero", state.peope.gender.toString()),
              _textStyle("Color de Ojos", state.peope.eyeColor.toString()),
              _textStyle("Colors de pelo", state.peope.hairColor.toString()),
              _textStyle("Altura", state.peope.height.toString()),
              _textStyle("Planeta", state.planet.name.toString()),
              _textStyle("Masa", state.peope.mass.toString()),
              for (var i = 0; i < state.listNameStarships.length; i++)
                _textStyle("Nave", state.listNameStarships[i].toString()),
              for (var i = 0; i < state.listNameVehicles.length; i++)
                _textStyle("Vehiculo", state.listNameVehicles[i].toString()),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Butons(
                      text: "Back",
                      icon: Icons.arrow_back,
                      onPressed: () {
                        _homePageBloc.add(HomePageBackEvent(state.welcome));
                      }),
                  const SizedBox(width: 10),
                  Butons(
                      text: "Report",
                      icon: Icons.report_gmailerrorred_sharp,
                      onPressed: () {
                       _homePageBloc.add(ReportEvent(state.peope,state.welcome));
                      
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  Text _textStyle(String cadena, String cadenaValue) {
    return Text("$cadena : $cadenaValue",
        textAlign: TextAlign.right,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16));
  }

  Widget _listPeople(dynamic state, BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
            alignment: Alignment.bottomCenter,
            height: MediaQuery.of(context).size.height * 0.8,
            child: _buildList(state.welcome)),
        const SizedBox(height: 20),
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
              _homePageBloc.add(
                  HomePageDetailPeopleEvent(welcome.results![index], welcome));
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
}
