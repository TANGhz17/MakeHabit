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
    Column() {
      Row() {
        Text('RecordList')
          .fontSize(FontSize.LARGE)
          .fontColor($r('app.color.blue_light'))
          .textAlign(TextAlign.Start)
          .onClick(() => {
            this.getHabits()
          })
      }
      .align(Alignment.Start)

      List({ space: 16 }) {
        ForEach(this.records, (record: Record) => {
          ListItem() {
            Row() {
              Text(this.habits[record.habitId].name)
                .fontSize(FontSize.SMALL)
                .fontColor("#252a34")
                .textAlign(TextAlign.Start)
            }
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .alignListItem(ListItemAlign.Start)
    }

  }
}