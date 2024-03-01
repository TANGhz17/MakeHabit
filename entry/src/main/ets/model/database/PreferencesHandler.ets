import data_preferences from '@ohos.data.preferences';
import { CommonConstants } from '../../common/constants/CommonConstants';
import PreferencesListener from './PreferencesListener';

/**
 * 轻量级数据库操作类
 */
export default class PreferencesHandler {
  static instance: PreferencesHandler = new PreferencesHandler();
  private preferences: data_preferences.Preferences | null = null;
  private defaultValue = '';
  private listeners: PreferencesListener[];

  private constructor() {
    this.listeners = new Array();
  }

  /**
   * 配置 PreferencesHandler。
   *
   * @param context Context
   */
  public async configure(context: Context) {
    this.preferences = await data_preferences.getPreferences(context, CommonConstants.PREFERENCE_ID);
    this.preferences.on('change', (data: Record<string, Object>) => {
      for (let preferencesListener of this.listeners) {
        preferencesListener.onDataChanged(data.key as string);
      }
    });
  }

  /**
   * 在 PreferencesHandler 中设置数据。
   *
   * @param key string
   * @param value any
   */
  public async set(key: string, value: string) {
    if (this.preferences != null) {
      await this.preferences.put(key, value);
      await this.preferences.flush();
    }
  }

  /**
   * 在 PreferencesHandler 中获取数据。
   *
   * @param key string
   * @param defValue any
   * @return data about key
   */
  public async get(key: string) {
    let data: string = '';
    if (this.preferences != null) {
      data = await this.preferences.get(key, this.defaultValue) as string;
    }
    return data;
  }

  /**
   * 清除 PreferencesHandler 中的数据。
   */
  public clear() {
    if (this.preferences != null) {
      this.preferences.clear();
    }
  }

  /**
   * 在 PreferencesHandler 中添加首选项侦听器。
   *
   * @param listener PreferencesListener
   */
  public addPreferencesListener(listener: PreferencesListener) {
    this.listeners.push(listener);
  }
}