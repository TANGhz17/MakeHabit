import router from '@ohos.router';
import { CommonConstants } from '../common/constants/CommonConstants';
import DimensionUtil from '../common/utils/DimensionUtil';
import Logger from '../common/utils/Logger';
import HabitModel from '../model/HabitModel';
import RecordModel from '../model/RecordModel';
import BackContainer from '../view/BackContainer';
import Habit from '../viewmodel/Habit';
import Record from '../viewmodel/Record';

@Entry
@Component
struct DetailIndex {
  @State habits: Habit[] = [];
  @State selectValues: SelectOption[] = [{ value: '锻炼'}, { value: '学习'}, { value: '练字'}]
  @State selectedValue: string = '锻炼'
  @State habitId: number = NaN;

  @State year : number = 2024;
  @State month : number = 4;
  @State date : number = 22;

  private selectedTime: Date = new Date();

  aboutToAppear(){
    this.syncHabits()
  }

  onPageShow() {
    const params = router.getParams() // 获取传递过来的参数对象
    this.selectedTime.setFullYear(params['year'],params['month'],params['date'])
    this.selectedTime.setSeconds(0,0)
    this.year = this.selectedTime.getFullYear()
    this.month = this.selectedTime.getMonth() + 1
    this.date = this.selectedTime.getDate()

    Logger.debug(this.selectedTime.toString())
  }

  syncHabits() {
    HabitModel.queryAllHabits()
      .then(habits => {
        this.habits = habits
        this.habitId = habits[0].id

        let selectValues : SelectOption[] = []
        habits.forEach((habit : Habit)=>{
          selectValues.push({value: habit.name})
        })
        this.selectValues = selectValues
        this.selectedValue = this.selectValues[0].value as string
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
          RecordModel.insert(new Record(NaN, this.selectedTime.getTime(), this.habitId))

          router.back();
        })
      }

      Text(this.year + '年' +
           this.month + '月' +
           this.date + '日')
        .fontColor($r('app.color.grey_divider'))
        .fontWeight(FontWeight.Medium)

      // 设置时间(不需要日期)
      TimePicker({
        selected: this.selectedTime,
      })
        .useMilitaryTime(false)
        .onChange((value: TimePickerResult) => {
          this.selectedTime.setHours(value.hour, value.minute)
          console.info('select current date is: ' + JSON.stringify(value))
        })
        .width('80%')

      // 设置habitId
      Select(this.selectValues)
        .selected(0)
        .value(this.selectedValue)
        .font({ size: 16, weight: 500 })
        .fontColor('#182431')
        .selectedOptionFont({ size: 16, weight: 400 })
        .optionFont({ size: 16, weight: 400 })
        .onSelect((index: number) => {
          console.info('Select:' + index)
          this.habitId = this.habits[index].id
        })
    }
    .backgroundColor($r('app.color.grey_light'))
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
  }
}