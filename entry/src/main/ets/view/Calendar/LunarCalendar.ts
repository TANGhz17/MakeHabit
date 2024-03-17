const TAG = "LunarCalendar"

export class LunarCalendar {
  /**
   * 获取阴历
   * @param date
   * @returns
   */
  static getLunarDate(date: Date) {
    console.log(TAG, `${date.getFullYear()}年${date.getMonth() + 1}月${date.getDate()}日`)

    const year = date.getFullYear();
    const month = date.getMonth();
    const day = date.getDate();

    // 计算阴历年份
    let lunarYear = year - 1900 + 4712;
    if (lunarYear > 9999 || lunarYear < 1900) {
      console.error('无效的阴历年份');
      return;
    }

    // 计算阴历月份
    let lunarMonth = (lunarYear % 12) + 1;
    if (lunarMonth > 12 || lunarMonth < 1) {
      console.error('无效的阴历月份');
      return;
    }

    // 计算阴历日期
    let lunarDay;
    if (day < 1 || day > 31) {
      console.error('无效的阴历日期');
      return;
    } else if (day === 29 && (lunarMonth === 1 || lunarMonth === 3 || lunarMonth === 5 || lunarMonth === 7 || lunarMonth === 8 || lunarMonth === 10 || lunarMonth === 12)) {
      lunarDay = 15;
    } else if (day === 30 && (lunarMonth === 4 || lunarMonth === 6 || lunarMonth === 9 || lunarMonth === 11)) {
      lunarDay = 16;
    } else {
      lunarDay = day;
    }

    // 返回阴历日期字符串
    return `${lunarYear}年${lunarMonth}月${lunarDay}日`;
  }
}