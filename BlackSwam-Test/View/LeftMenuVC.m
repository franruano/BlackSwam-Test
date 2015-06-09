#import "LeftMenuVC.h"
#import "SlideNavigationContorllerAnimatorFade.h"
#import "SlideNavigationContorllerAnimatorSlide.h"
#import "SlideNavigationContorllerAnimatorScale.h"
#import "SlideNavigationContorllerAnimatorScaleAndFade.h"
#import "SlideNavigationContorllerAnimatorSlideAndFade.h"

@implementation LeftMenuVC

#pragma mark - UIViewController Methods -

- (id)initWithCoder:(NSCoder *)aDecoder {
	self.slideOutAnimationEnabled = YES;
	return [super initWithCoder:aDecoder];
}

- (void)viewDidLoad {
	[super viewDidLoad];
}

#pragma mark - UITableView Delegate & Datasrouce -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 20)];
	view.backgroundColor = [UIColor clearColor];
	return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftMenuCell"];
	switch (indexPath.row)
	{
		case 0:
			cell.textLabel.text = @"Home";
			break;
		case 1:
			cell.textLabel.text = @"Check cached Images";
			break;
		case 2:
			cell.textLabel.text = @"Clean cache";
			break;
	}
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"UIMainStoryboardFile"] bundle: nil];
	
	UIViewController *vc ;
	
	switch (indexPath.row)
	{
		case 0:
			vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"HomeVC"];
			break;
			
		case 1:
			vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"CacheTableVC"];
			break;
			
		case 2:
            [self showAlertMessage];
            
			break;
	}
    if (vc){
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
															 withSlideOutAnimation:self.slideOutAnimationEnabled
																	 andCompletion:nil];
    }
}

#pragma marks - UIAlertview
- (void) showAlertMessage {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Clean cache?" message:@"Do you really want to clean the cache?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    [alert addButtonWithTitle:@"Yes"];
    [alert setDelegate:self];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSLog(@"Cleaning cache");
        [self cleanCache];

        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier: @"HomeVC"];
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                                 withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                         andCompletion:nil];
    }else{
         [[SlideNavigationController sharedInstance] closeMenuWithCompletion:nil];
    }
}

- (void) cleanCache {
    //Deleting file phisically
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesFolder = paths[0];
    NSError *error = nil;
    for (NSString *file in [fm contentsOfDirectoryAtPath:cachesFolder error:&error]) {
        [fm removeItemAtPath:[NSString stringWithFormat:@"%@%@", cachesFolder, file] error:&error];
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"catStored"];
    [userDefaults synchronize];
}
@end
