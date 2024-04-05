import { McLineChart, Options } from '@mcui/mccharts'

@Entry
@Component
struct ChartIndex {
  @State option: Options = new Options({
    xAxis:{
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
      axisLabel: {  // x轴文本标签样式
        color: '#bf19ff',
        fontWeight: '600',
        fontFamily: 'sans-serif',
        fontSize: 20,
      },
      formatter: function (name) { // 自定义文本标签
        return '周六'
      },
      data: ['周一','周二','周三','周四','周五','周六','周日'] // 数据
    },
    yAxis:{
      name:'温度'
    },
    series:[
      {
        name:'最高气温',
        data:[11, 11, 15, 13, 12, 130, 10]
      }
    ]
  })

  build(){
    Row(){
      McLineChart({
        // Assigning the '@State' decorated attribute 'option' to the '@ObjectLink' decorated attribute 'options' is not allowed. <ArkTSCheck>
        options: this.option
      })
    }
  }
}