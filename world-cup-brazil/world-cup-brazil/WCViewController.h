//
//  WCViewController.h
//  world-cup-brazil
//
//  Created by saranpol on 5/14/2557 BE.
//  Copyright (c) 2557 hlpth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *mTable;
@property (nonatomic, strong) NSArray *mArrayData;
@property (nonatomic, strong) UIRefreshControl *mRefreshControl;

- (IBAction)clickEndOfLine:(id)sender;
- (void)updateData;

@end
