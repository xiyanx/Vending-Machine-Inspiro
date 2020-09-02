import 'package:rxdart/src/subjects/behavior_subject.dart';
import 'package:vending_inspiro_septian/src/models/product.dart';
import 'package:vending_inspiro_septian/src/models/vending_machine.dart';
import 'package:vending_inspiro_septian/src/repository/VendingMachineRepository.dart';
import 'package:vending_inspiro_septian/src/bloc/bloc_base.dart';
import 'package:vending_inspiro_septian/src/utils.dart';

class VendingMachineBloc implements BlocBase {

  void init(VendingMachineRepository vendingMachineRepository) {
    if (this.vendingMachine == null) {
      this.vendingMachine = vendingMachineRepository.getVendingMachine();

      List<Product> products = vendingMachine.getProducts();
      _product1.sink.add(products[0].getName());
      _product2.sink.add(products[1].getName());
      _product3.sink.add(products[2].getName());
      _product4.sink.add(products[3].getName());
      _product5.sink.add(products[4].getName());

      updateTampilan();
    }
  }

  int coinSize = 2;

  final BehaviorSubject<String> _display =
      BehaviorSubject<String>();
  final BehaviorSubject<String> _summary =
  BehaviorSubject<String>();
  final BehaviorSubject<String> _change =
      BehaviorSubject<String>();
  final BehaviorSubject<String> _product1 =
      BehaviorSubject<String>();
  final BehaviorSubject<String> _product2 =
      BehaviorSubject<String>();
  final BehaviorSubject<String> _product3 =
      BehaviorSubject<String>();
  final BehaviorSubject<String> _product4 =
      BehaviorSubject<String>();
  final BehaviorSubject<String> _product5 =
      BehaviorSubject<String>();

  Stream<String> get display => _display.stream;

  Stream<String> get change => _change.stream;

  Stream<String> get summary => _summary.stream;

  Stream<String> get product1 => _product1.stream;

  Stream<String> get product2 => _product2.stream;

  Stream<String> get product3 => _product3.stream;

  Stream<String> get product4 => _product4.stream;

  Stream<String> get product5 => _product5.stream;

  void setDisplay(String message) => _display.add(message);

  void setChange(String message) => _change.add(message);

  void setSummary(String message) => _summary.add(message);

  VendingMachine vendingMachine;

  void ubahUang() {
    switch (coinSize) {
      case 2:
        coinSize = 5;
        break;
      case 5:
        coinSize = 10;
        break;
      case 10:
        coinSize = 20;
        break;
      case 20:
        coinSize = 50;
        break;
      case 50:
        coinSize = 2;
    }
  }

  Stream<String> getVendingMachineProductDisplay(int productIndex) {
    switch (productIndex) {
      case 0:
        return product1;
      case 1:
        return product2;
      case 2:
        return product3;
      case 3:
        return product4;
      case 4:
        return product5;
      default:
        throw new Exception(
            "Hanya 5 produk yang tersedia tetapi item ${productIndex - 1} diminta");
    }
  }

  void ambilUang() {
    if (this.vendingMachine == null) {
      throw new Exception(
          "init() harus dipanggil sebelum memanggil methods lain dalam view model ini");
    }

    vendingMachine.ambilUang();
    updateTampilan();
  }

  bool masukkanUang() {
    if (vendingMachine == null) {
      throw new Exception(
          "init() harus dipanggil sebelum memanggil methods lain dalam view model ini");
    }

    final bool result = vendingMachine.masukkanUang(coinSize);
    updateTampilan();
    return result;
  }

  void beliProduct(int productIndex) {
    if (vendingMachine == null) {
      throw Exception(
          "init() harus dipanggil sebelum memanggil methods lain dalam view model ini");
    }

    vendingMachine.beliProduct(productIndex);
    updateTampilan();
  }

  void kembalianUang() {
    if (vendingMachine == null) {
      throw Exception(
          "init() harus dipanggil sebelum memanggil methods lain dalam view model ini");
    }

    this.vendingMachine.uangKembalian();
    updateTampilan();
  }

  void updateTampilan() {
    if (vendingMachine == null) {
      throw Exception(
          "init() harus dipanggil sebelum memanggil methods lain dalam view model ini");
    }

    setDisplay(vendingMachine.updateAndGetCurrentMessageForDisplay());
    setChange("Ambil ${convertKeRupiah(vendingMachine.getKembalianRupiahp())}");
    setSummary(vendingMachine.toString());
  }

  @override
  void dispose() {
    _display.close();
    _change.close();
    _product1.close();
    _product2.close();
    _product3.close();
    _product4.close();
    _summary.close();
    _change.close();
  }
}
