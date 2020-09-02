import 'package:vending_inspiro_septian/src/models/product.dart';

class Stok {
  Stok(this._product, this.tersedia) {
    if (tersedia < 0) {
      throw Exception("stok harus 0 atau lebih tinggi");
    }
  }

  final Product _product;
  int tersedia;

  Product getProduk() {
    return _product;
  }

  int getAvailable() {
    return tersedia;
  }

  void kurangiStokTersedia() {
    if (this.tersedia < 1) {
      throw Exception("Tidak ada stok untuk $_product saat ini.");
    }

    this.tersedia--;
  }

  String toString() {
    return "$tersedia ${_product.toString()}";
  }
}
