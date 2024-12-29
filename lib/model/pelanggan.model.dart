class PelangganData {
  final String id_pelanggan;
  final String nama_lengkap;
  final String tanggal_lahir;
  final String jenis_kelamin;
  final String alamat;
  final String no_telp;
  final String email;
  final String password;
  final String asal_desa;
  final String no_kk;
  final String path_gambar_kk;

  const PelangganData({
    required this.id_pelanggan,
    required this.nama_lengkap,
    required this.tanggal_lahir,
    required this.jenis_kelamin,
    required this.alamat,
    required this.no_telp,
    required this.email,
    required this.password,
    required this.asal_desa,
    required this.no_kk,
    required this.path_gambar_kk,
  });

  factory PelangganData.fromJson(Map<String, dynamic> json) {
    return PelangganData(
      id_pelanggan: json['id_pelanggan'],
      nama_lengkap: json['nama_lengkap'],
      tanggal_lahir: json['tanggal_lahir'],
      jenis_kelamin: json['jenis_kelamin'],
      alamat: json['alamat'],
      no_telp: json['no_telp'],
      email: json['email'],
      password: json['password'],
      asal_desa: json['asal_desa'],
      no_kk: json['no_kk'],
      path_gambar_kk: json['path_gambar_kk'],
    );
  }
  Map<String, dynamic> toJson() => {
        'id_pelanggan': this.id_pelanggan,
        'nama_lengkap': this.nama_lengkap,
        'tanggal_lahir': this.tanggal_lahir,
        'jenis_kelamin': this.jenis_kelamin,
        'alamat': this.alamat,
        'no_telp': this.no_telp,
        'email': this.email,
        'password': this.password,
        'asal_desa': this.asal_desa,
        'no_kk': this.no_kk,
        'path_gambar_kk': this.path_gambar_kk,
      };
}
