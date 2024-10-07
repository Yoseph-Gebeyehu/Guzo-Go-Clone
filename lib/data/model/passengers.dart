class Passengers {
  final String adult;
  final String children;
  final String infant;

  Passengers({
    required this.adult,
    required this.children,
    required this.infant,
  });

  factory Passengers.fromJson(Map<String, dynamic> json) {
    return Passengers(
      adult: json['adult'],
      children: json['children'],
      infant: json['infant'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'children': children,
      'infant': infant,
    };
  }
}
