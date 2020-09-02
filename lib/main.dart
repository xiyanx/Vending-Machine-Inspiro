import 'package:flutter/material.dart';
import 'package:vending_inspiro_septian/src/bloc/bloc_provider.dart';
import 'package:vending_inspiro_septian/ui/vending/vending_bloc.dart';
import 'package:vending_inspiro_septian/ui/vending/vending_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<VendingMachineBloc>(
      bloc: VendingMachineBloc(),
      child: MaterialApp(
        title: 'Vending Inspiro',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: VendingPage('Vending Inspiro'),
      ),
    );
  }
}
