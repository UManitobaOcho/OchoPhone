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

- (void)testBlankAssignmentRejected
{
    _vc = [[ProfAddAssignmentViewController alloc] initWithNibName:@"ProfAddAssignmentViewController" bundle:nil];
    
    [_vc viewDidLoad];
    
    _vc.AssignmentNameError = [[UILabel alloc] init];
    _vc.ReleaseDateError = [[UILabel alloc] init];
    _vc.DueDateError = [[UILabel alloc] init];
    _vc.FileInputError = [[UILabel alloc] init];
    _vc.ReleaseDatePicker = [[UIDatePicker alloc] init];
    _vc.DueDatePicker = [[UIDatePicker alloc] init];
    
    [_vc verifyAssignment];
    
    XCTAssertTrue([_vc.AssignmentNameError.text isEqualToString:@"Must Enter a Name"]);
    XCTAssertTrue([_vc.ReleaseDateError.text    isEqualToString:@"Release Date must be before the Due Date"]);
    XCTAssertTrue([_vc.FileInputError.text      isEqualToString:@"Type in an assignment or select \'Upload Assignment Later\'"]);
}

- (void)testAssignmentNameErrorNotThrown
{
    _vc = [[ProfAddAssignmentViewController alloc] initWithNibName:@"ProfAddAssignmentViewController" bundle:nil];
    
    [_vc viewDidLoad];
    
    _vc.AssignmentNameError = [[UILabel alloc] init];
    _vc.AssignmentNameBox = [[UITextField alloc] init];
    
    _vc.AssignmentNameBox.text = @"Assignment Test";
    [_vc verifyAssignment];
    XCTAssertTrue([_vc.AssignmentNameError.text isEqualToString:@" "]);
    
    _vc.AssignmentNameBox.text = @"a";
    [_vc verifyAssignment];
    XCTAssertTrue([_vc.AssignmentNameError.text isEqualToString:@" "]);
    
    _vc.AssignmentNameBox.text = @"abcdefghijklmnopqrstuvwxyz1234567890";
    [_vc verifyAssignment];
    XCTAssertTrue([_vc.AssignmentNameError.text isEqualToString:@" "]);
    
    _vc.AssignmentNameBox.text = @"~!@#$%^&*()_+?><:\"\{}|\\]\[\';/.,\']";
    [_vc verifyAssignment];
    XCTAssertTrue([_vc.AssignmentNameError.text isEqualToString:@" "]);
    
    _vc.AssignmentNameBox.text = @" ";
    [_vc verifyAssignment];
    XCTAssertTrue([_vc.AssignmentNameError.text isEqualToString:@" "]);
    
    _vc.AssignmentNameBox.text = @"             ";
    [_vc verifyAssignment];
    XCTAssertTrue([_vc.AssignmentNameError.text isEqualToString:@" "]);
    
    _vc.AssignmentNameBox.text = @"This is the longest name in the world with some added spaces, for crazy professors!!!";
    [_vc verifyAssignment];
    XCTAssertTrue([_vc.AssignmentNameError.text isEqualToString:@" "]);
}

- (void)testFileContentsErrorNotThrown
{
    _vc = [[ProfAddAssignmentViewController alloc] initWithNibName:@"ProfAddAssignmentViewController" bundle:nil];
    
    [_vc viewDidLoad];
    
    _vc.FileInputError = [[UILabel alloc] init];
    _vc.FileInputBox = [[UITextView alloc] init];
    
    _vc.FileInputBox.text = @"Question1: What is a SQL Statement?";
    [_vc verifyAssignment];
    XCTAssertTrue([_vc.FileInputError.text isEqualToString:@" "]);
    
    _vc.FileInputBox.text = @"Q";
    [_vc verifyAssignment];
    XCTAssertTrue([_vc.FileInputError.text isEqualToString:@" "]);
    
    _vc.FileInputBox.text = @"QQQUUUEEESSSTTTIIIIIOOOOONNNNNNNNNNNNN";
    [_vc verifyAssignment];
    XCTAssertTrue([_vc.FileInputError.text isEqualToString:@" "]);
    
    _vc.FileInputBox.text = @"~!@#$%^&*()_+?><:\"\{}|\\]\[\';/.,\']";
    [_vc verifyAssignment];
    XCTAssertTrue([_vc.FileInputError.text isEqualToString:@" "]);
    
    _vc.FileInputBox.text = @" ";
    [_vc verifyAssignment];
    XCTAssertTrue([_vc.FileInputError.text isEqualToString:@" "]);
    
    _vc.FileInputBox.text = @"Question#1\nWhat is the square root of pi?\n\nQuestion#2\nWhat is the log base 2 of e?\n\n";
    [_vc verifyAssignment];
    XCTAssertTrue([_vc.FileInputError.text isEqualToString:@" "]);
    
    _vc.FileInputBox.text = @"Question#1\nWhat is the square root of pi?\n\nQuestion#2\nWhat is the log base 2 of e?\n\nQuestion#1\nWhat is the square root of pi?\n\nQuestion#2\nWhat is the log base 2 of e?\n\nQuestion#1\nWhat is the square root of pi?\n\nQuestion#2\nWhat is the log base 2 of e?\n\nQuestion#1\nWhat is the square root of pi?\n\nQuestion#2\nWhat is the log base 2 of e?\n\nQuestion#1\nWhat is the square root of pi?\n\nQuestion#2\nWhat is the log base 2 of e?\n\nQuestion#1\nWhat is the square root of pi?\n\nQuestion#2\nWhat is the log base 2 of e?\n\nQuestion#1\nWhat is the square root of pi?\n\nQuestion#2\nWhat is the log base 2 of e?\n\nQuestion#1\nWhat is the square root of pi?\n\nQuestion#2\nWhat is the log base 2 of e?\n\nQuestion#1\nWhat is the square root of pi?\n\nQuestion#2\nWhat is the log base 2 of e?\n\nQuestion#1\nWhat is the square root of pi?\n\nQuestion#2\nWhat is the log base 2 of e?\n\n";
    [_vc verifyAssignment];
    XCTAssertTrue([_vc.FileInputError.text isEqualToString:@" "]);
}

@end
