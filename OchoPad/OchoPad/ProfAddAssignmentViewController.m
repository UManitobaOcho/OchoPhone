//
//  ProfAddAssignmentViewController.m
//  OchoPad
//
//  Created by Nicholas Guillas on 2014-03-06.
//  Copyright (c) 2014 Team Ocho (8). All rights reserved.
//

#import "ProfAddAssignmentViewController.h"
#import "ComInterface.h"

@interface ProfAddAssignmentViewController ()


@end

@implementation ProfAddAssignmentViewController

ProfAssignment *profAssignment;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.AssignmentNameError.hidden = YES;
    self.ReleaseDateError.hidden = YES;
    self.DueDateError.hidden = YES;
    self.FileInputError.hidden = YES;
    self.AssignmentNameError.text = @" ";
    self.ReleaseDateError.text = @" ";
    self.DueDateError.text = @" ";
    self.FileInputError.text = @" ";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)done:(id)sender
{
    NSDate *releaseDateOrig = self.ReleaseDatePicker.date;
    NSDate *dueDateOrig = self.DueDatePicker.date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy hh:mm aa"];
    
    // Add text to a file
    //get the documents directory:
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //make a file name to write the data to using the documents directory:
    NSString *fileName = [NSString stringWithFormat:@"%@/textfile.txt",
                          documentsDirectory];
    NSString *content = self.FileInputBox.text;
    //save content to the documents directory
    [content writeToFile:fileName atomically:NO encoding:NSStringEncodingConversionAllowLossy error:nil];
    
    // create date strings
    NSString *releaseDate = [dateFormat stringFromDate:releaseDateOrig];
    NSString *dueDate = [dateFormat stringFromDate:dueDateOrig];
    
    // create assignment object
    profAssignment = [[ProfAssignment alloc] init];
    profAssignment.AssignmentName = self.AssignmentNameBox.text;
    profAssignment.CourseNumber = self.currCourse.number;
    profAssignment.ReleaseDate = releaseDate;
    profAssignment.DueDate = dueDate;
    
    if(self.FileInputSwitcher.selectedSegmentIndex == 0){
        profAssignment.file = [NSString stringWithContentsOfFile:fileName];
        profAssignment.name = [NSString stringWithFormat:@"%@%@", [profAssignment.AssignmentName stringByReplacingOccurrencesOfString:@" " withString:@"_"], @".txt"];
        profAssignment.type = @"text/plain";
        profAssignment.size = [NSString stringWithFormat: @"%d", profAssignment.file.length];
    }else{
        profAssignment.file = nil;
        profAssignment.name = nil;
        profAssignment.type = nil;
        profAssignment.size = nil;
    }
    
    if([self verifyAssignment] == YES) {
        [self submitAssignment];
    }
}

- (IBAction)FileInputMethod:(id)sender {
    self.FileInputBox.hidden = !(self.FileInputBox.hidden);
    self.UploadMessage.hidden = !(self.UploadMessage.hidden);
}

- (void)submitAssignment
{
    [ComInterface sharedInstance].delegate = self;
    SocketIO *mySocketIO = [ComInterface sharedInstance].socketIO;
    
    NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:
                          profAssignment.AssignmentName, @"assignmentTitle",
                          profAssignment.CourseNumber, @"course",
                          profAssignment.ReleaseDate, @"releaseDate",
                          profAssignment.DueDate, @"dueDate",
                          profAssignment.name, @"name",
                          profAssignment.type, @"type",
                          profAssignment.size, @"size",
                          profAssignment.file, @"file",
                          nil];
    
    [mySocketIO sendEvent:@"profAddAssignment" withData:data];
}

- (bool)verifyAssignment
{
    bool isValid = YES;
    
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"MM/dd/yyyy HH:mm"];
    df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:[NSTimeZone localTimeZone].secondsFromGMT];
    NSDate *currentDate = [NSDate date];
    
    self.AssignmentNameError.hidden = YES;
    self.ReleaseDateError.hidden = YES;
    self.DueDateError.hidden = YES;
    self.FileInputError.hidden = YES;
    self.AssignmentNameError.text = @" ";
    self.ReleaseDateError.text = @" ";
    self.DueDateError.text = @" ";
    self.FileInputError.text = @" ";
    
    NSLog(@"%@",self.ReleaseDatePicker.date);
    NSLog(@"%@",self.DueDatePicker.date);
    NSLog(@"%@",currentDate);
    
	if(self.AssignmentNameBox.text.length < 1) {
		self.AssignmentNameError.text = @"Must Enter a Name";
        self.AssignmentNameError.hidden = NO;
		isValid = NO;
	}
    
	if(self.FileInputBox.text.length <= 0 && self.FileInputSwitcher.selectedSegmentIndex == 0) {
		self.FileInputError.text = @"Type in an assignment or select \'Upload Assignment Later\'";
        self.FileInputError.hidden = NO;
		isValid = NO;
	}
    
    if([self.DueDatePicker.date compare:self.ReleaseDatePicker.date] == NSOrderedAscending) {
        self.ReleaseDateError.text = @"Release Date must be before the Due Date";
        self.ReleaseDateError.hidden = NO;
        isValid = NO;
    }
    
    if([self.DueDatePicker.date compare:currentDate] == NSOrderedAscending) {
        self.DueDateError.text = @"Due Date must be after the current time";
        self.DueDateError.hidden = NO;
        isValid = NO;
    }

    if([self.ReleaseDatePicker.date compare:currentDate] == NSOrderedAscending) {
        self.ReleaseDateError.text = @"Release Date must be after the current time";
        self.ReleaseDateError.hidden = NO;
        isValid = NO;
    }
    
    return isValid;
}

- (void)receivedPacket:(id)packet
{
    NSArray *response = packet[@"args"][0][@"rows"];
    NSInteger count = [(NSNumber *)[packet[@"args"][0] objectForKey:@"rowCount"] integerValue];
    
    if([packet[@"name"] isEqual: @"ProfAssignmentSubmitted"])
    {
        NSLog(@"Professor Assignment Added Successfully");
        //[self dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
