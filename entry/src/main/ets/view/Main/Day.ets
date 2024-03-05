import { CommonConstants, FontSize } from '../../common/constants/CommonConstants'
import BaseText from './BaseText';

@Component
export default struct Day {
  day : number;
  // @Link hadRecord : boolean;

  // Day(day){
  //   this.day = day;
  // }

  build() {
    BaseText({text : this.day.toString()})
      .backgroundColor($r('app.color.blue_light'))
  }
}