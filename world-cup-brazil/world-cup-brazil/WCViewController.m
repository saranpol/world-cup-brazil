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

@implementation WCViewController

@synthesize mTable;
@synthesize mArrayData;
@synthesize mRefreshControl;
@synthesize mArrayGroupData;
@synthesize mDicGroupData;

- (void)viewDidLoad
{
    [super viewDidLoad];
    API *a = [API getAPI];
    a.mVC = self;

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
    
    [cell.mLabelT1 setText:[[d objectForKey:@"t1"] capitalizedString]];
    [cell.mLabelT2 setText:[[d objectForKey:@"t2"] capitalizedString]];
    
    
    NSRange range = [[d objectForKey:@"t1"] rangeOfString:@"["];
    if (range.location != NSNotFound)
    {
        [cell.mImageViewT1 setImage:[UIImage imageNamed:@"Unknown.png"]];
    }else {
        [cell.mImageViewT1 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[[d objectForKey:@"t1"] capitalizedString]]]];
    }
    
    NSRange range2 = [[d objectForKey:@"t2"] rangeOfString:@"["];
    if (range2.location != NSNotFound)
    {
        [cell.mImageViewT2 setImage:[UIImage imageNamed:@"Unknown.png"]];
    }else {
        [cell.mImageViewT2 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[[d objectForKey:@"t2"] capitalizedString]]]];
    }

    
    [cell.mLabelTime setText:[self getTimeShow:[d objectForKey:@"time"] cell:cell]];
    cell.mMatch = [d objectForKey:@"m"];
    [cell updateSwitchStatus];
    
    [cell setBackgroundColor:[UIColor colorWithRed:81.0/255.0 green:140.0/255.0 blue:20.0/255.0 alpha:1.0]];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 38)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(38, 10, tableView.frame.size.width, 18)];
    [label setFont:[UIFont fontWithName:@"Open Sans" size:12]];

    [label setTextColor:[UIColor colorWithRed:80/255.0 green:77/255.0 blue:77/255.0 alpha:1.0]];
    
    
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(15, 0, 2, 38)];
    [viewLine setBackgroundColor:[UIColor colorWithRed:189/255.0 green:195/255.0 blue:198/255.0 alpha:1.0]];
    [view addSubview:viewLine];
    
//    UIImageView *imageDot = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 8, 8)];
    UIImage * myImage = [UIImage imageNamed: @"dot.png"];
    UIImageView *imageDot = [[UIImageView alloc] initWithImage:myImage];
    [imageDot setFrame:CGRectMake(12, 15, 8, 8)];
    [view addSubview:imageDot];



    
    NSString *string =[mArrayGroupData objectAtIndex:section];
//    NSString *string =@"test";

    /* Section header is in 0th index... */
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

@end
