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
    [self.tableView setDataSource:self]; [self.tableView setDelegate:self];
    SocketIO *mySocketIO = [ComInterface sharedInstance].socketIO;
    self.students = [[NSMutableArray alloc] init];
    NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:self.currCourse.course_id, @"course", nil];
    
    [mySocketIO sendEvent:@"getStudNotInCourse" withData:data];
    [self.tableView reloadData];
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
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([self.students count]-1) inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.students count];
}
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StudentCell"];
    if (cell == nil) {
    }
    Student *stud = (self.students)[indexPath.row];
    cell.textLabel.text = stud.username;
    cell.detailTextLabel.text = stud.first_name;
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender {
    NSString *stud = @"";
    NSArray *selected = [self.tableView indexPathsForSelectedRows];
    for(id row in selected) {
        NSInteger r = [row row];
        Student *studTwo = [self.students objectAtIndex:r];
        stud = [stud stringByAppendingString:studTwo.student_id];
        stud = [stud stringByAppendingString:@","];
    }
    //NSLog(stud);
    NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:self.currCourse.course_id, @"course", stud, @"student", nil];
    [self sumbitStudent:data];
    
    
}
- (void)sumbitStudent:(NSDictionary *) data
{
    [ComInterface sharedInstance].delegate = self;
    SocketIO *mySocketIO = [ComInterface sharedInstance].socketIO;

    [mySocketIO sendEvent:@"addStudentToCourse" withData:data];
    NSLog(@"successful sending data to server");
    
}
- (void)receivedPacket:(id)packet
{
    NSLog(packet[@"name"]);
    NSLog(@"TESTTS ETS ETSE TS ET ET ET\n\n\n");
    
    
    if([packet[@"name"] isEqual: @"foundStudNotInCourse"])
    {
        NSArray *response = packet[@"args"][0][@"rows"];
        NSInteger count = [(NSNumber *)[packet[@"args"][0] objectForKey:@"rowCount"] integerValue];
        [self studentAdd:response rowCount:count];
    }
    else if([packet[@"name"] isEqual: @"addedStudent"])
    {
        NSLog(@"The student was added");
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
