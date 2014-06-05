//
//  ViewPredict.m
//  world-cup-brazil
//
//  Created by saranpol on 6/3/2557 BE.
//  Copyright (c) 2557 hlpth. All rights reserved.
//

#import "ViewPredict.h"
#import "ViewUtil.h"
#import "API.h"


@implementation ViewPredict

@synthesize mDictMatch;
@synthesize mImageT1;
@synthesize mImageT2;
@synthesize mImageAnimal;
@synthesize mViewContent;
@synthesize mCountLR;
@synthesize mT1;
@synthesize mT2;
@synthesize mDetailApp;
@synthesize mTime;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSRange range = [[mDictMatch objectForKey:@"t1"] rangeOfString:@"["];
    if (range.location != NSNotFound)
    {
        [mImageT1 setImage:[UIImage imageNamed:@"Unknown_l.png"]];
    }else {
        [mImageT1 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_l.png",[[mDictMatch objectForKey:@"t1"] capitalizedString]]]];
    }
    
    NSRange range2 = [[mDictMatch objectForKey:@"t2"] rangeOfString:@"["];
    if (range2.location != NSNotFound)
    {
        [mImageT2 setImage:[UIImage imageNamed:@"Unknown_l.png"]];
    }else {
        [mImageT2 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_l.png",[[mDictMatch objectForKey:@"t2"] capitalizedString]]]];
    }
    
    
    int fontSize = 14;
    int fontSize2 = 10;
    int fontSize3 = 12;

    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        fontSize = 25;
        fontSize2 = 16;
        fontSize3 = 18;
    }
    
    [mT1 setFont:[UIFont fontWithName:@"Open Sans" size:fontSize]];
    [mT2 setFont:[UIFont fontWithName:@"Open Sans" size:fontSize]];
    [mDetailApp setFont:[UIFont fontWithName:@"Open Sans" size:fontSize2]];
    [mTime setFont:[UIFont fontWithName:@"Open Sans" size:fontSize3]];



    [mT1 setText:[NSString stringWithFormat:@"%@", [[mDictMatch objectForKey:@"t1"] capitalizedString]]];
    [mT2 setText:[NSString stringWithFormat:@"%@", [[mDictMatch objectForKey:@"t2"] capitalizedString]]];
    
    
    
    NSString *sTime = [mDictMatch objectForKey:@"time"];
    NSString *sConvertTime = [self getTime:sTime];
    [mTime setText:sConvertTime];
    
    mTime.alpha = 0;
    mDetailApp.alpha = 0;
}

- (NSString*)getTime:(NSString*)time {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
    [df setDateFormat:@"yyyy-MM-dd'T'HH:mmZZZZ"];
    NSDate *date = [df dateFromString:time];
    [df setTimeZone:[NSTimeZone localTimeZone]];
    [df setLocale:[NSLocale currentLocale]];
    [df setDateFormat:@"d MMM YYYY HH:MM"];
    return [df stringFromDate:date];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self performSelector:@selector(animateLR) withObject:nil afterDelay:0.1];
}

- (void)animateLR {
        self.mCountLR++;
        mImageAnimal.transform = CGAffineTransformMake(mImageAnimal.transform.a * -1, 0, 0, 1, mImageAnimal.transform.tx, 0);
        NSNumber *winner = [mDictMatch objectForKey:@"winner"];
        if(mCountLR < 5+[winner integerValue])
            [self performSelector:@selector(animateLR) withObject:nil afterDelay:0.5];
        else{
            [self performSelector:@selector(animateNokFly) withObject:nil afterDelay:0.1];
            [self performSelector:@selector(animateAnimal) withObject:nil afterDelay:2.0];
        }

}



- (void)animateNokFly {
    NSArray *imageNames = @[@"macaw_2.png", @"macaw_3.png"];
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (int i = 0; i < imageNames.count; i++) {
        [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
    }
    
    mImageAnimal.animationImages = images;
    mImageAnimal.animationDuration = 0.7;
    [mImageAnimal startAnimating];
}

- (void)animateAnimal {
    NSNumber *winner = [mDictMatch objectForKey:@"winner"];

    [UIView animateWithDuration:2.0
                          delay:0.0
         usingSpringWithDamping:0.4
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         float y = mImageT1.frame.origin.y - 75;
                         if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
                            y = mImageT1.frame.origin.y - 152;
                         
                         
                         switch ([winner integerValue]) {
                             case 0:{ // Draw
                                 float x = (mImageT1.frame.origin.x + mImageT2.frame.origin.x)/2.0;
                                 [ViewUtil setFrame:mImageAnimal x:x y:y];
                                 break;
                             }
                             case 1:{ // T1
                                 [ViewUtil setFrame:mImageAnimal x:mImageT1.frame.origin.x y:y];
                                 break;
                             }
                             case 2:{ // T2
                                 [ViewUtil setFrame:mImageAnimal x:mImageT2.frame.origin.x y:y];
                                 break;
                             }
                         }
                     }completion:^(BOOL finished){
                         [self fadein];
                         switch ([winner integerValue]) {
                             case 0:{ // Draw
                                 break;
                             }
                             case 1: // T1
                             case 2: // T2
                                 [mImageAnimal stopAnimating];
                                 [mImageAnimal setImage:[UIImage imageNamed:@"macaw_1.png"]];
                                 break;
                         }
                     }];
}


-(void) fadein
{
    mTime.alpha = 0;
    mDetailApp.alpha = 0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    //don't forget to add delegate.....
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationDuration:0.7];
    mTime.alpha = 1;
    mDetailApp.alpha = 1;
    
    [UIView commitAnimations];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)clickBack:(id)sender {
    API *a = [API getAPI];
    [a reloadViewMain];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage*)saveImage {
    UIImage* image;
    UIGraphicsBeginImageContextWithOptions(mViewContent.bounds.size, self.view.opaque, 0.0);
    [mViewContent.layer renderInContext:UIGraphicsGetCurrentContext()];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    return image;
}

- (IBAction)clickShare:(id)sender {
    UIImage *image = [self saveImage];
    
    NSArray* dataToShare = @[image];  // ...or whatever pieces of data you want to share.
    
    UIActivityViewController* activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:dataToShare
                                      applicationActivities:nil];
    [self presentViewController:activityViewController animated:YES completion:^{
        
    }];
}

@end
