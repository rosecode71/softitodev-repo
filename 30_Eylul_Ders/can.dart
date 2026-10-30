class CanSistemi {
  final String karakterAdi;
  double _canPuani =
      100.0; // Değişkenin başına _ koyduğumuz zaman bu değişkeni gizli olarak kodlar ve dışarıdan erişime kapanır.

  CanSistemi({required this.karakterAdi});

  //getter ile can puanı güvenli dışarıya okutma
  double get canPuani {
    return _canPuani;
  }

  //setter ile can değeri değişirken oyun kurallarını denetleyelim
  set canPuani(double yeniCan) {
    if (yeniCan <= 0) {
      _canPuani = 0.0;
      print("$karakterAdi canı tükendi ve yere yığıldı");
    } else if (yeniCan >= 100.0) {
      _canPuani = 100.0;
      print("Can tamamen dolu(maksimum 100 HP )");
    } else {
      _canPuani = yeniCan;
    }
  }

  bool get hayattaMi {
    return _canPuani > 0.0;
  }
}

void main() {
  print("Kahraman Can Barı Güvenlik Sistemi");

  final savasciCani = CanSistemi(karakterAdi: "Royoma Werxim");
  print("Başlangıç Canı    : HP ${savasciCani}");
  print("35 hasar alındı.");
  savasciCani.canPuani = savasciCani.canPuani - 35.0;
  print("Kalan can              :${savasciCani.canPuani}");

  print("200 can veren iksir içildi");
  savasciCani.canPuani = 200.0;
  print("Sabitlenen Can         : HP ${savasciCani.canPuani}");

  print("Ölümcül Darbe Aldı.");
  savasciCani.canPuani = -50.0;
  print("Nihai Can              : HP ${savasciCani.canPuani}");
  print("Savaşçı Hayatta mı?    : ${savasciCani.hayattaMi ? "Evet" : "Hayır(Öldü-_-)"}");
}
