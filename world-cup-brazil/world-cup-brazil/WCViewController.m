//
//  WCViewController.m
//  world-cup-brazil
//
//  Created by saranpol on 5/14/2557 BE.
//  Copyright (c) 2557 hlpth. All rights reserved.
//

#import "WCViewController.h"
#import "API.h"
#import "CellVS.h"
#import "GADBannerView.h"
#import "ViewUtil.h"
#import "ViewTeamSchedule.h"
#import "ViewPredict.h"

@implementation WCViewController

@synthesize mTable;
@synthesize mArrayData;
@synthesize mRefreshControl;
@synthesize mArrayGroupData;
@synthesize mDicGroupData;
@synthesize mViewPicker;
@synthesize mDatePickerView;
@synthesize mViewTeamSchedule;


- (void)viewDidLoad
{
    [super viewDidLoad];
    API *a = [API getAPI];
    a.mVC = self;
    
    [self setUpDatePicker];

    self.mRefreshControl = [[UIRefreshControl alloc] init];
    [mRefreshControl addTarget:self action:@selector(updateData:) forControlEvents:UIControlEventValueChanged];
    [mRefreshControl setTintColor:[UIColor whiteColor]];
    [mTable addSubview:mRefreshControl];
    
    NSDictionary *json = [a getObject:M_TABLE];
    if(json){
        self.mArrayData = [json objectForKey:@"data"];
//        NSLog(@"mArrayData %@",mArrayData);
        [mTable reloadData];
    }
    
    [self updateData];
    
    // setup admob
    // Create a view of the standard size at the top of the screen.
    // Available AdSize constants are explained in GADAdSize.h.
    GADBannerView *ad;
    if(IS_IPAD){
        ad = [[GADBannerView alloc] initWithAdSize:kGADAdSizeLeaderboard];
        ad.adUnitID = @"a15372b61e2b31f";
        [ViewUtil setFrame:ad x:20 y:1024-90];
    }else{
        ad = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
        ad.adUnitID = @"a15372b59d3f15b";
        [ViewUtil setFrame:ad y:self.view.frame.size.height-50];
    }
    

    ad.rootViewController = self;
    [self.view addSubview:ad];
    GADRequest *request = [GADRequest request];
//    request.testDevices = @[ GAD_SIMULATOR_ID ];
    [ad loadRequest:request];

    
}

- (void)setUpDatePicker {
    mIsShowPicker = NO;
    [mDatePickerView setCountDownDuration:15*60];
}

- (void)updateData {
    [self updateData:mRefreshControl];
}




