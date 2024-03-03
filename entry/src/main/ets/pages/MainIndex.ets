import router from '@ohos.router';
import { LocalDate } from '@js-joda/core'
import { CommonConstants } from '../common/constants/CommonConstants';
import Month from '../view/Main/Month';

@Entry
@Component
struct MainIndex {

  // @State

  aboutToAppear(){
    var mDate = LocalDate.parse('2024-03-01');
    // .now() 今天的日期
    console.debug("MakeHabit main "+ LocalDate.now().toString());
    // .dayOfWeek() 当前日期是周几: FRIDAY
    console.debug("MakeHabit main "+ mDate.dayOfWeek().toString());
    // .isLeapYear() 当前日期是否为闰年：true
    console.debug("MakeHabit main "+ mDate.isLeapYear().toString());
    // .lengthOfMonth() 当前月有多少天：31
    console.info(mDate.lengthOfMonth().toString());
  }

  build() {
    Column() {
      // Text("2024年3月")
      //   .textAlign(TextAlign.Start)

      Month({month : 1})

    }
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
    .backgroundColor($r('app.color.grey_light'))
  }
}