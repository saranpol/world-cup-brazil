//
//  CellVS.m
//  world-cup-brazil
//
//  Created by saranpol on 5/14/2557 BE.
//  Copyright (c) 2557 hlpth. All rights reserved.
//

#import "CellVS.h"

@implementation CellVS

@synthesize mLabelTime;
@synthesize mLabelT1;
@synthesize mLabelT2;
@synthesize mSwitch;
@synthesize mDate;
@synthesize mMatch;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UILocalNotification*)getNoti {
    for(UILocalNotification *n in [[UIApplication sharedApplication] scheduledLocalNotifications]){
        NSNumber *m = [n.userInfo objectForKey:@"match"];
        if (m && [m isEqualToNumber:mMatch]) {
            return n;
        }
    }
    return nil;
}

- (void)updateSwitchStatus {
    if([[NSDate date] compare:mDate] == NSOrderedDescending){
        [mSwitch setHidden:YES];
        return;
    }
    [mSwitch setHidden:NO];
    
    if([self getNoti])
        [mSwitch setOn:YES];
    else
        [mSwitch setOn:NO];
}

- (IBAction)clickSwitch:(id)sender {
    if([mSwitch isOn]){
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.fireDate = mDate;
        NSString *alert = [NSString stringWithFormat:@"%@ VS %@ will start in 15 minutes", mLabelT1.text, mLabelT2.text];
        notification.alertBody = alert;
        notification.soundName = UILocalNotificationDefaultSoundName;
        notification.userInfo = @{@"match":mMatch, @"message":alert};
        notification.applicationIconBadgeNumber = 1;
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        NSLog(@"%@ %@", mDate, alert);
        UIAlertView *x = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@ VS %@", mLabelT1.text, mLabelT2.text]
                                                        message:@"will remind before match 15 minutes"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [x show];
    }else{
        UILocalNotification *n = [self getNoti];
        if(n){
            [[UIApplication sharedApplication] cancelLocalNotification:n];
            NSLog(@"cancel %@", n);
        }
            
    }
}

@end
