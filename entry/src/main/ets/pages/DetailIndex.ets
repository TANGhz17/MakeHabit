import router from '@ohos.router';
import { CommonConstants } from '../common/constants/CommonConstants';
import DimensionUtil from '../common/utils/DimensionUtil';
import HabitModel from '../model/HabitModel';
import RecordModel from '../model/RecordModel';
import BackContainer from '../view/BackContainer';
import { DatePickArea } from '../view/DatePickArea';
import Habit from '../viewmodel/Habit';
import Record from '../viewmodel/Record';

@Entry
@Component
struct DetailIndex {
  @LocalStorageLink('isReload') isReload: boolean = false;

  @State habits: Habit[] = [];
  @State habitId: number = NaN;

  private selectedTime: Date = new Date()

  private myYear: number = 2000;
  private myMonth: number = 0;
  private myDate: number = 0;

  @State myHour: number = 0;
  @State myMinute: number = 0;
  @State mySecond: number = 0;

  aboutToAppear(){
    this.syncHabits()
    this.selectedTime.setSeconds(0,0)
  }

  onPageShow() {
    const params = router.getParams() // 获取传递过来的参数对象
    this.myYear = params['year']
    this.myMonth = params['month']
    this.myDate = params['date']
  }

  getDate() : Date {
    return new Date(this.myYear,this.myMonth,this.myDate,this.myHour,this.myMinute,this.mySecond)
  }

  addRecordToDB(record: Record){
    RecordModel.insert(record)
  }

  getRecord(habitId: number): Record {
    return new Record(NaN, this.getDate().getTime(), habitId)
  }

  syncHabits() {
    HabitModel.queryAllHabits()
      .then(habits => {
        this.habits = habits
        this.habitId = habits[0].id
      })
  }

  build() {
    Column() {
      BackContainer({
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
          this.addRecordToDB(new Record(NaN, this.selectedTime.getTime(), this.habitId))

          router.back();
        })
      }

      // 设置时间(不需要日期)
      // DatePickArea({ myHour: $myHour, myMinute: $myMinute, mySecond: $mySecond })

      TimePicker({
        selected: this.selectedTime,
      })
        .useMilitaryTime(true)
        .onChange((value: TimePickerResult) => {
          this.selectedTime.setHours(value.hour, value.minute)
          console.info('select current date is: ' + JSON.stringify(value))
        })
        .width('100%')

      // 设置habitId
      Select([{ value: 'aaa'},
        { value: 'bbb'},
        { value: 'ccc'},
        { value: 'ddd'},
        { value: '新建'}])
        .selected(2)
        .value('TTTTT')
        .font({ size: 16, weight: 500 })
        .fontColor('#182431')
        .selectedOptionFont({ size: 16, weight: 400 })
        .optionFont({ size: 16, weight: 400 })
        .onSelect((index: number) => {
          console.info('Select:' + index)
        })
    }
    .backgroundColor($r('app.color.grey_light'))
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
  }
}