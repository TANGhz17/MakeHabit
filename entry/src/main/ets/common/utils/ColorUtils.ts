export class ColorUtils {

  static lightenColor(color) {
    // 如果颜色值是十六进制颜色代码
    if (typeof color === 'string' && color.startsWith('#')) {
      return ColorUtils.lightenHexColor(color);
    }
    // 如果颜色值是整型
    else if (typeof color === 'number') {
      return ColorUtils.lightenIntColor(color);
    }
    // 其他情况返回错误
    else {
      throw new Error('Invalid color value.');
    }
  }

  static lightenHexColor(hexColor) {
    // 将十六进制颜色代码转换为 RGB 格式
    let rgbColor = ColorUtils.hexToRgb(hexColor);

    // 将 RGB 值转换为 HSL 格式
    let hslColor = ColorUtils.rgbToHsl(rgbColor.r, rgbColor.g, rgbColor.b);

    // 增加亮度值
    hslColor.l += 0.1; // 这里可以根据需要调整亮度增加的量

    // 将 HSL 值转换回 RGB 格式
    let lightenedRgbColor = hslToRgb(hslColor.h, hslColor.s, hslColor.l);

    // 将 RGB 值转换回十六进制颜色代码
    let lightenedHexColor = rgbToHex(lightenedRgbColor.r, lightenedRgbColor.g, lightenedRgbColor.b);

    return lightenedHexColor;
  }

  static lightenIntColor(intColor) {
    // 将整型颜色值视为 RGB 格式
    let rgbColor = { r: intColor >> 16, g: (intColor >> 8) & 0xFF, b: intColor & 0xFF };

    // 将 RGB 值转换为 HSL 格式
    let hslColor = rgbToHsl(rgbColor.r, rgbColor.g, rgbColor.b);

    // 增加亮度值
    hslColor.l += 0.1; // 这里可以根据需要调整亮度增加的量

    // 将 HSL 值转换回 RGB 格式
    let lightenedRgbColor = hslToRgb(hslColor.h, hslColor.s, hslColor.l);

    // 将 RGB 值转换回整型颜色值
    let lightenedIntColor = (lightenedRgbColor.r << 16) + (lightenedRgbColor.g << 8) + lightenedRgbColor.b;

    return lightenedIntColor;
  }

}