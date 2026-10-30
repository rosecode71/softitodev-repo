//mixin and with : Sınıf hiyerarşisine girmeden kod paylaşımı sağlama
//abstarct class ile mixin arasındaki kullanılma farkı nedir
mixin UcmaYetisi {
  int ucusIrtifasiMetre = 100;
  void gogeYuksel() {
    print("Uçuş yetkisi : Kanatlarını Açtı ve $ucusIrtifasiMetre metreye yukseldi. ");
  }
}

mixin GorunmezlikYetisi {
  void pelerinOrt() {
    print("Görünmezlik: düşmanların gözünden tamamen kayboldu!");
  }
}

mixin AtesGucuYetisi {
  void alevSaldirisi() {
    print("Ateş Gücü: Kılıcını alevlendirdi ve alanı yaktı");
  }
}

class TemelKarakter {
  final String ad;
  TemelKarakter({required this.ad});
}

class EfsaneviEjderBinicisi extends TemelKarakter with UcmaYetisi, AtesGucuYetisi {
  final String ejderhaAdi;

  EfsaneviEjderBinicisi({required this.ejderhaAdi, required super.ad});

  void hucumEt() {
    print("$ad ve ejderha $ejderhaAdi savaşa atılıyor.");
    gogeYuksel();
    alevSaldirisi();
  }
}

class GolgeSuikastcisi extends TemelKarakter with GorunmezlikYetisi {
  GolgeSuikastcisi({required super.ad});

  void suikastYap() {
    print("$ad hedefe sessizce yaklaşıyor.");
    pelerinOrt();
    print("Kritik Darbe Vurdu");
  }
}

void main() {
  print("Süper güçler başlatılıyor.");

  final birinci = EfsaneviEjderBinicisi(ejderhaAdi: "Kraxin", ad: "Danearys");
  birinci.hucumEt();

  final ikinci = GolgeSuikastcisi(ad: "Monala Tora");
  ikinci.suikastYap();
}
