import 'package:flutter/material.dart';
import 'package:course_app/core/theme/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: TableCalendar(
        firstDay: DateTime.utc(2000, 01, 01),
        lastDay: DateTime.utc(2100, 12, 31),
        headerVisible: true,
        headerStyle: HeaderStyle(titleCentered: true),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(color: Colors.black),
          weekendStyle: TextStyle(color: Colors.red),
        ),
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: Colors.orange.shade200,
            shape: BoxShape.circle,
          ),
        ),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: _onDaySelected,
        calendarFormat: _calendarFormat,
        onFormatChanged: _onFormatChanged,
      ),
    );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }

  void _onFormatChanged(CalendarFormat format) {
    if (_calendarFormat != format) {
      setState(() => _calendarFormat = format);
    }
  }
}