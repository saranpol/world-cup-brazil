//
//  UITableViewNoDelay.m
//  Major
//
//  Created by MacBook Pro on 4/8/55 BE.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "UITableViewNoDelay.h"


@implementation UITableViewNoDelay


- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
	//if (view.tag == 34)
	//	return NO;
	//else 
	return YES;
}

@end
