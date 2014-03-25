//
//  GradeViewController.m
//  OchoPad
//
//  Created by Junjie Huang on 2014-03-19.
//  Copyright (c) 2014 Team Ocho (8). All rights reserved.
//

#import "GradeViewController.h"

@interface GradeViewController ()

@end

@implementation GradeViewController

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
    // Do any additional setup after loading the view.
    
    // set up ComInterface
    [ComInterface sharedInstance].delegate = self;
    
    // erase everything currently inside GradeInputBox
    self.GradeInputBox.text = @"";
    
    // make the GradeInputBox not editable
    self.GradeInputBox.editable = FALSE;
    
    // send getSubmittedAssignment event with enrolled_id = 1
    SocketIO *mySocketIO = [ComInterface sharedInstance].socketIO;
    [mySocketIO sendEvent:@"getSubmittedAssignment" withData: @1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)displayAssignmentGrade : (NSArray *)response
{
    NSString *outputStr = [NSString stringWithFormat:@"%@\n%@\n", @"Assignment Grade\n", @"Assignment Name\t\tMarks"];
    
    // extract assignment_name & grade values from response object
    NSArray *object = [response lastObject];
    for (NSUInteger i = 0; i < [object count]; i++) {
        NSString *grade = [[object objectAtIndex:i] objectForKey:@"grade"];
        NSString *assignmentName = [[object objectAtIndex:i] objectForKey:@"assignment_name"];
        
        outputStr = [NSString stringWithFormat:@"%@%@\t\t\t%@\n", outputStr, assignmentName, grade];
    }
    
    // put the outputStr inside GradeInputBox
    self.GradeInputBox.text = outputStr;
    
    SocketIO *mySocketIO = [ComInterface sharedInstance].socketIO;
    [mySocketIO sendEvent:@"getCompletedTests" withData: @1];
}

- (void)displayTestMarks : (NSArray *)response
{
    NSString *outputStr = [NSString stringWithFormat:@"%@\n\n%@\n%@\n", self.GradeInputBox.text, @"Test Marks\n", @"Test ID\t\tMarks"];
    
    // extract assignment_name & grade values from response object
    NSArray *object = [response lastObject];
    for (NSUInteger i = 0; i < [object count]; i++) {
        NSString *grade = [[object objectAtIndex:i] objectForKey:@"grade"];
        NSString *testID = [[object objectAtIndex:i] objectForKey:@"test_id"];
        
        outputStr = [NSString stringWithFormat:@"%@%@\t\t\t%@\n", outputStr, testID, grade];
    }
    
    // put the outputStr inside GradeInputBox
    self.GradeInputBox.text = outputStr;

}

- (void)receivedPacket:(id)packet
{
    NSArray *respoense = packet[@"args"];
    
    /* Needed for multiple return records */
    //NSArray *response = packet[@"args"][@"rows"];
    //NSInteger count = [[respoense lastObject] count];
    //NSLog(@"%d", count);
    
    if([packet[@"name"] isEqual: @"foundSubmittedAssignment"])
    {
        [self displayAssignmentGrade:respoense];
    } else if([packet[@"name"] isEqual: @"foundCompletedTests"]) {
        [self displayTestMarks:respoense];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
