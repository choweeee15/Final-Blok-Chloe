class Cabang {
  final int id;
  final String nama;
  final String alamat;
  final String kota;
  final String propinsi;
  final String kodepos;
  final String telp;
  final String email;
 
  Cabang({required this.id,required this.nama,required this.alamat,required this.kota,required this.propinsi,required this.kodepos,required this.telp,required this.email});
 
  factory Cabang.fromJson(Map<String, dynamic> json) {
    return Cabang(
      id: json['id'] as int,
      nama: json['nama'] as String,
      alamat: json['alamat'] as String,
      kota: json['kota'] as String,
      propinsi: json['propinsi'] as String,
      kodepos: json['kodepos'] as String,
      telp: json['telp'] as String,
      email: json['email'] as String
    );
  }
  
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['nama'] = nama;
    map['alamat'] = alamat;
    map['kota'] = kota;
    map['propinsi'] = propinsi;
    map['kodepos'] = kodepos;
    map['telp'] = telp;
    map['email'] = email;
    return map;
  }
}