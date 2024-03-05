import BaseText from './BaseText'

@Component
export default struct MonthHeader {
  build() {
    Grid() {
      GridItem() {
        BaseText({ text: '日' })
      }

      GridItem() {
        BaseText({ text: '一' })
      }

      GridItem() {
        BaseText({ text: '二' })
      }

      GridItem() {
        BaseText({ text: '三' })
      }

      GridItem() {
        BaseText({ text: '四' })
      }

      GridItem() {
        BaseText({ text: '五' })
      }

      GridItem() {
        BaseText({ text: '六' })
      }
    }
    .columnsGap(5)
    .rowsGap(5)
    .maxCount(7)
    .layoutDirection(GridDirection.Row)
  }
}