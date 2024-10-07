import 'package:flutter/material.dart';
import 'package:guzo_go_clone/data/model/trip_date.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../provider/trip_date_selector_provider.dart';

class TripDateSelectorPage extends StatefulWidget {
  const TripDateSelectorPage({super.key});

  @override
  State<TripDateSelectorPage> createState() => _TripDateSelectorPageState();
}

class _TripDateSelectorPageState extends State<TripDateSelectorPage> {
  List<DateTime> bookedDates = [];
  int? apartmentPrice;
  int? serviceCharge;

  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;

  bool isDateBooked(DateTime date) {
    return bookedDates.any((bookedDate) => isSameDay(bookedDate, date));
  }

  bool hasBookedDateInRange(DateTime start, DateTime end) {
    for (var day = start;
        !day.isAfter(end);
        day = day.add(const Duration(days: 1))) {
      if (isDateBooked(day)) {
        return true;
      }
    }
    return false;
  }

  int calculateNumberOfDays() {
    if (_rangeStart != null && _rangeEnd != null) {
      return _rangeEnd!.difference(_rangeStart!).inDays + 1;
    }
    return 1;
  }

  List<DateTime> getMonthsList(DateTime startMonth, int count) {
    List<DateTime> months = [];
    for (int i = 0; i < count; i++) {
      months.add(DateTime(startMonth.year, startMonth.month + i, 1));
    }
    return months;
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> months = getMonthsList(DateTime.now(), 12);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Please select departure and return date',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: true,
      ),
      body: ListView.builder(
        itemCount: months.length,
        itemBuilder: (context, index) {
          DateTime month = months[index];
          return TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: month,
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            rangeSelectionMode: _rangeSelectionMode,
            availableCalendarFormats: const {
              CalendarFormat.month: 'Month',
            },
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
              weekendStyle: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            startingDayOfWeek: StartingDayOfWeek.sunday,
            calendarStyle: CalendarStyle(
              selectedTextStyle: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
              todayTextStyle: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
              todayDecoration: const BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              rangeStartDecoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
              ),
              rangeEndDecoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              weekendTextStyle: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
              defaultTextStyle: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
              disabledTextStyle: const TextStyle(color: Colors.grey),
            ),
            enabledDayPredicate: (day) {
              return day
                  .isAfter(DateTime.now().subtract(const Duration(days: 1)));
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                if (_rangeStart != null &&
                    isSameDay(_rangeStart!, selectedDay)) {
                  _rangeStart = null;
                  _rangeEnd = null;
                  _rangeSelectionMode = RangeSelectionMode.toggledOff;
                } else if (_rangeStart == null) {
                  _rangeStart = selectedDay;
                  _rangeEnd = null;
                  _rangeSelectionMode = RangeSelectionMode.toggledOn;
                } else {
                  if (selectedDay.isBefore(_rangeStart!)) {
                    _rangeStart = selectedDay;
                    _rangeEnd = null;
                    _rangeSelectionMode = RangeSelectionMode.toggledOn;
                  } else {
                    if (!hasBookedDateInRange(_rangeStart!, selectedDay)) {
                      _rangeEnd = selectedDay;
                      _rangeSelectionMode = RangeSelectionMode.toggledOn;
                    } else {
                      _rangeEnd = null;
                      _rangeSelectionMode = RangeSelectionMode.toggledOff;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                            'Cannot select range with booked dates in between',
                          ),
                          backgroundColor: Theme.of(context).primaryColorDark,
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    }
                  }
                }
              });
            },
            onPageChanged: (focusedDay) {
              setState(() {});
            },
          );
        },
      ),
      bottomNavigationBar: _rangeStart != null && _rangeEnd != null
          ? BottomAppBar(
              elevation: 0,
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_rangeStart != null && _rangeEnd != null) {
                      String startDay = DateFormat('dd').format(_rangeStart!);
                      String startMonth =
                          DateFormat('MMMM').format(_rangeStart!);
                      String startDate =
                          DateFormat('EEEE').format(_rangeStart!);

                      String endDay = DateFormat('dd').format(_rangeEnd!);
                      String endMonth = DateFormat('MMMM').format(_rangeEnd!);
                      String endDate = DateFormat('EEEE').format(_rangeEnd!);

                      final tripDateProvider =
                          Provider.of<TripDateProvider>(context, listen: false);

                      tripDateProvider.addTripDates(
                        TripDate(
                          day: startDay,
                          month: startMonth,
                          date: startDate,
                        ),
                        TripDate(
                          day: endDay,
                          month: endMonth,
                          date: endDate,
                        ),
                        context,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColorDark,
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
