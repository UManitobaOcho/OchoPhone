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

@interface AssignmentTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, SocketIOConnectionDelegate> {
    NSDictionary *assignmentsDict;
    NSMutableArray *assignments;
}
@end
