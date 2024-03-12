import router from '@ohos.router';
import { CJCalendar, CJDateItem, OptMode } from '../view/Components/Calendar/CJCalendar'
import { CommonConstants } from '../common/constants/CommonConstants'
import Logger from '../common/utils/Logger'
import MainModel from '../viewmodel/MainViewModel';
import RecordModel from '../model/RecordModel';
import HabitModel from '../model/HabitModel';

@Entry
@Preview
@Component
struct MainIndex {
  private mainModel: MainModel = MainModel.instant;
  // @State days : Array<DayItem> = new Array();

  aboutToAppear(){
    let that = this;
    that.mainModel.addHabitsToDB()
    that.mainModel.addRecordsToDB()
  }

  build() {
    Column({ space: 16 }) {
      CJCalendar({
        optMode : OptMode.NORMAL,
        // cellLayout : this.cellLayout,

        recordIcoSize: 6,

        todayFontColor: $r('app.color.blue_light'),

        onDateChange: (date: CJDateItem) => {
          // if (date.hasRecord) {
          //   let tempDate: Date = new Date(date.fullYear, date.month, date.date)
          //   RecordModel.queryByDate(tempDate.getTime())
          //     .then(records => {
          //       let ids : number[] = []
          //       records.forEach(record => {
          //         ids.push(record.habitId)
          //       })
          //       HabitModel.queryByHabitName(ids)
          //         .then(habits => {
          //           habits.forEach(habit => {
          //             Logger.debug(tempDate.toDateString(), '有', habit.name, '习惯记录')
          //           })
          //         })
          //     })
          // }
        }
      })
        .height('50%')
    }
    .padding(16)
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor($r('app.color.grey_light'))
  }

  @Builder cellLayout(item: CJDateItem) {
    Column() {
      Text(item.date.toString())
        .fontSize(18)
        // .fontColor(this.getItemColor())
        .fontWeight(FontWeight.Normal)
      // Text("你好")
      //   .fontSize(12)
    }
  }
}