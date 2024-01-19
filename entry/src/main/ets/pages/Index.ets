import TitleComponent from '../view/Components/Title'

@Entry
@Preview
@Component
struct Index {
  @State message: string = 'Hello World'

  build() {
    Column() {
      TitleComponent()

    }
    .width('100%')
    .height('100%')
  }
}