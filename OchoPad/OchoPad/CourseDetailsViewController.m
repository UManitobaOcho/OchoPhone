//
//  CourseDetailsViewController.m
//  OchoPad
//
//  Created by Nico on 2/26/2014.
//  Copyright (c) 2014 Team Ocho (8). All rights reserved.
//

#import "CourseDetailsViewController.h"
#import "Course.h"

@interface CourseDetailsViewController ()

@end

@implementation CourseDetailsViewController

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
    
    _mainArray = [[NSArray alloc] initWithObjects:@"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", nil];
	// Do any additional setup after loading the view.
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_mainArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"thisCell"];
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
	if(self.nameTextField.text.length <= 2) {
		self.nameError.text = @"Name is to Short";
        self.nameError.hidden = NO;
		isValid = NO;
	}
    
    NSString *regex = @"\\w{4} \\d{4}";
    NSPredicate *testRegex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if(![testRegex evaluateWithObject:self.numberTextField.text]){
        self.numberError.text = @"Number must match format: 'EXAM 0000'";
        self.numberError.hidden = NO;
		isValid = NO;
    }
    
    regex = @"\\w\\d{2}";
    testRegex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];    
    if(![testRegex evaluateWithObject:self.sectionTextField.text]) {
        self.sectionError.text = @"Section must match format: 'A00'";
        self.sectionError.hidden = NO;
        isValid = NO;
    }
    
    //check that either online switch or atleast one day option is selected
    if(![self.onlineSwitch isOn] && [_tableView indexPathsForSelectedRows] == nil) {
        self.daysError.text = @"Either Online option must be selected or you must select atleast one day";
        self.daysError.hidden = NO;
        isValid = NO;
    }
    
    BOOL timesAreSame = (NSInteger)[self.startTime.date timeIntervalSinceDate:self.endTime.date] == 0 ;
    //check that start and end times are different
    if(![self.onlineSwitch isOn] && timesAreSame){
        self.timesError.text = @"Start and End times must be different";
        self.timesError.hidden = NO;
        isValid = NO;
    }
    
    return isValid;
}

- (IBAction)done:(id)sender
{
    if([self validateCourseFields]) {
        Course *course = [[Course alloc] init];
        course.name = self.nameTextField.text;
        course.number = self.numberTextField.text;
        course.section = self.sectionTextField.text;
    
        if([self.onlineSwitch isOn]) {
            course.class_times = @"Online";
        } else {
            course.class_times = [self getClassTimes:_tableView];
        }
    
        [self.delegate courseDetailsViewController:self didAddCourse:course];
    }
}

- (IBAction)cancel:(id)sender
{
    [self.delegate courseDetailsViewControllerDidCancel:self];
}


@end
