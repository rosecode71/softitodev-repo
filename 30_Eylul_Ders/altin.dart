class OyunKasasi {
  final String oyuncuAdi;
  int _altinMiktari = 0;

  OyunKasasi({required this.oyuncuAdi});

  int get altinMiktari {
    return _altinMiktari;
  }

  set altinMiktariEkle(int bakiye) {
    if (bakiye <= 0) {
      print("Altın kasaya eklenemez.");
      return;
    }

    _altinMiktari += bakiye;
  }
}

void main() {
  final oyuncuKasasi = OyunKasasi(oyuncuAdi: "Oyuncu");

  oyuncuKasasi.altinMiktariEkle = 150;

  print(oyuncuKasasi.altinMiktari);
}
