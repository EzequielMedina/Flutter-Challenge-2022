import 'package:flutter/material.dart';
import 'package:flutter_challenge_2022/Home/model/PeopleStarWartModel.dart';
import 'package:flutter_challenge_2022/Home/repository/PeopleStarWart.dart';
import 'package:flutter_challenge_2022/Home/ui/widgets/Buttons.dart';
import 'package:flutter_challenge_2022/Home/ui/widgets/Texts.dart';
import 'package:flutter_challenge_2022/bloc/home_page_bloc.dart';
import 'package:get_it/get_it.dart';

class DetailPeople extends StatelessWidget {
  final HomePageBloc homePageBloc;
  DetailPeople({Key? key, required this.homePageBloc}) : super(key: key);

  final _peticiones = GetIt.instance<PeopleStarWart>();
  @override
  Widget build(BuildContext context) {
    final state = homePageBloc.state;
    bool conexion = state.props[0];
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
          height: MediaQuery.of(context).size.height * 0.5,
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
                        homePageBloc
                            .add(HomePageBackEvent(state.valorIdWelcome));
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

  _reportPeople(Result peope) async {
    _peticiones.path = "https://jsonplaceholder.typicode.com/posts";
    Map<String, dynamic> queryParameters = {
      "userId": 1,
      "dateTime": DateTime.now().toString(),
      "character_name": homePageBloc.state.peope.name,
    };
    Map<dynamic, dynamic> res =
        await _peticiones.postReport(_peticiones.path, queryParameters);
    //homePageBloc.add(ReportEvent(homePageBloc.state.welcome, homePageBloc.state.peope));
    return res;
  }
}
