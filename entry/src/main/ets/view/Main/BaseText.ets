import { FontSize } from '../../common/constants/CommonConstants';

@Component
export default struct BaseText {
  private text : string;

  build(){
    Text(this.text.toString())
      .fontSize(FontSize.SMALL)
      .fontWeight(FontWeight.Normal)
      .textAlign(TextAlign.Center)
      .width(20)
      .height(20)
  }
}