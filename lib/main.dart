import 'package:api_practice/bloc/user_bloc.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/model/user_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final UserBloc _userBloc = UserBloc();

  @override
  void initState() {
    _userBloc.add(GetUserList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.grey[900]),
      padding: const EdgeInsets.only(top: 60, right: 50, left: 50),
      child: BlocProvider(
        create: (context) => _userBloc,
        child: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message!)));
            }
          },
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoaded) {
                return buildUser(context, state.userModel);
              } else if (state is UserLoading) {
                return _buildLoading();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    ));
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());

  Widget buildUser(BuildContext context, UserModel model) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      CircularProfileAvatar(
        "",
        radius: 70,
        initialsText: Text(
          model.getInitials(model.name!),
          style: const TextStyle(fontSize: 30),
        ),
        backgroundColor: Colors.blue,
      ),
      const SizedBox(
        height: 25,
      ),
      Text(
        model.name!,
        style: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      const SizedBox(
        height: 25,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: SizedBox(
              height: 60,
              child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[850],
                      elevation: 1,
                      shadowColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.zero))),
                  onPressed: () {
                    model.launchMapsUrl(double.parse(model.address!.geo!.lat!),
                        double.parse(model.address!.geo!.lng!));
                  },
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 30,
                  )),
            ),
          ),
          Expanded(
            flex: 5,
            child: SizedBox(
              height: 60,
              child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[850],
                      elevation: 1,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.zero)),
                      shadowColor: Colors.white),
                  onPressed: () {},
                  child: const Icon(
                    Icons.share,
                    color: Colors.white,
                    size: 30,
                  )),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 30,
      ),
      Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              height: 40,
              child: const Text(
                "Man",
                style: TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(
                  color: Colors.grey[850],
                  border: Border.all(color: Colors.white, width: 0.1)),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              height: 40,
              child: const Text(
                "Both",
                style: TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(
                  color: Colors.grey[850],
                  border: Border.all(color: Colors.white, width: 0.1)),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              height: 40,
              child: const Text(
                "Women",
                style: TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(
                  color: Colors.grey[850],
                  border: Border.all(color: Colors.white, width: 0.1)),
            ),
          ),
        ],
      ),
      const Spacer(),
      SizedBox(
        height: 60,
        width: double.infinity,
        child: TextButton(
          onPressed: () {
            _userBloc.add(GetUserList());
          },
          child: const Icon(
            Icons.refresh,
            color: Colors.white,
            size: 30,
          ),
          style: TextButton.styleFrom(
            backgroundColor: Colors.green,
          ),
        ),
      ),
      const Spacer()
    ]);
  }
}
