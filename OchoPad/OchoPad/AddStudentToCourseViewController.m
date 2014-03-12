//
//  AddStudentToCourseViewController.m
//  OchoPad
//
//  Created by Jasdeep Singh Bhumber on 2014-03-11.
//  Copyright (c) 2014 Team Ocho (8). All rights reserved.
//

#import "AddStudentToCourseViewController.h"
#import "ComInterface.h"
#import "Student.h"

@interface AddStudentToCourseViewController ()

@end

@implementation AddStudentToCourseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [ComInterface sharedInstance].delegate = self;
    SocketIO *mySocketIO = [ComInterface sharedInstance].socketIO;
    
    NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:self.currCourse.course_id, @"course", nil];
                          
                          //profAssignment.AssignmentName, @"assignmentTitle", profAssignment.CourseNumber, @"course", profAssignment.ReleaseDate, @"releaseDate", profAssignment.DueDate, @"dueDate", profAssignment.file, @"file", nil];
    
    [mySocketIO sendEvent:@"getStudNotInCourse" withData:data];
    NSLog(@"successful");
    
	// Do any additional setup after loading the view.
}
- (void)studentAdd:(NSArray *)response rowCount:(NSInteger)rowCount
{
    NSLog(@"Adding student to table");
    for(int i = 0; i < rowCount; i++)
    {
        Student *stud = [[Student alloc] init];
        stud.username = response[i][@"username"];
        stud.first_name = response[i][@"first_name"];
        stud.last_name = response[i][@"last_name"];
        stud.student_id = response[i][@"student_id"];
        [self.students addObject:stud];
        [self.tableView reloadData];
        //[self.tableView reloadData];
        
        //[self.students insertObject:_students atIndex:indexPath.row];
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([self.students indexOfObject:stud]) inSection:0];
        //[self.studentList beginUpdates];
        //[self.studentList
        //insertRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationBottom];
        //[self.studentList endUpdates];
        //[self.studentList insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([self.students count] - 1) inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView reloadData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.students count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"HITS");
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StudentCell"];
    Student *stud = (self.students)[indexPath.row];
    cell.textLabel.text = stud.username;
    cell.detailTextLabel.text = stud.first_name;
    //cell.textLabel.text = [self.students objectAtIndex:indexPath.row];
    return cell;
}

- (void)receivedPacket:(id)packet
{
    NSArray *response = packet[@"args"][0][@"rows"];
    NSInteger count = [(NSNumber *)[packet[@"args"][0] objectForKey:@"rowCount"] integerValue];
    
    if([packet[@"name"] isEqual: @"foundStudNotInCourse"])
    {
        [self studentAdd:response rowCount:count];
    }

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
