import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge_2022/bloc/home_page_bloc.dart';
import 'package:flutter_challenge_2022/Service/DependecyInjectionDio.dart';
import 'package:flutter_challenge_2022/Router/pages.dart';
import 'package:flutter_challenge_2022/Home/model/PlanetaModel.dart';
import 'package:flutter_challenge_2022/Home/model/StarshipsModel.dart';
import 'package:flutter_challenge_2022/Home/model/vehiculoModel.dart';
import 'package:flutter_challenge_2022/Home/model/PeopleStarWartModel.dart';
import 'package:flutter_challenge_2022/Home/ui/screen/HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DependencyInjectionDio.initialize();
  await Hive.initFlutter();

  Hive.registerAdapter(WelcomeAdapter());
  Hive.registerAdapter(ResultAdapter());
  Hive.registerAdapter(VehiculoAdapter());
  Hive.registerAdapter(StarshipsAdapter());
  Hive.registerAdapter(PlanetaAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomePageBloc()),
      ],
      child: MaterialApp(
        title: 'EL PLANETA TIERRA ESTA SIENDO INVADIDO',
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        routes: Pages.route,
      ),
    );
  }
}
