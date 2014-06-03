//
//  ViewPredict.m
//  world-cup-brazil
//
//  Created by saranpol on 6/3/2557 BE.
//  Copyright (c) 2557 hlpth. All rights reserved.
//

#import "ViewPredict.h"
#import "ViewUtil.h"


@implementation ViewPredict

@synthesize mDictMatch;
@synthesize mImageT1;
@synthesize mImageT2;
@synthesize mImageAnimal;
@synthesize mViewContent;
@synthesize mCountLR;

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
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self performSelector:@selector(animateLR) withObject:nil afterDelay:0.1];
}

- (void)animateLR {
        self.mCountLR++;
        mImageAnimal.transform = CGAffineTransformMake(mImageAnimal.transform.a * -1, 0, 0, 1, mImageAnimal.transform.tx, 0);
        NSNumber *winner = [mDictMatch objectForKey:@"winner"];
        if(mCountLR < 4+[winner integerValue])
            [self performSelector:@selector(animateLR) withObject:nil afterDelay:0.5];
        else{
            [self performSelector:@selector(animateNokFly) withObject:nil afterDelay:0.1];
            [self performSelector:@selector(animateAnimal) withObject:nil afterDelay:2.0];
        }

}



- (void)animateNokFly {
    NSArray *imageNames = @[@"nok_1.png", @"nok_2.png"];
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (int i = 0; i < imageNames.count; i++) {
        [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
    }
    
    mImageAnimal.animationImages = images;
    mImageAnimal.animationDuration = 0.7;
    [mImageAnimal startAnimating];
}

- (void)animateAnimal {
    
    [UIView animateWithDuration:2.0
                          delay:0.0
         usingSpringWithDamping:0.4
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         NSNumber *winner = [mDictMatch objectForKey:@"winner"];
                         float y = mImageT1.frame.origin.y + 80;
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
                         
                     }];
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
