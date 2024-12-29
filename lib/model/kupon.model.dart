class KuponData {
  final String id_kupon;
  final String jenis_kupon;
  final String kode_warna;
  final String harga_kupon;
  final String nama_desa;
  final String stok;

  const KuponData({
    required this.id_kupon,
    required this.jenis_kupon,
    required this.kode_warna,
    required this.harga_kupon,
    required this.nama_desa,
    required this.stok,
  });

  static KuponData fromJson(json) => KuponData(
      id_kupon: json['id_kupon'],
      jenis_kupon: json['jenis_kupon'],
      kode_warna: json['kode_warna'],
      harga_kupon: json['harga_kupon'],
      nama_desa: json['nama_desa'],
      stok: json['stok']);
}
