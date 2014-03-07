//
//  SingleCourseViewController.h
//  OchoPad
//
//  Created by Nicolas Richard on 2014-03-06.
//  Copyright (c) 2014 Team Ocho (8). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"
#import "ProfAddAssignmentViewController.h"

@interface SingleCourseViewController : UIViewController
@property(nonatomic) Course *currCourse;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *courseNumber;

@end
