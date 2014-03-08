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
    [dateFormat setDateFormat:@"cccc, MMM d, hh:mm aa"];
    
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
    ProfAssignment *profAssignment = [[ProfAssignment alloc] init];
    profAssignment.AssignmentName = self.AssignmentNameBox.text;
    profAssignment.CourseNumber = self.currCourse.number;
    profAssignment.ReleaseDate = releaseDate;
    profAssignment.DueDate = dueDate;
    profAssignment.file = [NSString stringWithContentsOfFile:fileName];
    
    // print the values
    NSLog(@"%@",profAssignment.AssignmentName);
    NSLog(@"%@",profAssignment.CourseNumber);
    NSLog(@"%@",profAssignment.file);
    NSLog(@"%@",profAssignment.ReleaseDate);
    NSLog(@"%@",profAssignment.DueDate);
    
//    SocketIO *mySocketIO = [ComInterface sharedInstance].socketIO;

//    SocketIOCallback cb = ^(id argsData) {
//        NSDictionary *response = argsData;
//        NSLog(@"AddAssignmentResponse >>> data: %@", response);
//    };
    
//    [mySocketIO sendEvent:@"profAddAssignment" withData:(@"assignmentTitle: %@, course: %@, file: %@, releaseDate: %@, dueDate: %@",profAssignment.AssignmentName,profAssignment.CourseNumber,profAssignment.file,profAssignment.ReleaseDate,profAssignment.DueDate) andAcknowledge:cb];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)FileInputMethod:(id)sender {
    self.FileInputBox.hidden = !(self.FileInputBox.hidden);
    self.UploadMessage.hidden = !(self.UploadMessage.hidden);
}

@end
