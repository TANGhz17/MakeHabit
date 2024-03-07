import DateUtils from  '../../common/utils/DateUtils'
import Logger from '../../common/utils/Logger'
import Day from './Day'
import MonthHeader from './MonthHeader';
import List from '@ohos.util.List';

// @Entry
@Preview
@Component
export default struct Month {
  // @Prop month : number;
  @State year : number = 2000;
  @State month : number = 0;

  days = new Array();

  aboutToAppear(){
    let that = this;
    let firstDay = DateUtils.getFirstDayOfMonthInWeek(that.year,that.month);
    Logger.debug(that.year+'年'+that.month+'月的第一天是周'+firstDay)
    let lengthMonth = DateUtils.getDaysOfMonth(that.year,that.month);
    let days = new List();
    // days.length = firstDay + 1 + lengthMonth;
    let dayIndex = 1;
    for (let i = 0; i < firstDay + lengthMonth; i++) {
      if (i < firstDay){
        days.add('');
        continue;
      }
      // var a = dayIndex++;
      days.add(dayIndex++);
    }
    that.days = days.convertToArray();
    Logger.debug(this.days.length.toString());
  }

  build() {
    Column() {
      MonthHeader()

      Grid(){
        // day item
        // LazyForEach
        ForEach(this.days, (item : string) => {
          GridItem() {
            Day({day : item})
          }
        }, (item: string) => item)
      }
      .columnsGap(5)
      .rowsGap(5)
      .maxCount(7)
      .layoutDirection(GridDirection.Row)
    }
  }
}