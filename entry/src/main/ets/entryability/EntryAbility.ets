import display from '@ohos.display';
import UIAbility from '@ohos.app.ability.UIAbility';
import window from '@ohos.window';
import { GlobalContext } from '../common/utils/GlobalContext';
import Logger from '../common/utils/Logger'
import DbUtil from '../common/utils/DbUtil';
import HabitModel from '../model/HabitModel';
import RecordModel from '../model/RecordModel';

export default class EntryAbility extends UIAbility {

  async onCreate(want, launchParam) {
    // 1.加载用户首选项
    // 2.初始化日期
    // AppStorage.SetOrCreate()
    // 3.初始化RDB工具
    await DbUtil.initDB(this.context);
    // 3.1.创建Habit表
    DbUtil.createTable(HabitModel.getCreateTableSql())
    // 3.2.创建Record表
    DbUtil.createTable(RecordModel.getCreateTableSql())

    Logger.info('Ability onCreate');
  }

  onDestroy() {
    Logger.info('Ability onDestroy');
  }

  // async
  onWindowStageCreate(windowStage: window.WindowStage) {
    // Main window is created, set main page for this ability
    Logger.info('Ability onWindowStageCreate');

    windowStage.loadContent('pages/MainIndex', (err, data) => {
      if (err.code) {
        Logger.error('Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      Logger.info('testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
  }

  onWindowStageDestroy() {
    // Main window is destroyed, release UI related resources
    Logger.info('Ability onWindowStageDestroy');
  }

  onForeground() {
    // Ability has brought to foreground
    Logger.info('Ability onForeground');
  }

  onBackground() {
    // Ability has back to background
    Logger.info('Ability onBackground');
  }
}
