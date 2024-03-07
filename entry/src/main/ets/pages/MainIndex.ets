import router from '@ohos.router';
import { CommonConstants } from '../common/constants/CommonConstants';
import MainModel from '../viewmodel/MainViewModel';
import Month from '../view/Main/Month';

@Entry
@Component
struct MainIndex {
  private mainModel: MainModel = MainModel.instant;

  aboutToAppear(){
    let that = this;
  }

  build() {
    Column() {

      Month({year : 2024, month : 2})

    }
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
    .backgroundColor($r('app.color.grey_light'))
  }
}