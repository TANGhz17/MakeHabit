// 类全局context类 屏幕适配工具类

import display from '@ohos.display';
import { GlobalContext } from './GlobalContext';

let context = getContext(this);

/**
 * Design drawing width.
 */
const DESIGN_WIDTH = 1228 / 3;

/**
 * Design drawing height.
 */
const DESIGN_HEIGHT = 2700 / 3;

/**
 * Fits tools with different sizes and lengths.
 */
export default class DimensionUtil {
  /**
   * 获取屏幕水平适配值。
   *
   * @return number
   */
  static adaptDimension(value: number): number {
    let deviceDisplay = GlobalContext.getContext().getObject('globalDisplay') as display.Display;
    let widthScale = deviceDisplay.width / DESIGN_WIDTH;
    let virtualHeight = widthScale * DESIGN_HEIGHT;
    let designDim = Math.sqrt(DESIGN_WIDTH * DESIGN_WIDTH + DESIGN_HEIGHT * DESIGN_HEIGHT);
    let virtualDim = Math.sqrt(deviceDisplay.width * deviceDisplay.width + virtualHeight * virtualHeight);
    return virtualDim * value / designDim; // 放缩后长度
  }

  /**
   * Obtains the screen horizontal adaptation px.
   *
   * @return number
   */
  static getPx(value: Resource): number {
    let beforeVp = context.resourceManager.getNumber(value.id);
    return DimensionUtil.adaptDimension(beforeVp);
  }

  /**
   * Obtains the screen horizontal adaptation vp.
   *
   * @return number
   */
  static getVp(value: Resource): number {
    let beforeVp = context.resourceManager.getNumber(value.id);
    return px2vp(DimensionUtil.adaptDimension(beforeVp));
  }

  /**
   * Obtains the screen horizontal adaptation fp.
   *
   * @return number
   */
  static getFp(value: Resource): number {
    let beforeFp = context.resourceManager.getNumber(value.id);
    return px2fp(DimensionUtil.adaptDimension(beforeFp));
  }
}