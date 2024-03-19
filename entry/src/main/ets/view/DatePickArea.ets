import { CommonConstants } from '../common/constants/CommonConstants';
import DimensionUtil from '../common/utils/DimensionUtil';

@Preview
@Component
export default struct DatePickArea {
  date: Date = new Date();

  private hours: string[];
  private minutes: string[];
  private seconds: string[];

  aboutToAppear(){
    this.initTime()
  }

  initTime(){
    this.hours = []
    this.minutes = []
    this.seconds = []
    for (let index = 0; index < 24; index++) {
      this.hours.push(index.toString().padStart(2, '0'))
    }
    for (let index = 0; index < 59; index++) {
      this.minutes.push(index.toString().padStart(2, '0'))
    }
    for (let index = 0; index < 59; index++) {
      this.seconds.push(index.toString().padStart(2, '0'))
    }
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Row() {
        TextPicker({ range: this.hours, selected: this.date.getHours() })
          .layoutWeight(CommonConstants.DEFAULT_LAYOUT_WEIGHT)
          .backgroundColor($r('app.color.grey_light'))
          .onChange((value: string, index: number) => {
            this.date.setHours(index);
          })
        TextPicker({ range: this.minutes, selected: this.date.getMinutes() })
          .layoutWeight(CommonConstants.DEFAULT_LAYOUT_WEIGHT)
          .backgroundColor($r('app.color.grey_light'))
          .onChange((value: string, index: number) => {
            this.date.setMinutes(index);
          })
        TextPicker({ range: this.seconds, selected: this.date.getSeconds() })
          .layoutWeight(CommonConstants.DEFAULT_LAYOUT_WEIGHT)
          .backgroundColor($r('app.color.grey_light'))
          .onChange((value: string, index: number) => {
            this.date.setSeconds(index);
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