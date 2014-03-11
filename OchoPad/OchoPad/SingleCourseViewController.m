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
    
    mainArray = [[NSArray alloc] initWithObjects:@"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", nil];
    
    _courseName.text = self.currCourse.name;
    _courseNumber.text = self.currCourse.number;
    _section.text = self.currCourse.section;
    
    if([self.currCourse.class_times isEqual:@"Online"]) {
        [_online setOn:YES animated:YES];
    } else {
        [_online setOn:NO animated:NO];
        [self setClassTimes:self.currCourse.class_times];
    }
}

- (void) setClassTimes:(NSString *)times
{
    NSArray *split = [times componentsSeparatedByString:@" "];

    //selects the days in tableview corresponding to the string value of times
    for(int i = 0; i < [split[0] length]; i++) {
        NSString *day = [split[0] substringWithRange:NSMakeRange(i, 1)];
        if([day isEqualToString:@"M"]) {
            [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        } else if([day isEqualToString:@"T"]) {
            [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        } else if([day isEqualToString:@"W"]) {
            [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        } else if([day isEqualToString:@"R"]) {
            [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        } else if([day isEqualToString:@"F"]) {
            [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
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
    return [mainArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"thisCell"];
    cell.textLabel.text = [mainArray objectAtIndex:indexPath.row];
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

- (IBAction)update:(id)sender
{
    Course *course = [[Course alloc] init];
    course.name = self.courseName.text;
    course.number = self.courseNumber.text;
    course.section = self.section.text;
    course.course_id = self.currCourse.course_id;
    
    if([self.online isOn]) {
        course.class_times = @"Online";
    } else {
        course.class_times = [self getClassTimes:tableView];
    }
    
    [self.delegate singleCourseViewController:self didUpdateCourse:course];
}

- (IBAction)cancel:(id)sender
{
    [self.delegate singleCourseViewControllerDidCancel:self];
}

@end
