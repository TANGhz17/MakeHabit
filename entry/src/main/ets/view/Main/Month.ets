import DateUtils from  '../../common/utils/DateUtils'
import Day from './Day'
import MonthHeader from './MonthHeader';

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
    let lengthMonth = DateUtils.getDaysOfMonth(that.year,that.month);
    let days = new Array();
    // days.length = firstDay + 1 + lengthMonth;
    let dayIndex = 1;
    for (let i = 0; i < firstDay + lengthMonth; i++) {
      if (i < firstDay){
        days[i] = '';
        continue;
      }
      var a = dayIndex++;
      days[i] = a.toString();
    }
    that.days = days;
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