- (void)updateData:(UIRefreshControl *)refreshControl {
    API *a = [API getAPI];
    [a api_get_table:^(id JSON){
        NSDictionary *json = (NSDictionary*)JSON;
        if(json){
            self.mArrayData = [json objectForKey:@"data"];
            NSMutableArray *aryData = [[NSMutableArray alloc]init];
            aryData = [json objectForKey:@"data"];
            
            
            NSMutableArray *newAry = [[NSMutableArray alloc]init];
            NSMutableDictionary *newDic = [[NSMutableDictionary alloc]init];

            for (NSDictionary *d in aryData) {
                NSString *sTime = [d objectForKey:@"time"];
                NSString *sConvertTime = [self getTime:sTime];

                BOOL iSAdd = NO;
                for (NSString * s in newAry) {
                    if ([s isEqualToString:sConvertTime])
                        iSAdd = YES;
                }
                
                if (!iSAdd) {
                    [newAry addObject:sConvertTime];
                    // save dic
                    [newDic setObject:[NSMutableArray array] forKey:sConvertTime];
                }
            }
            
            self.mArrayGroupData = newAry;
            
            for (NSDictionary *d in aryData) {
                NSString *sTime = [d objectForKey:@"time"];
                NSString *sConvertTime = [self getTime:sTime];
                NSMutableArray *tempAry = [newDic objectForKey:sConvertTime];
                [tempAry addObject:d];
            }
            
            self.mDicGroupData = newDic;
//            NSLog(@"mDicGroupData %@",mDicGroupData);


            [mTable reloadData];
            [a saveObject:json forKey:M_TABLE];
            
            [refreshControl endRefreshing];

        }
    }failure:^(NSError *failure){
        [refreshControl endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSString *s = [mArrayGroupData objectAtIndex:section];
    
    NSArray *ary = [mDicGroupData objectForKey:s];
    return (ary) ? [ary count] : 0;
    
//    return (mArrayData) ? [mArrayData count] : 0;
}


- (NSString*)getTime:(NSString*)time {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
    [df setDateFormat:@"yyyy-MM-dd'T'HH:mmZZZZ"];
    NSDate *date = [df dateFromString:time];
    [df setTimeZone:[NSTimeZone localTimeZone]];
    [df setLocale:[NSLocale currentLocale]];
    [df setDateFormat:@"d MMM YYYY"];
    return [df stringFromDate:date];
}

- (NSString*)getTimeShow:(NSString*)time cell:(CellVS*)cell {
//
//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//    [dateFormat setDateFormat:@"HH:mm"];
//    NSLog(@"mDatePickerView %@", [dateFormat stringFromDate:mDatePickerView.date]);
    
    
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
    [df setDateFormat:@"yyyy-MM-dd'T'HH:mmZZZZ"];
    NSDate *date = [df dateFromString:time];
    cell.mDate = [date dateByAddingTimeInterval:-15*60]; // 15 Minutes before
    
    [df setTimeZone:[NSTimeZone localTimeZone]];
    [df setLocale:[NSLocale currentLocale]];
//    [df setDateFormat:@"EEE d MMM - HH:mm"];
//    [df setDateFormat:@"HH:mm"];
    [df setDateFormat:@"HH:mm"];

    return [df stringFromDate:date];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellVS *cell = [tableView dequeueReusableCellWithIdentifier:@"CellVS" forIndexPath:indexPath];
    
    NSString *s = [mArrayGroupData objectAtIndex:indexPath.section];
    NSArray *ary = [mDicGroupData objectForKey:s];
    NSDictionary *d = [ary objectAtIndex:indexPath.row];

    
//    NSDictionary *d = [mArrayData objectAtIndex:indexPath.row];
    
    [cell setDelegate:self];
    [cell.mLabelT1 setText:[[d objectForKey:@"t1"] capitalizedString]];
    [cell.mLabelT2 setText:[[d objectForKey:@"t2"] capitalizedString]];
    
    
    NSRange range = [[d objectForKey:@"t1"] rangeOfString:@"["];
    if (range.location != NSNotFound)
    {
        [cell.mButtonT1 setImage:[UIImage imageNamed:@"Unknown.png"] forState:UIControlStateNormal];
    }else {
        [cell.mButtonT1 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[[d objectForKey:@"t1"] capitalizedString]]] forState:UIControlStateNormal];
    }
    
    NSRange range2 = [[d objectForKey:@"t2"] rangeOfString:@"["];
    if (range2.location != NSNotFound)
    {
        [cell.mButtonT2 setImage:[UIImage imageNamed:@"Unknown.png"] forState:UIControlStateNormal];
    }else {
        [cell.mButtonT2 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[[d objectForKey:@"t2"] capitalizedString]]] forState:UIControlStateNormal];
    }

    NSInteger m = [[d objectForKey:@"m"] integerValue];
    [cell.mButtonT1 setTag:m];
    [cell.mButtonT2 setTag:m];
    [cell.mButtonPredict setTag:m];
    
    [cell.mLabelTime setText:[self getTimeShow:[d objectForKey:@"time"] cell:cell]];
    cell.mMatch = [d objectForKey:@"m"];
    [cell updateSwitchStatus];
    
    [cell setBackgroundColor:[UIColor colorWithRed:81.0/255.0 green:140.0/255.0 blue:20.0/255.0 alpha:1.0]];
    return cell;
}

-(BOOL) isiPad{
    BOOL iPad = NO;
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
        iPad = YES;
    return iPad;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    int xLabel = 0;
    int yLabel = 0;
    int hLabel = 0;
    int sizeFont = 0;
    int xLine = 0;
    int yLine = 0;
    int xDot = 0;
    int yDot = 0;
    if ([self isiPad])
    {
        xLabel = 70;
        yLabel = 10;
        hLabel = 25;
        sizeFont = 15;
        xLine = 30;
        yLine = 0;
        xDot = 27;
        yDot = 15;
        
    }else {
        xLabel = 38;
        yLabel = 10;
        hLabel = 18;
        sizeFont = 12;
        xLine = 15;
        yLine = 0;
        xDot = 12;
        yDot = 15;
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 38)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(xLabel, yLabel, tableView.frame.size.width, 18)];
    [label setFont:[UIFont fontWithName:@"Open Sans" size:sizeFont]];
    [label setTextColor:[UIColor colorWithRed:80/255.0 green:77/255.0 blue:77/255.0 alpha:1.0]];
    
    
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(xLine, yLine, 2, 38)];
    [viewLine setBackgroundColor:[UIColor colorWithRed:189/255.0 green:195/255.0 blue:198/255.0 alpha:1.0]];
    [view addSubview:viewLine];
    
    UIImage * myImage = [UIImage imageNamed: @"dot.png"];
    UIImageView *imageDot = [[UIImageView alloc] initWithImage:myImage];
    [imageDot setFrame:CGRectMake(xDot, yDot, 8, 8)];
    [view addSubview:imageDot];


    
    NSString *string =[mArrayGroupData objectAtIndex:section];
    [label setText:string];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor colorWithRed:231/255.0 green:236/255.0 blue:240/255.0 alpha:1.0]]; //your background color...
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [mArrayGroupData count];
}


- (IBAction)clickEndOfLine:(id)sender {
    API *a = [API getAPI];
    [a gotoEndOfLine];
}



