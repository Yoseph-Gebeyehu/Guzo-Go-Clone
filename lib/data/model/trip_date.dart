class TripDate {
  final String day;
  final String month;
  final String date;

  TripDate({
    required this.day,
    required this.month,
    required this.date,
  });

  factory TripDate.fromJson(Map<String, dynamic> json) {
    return TripDate(
      day: json['day'],
      month: json['month'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'month': month,
      'date': date,
    };
  }
}
