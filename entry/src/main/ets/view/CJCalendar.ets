import Logger from '../common/utils/Logger'
import RecordModel from '../model/RecordModel';
import Record from '../viewmodel/Record';
import { RecordList } from './RecordList';

// CJCalendar

const TAG = "CJCalendar"

@Observed
export class CJDateItem {
  fullYear?: number
  month?: number
  date?: number
  week?: number
  time?: number
  isPre?: boolean // 是否是上一个月的 / 在startDate 之前
  isNext?: boolean // 是否是下一个月的 / 在endDate 之后
  records?: Record[] // 存储和查询到的日期内的记录信息

  constructor(fullYear?: number, month?: number,
              date?: number, day?: number,
              time?: number,
              isPre?: boolean,
              isNext?: boolean) {
    this.fullYear = fullYear
    this.month = month
    this.date = date
    this.week = day
    this.time = time
    this.isPre = isPre
    this.isNext = isNext
  }
}

@Component
struct CalenderCell {
  private selectOpacity: number = 0.15
  itemFontSize: Length
  itemFontColor: ResourceColor
  itemFontWeight: FontWeight
  recordIcoSize: Length
  todayFontColor: ResourceColor
  selectFontColor: ResourceColor
  selectItemBgColor: ResourceColor
  disabledFontColor: ResourceColor
  // 今日时间戳
  today: number
  @Link selectItem: CJDateItem
  @Link selectedDates: Array<CJDateItem>
  @Prop hasPre: boolean
  @Prop hasNext: boolean
  @Prop item: CJDateItem
  // 自定义每一项布局
  @BuilderParam public cellLayout?: (item: CJDateItem) => void = null
  @BuilderParam public todayLayout?: (item: CJDateItem) => void = null
  //
  cellClick: (item: CJDateItem) => void
  disableClick: (item: CJDateItem) => void

  /**
   * 检测是否包含在数组中
   */
  checkInArrays() {
    for (let index = 0; index < this.selectedDates.length; index++) {
      if (this.item.time == this.selectedDates[index].time) {
        return index
      }
    }
    return -1
  }

  getItemColor() {
    if (this.item.isPre) {
      return this.disabledFontColor
    }
    else if (this.item.isNext) {
      return this.disabledFontColor
    }
    else if (this.selectItem && this.selectItem.time == this.item.time) {
      return this.selectFontColor
    }
    else if (this.item.time == this.today) {
      return this.todayFontColor
    }
    return this.itemFontColor
  }

  getBorder() {
    if (this.selectItem && this.selectItem.time == this.item.time) {
      return {
        width: 1,
        color: this.getItemColor()
      }
    } else {
      return {
        width: 0,
      }
    }
  }

  /**
   * 获取选中项背景颜色
   */
  getSelectItemBg() {
    return this.selectItemBgColor
  }

  /**
   * 获取选中项背景透明度
   * @returns
   */
  getSelectItemBgOpa() {
    return this.item.isPre || this.item.isNext ? this.selectOpacity : 1
  }

  /**
   * 是否需要显示选项背景
   */
  isShowSelectBg() {
    return this.selectItem && this.selectItem.time == this.item.time
  }

  build() {
    Column() {
      if (this.cellLayout) {
        this.cellLayout(this.item)
      }
      else {
        if (this.todayLayout && this.item.time == this.today) {
          this.todayLayout(this.item)
        }
        else {
          Stack() {
            // 日期item的背景
            if (this.isShowSelectBg()) {
              Column()
                .position({ x: "10%", y: "10%" })
                .height("80%")
                .aspectRatio(1)
                .borderRadius(999)
                .backgroundColor(this.getSelectItemBg())
                .opacity(this.getSelectItemBgOpa())
                .transition({ type: TransitionType.Insert, opacity: 1 })
                .transition({ type: TransitionType.Delete, opacity: 0 })
              // .transition()
            }

            Column() {
              Text(this.item.date.toString())
                .fontSize(this.itemFontSize)
                .fontColor(this.getItemColor())
                .fontWeight(this.itemFontWeight)

              // 设置有记录的标识
              if (this.item.records) {
                Circle()
                  .width(this.recordIcoSize)
                  .height(this.recordIcoSize)
                  .fill($r('app.color.red_light'))
              }
            }

            // Text(this.item.lunarDate.week + "")
          }
          // .justifyContent(FlexAlign.Center)
          .aspectRatio(1)
          // .border(this.getBorder())
          .width("100%")
        }
      }
    }
    .justifyContent(FlexAlign.Center)
    .width("100%")
    .aspectRatio(1)
    .onClick(() => {
      if (this.item.isNext) {
        if (!this.hasNext) {
          if (this.disableClick) {
            this.disableClick(this.item)
          }
          return
        }
      }

      if (this.item.isPre) {
        if (!this.hasPre) {
          if (this.disableClick) {
            this.disableClick(this.item)
          }
          return
        }
      }

      this.selectItem = this.item

      if (this.cellClick) {
        this.cellClick(this.item)
      }
    })
  }
}

