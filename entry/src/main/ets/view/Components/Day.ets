import { App_Title, FontSize, TitleBarStyle } from '../../common/Constants'

@Component
export default struct Day {
  day : number;
  // @Link hadRecord : boolean;

  // Day(day){
  //   this.day = day;
  // }

  build() {
    Text(this.day.toString())
      .fontSize(FontSize.SMALL)
      .fontWeight(FontWeight.Normal)
      .textAlign(TextAlign.Center)
      .width(20)
      .height(20)
  }
}