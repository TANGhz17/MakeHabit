import { FontSize } from '../../common/constants/CommonConstants';
import Logger from '../../common/utils/Logger';
import HabitModel from '../../model/HabitModel';
import Habit from '../../viewmodel/Habit';
import Record from '../../viewmodel/Record';

@Component
export struct RecordList {
  private habits: Habit[];
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
    List({ space: 16 }) {
      ForEach(this.records, (record: Record) => {
        ListItem() {
          RecordListItem({
            habitName: this.habits[record.habitId].name,
            time: record.createTime
          })
        }
      })
    }
    .width('100%')
    .layoutWeight(1)
    .alignListItem(ListItemAlign.Start)
  }
}

@Component
export struct RecordListItem{
  private habitName: string
  private time: number
  private date: Date

  aboutToAppear(){
    let that = this
    that.date = new Date()
    that.date.setTime(this.time)
  }

  build() {
      Row() {
        Text(this.habitName)
          .fontSize(FontSize.LARGE)
          .fontColor("#252a34")
          .textAlign(TextAlign.Start)
        Text(this.date.toString())
          .fontSize(FontSize.SMALL)
          .fontColor("#252a34")
          .textAlign(TextAlign.Center)
      }
    .width('100%')
  }
}