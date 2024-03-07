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
    that.mainModel.testDate(2024, 3, 1)

    // var start = DateUtils.getDayOfWeek(2024, 3, 1);
    // var length = DateUtils.getLengthOfMonth(2024, 3);
    // console.debug("MakeHabit main " + '2024.03从周' + start + '开始，共' + length + '天。' )
  }

  build() {
    Column() {

      Month({year : 2024, month : 3})

    }
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
    .backgroundColor($r('app.color.grey_light'))
  }
}