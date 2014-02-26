//
//  CourseViewController.h
//  OchoPad
//
//  Created by Nico on 2/25/2014.
//  Copyright (c) 2014 Team Ocho (8). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseDetailsViewController.h"

@interface CourseViewController : UITableViewController <CourseDetailsViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *courses;

@end
