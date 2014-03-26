//
//  SingleCourseViewController.m
//  OchoPad
//
//  Created by Nicolas Richard on 2014-03-06.
//  Copyright (c) 2014 Team Ocho (8). All rights reserved.
//

#import "SingleCourseViewController.h"

@interface SingleCourseViewController ()

@end

@implementation SingleCourseViewController


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"ProfAddAssignment"]){
        ProfAddAssignmentViewController *controller = (ProfAddAssignmentViewController *)segue.destinationViewController;
        controller.currCourse = self.currCourse;
    }
    else if([segue.identifier isEqualToString:@"AddStudentToCourse"]){
        AddStudentToCourseViewController *controller = (AddStudentToCourseViewController *)segue.destinationViewController;
        controller.currCourse = self.currCourse;
    }
    else if([segue.identifier isEqualToString:@"RemoveStudentToCourse"]){
        RemoveStudentToCourseViewController *controller = (RemoveStudentToCourseViewController *)segue.destinationViewController;
        controller.currCourse = self.currCourse;
    } /*
    else if([segue.identifier isEqualToString:@"GetAssignmentsForCourse"]){
        AssignmentTableViewController *controller = (AssignmentTableViewController *)segue.destinationViewController;
        controller.currCourse = self.currCourse;
    }
       */
}

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
    
    if([self.isProf  isEqual: @YES]) {
        self.UpdateButton.enabled = YES;
        self.courseName.enabled = YES;
        self.courseNumber.enabled = YES;
        self.section.enabled = YES;
        self.online.enabled = YES;
        self.startTime.enabled = YES;
        self.endTime.enabled = YES;
        self.startTime.userInteractionEnabled = YES;
        self.endTime.userInteractionEnabled = YES;
        self.tableViewer.userInteractionEnabled = YES;
        self.StudentButton.hidden = NO;
        self.AssignmentButton.hidden = NO;
        self.StudentLabel.hidden = NO;
        self.AssignmentLabel.hidden = NO;
        self.ClassListButton.hidden = NO;
        self.ClassListLabel.hidden = NO;
        NSLog(@"PROFESSOR");
    } else {
        self.UpdateButton.enabled = NO;
        self.courseName.enabled = NO;
        self.courseNumber.enabled = NO;
        self.section.enabled = NO;
        self.online.enabled = NO;
        self.startTime.enabled = NO;
        self.endTime.enabled = NO;
        self.startTime.userInteractionEnabled = NO;
        self.endTime.userInteractionEnabled = NO;
        self.tableViewer.userInteractionEnabled = NO;
        self.StudentButton.hidden = YES;
        self.AssignmentButton.hidden = YES;
        self.StudentLabel.hidden = YES;
        self.AssignmentLabel.hidden = YES;
        self.ClassListButton.hidden = YES;
        self.ClassListLabel.hidden = YES;
        NSLog(@"STUDENT");
    }
    
    _mainArray = [[NSArray alloc] initWithObjects:@"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", nil];
    
    _courseName.text = self.currCourse.name;
    _courseNumber.text = self.currCourse.number;
    _section.text = self.currCourse.section;
    
    if([self.currCourse.class_times isEqual:@"Online"]) {
        [_online setOn:YES animated:YES];
    } else {
        [_online setOn:NO animated:NO];
        [self setClassTimes:self.currCourse.class_times];
    }
    
    
    if (assignmentController == nil) {
        NSLog(@"Setting the assignment Controller properly");
        assignmentController = [[AssignmentTableViewController alloc] init];
    }
    [self.assignmentTable setDataSource:assignmentController];
    assignmentController.view = assignmentController.tableView;
    
}

