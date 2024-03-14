import { FontSize } from '../../common/constants/CommonConstants';
import HabitModel from '../../model/HabitModel';
import Habit from '../../viewmodel/Habit';
import Record from '../../viewmodel/Record';

@Component
export struct RecordList {
  private habits: Habit[];
  @Link records: Record[];

  aboutToAppear() {
    let that = this
    HabitModel.queryAllHabit()
      .then(habits => {
        that.habits = habits
      })
  }

  build() {
    Row() {
      Text('RecordList')
        .fontSize(FontSize.LARGE)
        .fontColor($r('app.color.blue_light'))
        .textAlign(TextAlign.Center)
      List() {
        ForEach(this.records, (record: Record) => {
          ListItem() {
            Row() {
              Text(this.habits[record.habitId].name)
                .fontSize(FontSize.SMALL)
                .fontColor($r('app.color.grey_with_opacity'))
                .textAlign(TextAlign.Start)
            }
          }
        })
      }
    }
  }
}