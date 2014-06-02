//
//  ViewTeamSchedule.h
//  world-cup-brazil
//
//  Created by saranpol on 5/14/2557 BE.
//  Copyright (c) 2557 hlpth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableViewNoDelay.h"
#import "CellVS.h"

@interface ViewTeamSchedule : UIViewController <UITableViewDataSource, UITableViewDelegate, CellVSDelegate> {
    BOOL mIsShowPicker;
    int mCountDownTimer;
}

@property (nonatomic, weak) IBOutlet UILabel *mTitle;
@property (nonatomic, weak) IBOutlet UITableViewNoDelay *mTable;
@property (nonatomic, strong) NSArray *mArrayData;
@property (nonatomic, strong) UIRefreshControl *mRefreshControl;
@property (nonatomic, strong) NSArray *mArrayGroupData;
@property (nonatomic, strong) NSDictionary *mDicGroupData;
@property (nonatomic, strong) NSString *mInterestTeam;
@property (nonatomic, weak) IBOutlet UIView *mViewPicker;
@property (nonatomic, weak) IBOutlet UIDatePicker *mDatePickerView;

- (IBAction)clickDone:(id)sender;
- (IBAction)clickFlipBack:(id)sender;

//- (IBAction)clickEndOfLine:(id)sender;
- (void)updateData;
- (void)showPicker;
- (void)hidePicker;

@end
