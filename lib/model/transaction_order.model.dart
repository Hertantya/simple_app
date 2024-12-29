class TransactionOrderData {
  final String id_order;
  final String id_pelanggan;
  final String id_kupon;
  final String no_kk;
  final String path_gambar_kk;
  final String tanggal_order;
  final String jumlah_order;
  final String total_order;
  final String status_order;
  final String nama_pelanggan;
  final String jenis_kupon;
  final String harga_kupon;

  const TransactionOrderData({
    required this.id_order,
    required this.id_pelanggan,
    required this.id_kupon,
    required this.no_kk,
    required this.path_gambar_kk,
    required this.tanggal_order,
    required this.jumlah_order,
    required this.total_order,
    required this.status_order,
    required this.nama_pelanggan,
    required this.jenis_kupon,
    required this.harga_kupon,
  });

  static TransactionOrderData fromJson(json) => TransactionOrderData(
      id_order: json['id_order'],
      id_pelanggan: json['id_pelanggan'],
      id_kupon: json['id_kupon'],
      no_kk: json['no_kk'],
      path_gambar_kk: json['path_gambar_kk'],
      tanggal_order: json['tanggal_order'],
      jumlah_order: json['jumlah_order'],
      total_order: json['total_order'],
      status_order: json['status_order'],
      nama_pelanggan: json['nama_pelanggan'],
      jenis_kupon: json['jenis_kupon'],
      harga_kupon: json['harga_kupon']);
  Map<String, dynamic> toJson() => {
        'id_order': this.id_order,
        'id_pelanggan': this.id_pelanggan,
        'id_kupon': this.id_kupon,
        'no_kk': this.no_kk,
        'path_gambar_kk': this.path_gambar_kk,
        'tanggal_order': this.tanggal_order,
        'jumlah_order': this.jumlah_order,
        'total_order': this.total_order,
        'status_order': this.status_order,
        'nama_pelanggan': this.nama_pelanggan,
        'jenis_kupon': this.jenis_kupon,
        'harga_kupon': this.harga_kupon,
      };
}
