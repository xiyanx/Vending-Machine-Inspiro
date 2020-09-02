import 'package:vending_inspiro_septian/src/contract/vend_contract.dart';
import 'package:vending_inspiro_septian/src/models/product.dart';
import 'package:vending_inspiro_septian/src/models/stock.dart';
import 'package:vending_inspiro_septian/src/utils.dart';

const int _uangDuaRibu = 2;

const int _uangLimaRibu = 5;

const int _uangSepuluhRibu = 10;

const int _uangDuapuluhRibu = 20;

const int _UangLimapuluhRibu = 50;


const String pesanMasukkanUang = "MASUKKAN UANG";
const String pesanUangKembalianHabis = "KEMBALIAN HABIS";
const String pesanHarga = "HARGA";
const String pesanStokHabis = "STOK HABIS";
const String pesanTerimaKasih = "TERIMA KASIH";

class VendingMachine implements VendingContract {
  VendingMachine(this.stokTersedia) {
    updateAndGetCurrentMessageForDisplay();
  }

  final List<Stok> stokTersedia;

  int _matauangRupiahp = 0;

  int _kembaliRupiahp = 0;

  int _kembalianRupiahp = 500;

  String _pesanTerakhir = pesanMasukkanUang;

  String toString() {
    return "Rp. ${convertKeRupiah(_matauangRupiahp)} uang didalam mesin, Rp. ${convertKeRupiah(_kembalianRupiahp)} uang kembalian didalam mesin, dan ${stokTersedia.length} produk";
  }

  @override
  bool masukkanUang(int RPp) {
    switch (RPp) {
      case _uangDuaRibu:
      case _uangLimaRibu:
      case _uangSepuluhRibu:
      case _UangLimapuluhRibu:
      case _uangDuapuluhRibu:
        {
          // valid
          this._matauangRupiahp += RPp;
          this._pesanTerakhir =
              "Rp. ${convertKeRupiah(_matauangRupiahp)}";
          return true;
        }
      default:
        _matauangRupiahp += RPp;
        return false;
    }
  }

  String updateAndGetCurrentMessageForDisplay() {
    String pesanUntukDikirim = _pesanTerakhir;

    if (_matauangRupiahp == 0) {
      _pesanTerakhir = pesanMasukkanUang;

      for (final Stok stok in stokTersedia) {
        if (stok.getProduk().getHargaBarangp() > _kembalianRupiahp) {
          _pesanTerakhir = pesanUangKembalianHabis;
          break;
        }
      }
    } else {
      _pesanTerakhir = "Rp. ${convertKeRupiah(_matauangRupiahp)}";
    }

    return pesanUntukDikirim;
  }

  @override
  int getTerimaRupiahp() {
    return _matauangRupiahp;
  }

  @override
  int getKembalianRupiahp() {
    return _kembaliRupiahp;
  }

  @override
  bool beliProduct(int productIndex) {
    return productIndex < stokTersedia.length &&
        _testBeli(stokTersedia[productIndex]);
  }

  bool _testBeli(final Stok stok) {
    if (stok.getAvailable() == 0) {
      _pesanTerakhir = pesanStokHabis;
      return false;
    }

    Product product = stok.getProduk();

    if (_matauangRupiahp - product.getHargaBarangp() < 0) {
      _pesanTerakhir = "$pesanHarga Rp.${convertKeRupiah(product.getHargaBarangp())}";
      return false;
    }

    stok.kurangiStokTersedia();

    _matauangRupiahp -= product.getHargaBarangp();

    _kembalianRupiahp -= _matauangRupiahp;

    _kembaliRupiahp += _matauangRupiahp;
    _matauangRupiahp = 0;

    _pesanTerakhir = pesanTerimaKasih;

    return true;
  }

  @override
  void uangKembalian() {
    _kembaliRupiahp += _matauangRupiahp;
    _matauangRupiahp = 0;

    updateAndGetCurrentMessageForDisplay();
  }

  @override
  void ambilUang() {
    _kembaliRupiahp = 0;
  }

  List<Product> getProducts() {
    List<Product> products = List();

    for (final stok in stokTersedia) {
      products.add(stok.getProduk());
    }

    return products;
  }
}
