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

- (void)viewDidLoad
{
    [super viewDidLoad];
    API *a = [API getAPI];
    a.mVC = self;

    self.mRefreshControl = [[UIRefreshControl alloc] init];
    [mRefreshControl addTarget:self action:@selector(updateData:) forControlEvents:UIControlEventValueChanged];
    [mTable addSubview:mRefreshControl];
    
    NSDictionary *json = [a getObject:M_TABLE];
    if(json){
        self.mArrayData = [json objectForKey:@"data"];
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
        [refreshControl endRefreshing];
        NSDictionary *json = (NSDictionary*)JSON;
        if(json){
            self.mArrayData = [json objectForKey:@"data"];
            [mTable reloadData];
            [a saveObject:json forKey:M_TABLE];
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
    return (mArrayData) ? [mArrayData count] : 0;
}


- (NSString*)getTimeShow:(NSString*)time cell:(CellVS*)cell {

    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
    [df setDateFormat:@"yyyy-MM-dd'T'HH:mmZZZZ"];
    NSDate *date = [df dateFromString:time];
    cell.mDate = [date dateByAddingTimeInterval:-15*60]; // 15 Minutes before
    
    [df setTimeZone:[NSTimeZone localTimeZone]];
    [df setLocale:[NSLocale currentLocale]];
    [df setDateFormat:@"EEE d MMM - HH:mm"];
    return [df stringFromDate:date];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellVS *cell = [tableView dequeueReusableCellWithIdentifier:@"CellVS" forIndexPath:indexPath];

    NSDictionary *d = [mArrayData objectAtIndex:indexPath.row];
    [cell.mLabelT1 setText:[d objectForKey:@"t1"]];
    [cell.mLabelT2 setText:[d objectForKey:@"t2"]];
    [cell.mLabelTime setText:[self getTimeShow:[d objectForKey:@"time"] cell:cell]];
    cell.mMatch = [d objectForKey:@"m"];
    [cell updateSwitchStatus];
    
    [cell setBackgroundColor:[UIColor colorWithRed:81.0/255.0 green:140.0/255.0 blue:20.0/255.0 alpha:1.0]];
    return cell;
}

- (IBAction)clickEndOfLine:(id)sender {
    API *a = [API getAPI];
    [a gotoEndOfLine];
}

@end
