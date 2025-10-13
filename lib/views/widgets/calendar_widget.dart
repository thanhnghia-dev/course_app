import 'package:flutter/material.dart';
import 'package:course_app/core/theme/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

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
  void initState() {
    super.initState();
    initializeDateFormatting('vi_VN', null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: TableCalendar(
        locale: 'vi_VN',
        firstDay: DateTime.utc(2000, 01, 01),
        lastDay: DateTime.utc(2100, 12, 31),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),

        onDaySelected: _onDaySelected,
        onFormatChanged: _onFormatChanged,

        headerVisible: true,
        headerStyle: HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          titleTextFormatter: (date, locale) {
            final formatted = DateFormat.yMMMM(locale).format(date);
            return '${formatted[0].toUpperCase()}${formatted.substring(1)}';
          },
          titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          leftChevronIcon: const Icon(Icons.chevron_left, color: Colors.black87),
          rightChevronIcon:
              const Icon(Icons.chevron_right, color: Colors.black87),
        ),

        daysOfWeekStyle: const DaysOfWeekStyle(
          weekdayStyle: TextStyle(color: Colors.black87),
          weekendStyle: TextStyle(color: Colors.red),
        ),

        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          todayTextStyle: const TextStyle(color: Colors.white),
          selectedTextStyle: const TextStyle(color: Colors.white),
        ),
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
