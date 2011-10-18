//
//  MainViewController.h
//  BarCodeScanner
//
//  Created by Corin Lawson on 18/10/11.
//  Copyright (c) 2011 Corin Lawson. All rights reserved.
//

#import "ScannerKit.h"
#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, SKScannerViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *scanButton;

@end
