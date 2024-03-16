import router from '@ohos.router';
import Logger from '../common/utils/Logger';
import { CJDateItem } from '../view/Components/Calendar/CJCalendar';

@Entry
@Preview
@Component
struct DetailIndex {
  @State currDate: CJDateItem = null;

  onPageShow() {
    const params = router.getParams(); // 获取传递过来的参数对象
    this.currDate = JSON.parse(params['date'])
    Logger.debug('Detail get router Date: ', JSON.stringify(this.currDate))
  }

  build(){

  }
}