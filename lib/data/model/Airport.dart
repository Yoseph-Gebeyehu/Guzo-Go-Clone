class Airport {
  final String city;
  final String airportName;
  final String shortCode;

  Airport({
    required this.city,
    required this.airportName,
    required this.shortCode,
  });

  factory Airport.fromJson(Map<String, dynamic> json) {
    return Airport(
      city: json['City'],
      airportName: json['AirportName'],
      shortCode: json['ShortCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'City': city,
      'AirportName': airportName,
      'ShortCode': shortCode,
    };
  }
}
