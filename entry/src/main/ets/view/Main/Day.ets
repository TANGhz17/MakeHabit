import { CommonConstants, FontSize } from '../../common/constants/CommonConstants'
import BaseText from './BaseText';

@Component
export default struct Day {
  day : string;
  // @Link hadRecord : boolean;

  build() {
    // if(this.day != '') {
      BaseText({text : this.day})
        // .backgroundColor($r('app.color.blue_light'))
    // }
  }
}