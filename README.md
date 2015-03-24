![demo](Screenshots/logo.png)
Logo by [T.E.D. Andrick](http://www.liquid-anvil.com/)

[![License](https://img.shields.io/cocoapods/l/Organic.svg)](http://doge.mit-license.org) [![Build Status](https://img.shields.io/travis/mamaral/Organic.svg)](https://travis-ci.org/mamaral/Organic/) ![Badge w/ Version](https://img.shields.io/cocoapods/v/Organic.svg)

A UITableViewController subclass designed with efficiency and maintenance in mind, and tries its best to ***handle just about everything for you.***

No more if-statements and switches in *every* table view dataSource and delegate method. No more splitting up all the logic for each row and section into a dozen different methods, making addition, removal, or minor alterations to format and layout a headache. We feel your pain, we know the struggle. Moving one section of cells below another, moving cells between sections, adding new cells to existing sections, etc., with a decently-complex table view can be a nightmare, but with `Organic` it's as simple as changing the order of objects in an array.

Organic allows you to define the sections and which cells they contain all-at-once, and takes care of the rest of the housekeeping for you.

Ignoring the custom cells, which are created in their respective classes, creating the below table view with `Organic` took less than 20 lines of code:

![demo](Screenshots/demo.png)



Installation
===

Available via [CocoaPods](http://cocoapods.org/?q=Organic)

```ruby
pod ‘Organic’
```

Get Started
====

OrganicViewControllers are comprised of sections that can either be static and pre-generated, or can contain reusable cells that can be dequeued and customized for better performance and efficiency. In the above example, showing a GitHub profile, the first section with 3 cells is pre-generated, whereas the repositories section is built using reusable cells.

Building Pre-Generated Cells (*not for reuse*)
---

To do this, you first need to subclass or create instances of `OrganicCell`. These cells encapsulate two major properties, `height` and `actionBlock`.

The `height` property, as the name indicates, defines the height of the cell. When you layout your cell and all of its subViews, you can set the height based on the contents and the cell itself will be responsible for reporting the proper size in `heightForRowAtIndexPath:`. If this is never set, `UITableViewAutomaticDimension` is the fallback.

The `actionBlock` property defines the action that will be performed when the cell is selected and `didSelectRowAtIndexPath:` is called. Setting the `actionBlock` property on the cell when you create it allows you to keep the behavior of the cell when selected paired with the creation of the cell, so if you ever want to modify this cell and the action associated with it, you don't need to go searching through the code to find where it is defined.  If this property is never set, nothing happens when the cell is selected.

```objective-c
OrganicCell *myCell = [OrganicCell cellWithStyle:UITableViewCellStyleDefault height:44 actionBlock:^{
	// Do whatever you want here when the cell is selected.
}];
```

Building Sections with Pre-Generated Cells
---

The `OrganicSection` object encapsulates all of the properties that define a table view section. Whatever you set the `headerTitle` and/or `footerTitle` properties as will be returned in the `titleForHeaderInSection:` and `titleForFooterInSection:` methods respectively. 

If you want to define a `UIView` as the `viewForHeaderInSection:` or `viewForFooterInSection:`, set the `headerView` and/or `footerView` properties on the object. Whenever you're defining either a header or footer view, be sure to also set the accompanying `headerHeight` and `footerHeight` properties so when `heightForHeaderInSection` and `heightForFooterInSection`are called the table view will make it fit accordingly.

Lastly, every section will contain an array of `OrganicCell` objects that you create that will be returned in the defined order inside `cellForRowAtIndexPath:`.

Various convenience class methods have been created with the different combinations of titles and views to make your life a little easier. Sections can contain any combination of titles and views that you want as long as they don't use both a title and a view for the header or footer. If this were to occur, the views would take precedent.

```objective-c
+ (instancetype)sectionWithCells:(NSArray *)cells;
+ (instancetype)sectionWithHeaderTitle:(NSString *)headerTitle cells:(NSArray *)cells;
+ (instancetype)sectionWithHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle cells:(NSArray *)cells;
+ (instancetype)sectionWithHeaderTitle:(NSString *)headerTitle footerView:(UIView *)footerView footerHeight:(CGFloat)footerHeight cells:(NSArray *)cells;
+ (instancetype)sectionWithHeaderView:(UIView *)headerView headerHeight:(CGFloat)headerHeight cells:(NSArray *)cells;
+ (instancetype)sectionWithHeaderView:(UIView *)headerView headerHeight:(CGFloat)headerHeight footerTitle:(NSString *)footerTitle cells:(NSArray *)cells;
+ (instancetype)sectionWithHeaderView:(UIView *)headerView headerHeight:(CGFloat)headerHeight footerView:(UIView *)footerView footerHeight:(CGFloat)footerHeight cells:(NSArray *)cells;
+ (instancetype)sectionWithFooterTitle:(NSString *)footerTitle cells:(NSArray *)cells;
+ (instancetype)sectionWithFooterView:(UIView *)footerView footerHeight:(CGFloat)footerHeight cells:(NSArray *)cells;
```

Building Sections That Support Cell Reuse
---
OrganicSections now support cell reuse. To create such a section, you need to call the below convenience initializer and provide a few parameters:

```objective-c
+ (instancetype)sectionSupportingReuseWithTitle:(NSString *)title cellCount:(NSInteger)cellCount cellHeight:(CGFloat)cellHeight cellForRowBlock:(CellForRowBlock)cellForRowBlock actionBlock:(CellActionBlock)actionBlock;
```

- `title` will be the title of the table view section. Leave this nil if you don't want a header title.
- `cellCount` is just what it sounds like, the number of cells this row will have. You should use whatever you would normally use for your dataSource, such as the count of an NSArray.
- `cellHeight` is what you would normally return in `heightForRowAtIndexPath:`. Currently, Organic only supports a single height for all cells in a section supporting reuse. I am looking into ways to get around the fact that `heightForRowAtIndexPath:` is called before `cellForRowAtIndexPath:`, which causes headaches-galore for people who want to let their cells determine their height once they are created.
- `cellForRowBlock` is a block that is called when the parent OrganicViewController's `cellForRowAtIndexPath:` is called. You will be provided a reference to the table view, and the row index, and should implement this the same way you would normally implement cell reuse.
- `actionBlock` is a block that is called when the cell is selected. You are provided the row index for this, and can define the action you want to occur when a cell at that index is tapped.

Putting It All Together
---

First, subclass `OrganicViewController`. You can choose when/where to define your sections. `viewDidLoad` or `viewWillAppear:` are two decent candidates. Create your cells, insert them into sections, insert the sections in an array in the order you want, and set them as the `sections` property. There is no need to `reloadData` after doing this, setting the sections will take care of that automatically.

Here is a simple example of a table view with three section, two that are pre-built, and one that supports reuse, and could easily be scaled to whatever degree you desire. All of the heights, actions, titles, etc., are kept logically in the same place, where they belong.

```objective-c
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	__weak typeof(self) weakSelf = self;
	OrganicCell *helloWorldCell = [OrganicCell cellWithStyle:UITableViewCellStyleDefault height:40 actionBlock:^{
		[weakSelf doA];
	}];
	helloWorldCell.textLabel.text = @"Say Hello";
    
	OrganicCell *goodbyeWorldCell = [OrganicCell cellWithStyle:UITableViewCellStyleDefault height:55 actionBlock:^{
		[weakSelf doB];
	}];
	goodbyeWorldCell.textLabel.text = @"Say Goodbye";
    
	OrganicSection *firstStaticSection = [OrganicSection sectionWithHeaderTitle:@"Welcome" cells:@[helloWorldCell, goodbyeWorldCell]];
    
    OrganicCell *randomCell = [OrganicCell cellWithStyle:UITableViewCellStyleSubtitle height:44 actionBlock:^{
		[weakSelf doC];
	}];
	randomCell.textLabel.text = @"Knock knock...";
	randomCell.detailTextLabel.text = @"Who's there?";
    
	OrganicSection *secondStaticSection = [OrganicSection sectionWithCells:@[randomCell]];
    
	NSArray *demoDataSource = @[@"One", @"Two", @"Three"];
	OrganicSection *sectionWithReuse = [OrganicSection sectionSupportingReuseWithTitle:@"Section with Reuse" cellCount:demoDataSource.count cellHeight:55 cellForRowBlock:^UITableViewCell *(UITableView *tableView, NSInteger row) {
		static NSString *cellReuseID = @"CellReuseID";
        
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID];
        
       if (!cell) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseID];
		}
        
		cell.textLabel.text = demoDataSource[row];
        
       return cell;
        
	} actionBlock:^(NSInteger row) {
		[weakSelf doDForRow:row];
	}];
    
	self.sections = @[firstStaticSection, secondStaticSection, sectionWithReuse];
}
```

Step 4. Compare
---
We just created an extremely simple table view controller with only a few lines of code and no logic needed. Compare this with a similar implementation using a generic UITableViewController:

```objective-c
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (section == 0) {
		return @"Welcome";
	}
	
	else if (section == 2) {
		return @"Section with Reuse";
	}
	
	else {
		return nil;
	}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    
    else if (section == 1) {
        return 1;
    }
    
    else {
        return demoDataSource.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 0) {
		if (indexPath.row == 0) {
			return 40;
		}
        
       else {
			return 55;
		}
	}
    
	else if (indexPath.section == 1) {
		return 44;
	}
    
	else {
		return 55;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 0) {
		if (indexPath.row == 0) {
			UITableViewCell *helloWorldCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
			helloWorldCell.textLabel.text = @"Say Hello";
			return helloWorldCell;
		}
        
		else {
			UITableViewCell *goodbyeWorldCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
			goodbyeWorldCell.textLabel.text = @"Say Goodbye";
			return goodbyeWorldCell;
		}
	}
	else if (indexPath.section == 1) {
		UITableViewCell *boringCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
		boringCell.textLabel.text = @"Knock knock..";
		boringCell.detailTextLabel.text = @"Who's there?";		return boringCell;
	}
    
	else {
		static NSString *cellReuseID = @"CellReuseID";
        
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID];
        
		if (!cell) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseID];
		}
        
		cell.textLabel.text = demoDataSource[indexPath.row];
        
		return cell;
	}
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
	if (indexPath.section == 0) {
		if (indexPath.row == 0) {
			[self doA];
		}
        
		else {
			[self doB];
		}
	}
    
	else if (indexPath.section == 1) {
		[self doC];
	}
    
	else {
		[self doDForRow:indexPath.row];
	}
}
```

Now consider what you'd have to do if you wanted to switch around the order of the cells, or add another cell into the section in between, or add another section and move one cell to the other.

Using `Organic` reduced the code in the above example, which was one of the simplest table view controllers possible, by roughly 70%. It will make the initial implementation drastically quicker, and will make maintanence a breeze, or your money back.

Community
====

Questions, comments, issues, and pull requests welcomed!!


License
====

This project is made available under the MIT license. See LICENSE.txt for details.
