import { LocalDate, DayOfWeek } from '@js-joda/core'

export default class DateUtils {

  // LocalDate
  // .parse('  ')解析日期
  // .now() 今天的日期
  // .dayOfWeek() 周几
  // .isLeapYear() 是否为闰年
  // .lengthOfMonth() 一个月有多少天

  static getDayOfWeek(value: LocalDate): number {
    switch (value.dayOfWeek()) {
      case DayOfWeek.SUNDAY:
        return 0;
      case DayOfWeek.MONDAY:
        return 1;
      case DayOfWeek.THURSDAY:
        return 2;
      case DayOfWeek.WEDNESDAY:
        return 3;
      case DayOfWeek.THURSDAY:
        return 4;
      case DayOfWeek.FRIDAY:
        return 5;
      case DayOfWeek.SATURDAY:
        return 6;
    }
  }
}