import 'dart:js_interop';

@JS('getBalineseDate')
external JSObject _getBalineseDate(
  int year,
  int month,
  int day,
);

class BalineseCalendarData {
  final int saka;
  final String sasih;
  final String wuku;

  const BalineseCalendarData({
    required this.saka,
    required this.sasih,
    required this.wuku,
  });
}

class BalineseCalendarService {
  static BalineseCalendarData getCalendar(DateTime tanggal) {
    final result = _getBalineseDate(
      tanggal.year,
      tanggal.month,
      tanggal.day,
    ).dartify() as Map;

    return BalineseCalendarData(
      saka: (result['saka'] as num).toInt(),
      sasih: result['sasih'].toString(),
      wuku: result['wuku'].toString(),
    );
  }
}