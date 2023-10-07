import { FontSize } from '../common/Constants'

@Preview
@Component
export default struct RecordItemComponent {
  // @Prop habitId : string
  // @Prop count : string
  // @Prop date : string
  // @Prop message : string
  @State habitId : string = '0'
  @State count : string = '1'
  @State date : string = '2023/10/10'
  @State message : string = 'message'

  build() {
    Row() {
      Text(this.habitId)
        .fontSize(FontSize.SMALL)
        .width('15%')

      Text(this.count)
        .fontSize(FontSize.SMALL)
        .width('15%')

      Text(this.date)
        .fontSize(FontSize.SMALL)
        .width('30%')

      Text(this.message)
        .fontSize(FontSize.SMALL)
        .width('40%')
    }
    .height(48)
    .width('80%')
    .borderRadius(20)
  }
}