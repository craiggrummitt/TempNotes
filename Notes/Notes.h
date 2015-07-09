//
//  Notes.h
//  Notes
//
//  Created by Craig on 8/07/2015.
//  Copyright (c) 2015 Thinkful. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Note;

@interface Notes : NSObject<NSCoding>
@property (strong, nonatomic) NSMutableArray *notes;
@property (assign, nonatomic) NSInteger  count;
-(id)initWithNotes:(NSArray *)notes;
-(Note *)getNoteAtIndex:(NSInteger)index;
-(void)addNote:(Note *)note;
-(Note *)deleteNoteAtIndex:(NSInteger)index;
-(void)moveFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;
//func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
@end
