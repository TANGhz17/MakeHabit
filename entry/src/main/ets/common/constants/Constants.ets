/**
 * The font size of application.
 */
export enum FontSize{
  SMALL = 14,
  MIDDLE = 16,
  LARGE = 20
}

/**
 * The font weight of application.
 */
export enum FontWeight {
  BOLD = '400',
  BOLDER = '500',
};

/**
 * The weight is global default value for component size.
 */
export const WEIGHT = '100%';

/**
 * The title of TitleComponent.
 */
export const App_Title = $r("app.string.app_name");

class titleBarStyle {
  IMAGE_BACK_SIZE: number = 21;
  IMAGE_BACK_MARGIN_RIGHT: number = 18;
  IMAGE_LOADING_SIZE: number = 22;
  BAR_HEIGHT: number = 47;
  BAR_MARGIN_HORIZONTAL: number = 26;
  BAR_MARGIN_TOP: number = 10;
  WEIGHT: string = '50%';
}

/**
 * The Style of TitleComponent.
 */
export const TitleBarStyle: titleBarStyle = {
  /**
   * The image size of back button.
   */
  IMAGE_BACK_SIZE: 21,

  /**
   * The right margin of back button.
   */
  IMAGE_BACK_MARGIN_RIGHT: 18,

  /**
   * The size of loading image.
   */
  IMAGE_LOADING_SIZE: 22,

  /**
   * The height of TitleComponent.
   */
  BAR_HEIGHT: 47,

  /**
   * The horizontal margin of TitleComponent.
   */
  BAR_MARGIN_HORIZONTAL: 26,

  /**
   * The top margin of TitleComponent.
   */
  BAR_MARGIN_TOP: 10,

  /**
   * The weight of Row layout.
   */
  WEIGHT: '50%',
};