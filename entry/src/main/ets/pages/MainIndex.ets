import router from '@ohos.router';
import { CJCalendar, CJDateItem, OptMode } from '../view/Components/Calendar/CJCalendar'
import { CommonConstants } from '../common/constants/CommonConstants'
import Logger from '../common/utils/Logger'
import MainModel from '../viewmodel/MainViewModel';
import { RecordList } from '../view/Main/RecordList';
import Record from '../viewmodel/Record';

@Entry
@Preview
@Component
struct MainIndex {
  private mainModel: MainModel = MainModel.instant;
  @State currDate: CJDateItem = null;
  @State records: Record[] = [];
  // @State days : Array<DayItem> = new Array();

  aboutToAppear(){
    let that = this;
    that.mainModel.addHabitsToDB()
    that.mainModel.addRecordsToDB()
  }

  build() {
    Column({ space: 24 }) {
      CJCalendar({
        optMode : OptMode.NORMAL,

        recordIcoSize: 6,

        todayFontColor: $r('app.color.blue_light'),

        onDateChange: (date: CJDateItem) => {
          this.currDate = date
          this.records = date.records
          Logger.debug(JSON.stringify(this.currDate.records))
        }
      })
        .height('50%')

      // this.records.forEach()
      // this.currDate.records 'this.currDate' does not comply with the UI component syntax. <etsLint>
      RecordList({records:$records})
        .width('100%')
        .height('50%')

    }
    .padding(16)
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor($r('app.color.grey_light'))
  }
}