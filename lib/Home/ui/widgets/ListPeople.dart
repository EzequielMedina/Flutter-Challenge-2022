import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenge_2022/Home/ui/widgets/Texts.dart';
import 'package:flutter_challenge_2022/bloc/home_page_bloc.dart';

class ListPeople extends StatelessWidget {
  final HomePageBloc homePageBloc;
  const ListPeople({Key? key, required this.homePageBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
            alignment: Alignment.bottomCenter,
            height: MediaQuery.of(context).size.height * 0.8,
            child: BuildListPeople(homePageBloc: homePageBloc)),
        const SizedBox(height: 20),
      ],
    );
  }
}

class BuildListPeople extends StatelessWidget {
  final HomePageBloc homePageBloc;
  const BuildListPeople({Key? key, required this.homePageBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = homePageBloc.state;
    final welcome = state.welcome;
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
              homePageBloc.add(HomePageDetailPeopleEvent(
                  welcome.results![index], welcome, state.props[0]));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
}
