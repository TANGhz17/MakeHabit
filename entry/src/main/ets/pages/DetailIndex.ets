import router from '@ohos.router';
import { CommonConstants } from '../common/constants/CommonConstants';
import DimensionUtil from '../common/utils/DimensionUtil';
import Logger from '../common/utils/Logger';
import HabitModel from '../model/HabitModel';
import BackContainer from '../view/BackContainer';
import { DatePickArea } from '../view/DatePickArea';
import Habit from '../viewmodel/Habit';
import Record from '../viewmodel/Record';

@Entry
@Component
struct DetailIndex {
  private record: Record = null;
  @State habits: Habit[] = [];
  private currDate: Date;
  private myTime: Date = new Date();
  private myHour: number = 0;
  private myMinute: number = 0;
  private mySecond: number = 0;
  private hours: string[] = [
    '00', '01', '02', '03', '04', '05', '06', '07', '08', '09',
    '10', '11', '12', '13', '14', '15', '16', '17', '18', '19',
    '20', '21', '22', '23'
  ];
  private minutes: string[] = [
    '00', '01', '02', '03', '04', '05', '06', '07', '08', '09',
    '10', '11', '12', '13', '14', '15', '16', '17', '18', '19',
    '20', '21', '22', '23', '24', '25', '26', '27', '28', '29',
    '30', '31', '32', '33', '34', '35', '36', '37', '38', '39',
    '40', '41', '42', '43', '44', '45', '46', '47', '48', '49',
    '50', '51', '52', '53', '54', '55', '56', '57', '58', '59'
  ];
  private seconds: string[] = [
    '00', '01', '02', '03', '04', '05', '06', '07', '08', '09',
    '10', '11', '12', '13', '14', '15', '16', '17', '18', '19',
    '20', '21', '22', '23', '24', '25', '26', '27', '28', '29',
    '30', '31', '32', '33', '34', '35', '36', '37', '38', '39',
    '40', '41', '42', '43', '44', '45', '46', '47', '48', '49',
    '50', '51', '52', '53', '54', '55', '56', '57', '58', '59'
  ];

  aboutToAppear() {
    this.myHour = this.myTime.getHours()
    this.myMinute = this.myTime.getMinutes()
    this.mySecond = this.myTime.getSeconds()
  }

  onPageShow() {
    const params = router.getParams() // 获取传递过来的参数对象
    const date = params['date'] as Date
    this.currDate = date
  }

  setRecord(habitId: number) {
    this.upDate()
    this.record.createTime = this.currDate.getTime()
    this.record.habitId = habitId
  }

  /**
   * 更新将设置的 h、m、s 时间，更新到原date数据里
   */
  upDate() {
    this.currDate.setHours(this.myHour, this.myMinute, this.mySecond)
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
          // this.upDate()
          Logger.debug('设置的时间是：', this.currDate.toDateString())
          Logger.debug('设置的时间是：', this.currDate.toTimeString());
          Logger.debug('设置的时间是：', this.myHour.toString() + ':' + this.myMinute.toString() + ':' + this.mySecond.toString())
          router.back();
        })
      }

      // 设置时间(不需要日期)
      // DatePickArea({ myHour: $myHour, myMinute: $myMinute, mySecond: $mySecond })
      Stack({ alignContent: Alignment.Center }) {
        Row() {
          TextPicker({ range: this.hours, selected: this.myTime.getHours() })
            .layoutWeight(CommonConstants.DEFAULT_LAYOUT_WEIGHT)
            .backgroundColor($r('app.color.grey_light'))
            .onChange((value: string, index: number) => {
              this.myHour = index;
            })
          TextPicker({ range: this.minutes, selected: this.myTime.getMinutes() })
            .layoutWeight(CommonConstants.DEFAULT_LAYOUT_WEIGHT)
            .backgroundColor($r('app.color.grey_light'))
            .onChange((value: string, index: number) => {
              this.myMinute = index;
            })
          TextPicker({ range: this.seconds, selected: this.myTime.getSeconds() })
            .layoutWeight(CommonConstants.DEFAULT_LAYOUT_WEIGHT)
            .backgroundColor($r('app.color.grey_light'))
            .onChange((value: string, index: number) => {
              this.mySecond = index;
            })

        }
      }
      .height(DimensionUtil.getVp($r('app.float.date_picker_height')))
      .padding({
        left: DimensionUtil.getVp($r('app.float.date_picker_padding_horizon')),
        right: DimensionUtil.getVp($r('app.float.date_picker_padding_horizon'))
      })
      // this.setTime(h m s)

      // 设置habitId

      // this.setRecord(habitId)

    }
    .backgroundColor($r('app.color.grey_light'))
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
  }
}