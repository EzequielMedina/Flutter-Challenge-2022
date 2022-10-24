import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge_2022/bloc/home_page_bloc.dart';

class MenuPage extends StatelessWidget {
  final HomePageBloc _homePageBloc = HomePageBloc();
  MenuPage({key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(31, 129, 127, 127),
        title: const Text('Conexion de la aplicacion'),
      ),
      body: Center(
        child: BlocBuilder<HomePageBloc, HomePageState>(
          builder: (context, state) {
            print(state.changeSwitch);
            bool _changeSwitch = false;
            return Stack(alignment: Alignment.center, children: [
              Image(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
                image: const AssetImage('assest/star-wars-backgrounds.jpg'),
              ),
              Card(
                color: const Color.fromARGB(209, 250, 250, 250),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.12,
                  child: Column(
                    children: [
                      const Text(
                        "\n Desactivar o Activar Conexion",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Switch(
                          value: state.changeSwitch,
                          onChanged: (value) {
                            _changeSwitch = value;
                            _homePageBloc.add(ChangeSwitchEvent(value));
                            print(state.changeSwitch);
                          }),
                    ],
                  ),
                ),
              ),
            ]);
          },
        ),
      ),
    );
  }
}
