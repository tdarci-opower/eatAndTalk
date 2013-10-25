#import <Foundation/Foundation.h>
#import "Utils.h"

NSString * resStr(NSString *key) {
  return NSLocalizedString(key, nil);
}

#define UNIQUE_ID_KEY @"UNIQUE_ID_KEY"

@implementation Utils

+ (BOOL) isEmpty:(id) objectToTest {
  
  return objectToTest == nil
  || ([objectToTest isKindOfClass:[NSNull class]])
  || ([objectToTest respondsToSelector:@selector(length)]
      && [objectToTest performSelector:@selector(length)] == 0)
  || ([objectToTest respondsToSelector:@selector(count)]
      && [objectToTest performSelector:@selector(count)] == 0);
}

+ (int)indexOfString:(NSString*)string inArray:(NSString * const *)strings withLength:(int)length
{
  int idx = 0;
  while(strings && idx < length && strings[idx]) {
    if ([string isEqualToString:strings[idx]]) {
      break;
    }
    idx++;
  }
  if (!strings || length <= idx || !strings[idx]) {
    idx = -1;
  }
  return idx;
}

+ (int)roundToNearest5:(int)val
{
  return (val % 5) >= 2.5 ? floor(val / 5) * 5 + 5 : floor(val / 5) * 5;
}

+ (UIColor *)hexToUIColor:(NSString*)hexCode {
  NSString *cleanString = [hexCode stringByReplacingOccurrencesOfString:@"#" withString:@""];
  if([cleanString length] == 3) {
    cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@", 
                   [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                   [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                   [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
  }
  if([cleanString length] == 6) {
    cleanString = [cleanString stringByAppendingString:@"ff"];
  }
  
  unsigned int baseValue;
  [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
  
  float red = ((baseValue >> 24) & 0xFF)/255.0f;
  float green = ((baseValue >> 16) & 0xFF)/255.0f;
  float blue = ((baseValue >> 8) & 0xFF)/255.0f;
  float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
  
  return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


+ (UIColor *)rgbToUIColorRed:(float)red green:(float)green blue:(float)blue {
  return [UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:(blue/255.0f) alpha:1.0];
}


+ (NSInteger) calendarDaysBetweenStartDate: (NSDate *) startDate andEndDate: (NSDate *) endDate usingTimeZone: (NSTimeZone *) timeZone
{
  if ((! startDate) || (!endDate) || (!timeZone)) {
    return 0;
  }
  
  NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
  calendar.timeZone = timeZone;

  NSDateComponents *startDateStartComponents = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:startDate];
  startDateStartComponents.calendar = calendar;
  startDateStartComponents.timeZone = timeZone;
  startDateStartComponents.hour = 0;
  startDateStartComponents.minute = 0;
  startDateStartComponents.second = 0;
  NSDateComponents *endDateStartComponents = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:endDate];
  endDateStartComponents.calendar = calendar;
  endDateStartComponents.timeZone = timeZone;
  endDateStartComponents.hour = 0;
  endDateStartComponents.minute = 0;
  endDateStartComponents.second = 0;
  
  NSDate *startDateStart = [startDateStartComponents date];
  NSDate *endDateStart = [endDateStartComponents date];
  
  NSInteger daysDiff = 0;
  NSDateComponents *dateDifference = [calendar components:NSDayCalendarUnit
                                                 fromDate:startDateStart
                                                   toDate:endDateStart
                                                  options:0];
  daysDiff = dateDifference.day;
  return daysDiff;
}

+ (BOOL) isViewVisible:(UIViewController *)viewController {
  return viewController.isViewLoaded && viewController.view.window;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
  CGRect rect = CGRectMake(0.0, 0.0, 1.0, 1.0);
  // Create a 1 by 1 pixel context
  UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
  [color setFill];
  UIRectFill(rect);   // Fill it with your color
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}

@end
