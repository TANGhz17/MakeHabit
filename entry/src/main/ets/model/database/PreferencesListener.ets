/**
 * 轻量级数据库回调接口
 */
export default interface PreferencesListener {
  /**
   * Preferences on data changed listener.
   *
   * @param key string
   */
  onDataChanged: (key: string) => void
}