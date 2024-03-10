import display from '@ohos.display';
import dataPreferences from '@ohos.data.preferences';
import UIAbility from '@ohos.app.ability.UIAbility';
import window from '@ohos.window';
import PreferencesHandler from '../model/database/PreferencesHandler';
import { GlobalContext } from '../common/utils/GlobalContext';
import Logger from '../common/utils/Logger'

export default class EntryAbility extends UIAbility {

  onCreate(want, launchParam) {
    Logger.info('Ability onCreate');
  }

  onDestroy() {
    Logger.info('Ability onDestroy');
  }

  // async
  onWindowStageCreate(windowStage: window.WindowStage) {
    // Main window is created, set main page for this ability
    Logger.info('Ability onWindowStageCreate');

    try {
      dataPreferences.getPreferences(this.context, 'cn.tanghz17.makehabit', (err, preferences) => {
        if (err) {
          console.error(`Failed to get preferences. Code:${err.code},message:${err.message}`);
          return;
        }
        console.info('Succeeded in getting preferences.');
        // 进行相关数据操作
      })
    } catch (err) {
      console.error(`Failed to get preferences. Code:${err.code},message:${err.message}`);
    }

    // let globalDisplay: display.Display = display.getDefaultDisplaySync();
    // GlobalContext.getContext().setObject('globalDisplay', globalDisplay);
    //
    // let preference = GlobalContext.getContext().getObject('preference') as PreferencesHandler;
    // await preference.configure(this.context.getApplicationContext());

    windowStage.loadContent('pages/MainIndex', (err, data) => {
      if (err.code) {
        Logger.info('Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
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
