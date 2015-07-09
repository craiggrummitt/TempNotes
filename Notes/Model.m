//
//  Model.m
//  Notes
//
//  Created by Craig on 4/07/2015.
//  Copyright (c) 2015 Thinkful. All rights reserved.
//

#import "Model.h"
#import "Notes.h"
#import "Note.h"

@implementation Model
+ (Model *)sharedModel
{
    static Model* modelSingleton = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        modelSingleton = [[Model alloc] init];
    });
    return modelSingleton;
}

-(Notes *)notes {
    if (!_notes) {
       /* _notes = [[Notes alloc] initWithNotes:@[
                                                [[Note alloc] initWithTitle:@"First note" detail:@"Here's some detail"],
                                                [[Note alloc] initWithTitle:@"Second note" detail:@"Here's some more detail"]
                                                ]
                  ];*/
        _notes = [[Notes alloc] initWithNotes:[self loadNotes]];
    }
    return _notes;
}


-(void)saveNotes {
    [NSKeyedArchiver archiveRootObject:self.notes.notes toFile:[self filePath]];
}
-(NSArray *)loadNotes {
    NSArray *notesArray = [NSKeyedUnarchiver unarchiveObjectWithFile:[self filePath]];
    if (!notesArray) {
        notesArray = @[];
    }
    return(notesArray);
}
-(NSString *)filePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    return ([documentsDirectoryPath stringByAppendingPathComponent:@"appData"]);
}

/*-(void)saveNote:(Note *)note {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:note.title forKey:@"title"];
    [defaults setObject:note.detail forKey:@"detail"];
    [defaults synchronize];
}
-(Note *)loadNote {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *title = [defaults stringForKey:@"title"];
    NSString *detail = [defaults stringForKey:@"detail"];
    Note *note;
    if (title && detail) {
        note = [[Note alloc] initWithTitle:title detail:detail];
    } else {
        note = [[Note alloc] initWithTitle:@"" detail:@""];
    }
    return note;

}*/
@end
