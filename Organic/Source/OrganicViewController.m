//
//  OrganicViewController.m
//  Organic
//
//  Created by Mike on 1/7/15.
//  Copyright (c) 2015 Mike Amaral. All rights reserved.
//

#import "OrganicViewController.h"

@interface OrganicViewController ()

@end

@implementation OrganicViewController

#pragma mark - Setting sections

- (void)setSections:(NSArray *)sections {
    _sections = sections;
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    OrganicSection *organicSection = self.sections[section];
    return organicSection.headerView;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    OrganicSection *organicSection = self.sections[section];
    return organicSection.headerTitle;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    OrganicSection *organicSection = self.sections[section];
    return organicSection.headerHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    OrganicSection *organicSection = self.sections[section];
    return organicSection.footerView;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    OrganicSection *organicSection = self.sections[section];
    return organicSection.footerTitle;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    OrganicSection *organicSection = self.sections[section];
    return organicSection.footerHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    OrganicSection *organicSection = self.sections[section];
    return organicSection.reuseEnabled ? organicSection.reusedCellCount : organicSection.cells.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrganicSection *organicSection = self.sections[indexPath.section];
    
    if (organicSection.reuseEnabled) {
        return organicSection.reusedCellHeight;
    }
    
    else {
        OrganicCell *cell = organicSection.cells[indexPath.row];
        return cell.height;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrganicSection *organicSection = self.sections[indexPath.section];
    
    if (organicSection.reuseEnabled) {
        return organicSection.cellForRowBlock(tableView, indexPath.row);
    }
    
    else {
        return organicSection.cells[indexPath.row];
    }
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    OrganicSection *organicSection = self.sections[indexPath.section];
    
    if (organicSection.reuseEnabled) {
        if (organicSection.reusedCellActionBlock) {
            organicSection.reusedCellActionBlock(indexPath.row);
        }
    }
    
    else {
        OrganicCell *cell = organicSection.cells[indexPath.row];
        
        if (cell.actionBlock) {
            cell.actionBlock();
        }
    }
}


@end
