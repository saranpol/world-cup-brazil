//
//  CellVS.h
//  world-cup-brazil
//
//  Created by saranpol on 5/14/2557 BE.
//  Copyright (c) 2557 hlpth. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CellVSDelegate <NSObject>
@optional
- (void)didShowDatePicker;
- (void)didHideDatePicker;

//- (void)didSetNotification:(NSNumber*)match date:(NSData*)date team1:(NSString*)team1 team2:(NSString*)team2;
//- (void)didCancelNotification;

@end


@interface CellVS : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *mLabelTime;
@property (nonatomic, weak) IBOutlet UILabel *mLabelT1;
@property (nonatomic, weak) IBOutlet UILabel *mLabelT2;
@property (nonatomic, weak) IBOutlet UISwitch *mSwitch;
@property (nonatomic, weak) IBOutlet UIImageView *mImageViewT1;
@property (nonatomic, weak) IBOutlet UIImageView *mImageViewT2;
@property (nonatomic, strong) NSDate *mDate;
@property (nonatomic, strong) NSNumber *mMatch;
@property (strong, nonatomic) id<CellVSDelegate> mDelegate;


- (IBAction)clickSwitch:(id)sender;
- (void)updateSwitchStatus;
- (void)setDelegate:(id)delegate;

@end
