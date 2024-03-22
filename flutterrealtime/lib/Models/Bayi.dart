class Bayi {
  int usubelistid;
  int usubelistuserid;
  String usubelistuname;
  String usubelistudealer;
  String usubelistsubedealer;
  String usubelistsubename;

  Bayi(
      {required this.usubelistid,
      required this.usubelistuserid,
      required this.usubelistuname,
      required this.usubelistudealer,
      required this.usubelistsubedealer,
      required this.usubelistsubename});

  factory Bayi.fromJson(Map<String, dynamic> json) {
    return Bayi(
      usubelistid: json['usubelistid'],
      usubelistuserid: json['usubelistuserid'],
      usubelistuname: json['usubelistuname'],
      usubelistudealer: json['usubelistudealer'],
      usubelistsubedealer: json['usubelistsubedealer'],
      usubelistsubename: json['usubelistsubename'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['usubelistid'] = this.usubelistid;
    data['usubelistuserid'] = this.usubelistuserid;
    data['usubelistuname'] = this.usubelistuname;
    data['usubelistudealer'] = this.usubelistudealer;
    data['usubelistsubedealer'] = this.usubelistsubedealer;
    data['usubelistsubename'] = this.usubelistsubename;
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Bayi &&
        other.usubelistid == usubelistid &&
        other.usubelistuserid == usubelistuserid &&
        other.usubelistuname == usubelistuname &&
        other.usubelistudealer == usubelistudealer &&
        other.usubelistsubedealer == usubelistsubedealer &&
        other.usubelistsubename == usubelistsubename;
  }

  @override
  int get hashCode {
    return usubelistid.hashCode ^
        usubelistuserid.hashCode ^
        usubelistuname.hashCode ^
        usubelistudealer.hashCode ^
        usubelistsubedealer.hashCode ^
        usubelistsubename.hashCode;
  }
}
