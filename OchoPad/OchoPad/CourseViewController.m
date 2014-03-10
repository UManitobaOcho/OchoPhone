//
//  CourseViewController.m
//  OchoPad
//
//  Created by Nico on 2/25/2014.
//  Copyright (c) 2014 Team Ocho (8). All rights reserved.
//

#import "CourseViewController.h"
#import "SingleCourseViewController.h"
#import "Course.h"

@interface CourseViewController ()
@property int selectedRow;
@property SocketIO *mySocketIO;
@property Course *courseToAdd;
@end

@implementation CourseViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //need to set delegate of singleton so that it may callback to the current controller
     [ComInterface sharedInstance].delegate = self;
    _mySocketIO = [ComInterface sharedInstance].socketIO;
    
    [_mySocketIO sendEvent:@"getCourses" withData:@1];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)fillCourseList:(NSArray *)response rowCount:(NSInteger)rowCount
{    
    for (int i = 0; i < rowCount; i++) {
        NSLog(@"received response >>> data: %@", response[i]);
        
        Course *course = [[Course alloc] init];
        course.course_id = response[i][@"course_id"];
        course.name = response[i][@"course_name"];
        course.number = response[i][@"course_number"];
        [self.courses addObject:course];
        
        //insert into course list
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([self.courses count] - 1) inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)receivedPacket:(id)packet
{
    NSArray *response = packet[@"args"][0][@"rows"];
    NSInteger count = [(NSNumber *)[packet[@"args"][0] objectForKey:@"rowCount"] integerValue];
    
    if([packet[@"name"] isEqual: @"foundCourses"])
    {
        [self fillCourseList:response rowCount:count];
    }
    else if([packet[@"name"] isEqual: @"courseDeleted"])
    {
        NSLog(@"Course deleted successfully");
    }
    else if([packet[@"name"] isEqual: @"courseAdded"])
    {
        _courseToAdd.course_id = response[0][@"addcourse"];
        [self addCourseToTable:_courseToAdd];
        _courseToAdd = nil;
        NSLog(@"Course added successfully");
    }
    else if([packet[@"name"] isEqual: @"ProfAssignmentSubmitted"])
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
        NSLog(@"Professor Assignment Added Successfully");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.courses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CourseCell"];
    
    Course *course = (self.courses)[indexPath.row];
    cell.textLabel.text = course.name;
    cell.detailTextLabel.text = course.number;
    
    return cell;
}

- (void)courseDetailsViewControllerDidSave:(CourseDetailsViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)courseDetailsViewControllerDidCancel:(CourseDetailsViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AddCourse"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        CourseDetailsViewController *courseDetailsViewController
                                  = [navigationController viewControllers][0];
        courseDetailsViewController.delegate = self;
    }
    if ([segue.identifier isEqualToString:@"CourseChosen"]) {
        SingleCourseViewController *controller = (SingleCourseViewController *) segue.destinationViewController;
        controller.currCourse = (self.courses)[self.selectedRow];
    }
}

- (void)addCourseToTable:(Course *)course
{
    //add course to table view
    [self.courses addObject:course];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([self.courses count] - 1) inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)courseDetailsViewController:(CourseDetailsViewController *)controller didAddCourse:(Course *)course
{
    _courseToAdd = course;
    
    //add course to server
    NSInteger userId = [ComInterface sharedInstance].userId;
    BOOL isProf = [ComInterface sharedInstance].isProf;
    NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:course.name, @"courseName",course.number, @"courseNum",course.section, @"section",course.class_times, @"times", @(userId), @"userId", @(isProf), @"isProf", nil];
    [_mySocketIO sendEvent:@"addCourse" withData:data];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

//remove course from server
- (void)deleteCourse:(NSInteger)row
{
    Course *course = self.courses[row];
    NSString *course_id = course.course_id;
    NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:course_id, @"courseId", nil];
    [_mySocketIO sendEvent:@"deleteCourse" withData:data];
    
    [self.courses removeObjectAtIndex:row];
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self deleteCourse:[indexPath row]];
        
        //remove row from tableView
        [[self tableView] deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    self.selectedRow = [indexPath row];
    //Build a segue string based on the selected cell
    NSString *segueString = [NSString stringWithFormat:@"CourseChosen"];
    
    //Since contentArray is an array of strings, we can use it to build a unique
    //identifier for each segue.
    
    //Perform a segue.
    [self performSegueWithIdentifier:segueString sender:[self.courses objectAtIndex:[indexPath row]]];
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
