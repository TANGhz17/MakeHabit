import { CommonConstants } from '../common/constants/CommonConstants';
import { DetailConstant } from '../common/constants/DetailConstant';
import DimensionUtil from '../common/utils/DimensionUtil';

@Component
export struct DatePickArea {
  @Link myHour: number;
  @Link myMinute: number;
  @Link mySecond: number;
  private myTime: Date = new Date();

  aboutToAppear() {
    this.myHour = this.myTime.getHours()
    this.myMinute = this.myTime.getMinutes()
    this.mySecond = this.myTime.getSeconds()
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Row() {
        TextPicker({ range: DetailConstant.Hours, selected: this.myTime.getHours() })
          .layoutWeight(CommonConstants.DEFAULT_LAYOUT_WEIGHT)
          .backgroundColor($r('app.color.grey_light'))
          .onChange((value: string, index: number) => {
            this.myHour = index;
          })
        TextPicker({ range: DetailConstant.Minutes, selected: this.myTime.getMinutes() })
          .layoutWeight(CommonConstants.DEFAULT_LAYOUT_WEIGHT)
          .backgroundColor($r('app.color.grey_light'))
          .onChange((value: string, index: number) => {
            this.myMinute = index;
          })
        TextPicker({ range: DetailConstant.Seconds, selected: this.myTime.getSeconds() })
          .layoutWeight(CommonConstants.DEFAULT_LAYOUT_WEIGHT)
          .backgroundColor($r('app.color.grey_light'))
          .onChange((value: string, index: number) => {
            this.mySecond = index;
          })

      }
    }
    .height(DimensionUtil.getVp($r('app.float.date_picker_height')))
    .padding({
      left: DimensionUtil.getVp($r('app.float.date_picker_padding_horizon')),
      right: DimensionUtil.getVp($r('app.float.date_picker_padding_horizon'))
    })
  }
}