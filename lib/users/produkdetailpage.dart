import 'package:flutter/material.dart';
import 'package:tokoonline/constans.dart';
import 'package:tokoonline/models/cabang.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ProdukDetailPage extends StatefulWidget {
  final int id;
  final String judul;
  final String harga;
  final String hargax;
  final String thumbnail;
  final bool valstok;

  ProdukDetailPage(
    this.id,
    this.judul,
    this.harga,
    this.hargax,
    this.thumbnail,
    this.valstok, {
    Key? key,
  }) : super(key: key);

  @override
  _ProdukDetailPageState createState() => _ProdukDetailPageState();
}

class _ProdukDetailPageState extends State<ProdukDetailPage> {
  List<Cabang> cabanglist = [];
  String? _valcabang; // Nullable _valcabang
  bool instok = false;

  @override
  void initState() {
    super.initState();
    fetchCabang();
    instok = widget.valstok; // Directly setting instok
  }

  Future<List<Cabang>> fetchCabang() async {
    List<Cabang> usersList = [];
    var params = "/cabang";
    try {
      var jsonResponse = await http.get(Uri.parse(Palette.sUrl + params));
      print("Response body: ${jsonResponse.body}"); // Debugging print
      if (jsonResponse.statusCode == 200) {
        final jsonItems = json.decode(jsonResponse.body).cast<Map<String, dynamic>>();

        usersList = jsonItems.map<Cabang>((json) {
          return Cabang.fromJson(json);
        }).toList();
        setState(() {
          cabanglist = usersList;
        });
      }
    } catch (e) {
      print('Error fetching cabang: $e');
    }
    return usersList;
  }

  _cekProdukCabang(String idproduk, String? idcabang) async {
    var params = "/cekprodukbycabang?idproduk=" + idproduk + "&idcabang=" + idcabang!;
    try {
      var res = await http.get(Uri.parse(Palette.sUrl + params));
      if (res.statusCode == 200) {
        if (res.body == "OK") {
          setState(() {
            instok = true;
          });
        } else {
          setState(() {
            instok = false;
          });
        }
      }
    } catch (e) {
      setState(() {
        instok = false;
      });
    }
  }

  Widget _body() {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Image.asset(
              '/' + widget.thumbnail,
              fit: BoxFit.fitWidth,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text(widget.judul),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: Text(widget.harga),
          ),
          Container(
            margin: EdgeInsets.all(10),
            height: 60, // Ensure enough space for interaction
            child: Material(
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                ),
                hint: Text("Pilih Cabang"),
                value: _valcabang,
                items: cabanglist.map((item) {
                  return DropdownMenuItem<String>(
                    child: Text(item.nama),
                    value: item.id.toString(),
                  );
                }).toList(),
                onChanged: (value) {
                  print("Selected Value: $value"); // Debugging print
                  setState(() {
                    _valcabang = value;
                    _cekProdukCabang(widget.id.toString(), _valcabang);
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Transaksi'),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _body(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Container(
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    child: Icon(
                      Icons.favorite_border,
                      size: 40.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      boxShadow: [
                        BoxShadow(color: Colors.grey[500]!, spreadRadius: 1),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/keranjangusers', (Route<dynamic> route) => false);
                  },
                  child: Container(
                    child: Icon(
                      Icons.shopping_cart,
                      size: 40.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      boxShadow: [
                        BoxShadow(color: Colors.grey[500]!, spreadRadius: 1),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (instok) {
                      // Keranjang _keranjangku = Keranjang(
                      //     idproduk: widget.id,
                      //     judul: widget.judul,
                      //     harga: widget.harga,
                      //     hargax: widget.hargax,
                      //     thumbnail: widget.thumbnail,
                      //     jumlah: 1,
                      //     userid: userid,
                      //     idcabang: _valcabang);
                      // saveKeranjang(_keranjangku);
                    }
                  },
                  child: Container(
                    height: 40.0,
                    child: Center(
                      child: Text(
                        'Beli Sekarang',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: instok ? Colors.blue : Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: instok ? Colors.blue : Colors.grey,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          height: 60.0,
          padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 2.0, bottom: 2.0),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            boxShadow: [
              BoxShadow(color: Colors.grey[100]!, spreadRadius: 1),
            ],
          ),
        ),
        elevation: 0,
      ),
    );
  }
}
