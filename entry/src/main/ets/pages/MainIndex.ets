import router from '@ohos.router';
import { CJCalendar, CJDateItem, OptMode } from '../view/Components/Calendar/CJCalendar'
import { CommonConstants } from '../common/constants/CommonConstants'
import Logger from '../common/utils/Logger'
import MainModel from '../viewmodel/MainViewModel';
import { RecordList } from '../view/Components/RecordList';
import Record from '../viewmodel/Record';
import DimensionUtil from '../common/utils/DimensionUtil';

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


      RecordList({records:$records})

      Blank()

      Button() {
        Image($r('app.media.ic_public_add_norm'))
          // .objectFit(ImageFit.Fill)
      }
      .backgroundColor($r('app.color.trans_parent'))
      .width(DimensionUtil.getVp($r('app.float.new_record_button_size')))
      .height(DimensionUtil.getVp($r('app.float.new_record_button_size')))
      .margin({
        bottom: DimensionUtil.getVp($r('app.float.new_record_button_margin_vertical')),
        top: DimensionUtil.getVp($r('app.float.new_record_button_margin_vertical'))
      })
      .onClick(() => {
        router.pushUrl({
          url: 'pages/DetailIndex',
          params: {
            date: JSON.stringify(this.currDate)
          }});
      })
    }
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
    .backgroundColor($r('app.color.grey_light'))
  }
}