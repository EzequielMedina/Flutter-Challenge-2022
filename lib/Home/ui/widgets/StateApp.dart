import 'package:flutter/material.dart';
import 'package:flutter_challenge_2022/Home/ui/widgets/DetailPeople.dart';
import 'package:flutter_challenge_2022/Home/ui/widgets/ListPeople.dart';
import 'package:flutter_challenge_2022/bloc/home_page_bloc.dart';

class StateApp extends StatelessWidget {
  final HomePageBloc homePageBloc;
  const StateApp({Key? key, required this.homePageBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = homePageBloc.state;
    if (state.welcome == null) {
      homePageBloc.add(HomePageSetEvent());
      return const Center(child: CircularProgressIndicator());
    } else if (state is HomePageLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state.isDetailPeople == false) {
      return ListPeople(homePageBloc: homePageBloc);
    } else if (state is HomePageError) {
      return Center(child: Text(state.message!));
    } else if (state.isDetailPeople == true) {
      return DetailPeople(homePageBloc: homePageBloc);
    } else if (state.isDetailPeople == false) {
      return ListPeople(homePageBloc: homePageBloc);
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}
