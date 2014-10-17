//
// Created by Adam Dziedzic on 16.10.2014.
//

#import "MainViewController.h"
#import "AFNetworking/AFNetworking.h"
#import "VenuesTableViewCell.h"


NSString *reuseIdentifier = @"identifier";

@implementation MainViewController {

    NSMutableArray *venues;

}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [_tableView registerClass:[VenuesTableViewCell class] forCellReuseIdentifier:reuseIdentifier];
}


- (IBAction)makeCall:(UIButton *)sender {
    NSURL *url = [[NSURL alloc] initWithString:@"https://api.foursquare.com/v2/venues/search"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:[url absoluteString]
      parameters:@{
              @"near" : @"Warsaw",
              @"client_id" : @"CVKXDA445ELKLIWQFGJRWVRV0A01WJM5HKHJBASLWJIKPJ3A",
              @"client_secret" : @"3OHXUPPTSOXZ3P2WXWVIDBEB1F504DWPKDENAJ5S1345YOBA",
              @"query" : _searchField.text,
              @"limit" : @"10",
              @"v" : @"20141015"
    }
         success:^(NSURLSessionDataTask *operation, NSDictionary *response) {
             venues = [[NSMutableArray alloc] init];
             for (int i = 0; i < ((NSArray *) response[@"response"][@"venues"]).count; ++i) {
//                NSLog(@"%@", ((NSDictionary *)response[@"response"][@"venues"][i]).allKeys);
                 NSString *name = response[@"response"][@"venues"][i][@"name"];
                 NSString *address = response[@"response"][@"venues"][i][@"location"][@"address"];
                 [venues addObject:@{@"name":name, @"address": address ? address : @"no address"}];
//                 NSLog(@"%@", response[@"response"][@"venues"][i][@"name"]);
//                 NSLog(@"%@", response[@"response"][@"venues"][i][@"location"][@"address"]);
                 [_tableView reloadData];
             }
         }
         failure:^(NSURLSessionDataTask *operation, NSError *error) {
             NSLog(@"%@", error);
         }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return venues.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VenuesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    cell.nameLabel.text = venues[indexPath.row][@"name"];
    cell.addressLabel.text = venues[indexPath.row][@"address"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}


@end