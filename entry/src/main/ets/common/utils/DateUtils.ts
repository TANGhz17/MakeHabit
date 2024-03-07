export default class DateUtils {
  /**
   * 获取一个月的第一天是周几
   */
  static getFirstDayOfMonthInWeek(year, month) {
    return new Date(year, month, 1).getUTCDay();
  }

  static getDaysOfMonth(year, month) {
    return new Date(year, month, 0).getDate();
  }
}