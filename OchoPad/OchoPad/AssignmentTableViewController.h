//
//  AssignmentTableViewController.h
//  OchoPad
//
//  Created by Hugo Cabral Tannus on 2014-03-24.
//  Copyright (c) 2014 Team Ocho (8). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"
#import "SocketIO.h"
#import "ComInterface.h"
#import "ProfAssignment.h"

@interface AssignmentTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, SocketIOConnectionDelegate>
{
    NSMutableDictionary *assignmentsDict;
    NSMutableArray *assignments;
}
@property(nonatomic) Course *currCourse;
@end
