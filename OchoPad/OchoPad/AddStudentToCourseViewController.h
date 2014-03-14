//
//  AddStudentToCourseViewController.h
//  OchoPad
//
//  Created by Jasdeep Singh Bhumber on 2014-03-11.
//  Copyright (c) 2014 Team Ocho (8). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"
#import "SocketIO.h"
#import "ComInterface.h"

@interface AddStudentToCourseViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, SocketIOConnectionDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic) Course *currCourse;

@property (nonatomic, strong) NSMutableArray *students;
@end
