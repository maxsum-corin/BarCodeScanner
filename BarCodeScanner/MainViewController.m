//
//  MainViewController.m
//  BarCodeScanner
//
//  Created by Corin Lawson on 18/10/11.
//  Copyright (c) 2011 Corin Lawson. All rights reserved.
//

#import "MainViewController.h"
#import "ScannerKit.h"

@implementation MainViewController
@synthesize scanButton;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setScanButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (![SKScannerViewController canRecognizeBarcodes]) {
        [[self scanButton] setEnabled:NO];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"This device doesn't support barcode recognition." delegate:self cancelButtonTitle:@"Bugger" otherButtonTitles:nil];
        
		[alertView show];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    } else if ([[segue identifier] isEqualToString:@"showscanner"]) {
        SKScannerViewController *scanner = [segue destinationViewController];
        scanner.shouldLookForEAN13AndUPCACodes = YES;
        scanner.shouldLookForEAN8Codes = YES;
        scanner.shouldLookForUPCECodes = YES;
        scanner.shouldLookForQRCodes = NO;
    }
}

@end
