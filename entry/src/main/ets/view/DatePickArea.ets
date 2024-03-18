import { DetailConstant } from '../common/constants/DetailConstant';
import { CommonConstants } from '../common/constants/CommonConstants';
import DimensionUtil from '../common/utils/DimensionUtil';
import DayDataItem from '../viewmodel/DayDataItem';

@Component
export default struct DatePickArea {
  build() {
    Stack({ alignContent: Alignment.Center }) {
      Row() {
        ForEach(DetailConstant.DAY_DATA, (item: DayDataItem) => {
          TextPicker({ range: item.data, selected: item.delSelect })
            .layoutWeight(CommonConstants.DEFAULT_LAYOUT_WEIGHT)
            .backgroundColor($r('app.color.grey_light'))
            .onChange((value: string, index: number) => {
              item.delSelect = index;
            })
        }, (item: DayDataItem) => JSON.stringify(item))
      }
    }
    .height(DimensionUtil.getVp($r('app.float.date_picker_height')))
    .padding({
      left: DimensionUtil.getVp($r('app.float.date_picker_padding_horizon')),
      right: DimensionUtil.getVp($r('app.float.date_picker_padding_horizon'))
    })
  }
}