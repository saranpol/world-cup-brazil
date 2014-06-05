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

- (void)didGotoViewTeamSchedule:(NSString*)team;


@end


@interface CellVS : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *mLabelTime;
@property (nonatomic, weak) IBOutlet UILabel *mLabelT1;
@property (nonatomic, weak) IBOutlet UILabel *mLabelT2;
@property (nonatomic, weak) IBOutlet UISwitch *mSwitch;
@property (nonatomic, weak) IBOutlet UIButton *mButtonT1;
@property (nonatomic, weak) IBOutlet UIButton *mButtonT2;
@property (nonatomic, weak) IBOutlet UIButton *mButtonPredict;
@property (nonatomic, weak) IBOutlet UIImageView *mImagePredict;

@property (nonatomic, weak) IBOutlet UIView *mContentView;
@property (nonatomic, strong) NSDate *mDate;
@property (nonatomic, strong) NSNumber *mMatch;
@property (strong, nonatomic) id<CellVSDelegate> mDelegate;


- (IBAction)clickSwitch:(id)sender;
- (IBAction)clickTeam1:(id)sender;
- (IBAction)clickTeam2:(id)sender;

- (void)updateSwitchStatus;
- (void)setDelegate:(id)delegate;

@end
