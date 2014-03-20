//
//  ProfAddAssignmentViewControllerTest.m
//  OchoPad
//
//  Created by Nicholas Guillas on 2014-03-20.
//  Copyright (c) 2014 Team Ocho (8). All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ProfAddAssignmentViewController.h"

@interface ProfAddAssignmentViewControllerTest : XCTestCase

@property (nonatomic, strong) ProfAddAssignmentViewController *vc;

@end

@implementation ProfAddAssignmentViewControllerTest

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testExample
{
    _vc = [[ProfAddAssignmentViewController alloc] initWithNibName:@"ProfAddAssignmentViewController" bundle:nil];
    [_vc viewDidLoad];
    
    //XCTAssertTrue([_vc.AssignmentNameError.text isEqualToString:@" "]);
    //XCTAssertTrue([_vc.ReleaseDateError.text isEqualToString:@" "]);
    //XCTAssertTrue([_vc.DueDateError.text isEqualToString:@" "]);
    //XCTAssertTrue([_vc.FileInputError.text isEqualToString:@" "]);
}

@end
