/**
 * 数据类型工具
 */
export default class DataTypeUtils {
  /**
   * return obj is null.
   *
   * @return boolean.
   */
  static isNull(obj: Object): boolean {
    return (typeof obj === 'undefined' || obj == null || obj === '');
  }

  /**
   * return new deep copy object from obj.
   *
   * @return type in obj.
   */
  static deepCopy(obj: number[]) {
    let newObj: number[] = [];
    for (let i = 0; i < obj.length; i++) {
      newObj[i] = JSON.parse(JSON.stringify(obj[i]));
    }
    return newObj;
  }
}