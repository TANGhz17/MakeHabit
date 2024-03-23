import router from '@ohos.router';
import { CJCalendar, CJDateItem } from '../view/Calendar/CJCalendar'
import { CommonConstants } from '../common/constants/CommonConstants'
import DimensionUtil from '../common/utils/DimensionUtil';
import Logger from '../common/utils/Logger'
import MainModel from '../viewmodel/MainViewModel';

@Entry
@Preview
@Component
struct MainIndex {
  private mainModel: MainModel = MainModel.instant;
  private showPage: boolean = true;

  @State currDate: CJDateItem = null;

  private bakeTime : Date;

  aboutToAppear(){
    this.mainModel.addHabitsToDB()
    this.mainModel.addRecordsToDB()
  }

  onPageShow(){
    this.showPage = true
  }

  build() {
    Column({ space: 12 }) {
      if (this.showPage){
        CJCalendar({
          selectTime : this.bakeTime,

          recordIcoSize: 6,

          todayFontColor: $r('app.color.blue_light'),

          onDateChange: (date: CJDateItem) => {
            this.currDate = date
          }
        })
      }

      Blank()

      Button() {
        Image($r('app.media.ic_public_add_norm_filled')).objectFit(ImageFit.Fill)
          .fillColor('#03A9F4')
          // .objectFit(ImageFit.Fill)
      }
      .backgroundColor($r('app.color.trans_parent'))
      .width(DimensionUtil.getVp($r('app.float.new_record_button_size')))
      .height(DimensionUtil.getVp($r('app.float.new_record_button_size')))
      .position({x: '90%', y: '95%'})
      .margin({
        bottom: DimensionUtil.getVp($r('app.float.new_record_button_margin_vertical')),
        top: DimensionUtil.getVp($r('app.float.new_record_button_margin_vertical'))
      })
      .onClick(() => {
        this.showPage = false
        this.bakeTime = new Date(this.currDate.fullYear, this.currDate.month, this.currDate.date)
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