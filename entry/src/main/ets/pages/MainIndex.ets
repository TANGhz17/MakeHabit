import router from '@ohos.router';
import { HmCalendar } from '@ohmos/calendar'
import dayjs from 'dayjs'
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
      Text('常规日历')
      HmCalendar({
        color: '#00aa00',
        selectedDays: [
          { date: '2024-01-01' },
          { date: '2024-01-10' },
          { date: '2024-01-20' },
        ],
        currentDate: dayjs().format('YYYY-MM-DD')
      })
        .borderRadius(8)
        .border({ width: 0.5, color: '#ededed' })
        .shadow({ color: '#ededed', radius: 16 })
    }
    .padding(16)
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor($r('app.color.grey_light'))
  }
}