//
//  EATLunchCell.h
//  eatAndTalk
//
//  Created by Tom Darci on 10/25/13.
//  Copyright (c) 2013 Opower. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EATLunchCell : UITableViewCell
+(EATLunchCell *) createLunchCell;
+(NSString *) reuseIdentifier;
@end
