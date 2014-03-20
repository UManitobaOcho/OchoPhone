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
    [mySocketIO sendEvent:@"getSubmittedAssignment" withData:@"1"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)displayGrade : (NSArray *)response
{
    NSLog(@"display Grade to GradeInputBox");
    
    // extract assignment_name & grade values from response object
    NSDictionary *object = [[response lastObject] lastObject];
    NSString *grade = [object objectForKey:@"grade"];
    NSString *assignmentName = [object objectForKey:@"assignment_name"];
    
    // append assignmentName & grade value to outputStr
    NSString *outputStr = [NSString stringWithFormat:@"%@\n%@\n%@\t\t\t%@", @"Assignment Grade\n", @"Assignment Name\t\tMarks", assignmentName, grade];
    
    // put the outputStr inside GradeInputBox
    self.GradeInputBox.text = outputStr;
}

- (void)receivedPacket:(id)packet
{
    NSArray *respoense = packet[@"args"];
    
    /* Needed for multiple return records */
    //NSArray *response = packet[@"args"][@"rows"];
    //NSInteger count = [(NSNumber *)[packet[@"args"][0] objectForKey:@"rowCount"] integerValue];
    
    if([packet[@"name"] isEqual: @"foundSubmittedAssignment"])
    {
        [self displayGrade:respoense];
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
