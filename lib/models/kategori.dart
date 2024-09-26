class Kategori {
  final int id;
  final String nama;

  // Add required keyword to ensure id and nama are not null
  Kategori({required this.id, required this.nama});

  // Factory method to create an instance of Kategori from JSON
  factory Kategori.fromJson(Map<String, dynamic> json) {
    return Kategori(
      id: json['id'] as int,
      nama: json['nama'] as String,
    );
  }
}
