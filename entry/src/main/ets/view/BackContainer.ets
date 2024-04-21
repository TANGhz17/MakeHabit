import router from '@ohos.router';
import { CommonConstants } from '../common/constants/CommonConstants';
import DimensionUtil from '../common/utils/DimensionUtil';

@Component
export default struct BackContainer {
  private CanBack: boolean = true;
  private header: string | Resource = $r('app.string.new_record');
  private backImgRes: string | Resource = $r('app.media.ic_public_cancel');
  private backFunc?: () => void;
  @BuilderParam closer?: () => void;

  build() {
    Row() {
      if (this.CanBack) {
        Button() {
          Image(this.backImgRes == null ? $r('app.media.ic_public_back') : this.backImgRes).objectFit(ImageFit.Fill)
        }
        .backgroundColor($r('app.color.trans_parent'))
        .width(DimensionUtil.getVp($r('app.float.title_button_size')))
        .height(DimensionUtil.getVp($r('app.float.title_button_size')))
        .onClick(() => {
          this.backFunc ? this.backFunc() : router.back();
        })
      }

      Text(this.header)
        .fontSize(DimensionUtil.getFp($r('app.float.detail_title_font_size')))
        .lineHeight(DimensionUtil.getVp($r('app.float.title_line_height')))
        .margin({ left: DimensionUtil.getVp($r('app.float.title_margin')) })
        .fontColor($r('app.color.grey_divider'))
        .fontWeight(FontWeight.Bold)
      Blank()
      if (this.closer) {
        this.closer();
      }
    }
    .padding({
      left: DimensionUtil.getVp($r('app.float.title_horizon_margin')),
      right: DimensionUtil.getVp($r('app.float.title_horizon_margin'))
    })
    .height(DimensionUtil.getVp($r('app.float.page_title_height')))
    .width(CommonConstants.FULL_LENGTH)
  }
}