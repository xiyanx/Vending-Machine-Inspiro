import 'package:vending_inspiro_septian/src/models/product.dart';

abstract class VendingContract {
  bool masukkanUang(int RPp);

  String updateAndGetCurrentMessageForDisplay();

  int getTerimaRupiahp();

  int getKembalianRupiahp();


  bool beliProduct(int productIndex);

  void uangKembalian();

  void ambilUang();

  List<Product> getProducts();
}
