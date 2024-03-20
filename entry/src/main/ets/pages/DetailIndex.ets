import router from '@ohos.router';
import { CommonConstants } from '../common/constants/CommonConstants';
import { DetailConstant } from '../common/constants/DetailConstant';
import DimensionUtil from '../common/utils/DimensionUtil';
import Logger from '../common/utils/Logger';
import HabitModel from '../model/HabitModel';
import RecordModel from '../model/RecordModel';
import BackContainer from '../view/BackContainer';
import { DatePickArea } from '../view/DatePickArea';
import Habit from '../viewmodel/Habit';
import Record from '../viewmodel/Record';

@Entry
@Component
struct DetailIndex {
  private record: Record;
  @State habits: Habit[] = [];
  @State habitId: number = NaN;

  private myYear: number = 2000;
  private myMonth: number = 0;
  private myDate: number = 0;

  @State myHour: number = 0;
  @State myMinute: number = 0;
  @State mySecond: number = 0;

  aboutToAppear(){
    this.syncHabits()
  }

  onPageShow() {
    const params = router.getParams() // 获取传递过来的参数对象
    this.myYear = params['year']
    this.myMonth = params['month']
    this.myDate = params['date']
  }

  getDateTime() : number {
    let date = new Date(this.myYear,this.myMonth,this.myDate,this.myHour,this.myMinute,this.mySecond)
    return date.getTime()
  }

  addRecordToDB(){
    RecordModel.insert(this.record)
  }

  setRecord(habitId: number) {
    this.record = new Record(NaN, this.getDateTime(), habitId)
  }

  syncHabits() {
    HabitModel.queryAllHabits()
      .then(habits => {
        this.habits = habits
      })
  }

  build() {
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
          // Logger.debug('设置的时间是：', this.myYear + '年' + ( this.myMonth + 1 ) + '月' + this.myDate + '日')
          // Logger.debug('设置的时间是：', this.myHour + ':' + this.myMinute + ':' + this.mySecond)
          // Logger.debug('设置的时间是：', new Date(this.myYear,this.myMonth,this.myDate,this.myHour,this.myMinute,this.mySecond).getTime().toString())
          this.setRecord(1)
          this.addRecordToDB()

          router.back();
        })
      }

      // 设置时间(不需要日期)
      DatePickArea({ myHour: $myHour, myMinute: $myMinute, mySecond: $mySecond })

      // 设置habitId

      // this.setRecord(habitId)

    }
    .backgroundColor($r('app.color.grey_light'))
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
  }
}