- (void) setClassTimes:(NSString *)times
{
    NSArray *split = [times componentsSeparatedByString:@" "];

    //selects the days in tableview corresponding to the string value of times
    for(int i = 0; i < [split[0] length]; i++) {
        NSString *day = [split[0] substringWithRange:NSMakeRange(i, 1)];
        if([day isEqualToString:@"M"]) {
            [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        } else if([day isEqualToString:@"T"]) {
            [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        } else if([day isEqualToString:@"W"]) {
            [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        } else if([day isEqualToString:@"R"]) {
            [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        } else if([day isEqualToString:@"F"]) {
            [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
    }
    
    //set timepickers
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm a"];
    
    [self.startTime setDate:[formatter dateFromString:[[split[1] stringByAppendingString:@" "] stringByAppendingString:split[2]]]];
    [self.endTime setDate:[formatter dateFromString:[[split[4] stringByAppendingString:@" "]  stringByAppendingString:split[5]]]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_mainArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"thisCell"];
    cell.textLabel.text = [_mainArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)getClassTimes:(UITableView *)table
{
    //create a string with the selected days
    NSString *result = @"";
    NSArray *selectedIndexPaths = [table indexPathsForSelectedRows];
    for(id row in selectedIndexPaths) {
        if([row row] == 0) {
            result = [result stringByAppendingString:@"M"];
        } else if([row row] == 1) {
            result = [result stringByAppendingString:@"T"];
        } else if([row row] == 2) {
            result = [result stringByAppendingString:@"W"];
        } else if([row row] == 3) {
            result = [result stringByAppendingString:@"R"];
        } else if([row row] == 4) {
            result = [result stringByAppendingString:@"F"];
        }
    }
    
    //format the remainder of the string and add in the formatted date value from the time picker
    result = [result stringByAppendingString:@" "];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"hh:mm aa"];
    
    result = [result stringByAppendingString:[dateFormat stringFromDate:self.startTime.date]];
    result = [result stringByAppendingString:@" - "];
    result = [result stringByAppendingString:[dateFormat stringFromDate:self.endTime.date]];
    
    NSLog(@"string %@", result);
    return result;
}

- (bool)validateCourseFields
{
    //reset values
    bool isValid = YES;
    
    self.nameError.hidden = YES;
    self.nameError.text = @"";
    self.numberError.hidden = YES;
    self.numberError.text = @"";
    self.sectionError.hidden = YES;
    self.sectionError.text = @"";
    self.daysError.hidden = YES;
    self.daysError.text = @"";
    self.timesError.hidden = YES;
    self.timesError.text = @"";
    
    //check text fields are formatted correctly
	if(self.courseName.text.length <= 2) {
		self.nameError.text = @"Name is to Short";
        self.nameError.hidden = NO;
		isValid = NO;
	}
    
    NSString *regex = @"\\w{4} \\d{4}";
    NSPredicate *testRegex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if(![testRegex evaluateWithObject:self.courseNumber.text]){
        self.numberError.text = @"Number must match format: 'EXAM 0000'";
        self.numberError.hidden = NO;
		isValid = NO;
    }
    
    regex = @"\\w\\d{2}";
    testRegex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if(![testRegex evaluateWithObject:self.section.text]) {
        self.sectionError.text = @"Section must match format: 'A00'";
        self.sectionError.hidden = NO;
        isValid = NO;
    }
    
    //check that either online switch or atleast one day option is selected
    if(![self.online isOn] && [_tableView indexPathsForSelectedRows] == nil) {
        self.daysError.text = @"Either Online option must be selected or you must select atleast one day";
        self.daysError.hidden = NO;
        isValid = NO;
    }
    
    BOOL timesAreSame = (NSInteger)[self.startTime.date timeIntervalSinceDate:self.endTime.date] == 0 ;
    //check that start and end times are different
    if(![self.online isOn] && timesAreSame){
        self.timesError.text = @"Start and End times must be different";
        self.timesError.hidden = NO;
        isValid = NO;
    }
    
    return isValid;
}

- (IBAction)update:(id)sender
{
    if([self validateCourseFields]) {
        Course *course = [[Course alloc] init];
        course.name = self.courseName.text;
        course.number = self.courseNumber.text;
        course.section = self.section.text;
        course.course_id = self.currCourse.course_id;
    
        if([self.online isOn]) {
            course.class_times = @"Online";
        } else {
            course.class_times = [self getClassTimes:_tableView];
        }
    
        [self.delegate singleCourseViewController:self didUpdateCourse:course];
    }
}

- (IBAction)cancel:(id)sender
{
    [self.delegate singleCourseViewControllerDidCancel:self];
}

@end
