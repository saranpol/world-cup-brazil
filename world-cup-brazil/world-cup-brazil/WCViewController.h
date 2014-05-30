//
//  WCViewController.h
//  world-cup-brazil
//
//  Created by saranpol on 5/14/2557 BE.
//  Copyright (c) 2557 hlpth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableViewNoDelay.h"

@interface WCViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableViewNoDelay *mTable;
@property (nonatomic, strong) NSArray *mArrayData;
@property (nonatomic, strong) UIRefreshControl *mRefreshControl;
@property (nonatomic, strong) NSArray *mArrayGroupData;
@property (nonatomic, strong) NSDictionary *mDicGroupData;


- (IBAction)clickEndOfLine:(id)sender;
- (void)updateData;

@end
