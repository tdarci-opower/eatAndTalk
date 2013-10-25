//
//  EATLunchCell.m
//  eatAndTalk
//
//  Created by Tom Darci on 10/25/13.
//  Copyright (c) 2013 Opower. All rights reserved.
//

#import "EATLunchCell.h"

static NSString * const kNibName = @"EATLunchCell";
static NSString * const kReuseIdentifier = @"EATLunchCell";

@implementation EATLunchCell

#pragma mark - object lifecycle

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - properties
-(NSString *)reuseIdentifier
{
  return [[self class]reuseIdentifier];
}


#pragma mark - view lifecycle

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - class methods

+(EATLunchCell *) createLunchCell
{
  NSArray * nibContents = [[NSBundle mainBundle] loadNibNamed:kNibName owner:self options:nil];
  if (nibContents && nibContents[0] && [nibContents[0] isKindOfClass:[EATLunchCell class]]) {
    EATLunchCell * cell = (EATLunchCell *) nibContents[0];
    return cell;
  }
  return nil;
}

+(NSString *) reuseIdentifier
{
  return kReuseIdentifier;
}

@end
