#Organic [![License](http://img.shields.io/:license-mit-blue.svg)](http://doge.mit-license.org)

A UITableViewController subclass designed with efficiency and maintanence in mind. It is intended for use with table views that have ***no reuse***, such as settings screens, profile screens, login screens, etc., and ***handles just about everything for you.***

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

Step 1. Subclass or create instances of `OrganicCell`.
---

These cells encapsulate two major properties, `height` and `actionBlock`.

The `height` property, as the name indicates, defines the height of the cell. When you layout your cell and all of its subViews, you can set the height based on the contents and the cell itself will be responsible for reporting the proper size in `heightForRowAtIndexPath:`. If this is never set, `UITableViewAutomaticDimension` is the fallback.

The `actionBlock` property defines the action that will be performed when the cell is selected and `didSelectRowAtIndexPath:` is called. Setting the `actionBlock` property on the cell when you create it allows you to keep the behavior of the cell when selected paired with the creation of the cell, so if you ever want to modify this cell and the action associated with it, you don't need to go searching through the code to find where it is defined.  If this property is never set, nothing happens when the cell is selected.

```objective-c
OrganicCell *myCell = [OrganicCell cellWithStyle:UITableViewCellStyleDefault height:44 actionBlock:^{
	// Do whatever you want here when the cell is selected.
}];
```

Step 2. Design your `OrganicSection` objects.
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

Step 3. Subclass `OrganicTableViewController` and put it all together.
---

You can choose when/where to define your sections. `viewDidLoad` or `viewWillAppear:` are two decent candidates. Create your cells, insert them into sections, insert the sections in an array in the order you want, and set them as the `sections` property. There is no need to `reloadData` after doing this, setting the sections will take care of that automatically.

Here is a simple example that can easily be scaled to whatever degree you desire.



```objective-c
- (void)viewDidLoad {
	[super viewDidLoad];
	
	OrganicCell *helloWorldCell = [OrganicCell cellWithStyle:UITableViewCellStyleDefault height:40 actionBlock:^{
		[[[UIAlertView alloc] initWithTitle:@"Hello World" message:@"Organic is awesome!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
	}];
	helloWorldCell.textLabel.text = @"Say Hello";
	
	OrganicCell *goodbyeWorldCell = [OrganicCell cellWithStyle:UITableViewCellStyleDefault height:55 actionBlock:^{
		[[[UIAlertView alloc] initWithTitle:@"Goodbye World" message:@"Toodles!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
	}];
	goodbyeWorldCell.textLabel.text = @"Say Goodbye";
	
	OrganicSection *firstSection = [OrganicSection sectionWithHeaderTitle:@"Welcome" cells:@[helloWorldCell, goodbyeWorldCell]];
	
	OrganicCell *randomCell = [OrganicCell cellWithStyle:UITableViewCellStyleSubtitle height:44 actionBlock:^{
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
			[[[UIAlertView alloc] initWithTitle:@"Java" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
		});
	}];
	randomCell.textLabel.text = @"Knock knock...";
	randomCell.detailTextLabel.text = @"Who's there?";
	
	OrganicSection *secondSection = [OrganicSection sectionWithCells:@[randomCell]];
	
	self.sections = @[firstSecion, secondSection];
}
```

Step 4. Compare
---
We just created an extremely simple table view controller with only a few lines of code and no logic needed. Compare this with a similar implementation using a generic UITableViewController:

```objective-c
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section == 0) {
		return 2;
	}
	
	else {
		return 1;
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
	
	else {
		return 44;
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
	else {
		UITableViewCell *boringCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
		boringCell.textLabel.text = @"Knock knock..";
		boringCell.detailTextLabel.text = @"Who's there?";
		return boringCell;	
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
    	if (indexPath.row == 0) {
			[[[UIAlertView alloc] initWithTitle:@"Hello World" message:@"Organic is awesome!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
		}
    
		else {
			[[[UIAlertView alloc] initWithTitle:@"Goodbye World" message:@"Toodles!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
		}	
	}
	
	else {
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
			[[[UIAlertView alloc] initWithTitle:@"Java" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
		});
	}
}
```

Now consider what you'd have to do if you wanted to switch around the order of the cells, or add another cell into the section in between, or add another section and move one cell to the other.

Using `Organic` reduced the code in the above example, which was one of the simplest table view controllers possible, by about 2/3. It will make the initial implementation drastically quicker, and will make maintanence a breeze, or your money back.

Community
====

Questions, comments, issues, and pull requests welcomed!!


License
====

This project is made available under the MIT license. See LICENSE.txt for details.
