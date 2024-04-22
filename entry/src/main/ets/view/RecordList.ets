import { CommonConstants } from '../common/constants/CommonConstants';
import DimensionUtil from '../common/utils/DimensionUtil';
import HabitModel from '../model/HabitModel';
import RecordModel from '../model/RecordModel';
import Habit from '../viewmodel/Habit';
import MainModel from '../viewmodel/MainViewModel';
import Record from '../viewmodel/Record';
import { CJDateItem } from './CJCalendar';

@Component
export struct RecordList {
  @State habits: Habit[] = [];

  @Link CJDates: Array<CJDateItem>;
  @Link CJDate: CJDateItem;

  aboutToAppear() {
    this.syncHabits()
  }

  syncHabits() {
    HabitModel.queryAllHabits()
      .then(habits => {
        this.habits = habits
      })
  }

  @Builder itemEnd(record: Record, index: number) {
    // 侧滑后尾端出现的组件
    Button({ type: ButtonType.Circle }) {
      Image($r('app.media.ic_public_delete_filled'))
        .width(30)
        .height(30)
    }
    .width(50)
    .height(50)
    .margin({
      left: 10
    })
    .backgroundColor($r('app.color.red_light'))
    .onClick(() => {
      RecordModel.deleteByRecordId(record.id)
      // this.CJDates[listIndex].records.splice(index,1)
    })
  }

  build() {
    List({ space: 12 }) {
      ForEach(this.CJDates, (date: CJDateItem) =>{
        if (date.time === this.CJDate.time){
          ForEach(date.records, (record: Record, index: number) => {
            ListItem() {
              RecordListItem({
                habits: $habits,
                record: record
              })
            }
            .swipeAction({ end: this.itemEnd.bind(this, record, index) }) // 设置侧滑属性
          }, (record: Record) => JSON.stringify(record))
        }
      })
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
  private record: Record;
  private mainModel: MainModel = MainModel.instant;
  private date: Date = new Date();
  private habit: Habit = null;

  aboutToAppear() {
    this.date.setTime(this.record.createTime)
    this.getHabitFromArray();
  }

  getHabitFromArray() {
    this.habits.forEach(habit => {
      if (habit.id == this.record.habitId) {
        this.habit = habit
      }
    })
  }

  build() {
    Row() {
      Column() {
        Row() {
          if (this.habit != null){
            Text(this.mainModel.getNoonContent(this.date))
              .CommonTextAttr(DimensionUtil.getVp($r('app.float.records_item_noon_font_size')),
                FontWeight.Regular)
            Text(this.habit.name)
              .CommonTextAttr(DimensionUtil.getVp($r('app.float.records_item_time_font_size')),
                FontWeight.Regular,
                { left: DimensionUtil.getVp($r('app.float.records_item_time_margin_left')) })
          }
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

@Extend(Text) function CommonTextAttr(fontSize: number, fontWeight: number, margin?: Margin,
                                      opacity?: Resource) {
  .fontColor($r('app.color.grey_divider'))
  .fontSize(fontSize)
  .fontWeight(fontWeight)
  .margin(margin != undefined ? margin : 0)
  .opacity(opacity != undefined ? opacity : 1)
}