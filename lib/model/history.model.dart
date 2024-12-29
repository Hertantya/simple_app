class HistoryData {
  final String bulan;
  final String total_pemasukan;
  final String created_at;
  final String updated_at;

  const HistoryData({
    required this.bulan,
    required this.total_pemasukan,
    required this.created_at,
    required this.updated_at,
  });

  static HistoryData fromJson(json) => HistoryData(
      bulan: json['bulan'],
      total_pemasukan: json['total_pemasukan'],
      created_at: json['created_at'],
      updated_at: json['updated_at']);
  Map<String, dynamic> toJson() => {
        'bulan': this.bulan,
        'total_pemasukan': this.total_pemasukan,
        'created_at': this.created_at,
        'updated_at': this.updated_at,
      };
}
