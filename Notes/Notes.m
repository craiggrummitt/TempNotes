//
//  Notes.m
//  Notes
//
//  Created by Craig on 8/07/2015.
//  Copyright (c) 2015 Thinkful. All rights reserved.
//

#import "Notes.h"
#import "Note.h"

@interface Notes ()
@end

@implementation Notes


-(id)initWithNotes:(NSArray *)notes {
    self = [super init];
    if (!self) {
        return nil; //something went wrong!
    }
    self.notes = [notes mutableCopy];
    return self;
}
-(NSInteger)count {
    return self.notes.count;
}
-(void)addNote:(Note *)note {
    [self.notes addObject:note];
}
-(Note *)getNoteAtIndex:(NSInteger)index {
    return self.notes[index];
}
-(Note *)deleteNoteAtIndex:(NSInteger)index {
    Note *noteToDelete = self.notes[index];
    [self.notes removeObjectAtIndex: index];
    return (noteToDelete);
}
-(void)moveFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    Note *noteToMove = [self deleteNoteAtIndex:fromIndex];
    [self.notes insertObject:noteToMove atIndex:toIndex];
}
#pragma mark - NSCoding protocol
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.notes forKey:@"notes"];
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [self init];
    NSArray *notesImmutable = [coder decodeObjectForKey:@"notes"];
    self.notes = [[NSMutableArray alloc] initWithArray:notesImmutable copyItems:YES];
    return self;
}
@end
