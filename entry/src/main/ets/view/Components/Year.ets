@Preview
@Component
  // @ts-ignore
export default struct Year {
  @Prop year : number;

  build() {
    Row() {
      // year
      Scroll() {
        Grid() {
          // Month item
          // LazyForEach
        }
        .width("100%")
        .height("100%")
        .maxCount(3)
        .layoutDirection(GridDirection.Row)
        .columnsGap(20)
        .rowsGap(20)
      }
      .width("100%")
      .height("100%")
      .offset({ x: "0vp", y: "0vp" })
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Auto)
      .edgeEffect(EdgeEffect.None)
    }
  }
}