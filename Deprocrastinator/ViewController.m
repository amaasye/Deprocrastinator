//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Syed Amaanullah on 1/12/15.
//  Copyright (c) 2015 Syed Amaanullah. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property NSMutableArray *tasks;
@property (weak, nonatomic) IBOutlet UITextField *taskCreator;
@property (weak, nonatomic) IBOutlet UITableView *taskTableView;
@property UITableViewCell *cell;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.editButton.title = @"Edit";

    self.tasks = [NSMutableArray arrayWithObjects: @"Finish code challenge", @"Do laundry", @"Pay phone bill", @"Walk the dog", nil];
}

#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tasks.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToDoItemID"];
    cell.textLabel.text = [self.tasks objectAtIndex:indexPath.row];

    return cell;
}

- (IBAction)onAddButtonPressed:(UIBarButtonItem *)sender {

    NSString *newTask = [NSString stringWithFormat:@"%@", self.taskCreator.text];

    [self.tasks addObject:newTask];
    [self.taskTableView reloadData];
    [self.view endEditing:YES];
    self.taskCreator.text = @"";

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor greenColor];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;

    if ([self.editButton.title isEqualToString:@"Done"]) {
        [self.tasks removeObjectAtIndex:indexPath.row];
        [self.taskTableView reloadData];
    }


}
- (IBAction)onEditButtonPressed:(id)sender {

        self.editButton.title = @"Done";

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.tasks removeObjectAtIndex:indexPath.row];
        [self.taskTableView reloadData];
    }
}

- (IBAction)swipeRight:(UISwipeGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:self.taskTableView];
    NSIndexPath *indexPath = [self.taskTableView indexPathForRowAtPoint:point];
    UITableViewCell *cell = [self.taskTableView cellForRowAtIndexPath:indexPath];

    if (cell.textLabel.textColor == [UIColor blackColor])  {
        cell.textLabel.textColor = [UIColor redColor];
    }
    else if (cell.textLabel.textColor == [UIColor redColor]) {
        cell.textLabel.textColor = [UIColor yellowColor];
    }
    else if (cell.textLabel.textColor == [UIColor yellowColor]) {
        cell.textLabel.textColor = [UIColor greenColor];
    }

}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {

    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSString *stringToMove = [self.tasks objectAtIndex:sourceIndexPath.row];
    [self.tasks removeObject:stringToMove];
    [self.tasks insertObject:stringToMove atIndex:destinationIndexPath.row];
    [self.taskTableView reloadData];
}







@end
