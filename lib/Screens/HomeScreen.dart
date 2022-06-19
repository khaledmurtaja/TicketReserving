import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketreserving/Screens/HomeScreenCubit/Cubit.dart';
import 'package:ticketreserving/Screens/HomeScreenCubit/states.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenCubit, HomeScreenStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeScreenCubit.get(context);
        return state.newState(context: context);
      },
    );
  }
}
