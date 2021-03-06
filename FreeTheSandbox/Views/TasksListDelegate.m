//
//  TasksListSource.m
//  FreeTheSandbox
//
//  Created by codecolorist on 2020/2/17.
//  Copyright © 2020 CC. All rights reserved.
//

#import "TasksListDelegate.h"

@implementation TasksListDelegate

- (id)initWithTable:(NSTableView*)table tasks:(NSArray<PFTProcess*>*)data
{
    self = [super init];
    if (self)
    {
        self.data = data;
        self.table = table;
    }
    return self;
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.data.count;
}

- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row {
    NSString *identifier = tableColumn.identifier;
    PFTProcess *task = self.data[row];

//    if ([identifier isEqualToString:@"MainCell"]) {
//
//    }
    
    if ([identifier isEqualToString:@"NameCell"]) {
        NSTableCellView *cellView = [tableView makeViewWithIdentifier:identifier owner:self];
        cellView.textField.stringValue = task.processName;
        cellView.imageView.objectValue = task.image;
        return cellView;
    }
    
    NSString *(^TextForCell)(NSString *cell) = ^NSString *(NSString *cell) {
        if ([cell isEqualToString:@"PathCell"]) {
            return task.executablePath;
        } else if ([cell isEqualToString:@"PIDCell"]) {
            return [NSString stringWithFormat:@"%d", task.processIdentifier];
        }
        return nil;
    };
    
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:identifier owner:self];
    NSString *value = TextForCell(identifier);
    cellView.textField.stringValue = value ? value : @"N/A";
    return cellView;
}

@end
