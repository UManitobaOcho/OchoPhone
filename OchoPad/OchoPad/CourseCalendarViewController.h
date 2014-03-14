//
//  CourseCalendarViewController.h
//  OchoPad
//
//  Created by Alexander Plishka on 2014-03-14.
//  Copyright (c) 2014 Team Ocho (8). All rights reserved.
//

#import <EventKit/EventKit.h>
#import "Course.h"

@interface CourseCalendarViewController : UIViewController

@property(nonatomic) Course *currCourse;
@property(nonatomic, strong) NSCalendar *calendar;

@end
