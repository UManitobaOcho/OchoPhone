//
//  CourseDetailsViewControllerTest.m
//  OchoPad
//
//  Created by Alexander Plishka on 2014-03-20.
//  Copyright (c) 2014 Team Ocho (8). All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CourseDetailsViewController.h"
#import "Course.h"

@interface CourseDetailsViewControllerTest : XCTestCase

@property (nonatomic, strong) CourseDetailsViewController *vc;

@end

@implementation CourseDetailsViewControllerTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDaysArrayIsLoaded
{
    _vc = [[CourseDetailsViewController alloc] initWithNibName:@"CourseDetailsViewController" bundle:nil];
    [_vc viewDidLoad];
    
    XCTAssertNotNil(_vc.mainArray);
    XCTAssertTrue([[_vc.mainArray objectAtIndex:0] isEqualToString:@"Monday"]);
    XCTAssertTrue([[_vc.mainArray objectAtIndex:1] isEqualToString:@"Tuesday"]);
    XCTAssertTrue([[_vc.mainArray objectAtIndex:2] isEqualToString:@"Wednesday"]);
    XCTAssertTrue([[_vc.mainArray objectAtIndex:3] isEqualToString:@"Thursday"]);
    XCTAssertTrue([[_vc.mainArray objectAtIndex:4] isEqualToString:@"Friday"]);
}

- (void)testValidateCourseFieldsIsTrue
{
    _vc = [[CourseDetailsViewController alloc] initWithNibName:@"CourseDetailsViewController" bundle:nil];

    _vc.nameTextField = [[UITextField alloc] init];
    _vc.numberTextField = [[UITextField alloc] init];
    _vc.sectionTextField = [[UITextField alloc] init];
    _vc.onlineSwitch = [[UISwitch alloc] init];
    _vc.startTime = [[UIDatePicker alloc] init];
    _vc.endTime = [[UIDatePicker alloc] init];
    
    _vc.nameTextField.text = @"Fake";
    _vc.numberTextField.text = @"COMP 3333";
    _vc.sectionTextField.text = @"A99";
    [_vc.onlineSwitch setOn:YES animated:YES];
    
    [_vc viewDidLoad];
    
    XCTAssertTrue([_vc validateCourseFields]);
}

- (void)testValidateCourseFieldsIsFalse
{
    _vc = [[CourseDetailsViewController alloc] initWithNibName:@"CourseDetailsViewController" bundle:nil];
    
    _vc.nameTextField = [[UITextField alloc] init];
    _vc.numberTextField = [[UITextField alloc] init];
    _vc.sectionTextField = [[UITextField alloc] init];
    _vc.onlineSwitch = [[UISwitch alloc] init];
    _vc.startTime = [[UIDatePicker alloc] init];
    _vc.endTime = [[UIDatePicker alloc] init];
    
    _vc.nameTextField.text = @"Fake";
    _vc.numberTextField.text = @"COMP feet";
    _vc.sectionTextField.text = @"A99";
    [_vc.onlineSwitch setOn:YES animated:YES];
    
    [_vc viewDidLoad];
    
    XCTAssertFalse([_vc validateCourseFields]);
}

- (void)testGetClassTimes
{
    _vc = [[CourseDetailsViewController alloc] initWithNibName:@"CourseDetailsViewController" bundle:nil];
    
    _vc.nameTextField = [[UITextField alloc] init];
    _vc.numberTextField = [[UITextField alloc] init];
    _vc.sectionTextField = [[UITextField alloc] init];
    _vc.onlineSwitch = [[UISwitch alloc] init];
    _vc.startTime = [[UIDatePicker alloc] init];
    _vc.endTime = [[UIDatePicker alloc] init];
    
    _vc.nameTextField.text = @"Fake";
    _vc.numberTextField.text = @"COMP feet";
    _vc.sectionTextField.text = @"A99";
    [_vc.onlineSwitch setOn:NO animated:YES];
    _vc.startTime.date = [[NSDate alloc]init];
    _vc.endTime.date = [[NSDate alloc]init];
    
    [_vc viewDidLoad];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm a"];
    
    NSString *str = [_vc getClassTimes:_vc.tableView];
    NSString *check = @" ";
    check = [check stringByAppendingString:[formatter stringFromDate:_vc.startTime.date]];
    check = [check stringByAppendingString:@" - "];
    check = [check stringByAppendingString:[formatter stringFromDate:_vc.endTime.date]];
    
    XCTAssertTrue([str isEqualToString:check]);
}

@end
