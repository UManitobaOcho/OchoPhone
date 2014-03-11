//
//  AddStudentToCourseViewController.h
//  OchoPad
//
//  Created by Jasdeep Singh Bhumber on 2014-03-11.
//  Copyright (c) 2014 Team Ocho (8). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"

@interface AddStudentToCourseViewController : UIViewController

@property(nonatomic) Course *currCourse;
@property (weak, nonatomic) IBOutlet UITableView *studentList;

@end
