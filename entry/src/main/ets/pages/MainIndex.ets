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

  @State selectItem: CJDateItem = undefined;

  aboutToAppear(){
    this.mainModel.addHabitsToDB()
    this.mainModel.addRecordsToDB()
  }

  build() {
    Column({ space: 12 }) {
        CJCalendar({
          selectItem: $selectItem,

          recordIcoSize: 6,

          todayFontColor: $r('app.color.blue_light')
        })

      Button() {
        Image($r('app.media.ic_public_add_norm_filled'))
          .objectFit(ImageFit.Fill)
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
        router.pushUrl({
          url: 'pages/DetailIndex',
          params: {
            year: this.selectItem.fullYear,
            month: this.selectItem.month,
            date: this.selectItem.date
          }});
      })
    }
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
    .backgroundColor($r('app.color.grey_light'))
  }
}