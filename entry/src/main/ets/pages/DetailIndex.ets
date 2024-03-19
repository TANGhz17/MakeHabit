import router from '@ohos.router';
import { CommonConstants } from '../common/constants/CommonConstants';
import DimensionUtil from '../common/utils/DimensionUtil';
import Logger from '../common/utils/Logger';
import HabitModel from '../model/HabitModel';
import BackContainer from '../view/BackContainer';
import DatePickArea from '../view/DatePickArea';
import Habit from '../viewmodel/Habit';
import Record from '../viewmodel/Record';

@Entry
@Preview
@Component
struct DetailIndex {
  @State currDate: Date = new Date();

  @State record: Record = null;

  @State habits: Habit[] = [];

  onPageShow() {
    const params = router.getParams() // 获取传递过来的参数对象
    let date = params['date'] as Date
    // this.currDate.setFullYear(date.getFullYear())
    // this.currDate.setMonth(date.getMonth())
    // this.currDate.setSeconds(date.getSeconds())

    // Logger.debug('Detail get router Date: ', JSON.stringify(this.currDate))
  }

  setRecord(habitId: number){
    this.record.createTime = this.currDate.getTime()
    this.record.habitId = habitId
  }

  syncHabits() {
    HabitModel.queryAllHabits()
      .then(habits => {
        this.habits = habits
      })
  }

  build(){
    Column() {
      BackContainer({
        // header: this.isNow ? $r('app.string.new_record') : $r('app.string.update_record'),
        header: $r('app.string.new_record'),
        backImgRes: $r('app.media.ic_public_cancel'),
      }) {
        Button() {
          Image($r('app.media.ic_public_ok_filled')).objectFit(ImageFit.Fill)
        }
        .backgroundColor($r('app.color.trans_parent'))
        .width(DimensionUtil.getVp($r('app.float.title_button_size')))
        .height(DimensionUtil.getVp($r('app.float.title_button_size')))
        .onClick(() => {
          // sql 插入record数据
          router.back();
        })
      }

      // 设置时间(不需要日期)
      DatePickArea()
      // CJCalendar({
      //   showDate : false,
      //   showTime: true,
      // })
      // this.setTime(h m s)

      // 设置habitId

      // this.setRecord(habitId)

    }
    .backgroundColor($r('app.color.grey_light'))
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
  }
}