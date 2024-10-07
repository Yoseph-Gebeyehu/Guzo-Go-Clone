class CabinClass {
  final String cabinClass;

  CabinClass({
    required this.cabinClass,
  });

  factory CabinClass.fromJson(Map<String, dynamic> json) {
    return CabinClass(
      cabinClass: json['cabinClass'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cabinClass': cabinClass,
    };
  }
}
