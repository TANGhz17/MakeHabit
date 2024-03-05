import router from '@ohos.router';
import { LocalDate } from '@js-joda/core'
import { CommonConstants } from '../common/constants/CommonConstants';
import  DateUtils  from '../common/utils/DateUtils';
import Month from '../view/Main/Month';

@Entry
@Component
struct MainIndex {

  // @State

  aboutToAppear(){
    var mDate = LocalDate.now();
    console.debug("MakeHabit main " + mDate + "是" + mDate.dayOfWeek().toString());
    console.debug("MakeHabit main " + mDate + "是周" + DateUtils.getDayOfWeek(mDate));
    console.debug("MakeHabit main " + mDate.monthValue() + "月有" + mDate.lengthOfMonth().toString() + "天");
    console.debug("MakeHabit main " + mDate.year() + "年" + mDate.isLeapYear().toString());
  }

  build() {
    Column() {

      Month({month : 1})

    }
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
    .backgroundColor($r('app.color.grey_light'))
  }
}