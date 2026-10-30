//Zindan ve Eşya(crafting) sistemi

extension AltinFormatUzantisi on int {
  //sayıyı formatlı altın metnine çevir
  String get toAltinKese => "${this} Altın";
}

extension AgirlikFormatUzantisi on double {
  //Ağırlık Kg olarak göster
  String get toAgirlikKg => "${this.toStringAsFixed(1)} kg";
}

//Eşyaların nadirlik dereceleri
enum EsyaNadirligi { yaygin, nadir, destansi, efsanevi }

//Genel zindan hata sınıfları
class ZindanException implements Exception {
  final String hataKodu;
  final String mesaj;
  final DateTime zaman = DateTime.now();

  ZindanException(this.hataKodu, this.mesaj);
  @override
  String toString() => "[$hataKodu] $mesaj ($zaman)";
}

//Çanta ağırlık aşıldığında hata kodu
class CantadaYerYokException extends ZindanException {
  CantadaYerYokException(double asim)
      : super("ERR_BAG_FULL", "Çanta Kapasitesi ${asim.toStringAsFixed(1)} kg Aşıldı. Eşyayı alamazsınız.");
}

//Yetersiz altın durumunda hata
class YetersizAltinException extends ZindanException {
  YetersizAltinException(int eksik) : super("ERR_NO_GOLD", "Bu işlem için $eksik altın daha gerekiyor.");
}

//------------------------------------------------
//Mixler
//------------------------------------------------

//1.Parçalanıp büyü tozuna dönüşebilen eşyalar
mixin ParcalanabilirYetisi {
  void tozaDonustur(String esyaAdi) {
    print("Demirci $esyaAdi parçaladı ve 5 adet 'Mavi büyü tozu' elde edildi.");
  }
}

//2.Rün basılarak extra güç kazandıran eşyalar
mixin RuneBasmaYetisi {
  void runKusa(String runeTuru) {
    print("Object büyüsü: Eşyaya '$runeTuru' rünü mühürlendi.(+15 büyü hasarı)");
  }
}

//----------------------------------------------
//Eşya/item Modeli
//----------------------------------------------

class Esya with ParcalanabilirYetisi, RuneBasmaYetisi {
  final String id;
  final String ad;
  final double agirlik;
  final EsyaNadirligi nadirlik;
  final String? aciklama;
  bool efsunluMu;

  Esya(
      {required this.id,
      required this.ad,
      required this.agirlik,
      required this.nadirlik,
      this.aciklama,
      this.efsunluMu = false});

  Esya.kucukCanIksiri()
      : id = "POT-001",
        ad = "Küçük Şifa İksiri",
        agirlik = 0.5,
        aciklama = "İçildiğinde anında 30 can yeniler",
        nadirlik = EsyaNadirligi.yaygin,
        efsunluMu = false;

  //record
  ({String etiket, double carpan, int satisFiyati}) degerlemeYap() {
    final (etiket, carpan, bazFiyat) = switch (nadirlik) {
      EsyaNadirligi.yaygin => ("Yaygın", 1.0, 50),
      EsyaNadirligi.nadir => ("Nadir", 1.5, 200),
      EsyaNadirligi.destansi => ("Destansı", 2.5, 750),
      EsyaNadirligi.efsanevi when efsunluMu => ("Kadim Efsanevi", 5.0, 3000),
      EsyaNadirligi.efsanevi => ("Efsanevi", 4.0, 2000)
    };

    return (etiket: etiket, carpan: carpan, satisFiyati: (bazFiyat * carpan).toInt());
  }
}

//Oyuncunun Çantası
class OyuncuCantasi {
  final String sahipAdi;
  final double maxAgirlikKapasitesi;
  final List<Esya> _esyalar = [];
  int _altin = 500;

  OyuncuCantasi({
    required this.sahipAdi,
    this.maxAgirlikKapasitesi = 25.0,
  });

  int get altin {
    return _altin;
  }

  //altın harcama metodumuz
  void altinHarcama(int miktar) {
    if (miktar > _altin) {
      throw YetersizAltinException(miktar - altin);
    }
    _altin -= miktar;
    print("[Ticaret]: $miktar altın harcandı. Kalan Cüzdan: ${_altin.toAltinKese}");
  }

