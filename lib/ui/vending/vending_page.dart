import 'package:flutter/material.dart';
import 'package:vending_inspiro_septian/src/repository/VendingMachineRepository.dart';
import 'package:vending_inspiro_septian/src/bloc/bloc_provider.dart';
import 'package:vending_inspiro_septian/src/utils.dart';
import 'package:vending_inspiro_septian/ui/vending/vending_bloc.dart';

class VendingPage extends StatelessWidget {

  const VendingPage(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {

    final VendingMachineBloc bloc = BlocProvider.of<VendingMachineBloc>(context);
    
    bloc.init(VendingMachineRepository());
    double screenWidth = getScreenWidth(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _getVendingImage(screenWidth)
            ],
          ),
          SizedBox(width: screenWidth / 2, child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _currentUangSizeText(bloc),
              _displayText(bloc),
              _getSpacer(),
              _getProductText(),
              _productSatuButton(bloc),
              _productDuaButton(bloc),
              _productTigaButton(bloc),
              _productEmpatButton(bloc),
              _productLimaButton(bloc),
              _getSpacer(),
              _getOptionsText(),
              _masukkanUangButton(bloc),
              _ubahUangButton(bloc),
              _ambilKembalianButton(bloc),
              _returnButton(bloc),
            ],))
        ],
                ),
                _getSpacer(height: 25),
                _getCurrentText(bloc)
              ]
      )
      ),
    );
  }

  Text _getOptionsText() => Text('Opsi');

  Text _getProductText() => Text('Produk');

  SizedBox _getSpacer({double height = 10}) => SizedBox(height: height);

  Widget _productSatuButton(VendingMachineBloc bloc) {
    return StreamBuilder<String>(
      stream: bloc.product1,
      initialData: '',
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return RaisedButton(
          child: Text(snapshot.data),
          onPressed: () => bloc.beliProduct(0),
        );
      },
    );
  }

  Widget _productDuaButton(VendingMachineBloc bloc) {
    return StreamBuilder<String>(
      stream: bloc.product2,
      initialData: '',
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return RaisedButton(
          child: Text(snapshot.data),
          onPressed: () => bloc.beliProduct(1),
        );
      },
    );
  }

  Widget _productTigaButton(VendingMachineBloc bloc) {
    return StreamBuilder<String>(
      stream: bloc.product3,
      initialData: '',
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return RaisedButton(
          child: Text(snapshot.data),
          onPressed: () => bloc.beliProduct(2),
        );
      },
    );
  }

  Widget _productEmpatButton(VendingMachineBloc bloc) {
    return StreamBuilder<String>(
      stream: bloc.product4,
      initialData: '',
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return RaisedButton(
          child: Text(snapshot.data),
          onPressed: () => bloc.beliProduct(3),
        );
      },
    );
  }

  Widget _productLimaButton(VendingMachineBloc bloc) {
    return StreamBuilder<String>(
      stream: bloc.product5,
      initialData: '',
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return RaisedButton(
          child: Text(snapshot.data),
          onPressed: () => bloc.beliProduct(4),
        );
      },
    );
  }

  Widget _returnButton(VendingMachineBloc bloc) {
    return RaisedButton(
      child: Text('Kembalikan Uang'),
      onPressed: () => bloc.kembalianUang(),
    );
  }

  Widget _masukkanUangButton(VendingMachineBloc bloc) {
    return RaisedButton(
      child: Text('Masukkan Uang'),
      onPressed: () => bloc.masukkanUang(),
    );
  }

  Widget _ambilKembalianButton(VendingMachineBloc bloc) {
    return RaisedButton(
      child: Text('Ambil Kembalian'),
      onPressed: () => bloc.ambilUang(),
    );
  }

  Widget _ubahUangButton(VendingMachineBloc bloc) {
    return RaisedButton(
      child: Text('Ubah Uang'),
      onPressed: () => bloc.ubahUang(),
    );
  }

  Widget _displayText(VendingMachineBloc bloc) {
    return StreamBuilder<String>(
      stream: bloc.display,
      initialData: '',
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return Text(snapshot.data, textScaleFactor: 2,);
      },
    );
  }

  Widget _currentUangSizeText(VendingMachineBloc bloc) {
    return StreamBuilder<String>(
      stream: bloc.change,
      initialData: '',
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return Text(snapshot.data, textScaleFactor: 1.5);
      },
    );
  }

  Widget _getVendingImage(double imageWidget) {
    return SizedBox(width: imageWidget / 2,
        child: Image.asset(
          'assets/images/vending.jpg',
          fit: BoxFit.fill,
        ));
  }

  Widget _getCurrentText(VendingMachineBloc bloc) {
    return StreamBuilder<String>(
      stream: bloc.summary,
      initialData: '',
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return Center(child: Text(snapshot.data));
      },
    );
  }
}
