
#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"

@interface LeftMenuVC : UIViewController <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, assign) BOOL slideOutAnimationEnabled;

@end
