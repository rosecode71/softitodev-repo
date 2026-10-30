abstract class LoncaUyesi {
  final String rumuz;
  LoncaUyesi({required this.rumuz});

  //Soyut metot abtsract method
  void ozelYetenekKullan();

  void loncaSelamVer() {
    print("$rumuz Lonca Bayrağını Selamladı: 'Onur ve zafer için'");
  }
}

class Sovalye extends LoncaUyesi {
  Sovalye({required super.rumuz});

  @override
  void ozelYetenekKullan() {
    print("$rumuz Demir kalkanını kaldırdı ve savunma duvarı ördü");
  }
}

class Sifaci extends LoncaUyesi {
  Sifaci({required super.rumuz});

  @override
  void ozelYetenekKullan() {
    print("$rumuz Kutsal ışık büyüsüyle tüm takımın canını tazeledi.");
  }
}
//soyut canavr sınıfı gövdesiz kükre, kurt canavaeı

abstract class Canavar {
  void kukre();
}

class Kurt extends Canavar {
  @override
  void kukre() {
    print("AUUUUUUUUU");
  }
}

class Ejderha extends Canavar {
  @override
  void kukre() {
    print("WAAAAA");
  }
}

void savasAlanindaKomutVer(List<LoncaUyesi> takim) {
  print("Liderin Emriyle Takım Yetenekleri Devreye Girsin");
  for (var t in takim) {
    t.loncaSelamVer();
    //Herkes kendi özel yeteneğini kullansın.
    t.ozelYetenekKullan();
  }
}

void canavarSesVer(List<Canavar> takim) {
  print("Liderin Emriyle Takım Yetenekleri Devreye Girsin");
  for (var t in takim) {
    t.kukre();
  }
}

void main() {
  print("Lonca Takımı");
  final List<LoncaUyesi> loncaBirligi = [
    Sovalye(rumuz: "Kızıl Şovalye Dora"),
    Sifaci(rumuz: "Orman Perisi Shahd"),
    Sovalye(rumuz: "Gümüş Muhafız Eren")
  ];

  //Hepsini tek bir emir ile çalışıtırıyoruz
  savasAlanindaKomutVer(loncaBirligi);

  final List<Canavar> canavarTakimi = [Kurt(), Ejderha()];
  canavarSesVer(canavarTakimi);
}
