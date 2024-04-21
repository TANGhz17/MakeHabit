import router from '@ohos.router';
import { CJCalendar, CJDateItem } from '../view/CJCalendar'
import { CommonConstants } from '../common/constants/CommonConstants'
import DimensionUtil from '../common/utils/DimensionUtil';
import Logger from '../common/utils/Logger'
import MainModel from '../viewmodel/MainViewModel';
import BackContainer from '../view/BackContainer';

let storage = new LocalStorage({ 'IsReload': true });

@Entry(storage)
@Component
struct MainIndex {
  private mainModel: MainModel = MainModel.instant;
  @LocalStorageLink('IsReload') isReload: boolean = false;
  @State selectItem: CJDateItem = undefined;

  aboutToAppear() {
    this.mainModel.addHabitsToDB()
    this.mainModel.addRecordsToDB()
  }

  build() {
    Column({ space: 12 }) {
      BackContainer({
        CanBack: false,
        header: $r('app.string.main_label')
      }) {
        Button() {
          Image($r('app.media.ic_public_chart')).objectFit(ImageFit.Fill)
        }
        .backgroundColor($r('app.color.trans_parent'))
        .width(DimensionUtil.getVp($r('app.float.title_button_size')))
        .height(DimensionUtil.getVp($r('app.float.title_button_size')))
        .onClick(() => {
          router.pushUrl({
            url: 'pages/ChartIndex'
          })
        })
      }

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
      .position({ x: '90%', y: '95%' })
      .margin({
        bottom: DimensionUtil.getVp($r('app.float.new_record_button_margin_vertical')),
        top: DimensionUtil.getVp($r('app.float.new_record_button_margin_vertical'))
      })
      .onClick(() => {
        // this.isReload = !this.isReload
        router.pushUrl({
          url: 'pages/DetailIndex',
          params: {
            year: this.selectItem.fullYear,
            month: this.selectItem.month,
            date: this.selectItem.date
          } });
      })
    }
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
    .backgroundColor($r('app.color.grey_light'))
  }
}