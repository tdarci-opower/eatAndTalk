#import "UIGradientButton.h"
#import "JabberJawColors.h"

static NSArray *s_normalLocations = nil;
static NSArray *s_normalColors = nil;
static NSArray *s_highlightColors = nil;
static UIColor *s_normalStrokeColor = nil;
static UIColor *s_highlightStrokeColor = nil;

@implementation UIGradientButton

+ (void)initialize
{
  // Defaults to blue color scheme
  UIColor *normalGradStart = [UIColor JJLightBlueColor];
  UIColor *normalGradEnd = [UIColor JJBlueColor];
  UIColor *normalStroke = [UIColor JJBlueColor];
  UIColor *highlightGradStart = [UIColor JJBlueColor];
  UIColor *highlightGradEnd = [UIColor JJBlueColor];
  UIColor *highlightStroke = [UIColor JJDarkBlueColor];
  
  s_normalLocations = [NSArray arrayWithObjects:
                       [NSNumber numberWithFloat: 0.0],
                       [NSNumber numberWithFloat: 1.0],
                       nil];

  s_normalColors = [NSArray arrayWithObjects:
                    (id)[normalGradStart CGColor],
                    (id)[normalGradEnd CGColor],
                    nil];
  
  
  s_highlightColors = [NSArray arrayWithObjects:
                        (id)[highlightGradStart CGColor],
                        (id)[highlightGradEnd CGColor],
                        nil];
  
  s_normalStrokeColor = normalStroke;
  s_highlightStrokeColor = highlightStroke;
}

- (void)setGrayColorScheme
{
  UIColor *normalGradStart = [UIColor whiteColor];
  UIColor *normalGradEnd = [UIColor JJLightGrayColor];
  UIColor *highlightGradStart = [UIColor JJGrayColor];
  UIColor *highlightGradEnd = [UIColor JJGrayColor];
  UIColor *normalStroke = [UIColor JJLightGrayColor];
  UIColor *highlightStroke = [UIColor JJDarkGrayColor];
  
  NSArray *normalColors = [NSArray arrayWithObjects:
                     (id)[normalGradStart CGColor],
                     (id)[normalGradEnd CGColor],
                     nil];
  
  NSArray *highlightColors = [NSArray arrayWithObjects:
                        (id)[highlightGradStart CGColor],
                        (id)[highlightGradEnd CGColor],
                        nil];
  
  [self setColors:normalColors forState:UIControlStateNormal];
  [self setColors:highlightColors forState:UIControlStateHighlighted]; 
  [self setStrokeColor:normalStroke forState:UIControlStateNormal]; 
  [self setStrokeColor:highlightStroke forState:UIControlStateHighlighted];
  
  
}

- (void)awakeFromNib
{
  _statesToLocations = [[NSMutableDictionary alloc] init];
  _statesToColors = [[NSMutableDictionary alloc] init];
  _statesToStrokes = [[NSMutableDictionary alloc] init];
  
  _gradientLayer = [[CAGradientLayer alloc] init];
  [_gradientLayer setBounds: self.bounds];
  [_gradientLayer setPosition:
    CGPointMake(self.bounds.size.width / 2,
                self.bounds.size.height / 2)];
  [_gradientLayer setCornerRadius:8.0f];
  [_gradientLayer setMasksToBounds: YES];
  
  [self.layer insertSublayer: _gradientLayer atIndex: 0];
  [self.layer setCornerRadius: 8.0f];
  [self.layer setMasksToBounds: NO];
  [self.layer setBorderWidth: 1.0f];
  self.layer.shadowColor = [UIColor blackColor].CGColor;
  self.layer.shadowOpacity = 0.35f;
  self.layer.shadowRadius = 2.0f;
  self.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);

  [_statesToLocations setObject:s_normalLocations forKey:[NSNumber numberWithInt:UIControlStateNormal]];
  [_statesToColors setObject:s_normalColors forKey:[NSNumber numberWithInt:UIControlStateNormal]];
  [_statesToColors setObject:s_highlightColors forKey:[NSNumber numberWithInt:UIControlStateHighlighted]];
  [_statesToStrokes setObject:s_normalStrokeColor forKey:[NSNumber numberWithInt:UIControlStateNormal]];
  [_statesToStrokes setObject:s_highlightStrokeColor forKey:[NSNumber numberWithInt:UIControlStateHighlighted]];

}

- (NSArray*) getLocationsForState: (UIControlState) state {
  NSArray* locations = (NSArray*) [_statesToLocations objectForKey: [NSNumber numberWithInteger: state]];
  if (locations == nil) {
    locations = (NSArray*) [_statesToLocations objectForKey: [NSNumber numberWithInt: UIControlStateNormal]];
  }
  return locations;
}

- (NSArray*) getColorsForState: (UIControlState) state {
  NSArray* colors = (NSArray*) [_statesToColors objectForKey: [NSNumber numberWithInteger: state]];
  if (colors == nil) {
    colors = (NSArray*) [_statesToColors objectForKey: [NSNumber numberWithInt: UIControlStateNormal]];
  }
  return colors;
}

- (UIColor*) getStrokeForState: (UIControlState) state {
  UIColor* color = (UIColor*) [_statesToStrokes objectForKey: [NSNumber numberWithInteger: state]];
  if (color == nil) {
    color = (UIColor*) [_statesToStrokes objectForKey: [NSNumber numberWithInt: UIControlStateNormal]];
  }
  return color;
}

- (void)drawRect:(CGRect)rect;
{
  NSArray* locations = [self getLocationsForState: self.state];
  NSArray* colors = [self getColorsForState: self.state];
  UIColor* strokeColor = [self getStrokeForState: self.state];
  
  if (locations && colors)
  {
    [_gradientLayer setColors: colors];
    [_gradientLayer setLocations: locations];
  }
  if(strokeColor) {
    [self.layer setBorderColor:[strokeColor CGColor]];
  }
  
  if(self.state == UIControlStateHighlighted) {
    self.layer.shadowRadius = 0.0f;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
  } else {
    self.layer.shadowRadius = 2.0f;
    self.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
  }
  
  [super drawRect:rect];
}

- (void) setLocations: (NSArray*)locations forState: (UIControlState)state {
  [_statesToLocations setObject: locations forKey: [NSNumber numberWithInt: state]];
  [_gradientLayer setNeedsDisplay];
}

- (void) setColors: (NSArray*)colors forState: (UIControlState)state {
  [_statesToColors setObject: colors forKey: [NSNumber numberWithInt: state]];
  [_gradientLayer setNeedsDisplay];
}

- (void) setStrokeColor: (UIColor*)color forState: (UIControlState)state {
  [_statesToStrokes setObject: color forKey: [NSNumber numberWithInt: state]];
  [_gradientLayer setNeedsDisplay];
}


- (void)setHighlighted:(BOOL)highlighted {
  [super setHighlighted:highlighted];
  [self setNeedsDisplay];
}

- (void)setEnabled:(BOOL)enabled {
  [super setEnabled: enabled];
  [self setNeedsDisplay];
}

- (void) setSelected:(BOOL)selected {
  [super setSelected:selected];
  [self setNeedsDisplay];
}



@end
