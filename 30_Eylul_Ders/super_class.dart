class TemelSavasci {
  final String ad;
  final double temelGuc;

  TemelSavasci({required this.ad, required this.temelGuc});

  void saldir() {
    print("[$ad] temel fiziksel yumruk attı.Hasar: $temelGuc");
  }
}

class Buyucu extends TemelSavasci {
  int manaPuani;

  Buyucu({required this.manaPuani, required super.ad, required super.temelGuc});

  @override
  void saldir() {
    if (manaPuani >= 10) {
      manaPuani -= 10;
      print("[$ad] Alev Topu Fırlattı.Hasar : ${temelGuc * 2} Kalan Mana: $manaPuani");
    } else {
      print("Mana Tükendi");
      super.saldir();
    }
  }
}

class Okcu extends TemelSavasci {
  int okSayisi;

  Okcu({required this.okSayisi, required super.ad, required super.temelGuc});

  @override
  void saldir() {
    if (okSayisi > 0) {
      okSayisi -= 1;
      print("[$ad] Hedefe Zehirli Ok fırlattı: Hasar: ${temelGuc * 1.5} Kalan Ok Sayısı $okSayisi");
    } else {
      print("Ok bitti");
      super.saldir();
    }
  }
}

void main() {
  print("Savaş Arenası");

  final asker = TemelSavasci(ad: "Adri", temelGuc: 20.0);
  asker.saldir();

  print("*" * 60);

  final merlin = Buyucu(manaPuani: 20, ad: "Soraya", temelGuc: 57.0);
  merlin.saldir();

  print("*" * 60);
  final legolas = Okcu(okSayisi: 7, ad: "Tomxi", temelGuc: 35.0);
  legolas.saldir();
}
