//
//  CurrencyConverterViewController.m
//  FirstApp
//
//  Created by Bikash Shrestha on 9/17/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import "CurrencyConverterVC.h"
#import "Currency.h"
#import "AppState.h"
#import "../Utils/Utils.h"
#import "CurrencyService.h"

@interface CurrencyConverterVC ()

@property (nonatomic, strong) AppState *appState;
@property (nonatomic, strong) Currency *currency1;
@property (nonatomic, strong) Currency *currency2;

@property (weak, nonatomic) IBOutlet UILabel *labelCurrency1;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewCurrency1;
@property (weak, nonatomic) IBOutlet UILabel *labelCurrency2;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewCurrency2;
@property (weak, nonatomic) IBOutlet UITextField *textFieldCurrency2;
@property (weak, nonatomic) IBOutlet UITextField *textFieldCurrency1;
@property (weak, nonatomic) IBOutlet UILabel *labelExchangeRate;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic) int selectedNumber;

@end

@implementation CurrencyConverterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.appState = [AppState instance];
    self.currency1 = self.appState.defaultCurrency1;
    self.currency2 = self.appState.defaultCurrency2;
    [UIUtils roundImage:self.imageViewCurrency1 radius:15.0f border:1.0f borderColor:[UIColor lightGrayColor]];
    [UIUtils roundImage:self.imageViewCurrency2 radius:15.0f border:1.0f borderColor:[UIColor lightGrayColor]];
    [self updateCurrencyLabel];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self updateExchangeRate];
    
}

- (void)selectCurrencyNumber: (int) currencyNumber {
    CurrencyTableVC *controller = [[CurrencyTableVC alloc] init];
    controller.viewTitle = [NSString stringWithFormat:@"Select Currency %d",currencyNumber];
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)buttonCurrency1Action:(UIButton *)sender {
    self.selectedNumber = 1;
    [self selectCurrencyNumber:1];
}

- (IBAction)buttonCurrency2Action:(UIButton *)sender {
    self.selectedNumber = 2;
    [self selectCurrencyNumber:2];
}

- (void) dataFromController:(Currency *)currency{
    BOOL alreadySelected=YES;
    if(self.selectedNumber == 1){
        if(![self.currency2.countryID isEqualToString:currency.countryID]){
            alreadySelected = NO;
            self.currency1 = currency;
        }
    }
    
    if(self.selectedNumber == 2){
        if(![self.currency1.currencyID isEqualToString:currency.currencyID]){
            alreadySelected = NO;
            self.currency2 = currency;
        }
    }
        
    if(alreadySelected){
        [AlertUtils showAlert:[NSString stringWithFormat:@"%@ is already selected", currency.currencyID] duration:1 controller:self];
        return;
    }
    [self updateCurrencyLabel];
    [self updateExchangeRate];
}

- (void) updateCurrencyLabel {
    NSString *title1 = self.currency1.currencyID;
    if(self.currency1.currencySymbol){
        title1 = [title1 stringByAppendingString:[NSString stringWithFormat:@" %@",
                                                  self.currency1.currencySymbol]];
    }
    self.labelCurrency1.text = title1;
    NSString *imageName = [NSString stringWithFormat:@"%@.png", self.currency1.countryID];
    [self.imageViewCurrency1 setImage:[UIImage imageNamed: imageName.lowercaseString]];
    
    NSString *title2 = self.currency2.currencyID;
    if(self.currency2.currencySymbol){
        title2 = [title2 stringByAppendingString:[NSString stringWithFormat:@" %@",
                                                  self.currency2.currencySymbol]];
    }
    self.labelCurrency2.text = title2;
    imageName = [NSString stringWithFormat:@"%@.png", self.currency2.countryID];
    [self.imageViewCurrency2 setImage:[UIImage imageNamed: imageName.lowercaseString]];
   
}

float rate = 0.0f;

- (void) updateExchangeRate {
    self.labelExchangeRate.text = @"";
    [self.activityIndicator startAnimating];
    CurrencyService *fetchCurrency = [[CurrencyService alloc] init];
    [fetchCurrency fetchExchangeRateWithCompletionHandler:self.currency1.currencyID currencyCode2:self.currency2.currencyID success:^(float exchangeRate) {
        [self.activityIndicator stopAnimating];
        rate = exchangeRate;
        NSLog(@"Exchange Rate: %.2f",exchangeRate);
        [self updateExhangeRateView];
    } failure:^(NSError *error) {
        [self.activityIndicator stopAnimating];
        [AlertUtils showAlert:error.localizedDescription duration:5 controller:self];
        NSLog(@"Error: %@",error);
        self.labelExchangeRate.text = @"Rate unavailable";
    }];
}

- (void) updateExhangeRateView{
    self.labelExchangeRate.text = [NSString stringWithFormat:@"%@ 1.0   =   %@ %.02f", self.currency1.currencyID,self.currency2.currencyID, rate];
}

@end
