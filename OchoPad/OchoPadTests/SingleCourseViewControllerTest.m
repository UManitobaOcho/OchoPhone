//
//  CourseViewControllerTest.m
//  OchoPad
//
//  Created by Alexander Plishka on 2014-03-20.
//  Copyright (c) 2014 Team Ocho (8). All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SingleCourseViewController.h"

@interface SingleCourseViewControllerTest : XCTestCase

@property (nonatomic, strong) SingleCourseViewController *vc;

@end

@implementation SingleCourseViewControllerTest

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
    _vc = [[SingleCourseViewController alloc] initWithNibName:@"SingleCourseViewController" bundle:nil];
    [_vc viewDidLoad];
    
    XCTAssertNotNil(_vc.mainArray);
    XCTAssertTrue([[_vc.mainArray objectAtIndex:0] isEqualToString:@"Monday"]);
    XCTAssertTrue([[_vc.mainArray objectAtIndex:1] isEqualToString:@"Tuesday"]);
    XCTAssertTrue([[_vc.mainArray objectAtIndex:2] isEqualToString:@"Wednesday"]);
    XCTAssertTrue([[_vc.mainArray objectAtIndex:3] isEqualToString:@"Thursday"]);
    XCTAssertTrue([[_vc.mainArray objectAtIndex:4] isEqualToString:@"Friday"]);
}

- (void)testCourseDetailsAreLoaded
{
    _vc = [[SingleCourseViewController alloc] initWithNibName:@"SingleCourseViewController" bundle:nil];
    
    Course *c = [[Course alloc] init];
    c.name = @"Fake";
    c.number = @"COMP 3333";
    c.section = @"A99";
    c.course_id = @"1";
    c.class_times = @"Online";
    
    _vc.currCourse = c;
    _vc.courseName = [[UITextField alloc] init];
    
    [_vc viewDidLoad];
    
    XCTAssertTrue([_vc.courseName.text isEqualToString:c.name]);
}

-(void)testOnlineIsSwitchedOn
{
    _vc = [[SingleCourseViewController alloc] initWithNibName:@"SingleCourseViewController" bundle:nil];
    
    Course *c = [[Course alloc] init];
    c.class_times = @"Online";
    
    _vc.currCourse = c;
    _vc.online = [[UISwitch alloc] init];
    
    [_vc viewDidLoad];
    
    XCTAssertTrue(_vc.online.isOn);
}

-(void)testClassTimesAreLoaded
{
    _vc = [[SingleCourseViewController alloc] initWithNibName:@"SingleCourseViewController" bundle:nil];
    
    Course *c = [[Course alloc] init];
    c.class_times = @"MW 10:00 AM - 11:15 AM";
    
    _vc.currCourse = c;
    _vc.online = [[UISwitch alloc] init];
    _vc.startTime = [[UIDatePicker alloc] init];
    _vc.endTime = [[UIDatePicker alloc] init];
    
    [_vc viewDidLoad];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"hh:mm a"];
    
    XCTAssertTrue(!_vc.online.isOn);
    XCTAssertTrue([_vc.startTime.date isEqualToDate:[formatter dateFromString:@"10:00 AM"]]);
    XCTAssertTrue([_vc.endTime.date isEqualToDate:[formatter dateFromString:@"11:15 AM"]]);
}

- (void)testValidateCourseFieldsIsTrue
{
    _vc = [[SingleCourseViewController alloc] initWithNibName:@"SingleCourseViewController" bundle:nil];
    
    Course *c = [[Course alloc] init];
    c.name = @"Fake";
    c.number = @"COMP 3333";
    c.section = @"A99";
    c.course_id = @"1";
    c.class_times = @"Online";
    
    _vc.currCourse = c;
    _vc.courseName = [[UITextField alloc] init];
    _vc.courseNumber = [[UITextField alloc] init];
    _vc.section = [[UITextField alloc] init];
    _vc.online = [[UISwitch alloc] init];
    _vc.startTime = [[UIDatePicker alloc] init];
    _vc.endTime = [[UIDatePicker alloc] init];
    
    [_vc viewDidLoad];
    
    XCTAssertTrue([_vc validateCourseFields]);
}

- (void)testValidateCourseFieldsIsFalse
{
    _vc = [[SingleCourseViewController alloc] initWithNibName:@"SingleCourseViewController" bundle:nil];
    
    Course *c = [[Course alloc] init];
    c.name = @"Fake";
    c.number = @"COMP STUF";
    c.section = @"A99";
    c.course_id = @"1";
    c.class_times = @"Online";
    
    _vc.currCourse = c;
    _vc.courseName = [[UITextField alloc] init];
    _vc.courseNumber = [[UITextField alloc] init];
    _vc.section = [[UITextField alloc] init];
    _vc.online = [[UISwitch alloc] init];
    _vc.startTime = [[UIDatePicker alloc] init];
    _vc.endTime = [[UIDatePicker alloc] init];
    
    [_vc viewDidLoad];
    
    XCTAssertFalse([_vc validateCourseFields]);
}

- (void)testGetClassTimes
{
    _vc = [[SingleCourseViewController alloc] initWithNibName:@"SingleCourseViewController" bundle:nil];
    
    Course *c = [[Course alloc] init];
    c.name = @"Fake";
    c.number = @"COMP STUF";
    c.section = @"A99";
    c.course_id = @"1";
    c.class_times = @"MW 10:00 AM - 11:15 AM";
    
    _vc.currCourse = c;
    _vc.courseName = [[UITextField alloc] init];
    _vc.courseNumber = [[UITextField alloc] init];
    _vc.section = [[UITextField alloc] init];
    _vc.online = [[UISwitch alloc] init];
    _vc.startTime = [[UIDatePicker alloc] init];
    _vc.endTime = [[UIDatePicker alloc] init];
    
    [_vc viewDidLoad];
    
    NSString *str = [_vc getClassTimes:_vc.tableView];
    XCTAssertTrue([str isEqualToString:@" 10:00 AM - 11:15 AM"]);
}

@end
