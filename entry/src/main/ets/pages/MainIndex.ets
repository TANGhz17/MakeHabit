import router from '@ohos.router';
import { CJCalendar, CJDateItem, OptMode } from '../view/Calendar/CJCalendar'
import { CommonConstants } from '../common/constants/CommonConstants'
import DimensionUtil from '../common/utils/DimensionUtil';
import Logger from '../common/utils/Logger'
import MainModel from '../viewmodel/MainViewModel';
import { RecordList } from '../view/RecordList';
import Record from '../viewmodel/Record';

@Entry
@Preview
@Component
struct MainIndex {
  private mainModel: MainModel = MainModel.instant;
  @State currDate: CJDateItem = null;
  @State records: Record[] = [];

  aboutToAppear(){
    this.mainModel.addHabitsToDB()
    this.mainModel.addRecordsToDB()
  }

  build() {
    Column({ space: 12 }) {
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
        Image($r('app.media.ic_public_add_norm_filled')).objectFit(ImageFit.Fill)
          .fillColor('#03A9F4')
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
            year: this.currDate.fullYear,
            month: this.currDate.month,
            date: this.currDate.date
          }});
      })
    }
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
    .backgroundColor($r('app.color.grey_light'))
  }
}