@Component
export struct CJCalendar {
  @LocalStorageLink('isReload') isReload: boolean = false;

  @Link selectItem: CJDateItem
  private today: Date = new Date() // 当天
  showDate: boolean = true // 是否显示日期选择
  timeFontSize: number | string | Resource = 18 // 时间字体大小
  timeFontColor: ResourceColor // 时间字体大小
  recordIcoSize: number | string | Resource = 6 // 有记录时的标志大小
  // 开始日期
  startDate: Date
  // 截止日期
  endDate: Date
  //
  @State private currMonth: number = this.today.getMonth()
  @State private currYear: number = this.today.getFullYear()
  private startDay: Date = new Date(
    this.today.getFullYear(),
    this.today.getMonth(),
    1
  ) // 当前显示的月份的第一天
  // 是否有上一个月
  @State private hasPre: boolean = true
  // 是否有下一个月
  @State private hasNext: boolean = true
  // 标题栏高度
  titleHeight: Length = '50vp'
  // 星期标题
  weeks: string[] = [
    "日",
    "一",
    "二",
    "三",
    "四",
    "五",
    "六",
  ]
  // 星期标题字体大小
  weekTitleFontSize: number | string | Resource = 12
  // 星期标题字体颜色
  weekTitleFontColor: ResourceColor = "#9E9E9E"
  // 星期标栏高度
  weekTitleHeight: Length = 40
  // 标题字体大小
  titleFontSize: number | string | Resource = 18
  // 标题字体颜色
  titleFontColor: ResourceColor = "#252a34"
  // 是否显示快捷 今
  showFastToday: boolean = true
  fastTodayFontSize: number | string | Resource = 12
  fastTodayFontColor: ResourceColor = "#FFFFFF"
  fastTodayBg: ResourceColor = undefined
  // 快捷回到今天自定义布局
  @BuilderParam public fastTodayLayout?: () => void = null
  // 日期每一项字体大小
  itemFontSize: number | string | Resource = 18
  itemFontColor: ResourceColor = "#252a34"
  itemFontWeight: FontWeight = FontWeight.Normal
  // 今日字体颜色
  todayFontColor: ResourceColor = "#03A9F4"
  // 不能使用的日期字体颜色
  disabledFontColor: ResourceColor = "#9E9E9E"
  // 选中日期字体颜色
  selectFontColor: ResourceColor = "#FFFFFF"
  // 选中日期背景颜色, 默认与todayFontColor一致
  selectItemBgColor: ResourceColor
  @State private title: string = undefined
  // 计算的总加载
  @State dates: Array<CJDateItem> = new Array()
  // 已选日期
  @State selectedDates: Array<CJDateItem> = new Array()
  // 自定义每一项布局
  @BuilderParam public cellLayout?: (item: CJDateItem) => void = null
  // 自定义日期标题每项内容
  @BuilderParam public titleCenterLayout?: () => void = null
  @BuilderParam public titleLeftLayout?: (hasPre: boolean) => void = null
  @BuilderParam public titleRightLayout?: (hasNext: boolean) => void = null
  // 仅自定义 今日 样式，当使用cellLayout时，tadayLayout无效
  @BuilderParam public todayLayout?: (item: CJDateItem) => void = null
  // 计算item时，如需添加更多自定义属性时使用
  reBuildDateItem: (item: CJDateItem) => CJDateItem
  // 选择变化监听，OptMode.NORMAL/OptMode.NORMAL,只返：date1，OptMode.MULTIPLE：两个都返
  onDateChange: (date1: CJDateItem | Array<CJDateItem>, date2?: CJDateItem) => void
  onMonthChange: (after: Date, befor: Date) => void
  // 不可选中项的点击事件
  disableCellClick: (item: CJDateItem) => void

  @Builder
  createWeekTitle(item) {
    Text(item)
      .textAlign(TextAlign.Center)
      .fontColor(this.weekTitleFontColor)
      .fontSize(this.weekTitleFontSize)
      .layoutWeight(1)
  }

