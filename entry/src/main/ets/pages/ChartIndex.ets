import { McLineChart, Options } from '@mcui/mccharts'
import BackContainer from '../view/BackContainer'

@Entry
@Component
struct ChartIndex {
  // private xAxisDate = ['周一', '周二', '周三', '周四', '周五', '周六', '周日']
  private xAxisDate = ['4.15', '4.16', '4.17', '4.18', '4.19', '4.20', '4.21']
  private series = [
    {
      name: '锻炼',
      data: [0, 0, 0, 1, 0, 0, 0]
    },
    {
      name: '学习',
      data: [0, 0, 0, 0, 0, 0, 0]
    },
    {
      name: '练字',
      data: [0, 0, 0, 0, 0, 0, 0]
    }
  ]

  @State option: Options = new Options({
    xAxis: {
      axisLine: { // 轴线样式
        show: true, // 是否显示
        lineStyle: {
          color: '#ccc',
          width: 2
        }
      },
      axisTick: { // 刻度线配置
        show: true, // 是否显示
        interval: 6, // 与文本的间隔
        length: 4, // 刻度的长度
        lineStyle: {
          color: '#ccc', // 刻度线颜色
          width: 2 // 刻度线宽度
        }
      },
      axisLabel: { // x轴文本标签样式
        color: '#bf19ff',
        fontWeight: '600',
        fontFamily: 'sans-serif',
        fontSize: 20,
      },
      data: this.xAxisDate // 数据
    },
    yAxis: {
      name: '频率'
    },
    series: this.series
  })

  aboutToAppear(){
    // this.option.xAxis.data = [];
    // this.option.series = []
  }

  build() {
    Column({ space: 12 }) {
      // 自定义组件“BackContainer”中的属性“closer”缺少赋值或初始化。
      BackContainer({
        header: $r('app.string.chart_label'),
        backImgRes: $r('app.media.ic_public_back'),
      }){ }

      Row() {
        McLineChart({
          // Assigning the '@State' decorated attribute 'option' to the '@ObjectLink' decorated attribute 'options' is not allowed. <ArkTSCheck>
          options: this.option
        })
          .height('50%')
      }
    }
  }
}