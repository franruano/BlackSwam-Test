#import "HomeVC.h"
#import "CatModel.h"
#import "Constants.h"


@interface HomeVC ()

@property (weak, nonatomic) IBOutlet UIImageView *imageCat;
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) NetworkManager *networkController;

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.networkController = [[NetworkManager alloc] init];
    [self.networkController setDelegate:self];
    [self.activityIndicator setHidden:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setInitialMessage];
    [self.imageCat setImage:nil];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - SlideNavigationController Methods
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu {
    return YES;
}

#pragma mark - Label Helper
- (void) setInitialMessage {
    [self.lblMessage setTextColor: [UIColor blackColor]];
    [self.lblMessage setText:@"Shake to load an image"];
    [self.lblMessage setFont:[UIFont systemFontOfSize:16]];
    
}
- (void) setErrorMessage:(NSString *)errorMessage {
    [self.lblMessage setTextColor: [UIColor redColor]];
    [self.lblMessage setText:[NSString stringWithFormat:@"%@ \n %@", @"Error! Try later", errorMessage]];
    [self.lblMessage setFont:[UIFont systemFontOfSize:14]];
    
}

#pragma marks - delegate NetworkController
- (void) NetworkManagerDidFinishLoadingItem:(id)item message:(NSError *)error{
    if (item){
        [self.imageCat setImage:[UIImage imageWithData:(NSData *) item]];
        [self setInitialMessage];
        CatModel *cat = [[CatModel alloc] init];
        [cat setCacheImage:(NSData *) item];
        [self addCatToCache:cat];
    }else{
        [self setErrorMessage:error.description];
        [self.imageCat setImage:nil];
    }
    [self hideActivityIndicator];
}

#pragma marks - shaker detection
- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake)
    {
        [self showActivityIndicator];
       [self.networkController createUrlRequest:kApi];
    }
}
#pragma marks - ActivityIndicator
- (void) showActivityIndicator {
    [self.activityIndicator setHidden:NO];
    [self.activityIndicator startAnimating];
}
- (void) hideActivityIndicator {
    [self.activityIndicator setHidden:YES];
    [self.activityIndicator stopAnimating];
}


#pragma mark - Functions
- (void) addCatToCache:(CatModel *)cat {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *arrayOfCats = [[NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:kStoreMemory]] mutableCopy];
    if (!arrayOfCats){
        arrayOfCats = [[NSMutableArray alloc] init];
    }
    [arrayOfCats addObject:cat];
    [userDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:arrayOfCats] forKey:kStoreMemory];
    [userDefaults synchronize];
}


@end
