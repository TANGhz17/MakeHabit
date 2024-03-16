import { CommonConstants } from '../../common/constants/CommonConstants';
import DimensionUtil from '../../common/utils/DimensionUtil';
import Logger from '../../common/utils/Logger';
import HabitModel from '../../model/HabitModel';
import Habit from '../../viewmodel/Habit';
import MainModel from '../../viewmodel/MainViewModel';
import Record from '../../viewmodel/Record';

@Component
export struct RecordList {
  @State habits: Habit[] = [];
  @Link records: Record[];

  aboutToAppear() {
    let that = this
    that.getHabits()
  }

  getHabits() {
    let that = this
    HabitModel.queryAllHabit()
      .then(habits => {
        that.habits = habits
        Logger.debug('habits have ', this.habits.length.toString())
      })
  }

  build() {
    List({ space: 12 }) {
      ForEach(this.records, (record: Record) => {
        ListItem() {
          RecordListItem({
            habits: $habits,
            record: record
          })
        }

      }, (record: Record) => JSON.stringify(record))
    }
    .padding({
      left: DimensionUtil.getVp($r('app.float.record_list_content_distance')),
      right: DimensionUtil.getVp($r('app.float.record_list_content_distance'))
    })
    .listDirection(Axis.Vertical)
    .layoutWeight(CommonConstants.DEFAULT_LAYOUT_WEIGHT)
    .margin({ top: DimensionUtil.getVp($r('app.float.record_list_content_distance')) })
  }
}

@Component
export struct RecordListItem {
  @Link habits: Habit[];
  @State record: Record = null;

  private mainModel: MainModel = MainModel.instant;
  private date: Date

  aboutToAppear() {
    let that = this
    that.date = new Date()
    that.date.setTime(this.record.createTime)
  }

  build() {
    Row() {
      Column() {
        Row() {
          Text(this.mainModel.getNoonContent(this.date))
            .CommonTextAttr(DimensionUtil.getVp($r('app.float.records_item_noon_font_size')),
              FontWeight.Regular)
          Text(this.habits[this.record.habitId].name)
            .CommonTextAttr(DimensionUtil.getVp($r('app.float.records_item_time_font_size')),
              FontWeight.Regular,
              { left: DimensionUtil.getVp($r('app.float.records_item_time_margin_left')) })
        }
      }
      .width(CommonConstants.FULL_LENGTH)
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(CommonConstants.DEFAULT_LAYOUT_WEIGHT)
    }
    .padding({
      left: DimensionUtil.getVp($r('app.float.record_list_content_distance')),
      right: DimensionUtil.getVp($r('app.float.record_list_content_distance'))
    })
    .width(CommonConstants.FULL_LENGTH)
    .height(DimensionUtil.getVp($r('app.float.records_item_height')))
    .backgroundColor(Color.White)
    .borderRadius(DimensionUtil.getVp($r('app.float.records_item_radius')))
  }
}

@Extend(Text)
function CommonTextAttr(fontSize: number, fontWeight: number, margin?: Margin,
                                      opacity?: Resource) {
  .fontColor($r('app.color.grey_divider'))
  .fontSize(fontSize)
  .fontWeight(fontWeight)
  .margin(margin != undefined ? margin : 0)
  .opacity(opacity != undefined ? opacity : 1)
}