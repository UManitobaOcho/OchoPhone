//
//  CourseViewController.h
//  OchoPad
//
//  Created by Nico on 2/25/2014.
//  Copyright (c) 2014 Team Ocho (8). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseDetailsViewController.h"
#import "SingleCourseViewController.h"
#import "ComInterface.h"

@interface CourseViewController : UITableViewController <CourseDetailsViewControllerDelegate, SocketIOConnectionDelegate, SingleCourseViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *courses;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *AddButton;

@property NSNumber *isProf;

@end
