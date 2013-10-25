#import "JabberJawColors.h"
#import "Utils.h"

@implementation UIColor (JJColor)

+ (UIColor *)JJRedColor
{
  // rgb = 255, 80, 0
  return [Utils hexToUIColor:@"FF5000"];
}

+ (UIColor *)JJDarkGrayColor
{
  // rgb = 60, 60, 60
  return [Utils hexToUIColor:@"3C3C3C"];
}

+ (UIColor *)JJGrayColor
{
  // rgb = 130, 130, 130
  return [Utils hexToUIColor:@"828282"];
}

+ (UIColor *)JJLightGrayColor
{
  // rgb = 190, 190, 190
  return [Utils hexToUIColor:@"BEBEBE"];
}

+ (UIColor *)JJLightestGrayColor
{
  // rgb = 204, 204, 204
  return [Utils hexToUIColor:@"CCCCCC"];
}

+ (UIColor *)JJDarkBlueColor
{
  // rgb = 25, 50, 90
  return [Utils hexToUIColor:@"19325A"];
}

+ (UIColor *)JJBlueColor
{
  // rgb = 0, 135, 205
  return [Utils hexToUIColor:@"0087CD"];
}

+ (UIColor *)JJLightBlueColor
{
  // rgb = 105, 200, 250
  return [Utils hexToUIColor:@"69C8FA"];
}

+ (UIColor *)JJGreenColor
{
  // rgby = 140, 185, 65
  return [Utils hexToUIColor:@"8CB941"];
}




@end