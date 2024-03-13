import router from '@ohos.router';
import { CJCalendar, CJDateItem, OptMode } from '../view/Components/Calendar/CJCalendar'
import { CommonConstants } from '../common/constants/CommonConstants'
import Logger from '../common/utils/Logger'
import MainModel from '../viewmodel/MainViewModel';
import RecordModel from '../model/RecordModel';
import HabitModel from '../model/HabitModel';
import { RecordList } from '../view/Main/RecordList';
import RecordItem from '../viewmodel/RecordItem';

@Entry
@Preview
@Component
struct MainIndex {
  private mainModel: MainModel = MainModel.instant;
  @State records: RecordItem[] = [];
  @State currDate: CJDateItem = new CJDateItem();
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

        recordIcoSize: 6,

        todayFontColor: $r('app.color.blue_light'),

        onDateChange: (date: CJDateItem) => {
          this.currDate = date
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

      // this.records.forEach()
      // this.currDate.records 'this.currDate' does not comply with the UI component syntax. <etsLint>
      RecordList({currDate:$currDate})

    }
    .padding(16)
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor($r('app.color.grey_light'))
  }
}