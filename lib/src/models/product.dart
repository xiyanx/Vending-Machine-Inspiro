import 'dart:core';

import 'package:vending_inspiro_septian/src/utils.dart';

class Product {

  Product(String name, int hargaRupiahp) {
    if ("" == name) {
      throw new Exception("nama tidak boleh kosong");
    }

    if (hargaRupiahp < 0) {
      throw new Exception("harga harus 0 atau lebih tinggi");
    }

    this._name = name;
    this._hargaRupiahp = hargaRupiahp;
  }

  String _name;

  int _hargaRupiahp;

  String getName() {
    return _name;
  }

  int getHargaBarangp() {
    return _hargaRupiahp;
  }

  String toString() {
    return "$_name/${convertKeRupiah(_hargaRupiahp)}";
  }

  bool equals(Object obj) {
    if (obj is Product) {
      Product p = obj;
      return p.getName() == _name &&
          p.getHargaBarangp() == _hargaRupiahp;
    }

    return this.equals(obj);
  }
}