import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge_2022/Helper/HttpResponse.dart';
import 'package:flutter_challenge_2022/Home/model/PeopleStarWartModel.dart';
import 'package:flutter_challenge_2022/Home/repository/PeopleStarWart.dart';
import 'package:flutter_challenge_2022/Home/ui/screen/MenuPage.dart';
import 'package:flutter_challenge_2022/Home/ui/widgets/Buttons.dart';
import 'package:flutter_challenge_2022/Home/ui/widgets/Texts.dart';
import 'package:flutter_challenge_2022/Router/pages.dart';
import 'package:flutter_challenge_2022/Router/pages.dart';
import 'package:flutter_challenge_2022/Router/routes.dart';
import 'package:flutter_challenge_2022/bloc/home_page_bloc.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatelessWidget {
  HomePage({key});
  final int _selectedIndex = 0;
  final HomePageBloc _homePageBloc = HomePageBloc();
  final _peticiones = GetIt.instance<PeopleStarWart>();
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
    } else if (state is HomePageDetailPeople || state is ReportEventState) {
      return _detailsPeople(state, context);
    } else if (state is HomePageDetailPeopleBack) {
      return _listPeople(state, context);
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  Widget _detailsPeople(dynamic state, BuildContext context) {
    bool conexion = state.changeSwitch;
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
              Texts("Nombre", state.peope.name.toString()),
              Texts("Cumpleaños", state.peope.birthYear.toString()),
              Texts("genero", state.peope.gender.toString()),
              Texts("Color de Ojos", state.peope.eyeColor.toString()),
              Texts("Colors de pelo", state.peope.hairColor.toString()),
              Texts("Altura", state.peope.height.toString()),
              Texts("Planeta", state.planet.name.toString()),
              Texts("Masa", state.peope.mass.toString()),
              for (var i = 0; i < state.listNameStarships.length; i++)
                Texts("Nave", state.listNameStarships[i].toString()),
              for (var i = 0; i < state.listNameVehicles.length; i++)
                Texts("Vehiculo", state.listNameVehicles[i].toString()),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Butons(
                      text: "Back",
                      icon: Icons.arrow_back,
                      color: Colors.black,
                      onPressed: () {
                        _homePageBloc.add(HomePageBackEvent(state.welcome));
                      }),
                  const SizedBox(width: 10),
                  Butons(
                      text: "Report",
                      icon: Icons.report_gmailerrorred_sharp,
                      color: Colors.red,
                      onPressed: () {
                        if (conexion) {
                          _reportPeople(state.peope).then((value) {
                            ScaffoldMessenger.of(context)
                              ..removeCurrentMaterialBanner()
                              ..showMaterialBanner(MaterialBanner(
                                  content: Text(
                                      "${value['userId'].toString()},\n${value["dateTime"]},\n${value["character_name"]}\n${value["id"]} "),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentMaterialBanner();
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ]));
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('No hay conexion'),
                            ),
                          );
                        }
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    ]);
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
              const CircularProgressIndicator();
              _homePageBloc.add(
                  HomePageDetailPeopleEvent(welcome.results![index], welcome));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [Texts("People", welcome.results![index].name!)],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Texts(
                      "gender",
                      welcome.results![index].gender!,
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _reportPeople(Result peope) async {
    _peticiones.path = "https://jsonplaceholder.typicode.com/posts";
    Map<String, dynamic> queryParameters = {
      "userId": 1,
      "dateTime": DateTime.now().toString(),
      "character_name": peope.name,
    };
    Map<dynamic, dynamic> res =
        await _peticiones.postReport(_peticiones.path, queryParameters);
    return res;
  }
}
