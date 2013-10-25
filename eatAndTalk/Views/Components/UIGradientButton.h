#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIGradientButton : UIButton {
  @private
  CAGradientLayer* _gradientLayer;
  NSMutableDictionary* _statesToLocations;
  NSMutableDictionary* _statesToColors;
  NSMutableDictionary* _statesToStrokes;
}

- (void)setGrayColorScheme;
- (void) setLocations: (NSArray*)locations forState: (UIControlState)state;
- (void) setColors: (NSArray*)colors forState: (UIControlState)state;
- (void) setStrokeColor: (UIColor*)color forState: (UIControlState)state;

@end
