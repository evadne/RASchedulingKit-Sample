//
//  RAViewController.m
//  RASchedulingKit-Sample
//
//  Created by Evadne Wu on 10/11/12.
//  Copyright (c) 2012 Radius. All rights reserved.
//

#import "RAViewController.h"
#import "RASchedulingKit.h"
#import "RAOperationQueue.h"

@interface RAViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, readwrite, strong) NSArray *tableCellContents;
@property (nonatomic, readwrite, strong) NSTimer *timer;
@end

@implementation RAViewController

//	- (NSOperationQueue *) ra_newOperationQueue {
//		
//		
//
//	}

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (!self)
		return nil;
	
	self.title = @"Hello World";
	_tableCellContents = @[];
	
	return self;
	
}

- (void) viewDidLoad {

	[super viewDidLoad];
	
	[self.tableView reloadData];

}

- (void) viewDidAppear:(BOOL)animated {

	[super viewDidAppear:animated];
	
	//	Simulate the timer using the common modes, instead of using the default timer
	//	to simulate things that happen at unfortnuate times such as an operation
	//	completing
	
	self.timer = [NSTimer timerWithTimeInterval:0.125f target:self selector:@selector(handleTimer:) userInfo:nil repeats:YES];
	[[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
	
}

- (void) viewWillDisappear:(BOOL)animated {

	[super viewWillDisappear:animated];
	
	[self.timer invalidate];
	self.timer = nil;

}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

	return [self.tableCellContents count];

}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	NSString *identifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	}
	
	cell.textLabel.text = [self.tableCellContents objectAtIndex:indexPath.row];
	return cell;

}

- (void) handleTimer:(NSTimer *)timer {

	__weak typeof(self) wSelf = self;
	
	[self ra_performBlock:^{
	
		NSDate *date = [NSDate date];
		static NSDateFormatter *dateFormatter;
		static dispatch_once_t onceToken;
		dispatch_once(&onceToken, ^{
			dateFormatter = [[NSDateFormatter alloc] init];
			dateFormatter.dateStyle = NSDateFormatterShortStyle;
			dateFormatter.timeStyle = NSDateFormatterShortStyle;
		});
		
		wSelf.tableCellContents = [wSelf.tableCellContents arrayByAddingObject:[dateFormatter stringFromDate:date]];
		
		[wSelf.tableView beginUpdates];
		[wSelf.tableView insertRowsAtIndexPaths:@[
			[NSIndexPath indexPathForRow:([wSelf.tableCellContents count] - 1) inSection:0]
		] withRowAnimation:UITableViewRowAnimationFade];
		[wSelf.tableView endUpdates];
		
	}];

}

@end
