//
//  CellVS.h
//  world-cup-brazil
//
//  Created by saranpol on 5/14/2557 BE.
//  Copyright (c) 2557 hlpth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellVS : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *mLabelTime;
@property (nonatomic, weak) IBOutlet UILabel *mLabelT1;
@property (nonatomic, weak) IBOutlet UILabel *mLabelT2;
@property (nonatomic, weak) IBOutlet UISwitch *mSwitch;
@property (nonatomic, strong) NSDate *mDate;
@property (nonatomic, strong) NSNumber *mMatch;

- (IBAction)clickSwitch:(id)sender;
- (void)updateSwitchStatus;
@end
