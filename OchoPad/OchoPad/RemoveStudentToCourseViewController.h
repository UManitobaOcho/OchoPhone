//
//  RemoveStudentToCourseViewController.h
//  OchoPad
//
//  Created by Jasdeep Singh Bhumber on 2014-03-24.
//  Copyright (c) 2014 Team Ocho (8). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"
#import "SocketIO.h"
#import "ComInterface.h"

@interface RemoveStudentToCourseViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, SocketIOConnectionDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic) Course *currCourse;
@property (nonatomic, strong) NSMutableArray *students;
- (IBAction)done:(id)sender;
@end
