//
//  CourseDetailsViewControllerTest.m
//  OchoPad
//
//  Created by Alexander Plishka on 2014-03-20.
//  Copyright (c) 2014 Team Ocho (8). All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CourseDetailsViewController.h"

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

- (void)testExample
{
    _vc = [[CourseDetailsViewController alloc] initWithNibName:@"CourseDetailsViewController" bundle:nil];
    [_vc viewDidLoad];
    
    XCTAssertTrue(true);
}

@end
