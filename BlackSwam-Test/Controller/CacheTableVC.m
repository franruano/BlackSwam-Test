
#import "CacheTableVC.h"
#import "CatModel.h"
#import "Constants.h"



@interface CacheTableVC ()

@property (nonatomic,strong) NSArray *arrayImagesCached;

@end

@implementation CacheTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.arrayImagesCached = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:kStoreMemory]];
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayImagesCached.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Set the data for this cell:
    CatModel *cat = (CatModel*)[self.arrayImagesCached objectAtIndex:indexPath.row];
    cell.textLabel.text = cat.fileName;
    cell.imageView.image = [UIImage imageWithData:[cat getCacheImage]];
    
    return cell;
}




#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu {
    return YES;
}

@end
