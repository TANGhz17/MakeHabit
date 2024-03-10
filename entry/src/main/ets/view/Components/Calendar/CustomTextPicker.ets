declare type CustomTextPickerTheme = {
  fgColor: ResourceColor,
  bgColor?: ResourceColor,
  fontSize: number | string | Resource
}

@Component
export default struct CustomTextPicker {
  initIndex: number = 0
  cellHeight: number = 65
  datas: Array<string> = []
  normal: CustomTextPickerTheme = { fontSize: 18, fgColor: Color.Black }
  selected: CustomTextPickerTheme = { fontSize: 18, fgColor: Color.Black }
  @State listHeight: number = 0
  @State selectedIdx: number = 0
  private scroller = new Scroller()

  // 数据变化
  onchange: (index: number) => void

  build() {
    Stack() {
      List({
        scroller: this.scroller,
        initialIndex: this.initIndex,
        space: 0
      }) {
        // ListItem().height((this.listHeight - this.cellHeight) / 2)

        ForEach(this.datas, (text, idx) => {
          ListItem() {
            Text(text)
              .fontSize(idx == this.selectedIdx ? this.selected.fontSize : this.normal.fontSize)
                // .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Center)
              .fontColor(idx == this.selectedIdx ? this.selected.fgColor : this.normal.fgColor)
          }
          .backgroundColor(idx == this.selectedIdx ? this.selected.bgColor : this.normal.bgColor)
          .size({ width: '100%', height: this.cellHeight })
        })

        // ListItem().height((this.listHeight - this.cellHeight) / 2)
      }
      .margin(0)
      .onAreaChange((oldArea, newArea) => {
        this.listHeight = newArea.height as number
      })
      .onScrollStop(() => {
        let offsetY = this.scroller.currentOffset().yOffset as number
        let selectedIdx = Math.round(offsetY / this.cellHeight)
        if (this.selectedIdx != selectedIdx) {
          if (this.onchange) {
            this.onchange(selectedIdx)
          }
          this.selectedIdx = selectedIdx
        }
        this.scroller.scrollTo({
          xOffset: 0,
          yOffset: selectedIdx * this.cellHeight,
          animation: {
            duration: 500,
            curve: Curve.Rhythm
          }
        })
      })
      .width("100%")
      .height(this.cellHeight)

      // Row()
      //   .border({
      //     width: { top: 1, bottom: 1 },
      //     color: { top: Color.Gray, bottom: Color.Gray }
      //   })
      //   .height(this.cellHeight)
      //   .width('100%')
      //   .hitTestBehavior(HitTestMode.Transparent)
    }
  }
}