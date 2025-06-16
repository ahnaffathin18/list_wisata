class User {
  final int? id;
  final String judul;
  final String deskripsi;

  User({this.id, required this.judul, required this.deskripsi});

  Map<String, dynamic> toMap() {
    return {'id': id, 'judul': judul, 'deskripsi': deskripsi};
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      judul: map['judul'],
      deskripsi: map['deskripsi'],
    );
  }
} 