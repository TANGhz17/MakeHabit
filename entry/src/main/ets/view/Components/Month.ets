import Day from './Day'

@Preview
@Component
export default struct Month {
  // @Prop month : number;
  month : number = 1;

  list : Array<number> = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30];

  build() {
    Column() {
      Text(this.month.toString()+"月")
        .width("100vp")
        .height("60vp")
        .fontColor("#ff0000")
        .textAlign(TextAlign.Center)
        .fontSize("36fp")
        .fontWeight(FontWeight.Bold)
      Grid(){
        // day item
        // LazyForEach
        ForEach(this.list, (item : number) => {
          GridItem() {
            Day({day : item})
          }
        }, (item: number) => item.toString())
      }
      .maxCount(7)
      .layoutDirection(GridDirection.Row)
    }
  }
}