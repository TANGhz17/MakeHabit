import { CommonConstants } from '../common/constants/CommonConstants';
import DimensionUtil from '../common/utils/DimensionUtil';
import Logger from '../common/utils/Logger';
import HabitModel from '../model/HabitModel';
import RecordModel from '../model/RecordModel';
import BackContainer from '../view/BackContainer';
import Habit from '../viewmodel/Habit';
import router from '@ohos.router';

@Entry
@Component
struct SettingIndex {
  @State habits: Habit[] = [];

  aboutToAppear() {
    this.syncHabits()
  }

  syncHabits() {
    HabitModel.queryAllHabits()
      .then(habits => {
        this.habits = habits
      })
  }

  dialogController: CustomDialogController = new CustomDialogController({
    builder: AddHabitDialog({}),
  })

  @Builder
  itemEnd(habit: Habit, index: number) {
    // 侧滑后尾端出现的组件
    Button({ type: ButtonType.Circle }) {
      Image($r('app.media.ic_public_delete_filled'))
        .width(30)
        .height(30)
    }
    .width(50)
    .height(50)
    .margin({
      left: 10
    })
    .backgroundColor($r('app.color.red_light'))
    .onClick(() => {
      HabitModel.deleteById(habit.id)
      RecordModel.deleteByHabitId(habit.id)
      // this.habits.splice(index)
    })
  }

  build() {
    Column({ space: 12 }) {
      BackContainer({
        header: '设置',
        backImgRes: $r('app.media.ic_public_back'),
      }) {
        Button() {
          Image($r('app.media.ic_public_add_norm'))
        }
        .backgroundColor($r('app.color.trans_parent'))
        .width(DimensionUtil.getVp($r('app.float.title_button_size')))
        .height(DimensionUtil.getVp($r('app.float.title_button_size')))
        .onClick(() => {
          this.dialogController.open()
        })
      }

      List({ space: 12 }) {
        ForEach(this.habits, (habit: Habit, listIndex: number) => {
          ListItem() {
            Row() {
              Column() {
                Text(habit.name)
                  .CommonTextAttr(DimensionUtil.getVp($r('app.float.records_item_time_font_size')),
                    FontWeight.Regular)
                Text(habit.msg)
                  .CommonTextAttr(DimensionUtil.getVp($r('app.float.records_item_noon_font_size')),
                    FontWeight.Regular,
                    { left: DimensionUtil.getVp($r('app.float.records_item_time_margin_left')) })
              }
              .width(CommonConstants.FULL_LENGTH)
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(CommonConstants.DEFAULT_LAYOUT_WEIGHT)
            }
            .padding({
              left: DimensionUtil.getVp($r('app.float.record_list_content_distance')),
              right: DimensionUtil.getVp($r('app.float.record_list_content_distance'))
            })
            .width(CommonConstants.FULL_LENGTH)
            .height(DimensionUtil.getVp($r('app.float.records_item_height')))
            .backgroundColor(Color.White)
            .borderRadius(DimensionUtil.getVp($r('app.float.records_item_radius')))
          }
          .swipeAction({ end: this.itemEnd.bind(this, habit, listIndex) }) // 设置侧滑属性
        })
      }
    }
  }
}

@CustomDialog
struct AddHabitDialog{
  @State habitName : string = ''
  @State habitMsg : string = ''
  controller?: CustomDialogController
  // 若尝试在CustomDialog中传入多个其他的Controller，以实现在CustomDialog中打开另一个或另一些CustomDialog，那么此处需要将指向自己的controller放在所有controller的后面
  cancel: () => void = () => {
  }
  confirm: () => void = () => {
  }

  build() {
    Column() {
      Text('习惯名称').fontSize(20).margin({ top: 10, bottom: 10 })
      TextInput({ placeholder: '' , text : this.habitName }).height(60).width('90%')
        .onChange((value: string) => {
          this.habitName = value
        })
      // Text('备注').fontSize(16).margin({ bottom: 10 })
      TextInput({ placeholder: '备注' , text : this.habitMsg }).height(60).width('90%')
        .onChange((value: string) => {
          this.habitMsg = value
        })
      Flex({ justifyContent: FlexAlign.SpaceAround }) {
        Button('cancel')
          .onClick(() => {
            this.controller.close()
            this.cancel()

          }).backgroundColor(0xffffff).fontColor(Color.Black)
        Button('confirm')
          .onClick(() => {
            if (this.controller != undefined && this.habitName !== '') {
              HabitModel.insert({id: NaN, name:this.habitName, msg:this.habitMsg, intervalTime: NaN})

              this.controller.close()
              this.confirm()
            }
          }).backgroundColor(0xffffff).fontColor(Color.Red)
      }.margin({ bottom: 10 })
    }.borderRadius(10)
  }
}

@Extend(Text)
function CommonTextAttr(fontSize: number, fontWeight: number, margin?: Margin,
                        opacity?: Resource) {
  .fontColor($r('app.color.grey_divider'))
  .fontSize(fontSize)
  .fontWeight(fontWeight)
  .margin(margin != undefined ? margin : 0)
  .opacity(opacity != undefined ? opacity : 1)
}