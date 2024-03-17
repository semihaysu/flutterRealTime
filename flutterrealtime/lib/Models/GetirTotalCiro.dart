class GetirTotalCiro {
    final double adCiro;
  final String adsubeTip;
  final int adFis;
  final String adsubeName;
  final double adSepetOrt;


    GetirTotalCiro({
    required this.adCiro,
    required this.adsubeTip,
    required this.adFis,
    required this.adsubeName,
    required this.adSepetOrt,
    });


        factory GetirTotalCiro.fromJson(Map<String, dynamic> json) {
  var adSepetOrtValue = json['adSepetOrt'];
  if (adSepetOrtValue is String && adSepetOrtValue == "NaN") {
    adSepetOrtValue = 0.0; // "NaN" değeri geldiğinde 0.0 olarak değiştirilir
  }
  return GetirTotalCiro(
    adCiro: (json['adCiro'] ?? 0.0).toDouble(),
    adsubeTip: json['adsubeTip'] ?? '',
    adFis: json['adFis'] ?? 0,
    adsubeName: json['adsubeName'] ?? '',
    adSepetOrt: (adSepetOrtValue ?? 0.0).toDouble(),
  );
}
}
