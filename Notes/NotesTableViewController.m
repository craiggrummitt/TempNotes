//
//  NotesTableViewController.m
//  Notes
//
//  Created by Craig on 8/07/2015.
//  Copyright (c) 2015 Thinkful. All rights reserved.
//

#import "NotesTableViewController.h"
#import "ViewController.h"
#import "Model.h"
#import "Note.h"

@interface NotesTableViewController ()
@property (strong, nonatomic) Note *noteToAdd;
@end

@implementation NotesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"note"];
    self.title = @"Notes";
    
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(toggleEdit:)];
    self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNote:)];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.noteToAdd && ![self.noteToAdd isBlank]) {
        [[Model sharedModel].notes addNote:self.noteToAdd];
    }
    [self.tableView reloadData];
    [[Model sharedModel] saveNotes];
    self.noteToAdd = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) toggleEdit:(UIButton*)sender {
    //tableView.setEditing(!tableView.editing, animated: true)
    [self.tableView setEditing:!self.tableView.editing animated:YES];
}
-(void)addNote:(id)sender {
    self.noteToAdd = [[Note alloc] initWithTitle:@"" detail:@""];
    ViewController *detailViewController = [[ViewController alloc] initWithNote:self.noteToAdd];
    [self.navigationController pushViewController:detailViewController animated:YES];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[Model sharedModel].notes count];
}


#pragma mark - Table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"note" forIndexPath:indexPath];
    Note *note = [[Model sharedModel].notes getNoteAtIndex:indexPath.row];
    cell.textLabel.text = note.title;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Note *note = [[Model sharedModel].notes getNoteAtIndex:indexPath.row];
    ViewController *detailViewController = [[ViewController alloc] initWithNote:note];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[Model sharedModel].notes deleteNoteAtIndex:indexPath.row];
        [[Model sharedModel] saveNotes];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    [[Model sharedModel].notes moveFromIndex:fromIndexPath.row toIndex:toIndexPath.row];
    [[Model sharedModel] saveNotes];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
