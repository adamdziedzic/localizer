//
// Created by Adam Dziedzic on 16.10.2014.
//

#import <Foundation/Foundation.h>


@interface MainViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *searchField;


@end