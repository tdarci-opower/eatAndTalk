#import <Foundation/Foundation.h>
#
#ifdef UI_USER_INTERFACE_IDIOM
  #define isPad() (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
  #define isIphone5() ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && \
          [UIScreen mainScreen].bounds.size.height * [UIScreen mainScreen].scale >= 1136)
#else
  #define isPad() NO
  #define isIphone5() NO
#endif

// Hey Tom, why a C function instead of a class method on Utils?
// Good question. Because I was looking for a shorter replacement for NSLocalizedString(key, nil),
// and [Utils resStr: key] is still too long.
extern NSString * resStr(NSString *key);

@interface Utils : NSObject

+ (int)indexOfString:(NSString*)string inArray:(NSString * const *)strings withLength:(int)length;
+ (int)roundToNearest5:(int)val;
+ (UIColor *)hexToUIColor:(NSString *)hexCode;
+ (UIColor *)rgbToUIColorRed:(float)red green:(float)green blue:(float)blue;
+ (BOOL) isEmpty:(id) something;
+ (NSInteger) calendarDaysBetweenStartDate: (NSDate *) startDate andEndDate: (NSDate *) endDate usingTimeZone: (NSTimeZone *) timeZone;
+ (BOOL) isViewVisible:(UIViewController*)viewController;
+ (UIImage *)imageWithColor:(UIColor *)color;
@end
