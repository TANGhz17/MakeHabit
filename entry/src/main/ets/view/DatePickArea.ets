import { CommonConstants } from '../common/constants/CommonConstants';
import DimensionUtil from '../common/utils/DimensionUtil';
import Logger from '../common/utils/Logger';

@Component
export struct DatePickArea {
  @Link myHour: number;
  @Link myMinute: number;
  @Link mySecond: number;
  private myTime: Date = new Date();
  private hours: string[] = [
    '00', '01', '02', '03', '04', '05', '06', '07', '08', '09',
    '10', '11', '12', '13', '14', '15', '16', '17', '18', '19',
    '20', '21', '22', '23'
  ];
  private minutes: string[] = [
    '00', '01', '02', '03', '04', '05', '06', '07', '08', '09',
    '10', '11', '12', '13', '14', '15', '16', '17', '18', '19',
    '20', '21', '22', '23', '24', '25', '26', '27', '28', '29',
    '30', '31', '32', '33', '34', '35', '36', '37', '38', '39',
    '40', '41', '42', '43', '44', '45', '46', '47', '48', '49',
    '50', '51', '52', '53', '54', '55', '56', '57', '58', '59'
  ];
  private seconds: string[] = [
    '00', '01', '02', '03', '04', '05', '06', '07', '08', '09',
    '10', '11', '12', '13', '14', '15', '16', '17', '18', '19',
    '20', '21', '22', '23', '24', '25', '26', '27', '28', '29',
    '30', '31', '32', '33', '34', '35', '36', '37', '38', '39',
    '40', '41', '42', '43', '44', '45', '46', '47', '48', '49',
    '50', '51', '52', '53', '54', '55', '56', '57', '58', '59'
  ];



  build() {
    Stack({ alignContent: Alignment.Center }) {
      Row() {
        TextPicker({ range: this.hours, selected: this.myTime.getHours() })
          .layoutWeight(CommonConstants.DEFAULT_LAYOUT_WEIGHT)
          .backgroundColor($r('app.color.grey_light'))
          .onChange((value: string, index: number) => {
            this.myHour = index;
            Logger.debug('Hour Change: ', this.myHour.toString())
          })
        TextPicker({ range: this.minutes, selected: this.myTime.getMinutes() })
          .layoutWeight(CommonConstants.DEFAULT_LAYOUT_WEIGHT)
          .backgroundColor($r('app.color.grey_light'))
          .onChange((value: string, index: number) => {
            this.myMinute = index;
            Logger.debug('Minute Change: ', this.myMinute.toString())
          })
        TextPicker({ range: this.seconds, selected: this.myTime.getSeconds() })
          .layoutWeight(CommonConstants.DEFAULT_LAYOUT_WEIGHT)
          .backgroundColor($r('app.color.grey_light'))
          .onChange((value: string, index: number) => {
            this.mySecond = index;
            Logger.debug('Second Change: ', this.mySecond.toString())
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