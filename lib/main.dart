import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FirebaseCrud(),
  ));
}

class FirebaseCrud extends StatefulWidget {
  const FirebaseCrud({Key? key}) : super(key: key);

  @override
  _FirebaseCrudState createState() => _FirebaseCrudState();
}

class _FirebaseCrudState extends State<FirebaseCrud> {
  late String id, ad, kategori;
  late String kitapSayfasi;

  idAl(idTutucu) {
    this.id = idTutucu;
  }

  adAl(adTutucu) {
    this.ad = adTutucu;
  }

  kategoriAl(kategoriTutucu) {
    this.kategori = kategoriTutucu;
  }

  sayfaAl(sayfaTutucu) {
    this.kitapSayfasi = sayfaTutucu;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Crud"),
        centerTitle: true,
      ),
      body: Column(

        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              onChanged: (String idTutucu) {
                idAl(idTutucu);
              },
              decoration: InputDecoration(
                hintText: "KitapID",
                hintStyle: TextStyle(color: Colors.teal),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54, width: 2)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              onChanged: (String adTutucu) {
                adAl(adTutucu);
              },
              decoration: InputDecoration(
                labelText: "Kitap Adı",
                labelStyle: TextStyle(color: Colors.teal),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54, width: 2)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              onChanged: (String kategoriTutucu) {
                kategoriAl(kategoriTutucu);
              },
              decoration: InputDecoration(
                labelText: "Kitap Kategorisi",
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54, width: 2)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              onChanged: (String sayfaTutucu) {
                sayfaAl(sayfaTutucu.toString());
              },
              decoration: const InputDecoration(
                labelText: "Kitap Sayfası",
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54, width: 2)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    veriEkle();
                  },
                  child: Text("Ekle"),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.indigoAccent,
                      onPrimary: Colors.white,
                      shadowColor: Colors.indigo,
                      elevation: 5),
                ),
                ElevatedButton(
                  onPressed: () {
                    veriOku();
                  },
                  child: Text("Oku"),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.teal,
                      onPrimary: Colors.white,
                      shadowColor: Colors.indigo,
                      elevation: 5),
                ),
                ElevatedButton(
                  onPressed: () {
                    veriGuncelle();
                  },
                  child: Text("Güncelle"),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.redAccent,
                      onPrimary: Colors.white,
                      shadowColor: Colors.indigo,
                      elevation: 5),
                ),
                ElevatedButton(
                  onPressed: () {
                    veriSil();
                  },
                  child: Text("Sil"),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.pinkAccent,
                      onPrimary: Colors.white,
                      shadowColor: Colors.indigo,
                      elevation: 5),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Firebase e veri ekler
  void veriEkle() {
    //veri yolu ekleme
    DocumentReference veriYolu = FirebaseFirestore.instance.collection(
        "kitaplik").doc(id);


    //çoklu veri yollamak için map
    Map<String, dynamic> kitaplar = {

      "KitapID": id,
      "KitapAdi": ad,
      "KitapKategori": kategori,
      "KitapSayfa": kitapSayfasi.toString(),

    };

    // veriyi veri tabanına ekle
    veriYolu.set(kitaplar).whenComplete(() =>
        Fluttertoast.showToast(msg: id + " ID'li kitap kitaplığa eklendi"));
  }

  // Firebaseden veri okur
  void veriOku() {
    DocumentReference veriOkumaYolu = FirebaseFirestore.instance.collection("kitaplik").doc(id);

    veriOkumaYolu.get().then((alinanDeger) {
      var alinanVeri =alinanDeger;

            String idTut = alinanVeri["KitapID"];
            String adTut = alinanVeri["KitapAdi"];
            String kategoriTut =alinanVeri["KitapKategori"];
            String sayfaTut =alinanVeri["KitapSayfa"];
      
      
      
      Fluttertoast.showToast(msg: " ID:"  +idTut+ "        Adı:"+adTut+ "         Kategorisi:"+kategoriTut+ "              Sayfa Sayisi:"+sayfaTut);

    });
  }



  //Firebaseden veri gunceller
  void veriGuncelle() {

    //veri yolunu olustur

    DocumentReference veriYoluGuncelle = FirebaseFirestore.instance.collection("kitaplik").doc(id);

    //çoklu veri güncellemek için map kullan


    Map<String,dynamic> guncellenecekVeri  = {
      "KitapID":id,
      "KitapAdi":ad,
      "KitapKategori":kategori,
      "KitapSayfa" : kitapSayfasi,

    };
    
   veriYoluGuncelle.update(guncellenecekVeri).whenComplete(() {
     Fluttertoast.showToast(msg: id + " ID'li kitap güncellendi");

   });


  }

  //Firebaseden veri siler
  void veriSil() {

    DocumentReference veriYoluSil= FirebaseFirestore.instance.collection("kitaplik").doc(id);


    veriYoluSil.delete().whenComplete(() {

      Fluttertoast.showToast(msg: id + " ID'li kitap silindi");


    });


  }
}
