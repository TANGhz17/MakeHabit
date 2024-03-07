import Day from './Day'
import MonthHeader from './MonthHeader';

// @Entry
@Preview
@Component
export default struct Month {
  // @Prop month : number;
  @State year : number = 2000;
  @State month : number = 0;

  days : Array<number> = [1];

  build() {
    Column() {
      MonthHeader()

      Grid(){
        // day item
        // LazyForEach
        ForEach(this.days, (item : number) => {
          GridItem() {
            Day({day : item})
          }
        }, (item: number) => item.toString())
      }
      .columnsGap(5)
      .rowsGap(5)
      .maxCount(7)
      .layoutDirection(GridDirection.Row)
    }
  }
}