  //Çantanın ağırlığı
  double get mevcutAgirlik => _esyalar.fold(0.0, (toplam, esya) => toplam + esya.agirlik);

  //Çantaya eşya ekle
  void esyaEkle(Esya esya) {
    if (esya.agirlik + mevcutAgirlik > maxAgirlikKapasitesi) {
      final double asim = mevcutAgirlik + esya.agirlik - maxAgirlikKapasitesi;
      throw CantadaYerYokException(asim);
    }
    _esyalar.add(esya);
    print("[Çanta]: '${esya.ad}' çantaya yerleştirildi. (${esya.agirlik.toAgirlikKg})");
  }

  //Sadece değerli eşyaları filitreler
  List<Esya> get degerliEsyalar => _esyalar
      .where((esya) => esya.nadirlik == EsyaNadirligi.destansi || esya.nadirlik == EsyaNadirligi.efsanevi)
      .toList();

  //Çanta Döküm Raporu

  void envanterRaporuBas() {
    print("""
   ==========================================================
   Kahraman Envanter Raporu
   Sahip: $sahipAdi | Altın: ${_altin.toAltinKese} | Yük: ${mevcutAgirlik.toAgirlikKg}/${maxAgirlikKapasitesi.toAgirlikKg};
   ==========================================================
""");

    for (var esya in _esyalar) {
      final deger = esya.degerlemeYap();
      final aciklamaMetni = esya.aciklama ?? "Özel Nitelik Belirtilmemiş";

      print(
          "${deger.etiket.padRight(20)} | ${esya.ad.padRight(24)} |${esya.agirlik.toAgirlikKg.padLeft(8)} | Değer: ${deger.satisFiyati.toAltinKese.padLeft(12)}");

      print("Not: $aciklamaMetni");

      print("Değerli eşya sayısı ${degerliEsyalar.length}");
      print("=================================================");
    }
  }
}

void main() {
  print("Zindan & Envanter Motoru Başlatılıyor....");

  final bool vipUyelik = true;

  //çantamızı oluşturuyoruz
  final canta = OyuncuCantasi(sahipAdi: "Elf Okçusu Natila", maxAgirlikKapasitesi: 20.0);

  final List<Esya> zindanGirisPaketi = [
    Esya.kucukCanIksiri(),
    Esya(
        id: "SWD-101",
        ad: "Gümüş Ejder Kılıcı",
        agirlik: 4.5,
        nadirlik: EsyaNadirligi.destansi,
        aciklama: "Karanlık yaratıklara karşı %25 ek hasar",
        efsunluMu: true),
    if (vipUyelik)
      Esya(
          id: "RNG-999",
          ad: "Zamanın Sonu Yüzüğü",
          agirlik: 0.2,
          nadirlik: EsyaNadirligi.efsanevi,
          aciklama: "Bekleme Sürelerini %20 azaltır",
          efsunluMu: true)
  ];

  //eşyaları çantaya ekle
  for (var esya in zindanGirisPaketi) {
    canta.esyaEkle(esya);
  }

  print("Zanaat ve büyü masası");
  final kilic = zindanGirisPaketi[1];
  kilic.runKusa("Kutsal Işık");
  kilic.tozaDonustur(kilic.ad);

  print("Ticaret ve altın harcama");
  try {
    canta.altinHarcama(200);
    canta.altinHarcama(800);
  } on YetersizAltinException catch (err) {
    print("Hata Yakalandı: ${err.mesaj}");
  } catch (err) {
    print("Genel Hata : $err");
  }

  //Kapasite aşım testi
  print("Çanta kapasitesi aşımı");
  try {
    final devKaya = Esya(id: "BLD-777", ad: "Göktaşı Parçası", agirlik: 28.0, nadirlik: EsyaNadirligi.yaygin);
    canta.esyaEkle(devKaya);
  } on CantadaYerYokException catch (err) {
    print("Aşırı yük engellendi. ${err.mesaj}");
  }
  canta.envanterRaporuBas();
}
