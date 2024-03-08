import router from '@ohos.router';
import { CJCalendar } from 'cjcalendar'
import { CommonConstants } from '../common/constants/CommonConstants';
import DayItem from '../viewmodel/DayItem'
import MainModel from '../viewmodel/MainViewModel';

@Entry
@Component
struct MainIndex {
  private mainModel: MainModel = MainModel.instant;
  @State days : Array<DayItem> = new Array();

  aboutToAppear(){
    let that = this;
  }

  build() {
    Column({ space: 16 }) {
      CJCalendar()
    }
    .padding(16)
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor($r('app.color.grey_light'))
  }
}