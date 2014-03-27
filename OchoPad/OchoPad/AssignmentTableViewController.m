//
//  AssignmentTableViewController.m
//  OchoPad
//
//  Created by Hugo Cabral Tannus on 2014-03-24.
//  Copyright (c) 2014 Team Ocho (8). All rights reserved.
//

#import "AssignmentTableViewController.h"
#import "ProfAssignment.h"


@implementation AssignmentTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    NSString *keyA = @"Assignment 1";
    NSString *keyB = @"Assignment 2";
    
    assignmentsDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                       [[NSDate alloc] init], keyA,
                       [[NSDate alloc] initWithTimeIntervalSinceNow:(24*60*60)], keyB, nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[ComInterface sharedInstance].delegate = self;
    //SocketIO *mySocketIO = [ComInterface sharedInstance].socketIO;
    
    //assignments = [[NSMutableArray alloc] init];
    //NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
     //                     @1, @"course_id", nil];
    
    //[mySocketIO sendEvent:@"getAssignmentsForCourse" withData:data];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [assignmentsDict count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"AssignmentCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    /*
     //5.1 you do not need this if you have set SettingsCell as identifier in the storyboard (else you can remove the comments on this code)
     if (cell == nil)
     {
     cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
     }
     */
    
    NSArray *keysList = [assignmentsDict allKeys];
    NSLog(@"%@\n", keysList);
    NSString *key = [keysList objectAtIndex:indexPath.row];
    NSLog(@"%@\n", key);
    NSDate *dueDate = [assignmentsDict objectForKey:key];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    NSString *formattedDateString = [dateFormatter stringFromDate:dueDate];
    
    [cell.textLabel setText:key];
    [cell.detailTextLabel setText:
     [NSString stringWithFormat:@"Due to %@.",formattedDateString]];
    return cell;
}

- (void)receivedPacket:(id)packet
{
    NSLog(@"receivedPacketAssigments >>>>> ");
    NSLog(@"got Packet:\n%@", packet);
    
    NSArray *response = packet[@"args"][0];
    NSLog(@"\ngot Response:\n%@", response);
    //NSInteger count = [(NSNumber *)[packet[@"args"][0] objectForKey:@"rowCount"] integerValue];
    NSInteger count = [response count];
    
    NSLog(@"Response count:\n%d", count);
    
    if([packet[@"name"] isEqual: @"foundAssignments"])
    {
        [self fillAssignmentList:response rowCount:count];
    }
    
    //else if([packet[@"name"] isEqual: @"ProfAssignmentSubmitted"])
    //{
    //  NSLog(@"Professor Assignment Added Successfully");
    //[self dismissViewControllerAnimated:YES completion:nil];
    //[self.navigationController popViewControllerAnimated:YES];
    //}
}

- (void)fillAssignmentList:(NSArray *)response rowCount:(NSInteger)rowCount
{
    NSIndexPath *indexP;
    
    while([assignments count] > 0) {
        indexP = [NSIndexPath indexPathForRow:([assignments count] - 1) inSection:0];
        [assignments removeObjectAtIndex:0];
        [[self tableView] deleteRowsAtIndexPaths:@[indexP] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    for (int i = 0; i < rowCount; i++) {
        NSLog(@"received response >>> data: %@", response[i]);
        
        ProfAssignment *assignment = [[ProfAssignment alloc] init];
        assignment.AssignmentName = response[i][@"assignment_name"];
        assignment.DueDate = response[i][@"due_date"];
        assignment.ReleaseDate = response[i][@"viewable_date"];
        [assignments addObject:assignment];
        
        
        NSLog(@"Assignment name: %@", assignment.AssignmentName);
        NSLog(@"received assignment >>> data: %@", assignment);
        NSLog(@"received response >>> data: %d", [assignments count]);
        /*
         NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([assignments count] - 1) inSection:0];
         [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
         */
    }
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

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
