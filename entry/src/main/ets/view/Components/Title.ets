import { App_Title, FontSize, TitleBarStyle } from '../../common/constants/Constants'

@Preview
@Component
export default struct TitleComponent {

  build() {
    Row() {
      Text(App_Title)
        .fontSize(FontSize.LARGE)
        .fontWeight(FontWeight.Bold)
    }
    .height(TitleBarStyle.BAR_HEIGHT)
    .width('100%')
    .padding({ left: TitleBarStyle.BAR_MARGIN_HORIZONTAL,
      right: TitleBarStyle.BAR_MARGIN_HORIZONTAL })
    .margin({ top: TitleBarStyle.BAR_MARGIN_TOP })
    .justifyContent(FlexAlign.SpaceAround)
  }
}