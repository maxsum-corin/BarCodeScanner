//
//  MainViewController.m
//  BarCodeScanner
//
//  Created by Corin Lawson on 18/10/11.
//  Copyright (c) 2011 Corin Lawson. All rights reserved.
//

#import "MainViewController.h"
#import "CustomScannerViewController.h"

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

#pragma mark - Flipside and Scanner Views

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void) scannerViewController:(SKScannerViewController *)scanner didRecognizeCode:(SKCode *)code {
    NSLog(@"Scanner Code: %@", code.rawContent);
    [self dismissModalViewControllerAnimated:YES];
    scanner.delegate = nil;
}

- (void) scannerViewController:(SKScannerViewController *)scanner didStopLookingForCodesWithError:(NSError *)error {
    [self dismissModalViewControllerAnimated:YES];
    scanner.delegate = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

- (IBAction) scanTapped:(id)sender {
	if([SKScannerViewController canRecognizeBarcodes]) { //Make sure we can even attempt barcode recognition, (i.e. on a device without a camera, you wouldn't be able to scan anything).
		SKScannerViewController *scannerVC = [[SKScannerViewController alloc] init]; //Insantiate a new SKScannerViewController
		
        scannerVC.shouldLookForEAN13AndUPCACodes = YES;
        scannerVC.shouldLookForEAN8Codes = YES;
        scannerVC.shouldLookForUPCECodes = YES;
        scannerVC.shouldLookForQRCodes = NO;
        scannerVC.delegate = self;

		scannerVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelTapped)];
		scannerVC.title = @"Scan a Barcode";

		UINavigationController *_nc = [[UINavigationController alloc] initWithRootViewController:scannerVC]; //Put our SKScannerViewController into a UINavigationController. (So it looks nice).

		[self presentModalViewController:_nc animated:YES]; //Slide it up onto the screen.
	} else {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"This device doesn't support barcode recognition." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		
		[alertView show];
	}
}
- (void) cancelTapped {
	[self dismissModalViewControllerAnimated:YES];
}
 

@end
