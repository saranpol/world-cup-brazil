//
//  ViewPredict.h
//  world-cup-brazil
//
//  Created by saranpol on 6/3/2557 BE.
//  Copyright (c) 2557 hlpth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"

@interface ViewPredict : GAITrackedViewController

@property (nonatomic, strong) NSDictionary *mDictMatch;
@property (nonatomic, weak) IBOutlet UIImageView *mImageT1;
@property (nonatomic, weak) IBOutlet UIImageView *mImageT2;
@property (nonatomic, weak) IBOutlet UIImageView *mImage1;
@property (nonatomic, weak) IBOutlet UIImageView *mImage2;
@property (nonatomic, weak) IBOutlet UIImageView *mImageAnimal;
@property (nonatomic, weak) IBOutlet UIImageView *mImageAnimal2;
@property (nonatomic, weak) IBOutlet UIView *mViewContent;
@property (nonatomic, weak) IBOutlet UILabel *mT1;
@property (nonatomic, weak) IBOutlet UILabel *mT2;
@property (nonatomic, weak) IBOutlet UILabel *mDetailApp;
@property (nonatomic, weak) IBOutlet UILabel *mDetailApp2;
@property (nonatomic, weak) IBOutlet UILabel *mTime;
@property (nonatomic, assign) NSInteger mCountLR;
@property (nonatomic, weak) IBOutlet UIScrollView *mScrollView;



- (IBAction)clickBack:(id)sender;

@end
