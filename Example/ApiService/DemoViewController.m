//
//  DemoViewController.m
//  ApiService
//
//  Created by guoshencheng on 10/10/15.
//  Copyright © 2015 guoshencheng. All rights reserved.
//

#import "DemoViewController.h"

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickGetButton:(id)sender {
    [[ApiService serviceWithDelegate:self] sendRequest:[ApiRequest requestForGet]];
}

- (IBAction)clickPostButton:(id)sender {
    [[ApiService serviceWithDelegate:self] sendRequest:[ApiRequest requestForPost]];
}

- (IBAction)clickPutButton:(id)sender {
    [[ApiService serviceWithDelegate:self] sendRequest:[ApiRequest requestForPut]];
}

- (IBAction)clickDeleteButton:(id)sender {
    [[ApiService serviceWithDelegate:self] sendRequest:[ApiRequest requestForDelete]];
}

- (IBAction)Multiparty:(id)sender {
    [[ApiService serviceWithDelegate:self] sendRequest:[ApiRequest requestForMultiparty]];
}

- (void)service:(ApiService *)service didFinishRequest:(ApiRequest *)request withResponse:(ApiResponse *)response {
    if (response.entities) {
        NSLog(@"%@", response.entities);
    } else if(response.entity) {
        NSLog(@"%@", response.entity);
    } else {
        
    }
}

@end