- (IBAction)clickDone:(id)sender {
    [self hidePicker];
    
    
//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//    [dateFormat setDateFormat:@"dd/mm/yyyy HH:mm"];
//    [dateFormat stringFromDate:mDatePickerView.countDownDuration];
//    NSLog(@"mDatePickerView %@", [dateFormat stringFromDate:mDatePickerView.date]);
//
//    // set noti
//    mCountDownTimer = [[dateFormat stringFromDate:mDatePickerView.date] intValue];
//    NSLog(@"mCountDownTimer %f", mDatePickerView.countDownDuration);
    
    API *a = [API getAPI];
    a.mDate = [a.mDate dateByAddingTimeInterval:mDatePickerView.countDownDuration];
    
    [self setNotification];

}


- (void)didShowDatePicker {
    if (!mIsShowPicker) {
        [self showPicker];
    }
}

- (void)didHideDatePicker {
    if (mIsShowPicker) {
        [self hidePicker];
    }
}

-(void)showPicker {
    
//    [mDatePickerView setHidden:YES];
//    [mDatePickerView setHidden:NO];
    
//    if (mIsShowPicker)
//        return
    

    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [ViewUtil setOriginY:mViewPicker y:64];
                     }
                     completion:^(BOOL isFinish) {
//                         mIsShowPicker = YES;
                     }];
}

-(void)hidePicker {
    //    [ViewUtil setOriginY:mViewPicker y:428];
    
    int y = 568;
    if ([self isiPad])
        y = 1023;
        
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [ViewUtil setOriginY:mViewPicker y:y];
                     }
                     completion:^(BOOL isFinish) {
//                         mIsShowPicker = NO;
                     }];
}

-(void)setNotification {
    API *a = [API getAPI];

    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = a.mDate;
    
    int minutes = mDatePickerView.countDownDuration/60;
//    NSString *timeCountDown = [NSString stringWithFormat:@"%f", mDatePickerView.countDownDuration/60];

    
    NSString *alert = @"";
    if (minutes > 59) {
        int min = ceil(minutes/60);
        alert = [NSString stringWithFormat:@"%@ VS %@ will start in %d hours %d minutes", a.mTeam1, a.mTeam2 , minutes/60 , min];
    }else {
        alert = [NSString stringWithFormat:@"%@ VS %@ will start in %d minutes", a.mTeam1, a.mTeam2 , minutes];
    }
    
    [NSString stringWithFormat:@"%@ VS %@ will start in %d minutes", a.mTeam1, a.mTeam2 , minutes];
    notification.alertBody = alert;
    notification.soundName = UILocalNotificationDefaultSoundName;
    notification.userInfo = @{@"match":a.mMatch};
    notification.applicationIconBadgeNumber = 1;
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    NSLog(@"%@ %@", a.mDate, alert);
    
    
    
    NSString *message_alert = @"";
    if (minutes > 59) {
        int min = minutes%60;
        message_alert = [NSString stringWithFormat:@"will remind before match %d hours %d minutes", minutes/60 , min];
    }else {
        message_alert = [NSString stringWithFormat:@"will remind before match %d minutes" , minutes];
    }
    
    
    UIAlertView *x = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@ VS %@", a.mTeam1, a.mTeam2 ]
                                                message:message_alert
                                               delegate:nil
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
    [x show];
}


- (UILocalNotification*)getNoti {
    for(UILocalNotification *n in [[UIApplication sharedApplication] scheduledLocalNotifications]){
        NSNumber *m = [n.userInfo objectForKey:@"match"];
        API *a = [API getAPI];
        if (m && [m isEqualToNumber:a.mMatch]) {
            return n;
        }
    }
    return nil;
}


- (void)didGotoViewTeamSchedule:(NSString*)team {
    NSLog(@"%@",team);
    
    if (!mViewTeamSchedule)
        self.mViewTeamSchedule =  [[ViewTeamSchedule alloc] initWithNibName:@"ViewTeamSchedule" bundle:nil];    
    [self.navigationController pushViewController:mViewTeamSchedule animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"GotoViewTeam1"]){
        ViewTeamSchedule *v = [segue destinationViewController];
        UIButton *b = (UIButton*)sender;
        NSDictionary *d = [mArrayData objectAtIndex:b.tag-1];
        NSString *t1 = [d objectForKey:@"t1"];
        v.mInterestTeam = t1;
        [v setDelegate:self];
        
    } else if ([[segue identifier] isEqualToString:@"GotoViewTeam2"]) {
        ViewTeamSchedule *v = [segue destinationViewController];
        UIButton *b = (UIButton*)sender;
        NSDictionary *d = [mArrayData objectAtIndex:b.tag-1];
        NSString *t2 = [d objectForKey:@"t2"];
        v.mInterestTeam = t2;
        [v setDelegate:self];
        
    } else if ([[segue identifier] isEqualToString:@"GotoViewPredict"]) {
        ViewPredict *v = [segue destinationViewController];
        UIButton *b = (UIButton*)sender;
        NSDictionary *d = [mArrayData objectAtIndex:b.tag-1];
        v.mDictMatch = d;
        
    }

}

- (void)didReloadViewMain {
    [mTable reloadData];
}



@end
