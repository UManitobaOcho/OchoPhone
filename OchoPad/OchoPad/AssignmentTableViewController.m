//
//  AssignmentTableViewController.m
//  OchoPad
//
//  Created by Hugo Cabral Tannus on 2014-03-24.
//  Copyright (c) 2014 Team Ocho (8). All rights reserved.
//

#import "AssignmentTableViewController.h"
#import "ProfAssignment.h"

@interface AssignmentTableViewController()

@end

@implementation AssignmentTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    NSString *keyA = @"Assignment 1";
    NSString *keyB = @"Assignment 2";
    
    assignmentsDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                            [[NSDate alloc] init], keyA,
                            [[NSDate alloc] initWithTimeIntervalSinceNow:(24*60*60)], keyB, nil];
    
    
    [ComInterface sharedInstance].delegate = self;
    SocketIO *mySocketIO = [ComInterface sharedInstance].socketIO;
    // cheating
    
    //self.currCourse = [[Course alloc] init];
    //self.currCourse.course_id = @"1";
    
    assignments = [[NSMutableArray alloc] init];
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                       @1, @"course_id", nil];
    
    [mySocketIO sendEvent:@"getAssignmentsForCourse" withData:data];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [ComInterface sharedInstance].delegate = self;
    SocketIO *mySocketIO = [ComInterface sharedInstance].socketIO;

    assignments = [[NSMutableArray alloc] init];
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                          @1, @"course_id", nil];
    
    [mySocketIO sendEvent:@"getAssignmentsForCourse" withData:data];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [assignments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"AssignmentsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    {
        NSArray *keysList = [assignmentsDict allKeys];
        NSLog(@"%@\n", keysList);
        NSString *key = [keysList objectAtIndex:indexPath.row];
        NSLog(@"%@\n", key);
        NSDate *dueDate = [assignmentsDict objectForKey:key];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        NSString *formattedDateString = [dateFormatter stringFromDate:dueDate];
    
        [cell.textLabel setText:key];
        [cell.detailTextLabel setText:formattedDateString];
    }
    
    ProfAssignment *assignment = assignments[indexPath.row];
    [cell.textLabel setText:assignment.AssignmentName];
    [cell.detailTextLabel setText:assignment.DueDate];
    
    //[NSString stringWithFormat:@"Due to %@.",formattedDateString]];
    return cell;
}

- (void)receivedPacket:(id)packet
{
    NSLog(@"receivedPacketAssigments >>>>> ");
    NSLog(@"got Packet:\n%@", packet);
    
    NSArray *response = packet[@"args"][0];
    NSLog(@"\ngot Response:\n%@", response);
    //NSInteger count = [(NSNumber *)[packet[@"args"][0] objectForKey:@"rowCount"] integerValue];
    NSInteger count = [response count];
    
    NSLog(@"Response count:\n%d", count);
    
    if([packet[@"name"] isEqual: @"foundAssignments"])
    {
        [self fillAssignmentList:response rowCount:count];
    }
    
    //else if([packet[@"name"] isEqual: @"ProfAssignmentSubmitted"])
    //{
    //  NSLog(@"Professor Assignment Added Successfully");
    //[self dismissViewControllerAnimated:YES completion:nil];
    //[self.navigationController popViewControllerAnimated:YES];
    //}
}

- (void)fillAssignmentList:(NSArray *)response rowCount:(NSInteger)rowCount
{
    NSIndexPath *indexP;
    
    while([assignments count] > 0) {
        indexP = [NSIndexPath indexPathForRow:([assignments count] - 1) inSection:0];
        [assignments removeObjectAtIndex:0];
        [[self tableView] deleteRowsAtIndexPaths:@[indexP] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    for (int i = 0; i < rowCount; i++) {
        NSLog(@"received response >>> data: %@", response[i]);
        
        ProfAssignment *assignment = [[ProfAssignment alloc] init];
        assignment.AssignmentName = response[i][@"assignment_name"];
        assignment.DueDate = response[i][@"due_date"];
        assignment.ReleaseDate = response[i][@"viewable_date"];
        [assignments addObject:assignment];
        
        
        NSLog(@"Assignment name: %@", assignment.AssignmentName);
        NSLog(@"received assignment >>> data: %@", assignment);
        NSLog(@"received response >>> data: %d", [assignments count]);
        /*
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([assignments count] - 1) inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        */
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *indexP;
    
    while([assignments count] > 0) {
        indexP = [NSIndexPath indexPathForRow:([assignments count] - 1) inSection:0];
        [assignments removeObjectAtIndex:0];
        [[self tableView] deleteRowsAtIndexPaths:@[indexP] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    for (int i = 0; i < rowCount; i++) {
        NSLog(@"received response >>> data: %@", response[i]);
        
        ProfAssignment *assignment = [[ProfAssignment alloc] init];
        assignment.AssignmentName = response[i][@"assignment_name"];
        assignment.DueDate = response[i][@"due_date"];
        assignment.ReleaseDate = response[i][@"viewable_date"];
        [assignments addObject:assignment];
        
        
        NSLog(@"Assignment name: %@", assignment.AssignmentName);
        NSLog(@"received assignment >>> data: %@", assignment);
        NSLog(@"received response >>> data: %d", [assignments count]);
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([assignments count] - 1) inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
}

- (void)receivedPacket:(id)packet
{
    NSLog(@"receivedPacketAssigments >>>>> ");
    NSLog(@"got Packet:\n%@", packet);
    
    NSArray *response = packet[@"args"][0];
    NSLog(@"\ngot Response:\n%@", response);
    //NSInteger count = [(NSNumber *)[packet[@"args"][0] objectForKey:@"rowCount"] integerValue];
    NSInteger count = [response count];
    
    NSLog(@"Response count:\n%d", count);
    
    if([packet[@"name"] isEqual: @"foundAssignments"])
    {
        [self fillAssignmentList:response rowCount:count];
    }
    
    //else if([packet[@"name"] isEqual: @"ProfAssignmentSubmitted"])
    //{
    //  NSLog(@"Professor Assignment Added Successfully");
    //[self dismissViewControllerAnimated:YES completion:nil];
    //[self.navigationController popViewControllerAnimated:YES];
    //}
}


@end