  @Builder
  createCell() {
    ForEach(this.dates, (item: CJDateItem, index: number) => {
      CalenderCell({
        item: item, // 不允许将“常规”修饰属性“item”分配给“@ObjectLink”修饰属性“item”。<ArkTSCheck>
        cellLayout: this.cellLayout,
        itemFontSize: this.itemFontSize,
        itemFontColor: this.itemFontColor,
        recordIcoSize: this.recordIcoSize,
        today: this.today.getTime(),
        itemFontWeight: this.itemFontWeight,
        todayFontColor: this.todayFontColor,
        todayLayout: this.todayLayout,
        selectItem: $selectItem,
        selectFontColor: this.selectFontColor,
        selectItemBgColor: this.selectItemBgColor,
        selectedDates: $selectedDates,
        disabledFontColor: this.disabledFontColor,
        hasPre: this.hasPre,
        hasNext: this.hasNext,
        disableClick: (item: CJDateItem) => {
          if (this.disableCellClick) {
            this.disableCellClick(item)
          }
        },
        cellClick: (item: CJDateItem) => {
          if (item.isPre) {
            this.preMonth()
          }
          else if (item.isNext) {
            this.nextMonth()
          }
          if (this.onDateChange) {
            this.onDateChange(item)
          }
        }
      })
        .width(`14.28%`)
    }, item => JSON.stringify(item))
  }

  /**
   * 属性初始化
   */
  initAttr() {
    if (!this.selectItemBgColor) {
      this.selectItemBgColor = this.todayFontColor
    }
    if (!this.fastTodayBg) {
      this.fastTodayBg = this.todayFontColor
    }

    this.today = new Date(
      this.today.getFullYear(),
      this.today.getMonth(),
      this.today.getDate(),
    )

    // 开始日期
    if (!this.startDate) {
      this.startDate = new Date(1970, 0, 1)
    }
    // 截止日期
    if (!this.endDate) {
      this.endDate = new Date(this.today.getFullYear() + 10, 11, 31)
    }

    if (this.today.getTime() < this.startDate.getTime()) {
      this.startDay.setTime(this.startDate.getTime())
      this.showFastToday = false
    } else if (this.today.getTime() > this.endDate.getTime()) {
      this.startDay.setTime(this.endDate.getTime())
      this.showFastToday = false
    } else {
      this.startDay.setTime(this.today.getTime())
    }
  }

  aboutToAppear() {
    this.initAttr()

    if (!this.selectItem) {
      let temp = new CJDateItem()
      temp.time = this.today.getTime()
      this.selectItem = temp
    }

    this.calcDatas()
  }

  /**
   * 下一个月
   */
  private nextMonth() {
    // this.dates.slice(0, this.dates.length)
    this.dates = []
    const beforDate = new Date(this.startDay.getFullYear(), this.startDay.getMonth())
    this.startDay.setMonth(this.startDay.getMonth() + 1)
    if (this.onMonthChange) {
      this.onMonthChange(new Date(this.startDay.getFullYear(), this.startDay.getMonth()), beforDate)
    }
    this.calcDatas()
  }

  /**
   * 上一个月
   */
  private preMonth() {
    // this.dates.slice(0, this.dates.length)
    this.dates = []
    const beforDate = new Date(this.startDay.getFullYear(), this.startDay.getMonth())
    this.startDay.setMonth(this.startDay.getMonth() - 1)
    if (this.onMonthChange) {
      this.onMonthChange(new Date(this.startDay.getFullYear(), this.startDay.getMonth()), beforDate)
    }
    this.calcDatas()
  }

  /**
   * 回到今天
   */
  private backToday() {
    this.dates = []
    const beforDate = new Date(this.startDay.getFullYear(), this.startDay.getMonth())
    this.startDay.setFullYear(this.today.getFullYear(), this.today.getMonth())

    let temp = new CJDateItem()
    temp.time = this.today.getTime()
    this.selectItem = temp

    if (this.onMonthChange) {
      this.onMonthChange(new Date(this.startDay.getFullYear(), this.startDay.getMonth()), beforDate)
    }
    this.calcDatas()
  }

  // 查询加载的日期在数据库里是否有记录
  private hasRecordWithDates() {
    this.dates.forEach(date => {
      let tempDate: Date = new Date(date.time)
      RecordModel.queryByDate(tempDate)
        .then(records => {
          if (records.length > 0) {
            Logger.debug(tempDate.toDateString() + '有 记录');
            date.records = records
          }
        })
    })
  }

