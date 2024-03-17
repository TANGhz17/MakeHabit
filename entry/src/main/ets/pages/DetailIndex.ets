import router from '@ohos.router';
import { CommonConstants } from '../common/constants/CommonConstants';
import DimensionUtil from '../common/utils/DimensionUtil';
import Logger from '../common/utils/Logger';
import BackContainer from '../view/BackContainer';
import Record from '../viewmodel/Record';

@Entry
@Preview
@Component
struct DetailIndex {
  private currDate: Date = new Date();

  private record: Record = null;

  onPageShow() {
    const params = router.getParams(); // 获取传递过来的参数对象
    this.currDate = params['date']
    Logger.debug('Detail get router Date: ', JSON.stringify(this.currDate))
  }

  build(){
    Column() {
      BackContainer({
        // header: this.isNow ? $r('app.string.new_record') : $r('app.string.update_record'),
        header: $r('app.string.new_record'),
        backImgRes: $r('app.media.ic_public_cancel'),
      }) {
        Button() {
          Image($r('app.media.ic_public_ok_filled')).objectFit(ImageFit.Fill)
        }
        .backgroundColor($r('app.color.trans_parent'))
        .width(DimensionUtil.getVp($r('app.float.title_button_size')))
        .height(DimensionUtil.getVp($r('app.float.title_button_size')))
        .onClick(() => {
          // this.viewModel.setAlarmRemind(this.alarmItem);
          router.back();
        })
      }

    }
    .backgroundColor($r('app.color.grey_light'))
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
  }
}