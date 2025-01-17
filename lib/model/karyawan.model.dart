// ignore_for_file: non_constant_identifier_names, unnecessary_this

class KaryawanData {
  final int id;
  final String nama_lengkap;
  final String tanggal_lahir;
  final String jenis_kelamin;
  final String alamat;
  final String telp;
  final String posisi;
  final String email;
  final int for_store_id;
  final String password;
  final String? created_at;
  final String? updated_at;
  final String? deleted_at;

  const KaryawanData({
    required this.id,
    required this.nama_lengkap,
    required this.tanggal_lahir,
    required this.jenis_kelamin,
    required this.alamat,
    required this.telp,
    required this.posisi,
    required this.email,
    required this.for_store_id,
    required this.password,
    required this.created_at,
    required this.updated_at,
    required this.deleted_at,
  });

  factory KaryawanData.fromJson(Map<String, dynamic> json) {
    return KaryawanData(
      id: json['id'],
      nama_lengkap: json['nama_lengkap'],
      tanggal_lahir: json['tanggal_lahir'],
      jenis_kelamin: json['jenis_kelamin'],
      alamat: json['alamat'],
      telp: json['telp'],
      posisi: json['posisi'],
      email: json['email'],
      for_store_id: json['for_store_id'],
      password: json['password'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      deleted_at: json['deleted_at'],
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'nama_lengkap': nama_lengkap,
        'tanggal_lahir': tanggal_lahir,
        'jenis_kelamin': jenis_kelamin,
        'alamat': alamat,
        'telp': telp,
        'posisi': posisi,
        'email': email,
        'for_store_id': for_store_id,
        'password': password,
        'created_at': created_at,
        'updated_at': updated_at,
        'deleted_at': deleted_at,
      };
}