  /**
   * 具体计算
   */
  private calcDatas() {
    const startDay = this.startDay
    this.currMonth = startDay.getMonth()
    this.currYear = startDay.getFullYear()
    this.title = `${startDay.getFullYear()}年${startDay.getMonth() + 1}月`
    startDay.setDate(1)

    if (startDay.getFullYear() < this.startDate.getFullYear()
      || (startDay.getFullYear() == this.startDate.getFullYear() && startDay.getMonth() <= this.startDate.getMonth())) {
      this.hasPre = false
    } else {
      this.hasPre = true
    }

    if (startDay.getFullYear() > this.endDate.getFullYear()
      || (startDay.getFullYear() == this.startDate.getFullYear() && startDay.getMonth() >= this.endDate.getMonth())) {
      this.hasNext = false
    } else {
      this.hasNext = true
    }

    // 计算第一个月
    // 获取第一个月总天数
    let endDay: Date = new Date(
      startDay.getFullYear(),
      startDay.getMonth() + 1,
      0, 23, 59, 59)

    let tempDate: Date = new Date(
      startDay.getFullYear(),
      startDay.getMonth(),
      startDay.getDate()
    )

    const count = endDay.getDate()
    const preCount = startDay.getDay()
    const nextCount = 6 - endDay.getDay()
    const finilCount = count + preCount + nextCount

    // 补齐上一个月
    tempDate.setDate(tempDate.getDate() - preCount)

    // 添加日期
    for (let i = 0; i < finilCount; i++) {
      let item = new CJDateItem(
        tempDate.getFullYear(),
        tempDate.getMonth(),
        tempDate.getDate(),
        tempDate.getDay(),
        tempDate.getTime(),
        (i < preCount ? true : false) || this.startDate.getTime() > tempDate.getTime(),
        (i >= preCount + count ? true : false) || this.endDate.getTime() < tempDate.getTime(),
      )
      if (this.reBuildDateItem) {
        this.reBuildDateItem(item)
      }
      this.dates.push(item)
      tempDate.setDate(tempDate.getDate() + 1)
    }

    this.hasRecordWithDates()
  }

  build() {
    Column() {
      if (this.isReload) {
        // topTitleLayout
        Row() {
          // titleLeftLayout
          Column() {
            if (this.titleLeftLayout) {
              this.titleLeftLayout(this.hasPre)
            } else {
              Image($r("app.media.ic_public_arrow_left"))
                .width(28)
                .fillColor(this.hasPre ? this.itemFontColor : this.disabledFontColor)
                .aspectRatio(1)
            }
          }
          .justifyContent(FlexAlign.Center)
          .height("100%")
          .aspectRatio(1)
          .onClick(() => {
            if (this.hasPre) {
              this.preMonth()
            }
          })

          Blank()

          // titleCenterLayout
          if (this.titleCenterLayout) {
            this.titleCenterLayout()
          }
          else {
            Row() {
              Text(this.title)
                .fontSize(this.titleFontSize)
                .fontColor(this.titleFontColor)
              if ((this.currYear == this.today.getFullYear() && this.currMonth != this.today.getMonth()
                || this.currYear != this.today.getFullYear()) && this.showFastToday) {
                Row() {
                  if (this.fastTodayLayout) {
                    this.fastTodayLayout()
                  } else {
                    Text("今")
                      .fontSize(this.fastTodayFontSize)
                      .fontColor(this.fastTodayFontColor)
                      .backgroundColor(this.fastTodayBg)
                      .borderRadius(50)
                      .padding(4)
                      .margin({ left: 4 })
                  }
                }
                .onClick(() => {
                  this.backToday()
                })
              }

            }
          }

          Blank()

          // titleRightLayout
          Column() {
            if (this.titleRightLayout) {
              this.titleRightLayout(this.hasNext)
            } else {
              Image($r("app.media.ic_public_arrow_right_filled"))
                .fillColor(this.hasNext ? this.itemFontColor : this.disabledFontColor)
                .width(28)
                .aspectRatio(1)
            }
          }
          .justifyContent(FlexAlign.Center)
          .height("100%")
          .aspectRatio(1)
          .onClick(() => {
            if (this.hasNext) {
              this.nextMonth()
            }
          })
        }
        .alignItems(VerticalAlign.Center)
        .width("100%")
        .height(this.titleHeight)

        // weeksTitle
        Row() {
          ForEach(this.weeks, (item, index) => {
            this.createWeekTitle(item)
          })
        }
        .alignItems(VerticalAlign.Center)
        .height(this.weekTitleHeight)

        // days
        Flex({ wrap: FlexWrap.Wrap }) {
          this.createCell()
        }
        .width("100%")
      }

      RecordList({ CJDates: $dates, CJDate: $selectItem })
    }
    .width("100%")

    // .height("100%")
  }
}