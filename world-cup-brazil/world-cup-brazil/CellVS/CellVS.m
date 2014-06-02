//
//  CellVS.m
//  world-cup-brazil
//
//  Created by saranpol on 5/14/2557 BE.
//  Copyright (c) 2557 hlpth. All rights reserved.
//

#import "CellVS.h"
#import "WCViewController.h"
#import "API.h"

@implementation CellVS

@synthesize mLabelTime;
@synthesize mLabelT1;
@synthesize mLabelT2;
@synthesize mButtonT1;
@synthesize mButtonT2;
@synthesize mButtonPredict;
@synthesize mSwitch;
@synthesize mDate;
@synthesize mMatch;
@synthesize mDelegate;


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
    [mSwitch setOnTintColor:[UIColor colorWithRed:0/255.0f green:146/255.0f blue:62/255.0f alpha:1.0]];
//    [mSwitch setTintColor:[UIColor colorWithRed:173/255.0f green:178/255.0f blue:176/255.0f alpha:1.0]];
    [mSwitch setTintColor:[UIColor colorWithWhite:0.9 alpha:1.0]];

    int fontSize = 10;
    if ([self isiPad])
        fontSize = 14;
    
    [mLabelTime setFont:[UIFont fontWithName:@"Open Sans" size:fontSize]];
    [mLabelT1 setFont:[self getFont]];
    [mLabelT2 setFont:[self getFont]];

}

-(UIFont *)getFont
{
    int fontSize = 14;
    if ([self isiPad])
        fontSize = 18;

    UIFont *font = [UIFont fontWithName:@"Open Sans" size:fontSize];
    return font;
}

-(BOOL) isiPad{
    BOOL isiPad = NO;
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
        isiPad = YES;
    
    return isiPad;
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

- (void)setDelegate:(id)delegate {
    self.mDelegate = delegate;
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
        
        if (mDelegate)
            [self.mDelegate didShowDatePicker];

        
        API *a = [API getAPI];
        a.mMatch = mMatch;
        a.mDate = mDate;
        a.mTeam1 = mLabelT1.text;
        a.mTeam2 = mLabelT2.text;
        
//        UILocalNotification *notification = [[UILocalNotification alloc] init];
//        notification.fireDate = mDate;
//        
//        NSString *alert = [NSString stringWithFormat:@"%@ VS %@ will start in 15 minutes", mLabelT1.text, mLabelT2.text];
//        notification.alertBody = alert;
//        notification.soundName = UILocalNotificationDefaultSoundName;
//        notification.userInfo = @{@"match":mMatch};
//        notification.applicationIconBadgeNumber = 1;
//        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
//        NSLog(@"%@ %@", mDate, alert);
//        UIAlertView *x = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@ VS %@", mLabelT1.text, mLabelT2.text]
//                                                        message:@"will remind before match 15 minutes"
//                                                       delegate:nil
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil];
//        [x show];
    }else{
        UILocalNotification *n = [self getNoti];
        if(n){
            [[UIApplication sharedApplication] cancelLocalNotification:n];
            NSLog(@"cancel %@", n);
        }
        
        if (mDelegate)
            [self.mDelegate didHideDatePicker];
        
    }
}


- (IBAction)clickTeam1:(id)sender {
    if (mDelegate)
        [self.mDelegate didGotoViewTeamSchedule:mLabelT1.text];
}


- (IBAction)clickTeam2:(id)sender {
    if (mDelegate)
        [self.mDelegate didGotoViewTeamSchedule:mLabelT2.text];
}


@end


















