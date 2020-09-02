import 'package:vending_inspiro_septian/src/contract/vend_contract.dart';
import 'package:vending_inspiro_septian/src/models/product.dart';
import 'package:vending_inspiro_septian/src/models/stock.dart';
import 'package:vending_inspiro_septian/src/models/vending_machine.dart';

class VendingMachineRepository {
  static final VendingMachineRepository _instance =
      VendingMachineRepository._internal();

  factory VendingMachineRepository() {
    return _instance;
  }

  static VendingContract _vendingMachine;

  VendingMachineRepository._internal() {
    final List<Stok> stock = List();
    stock.add(new Stok(Product("Biskuit", 6), 2));
    stock.add(new Stok(Product("Chips", 8), 3));
    stock.add(new Stok(Product("Oreo", 10), 1));
    stock.add(new Stok(Product("Tango", 12), 1));
    stock.add(new Stok(Product("Cokelat", 15), 1));
    _vendingMachine = VendingMachine(stock);
  }

  VendingContract getVendingMachine() {
    return _vendingMachine;
  }
}
