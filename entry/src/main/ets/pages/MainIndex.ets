import router from '@ohos.router';
import { CommonConstants } from '../common/constants/CommonConstants';

@Entry
@Component
struct MainIndex {

  build() {
    Column() {

    }
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
    .backgroundColor($r('app.color.grey_light'))
  }
}