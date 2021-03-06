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
#import "Utils.h"
#import "CurrencyService.h"
#import "CurrencyHistory.h"
#import "CountryCell.h"
#import "Utils.h"
#import "CurrencyChartVC.h"


@interface CurrencyConverterVC ()

@property (nonatomic, strong) AppState *appState;
@property (nonatomic, strong) Currency *currency1;
@property (nonatomic, strong) Currency *currency2;

@property (weak, nonatomic) IBOutlet UILabel *labelCurrency1;
@property (weak, nonatomic) IBOutlet UILabel *labelCurrency2;
@property (weak, nonatomic) IBOutlet UILabel *labelCurrency1Rate;
@property (weak, nonatomic) IBOutlet UILabel *labelCurrency2Rate;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewCurrency1;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewCurrency2;

@property (weak, nonatomic) IBOutlet UILabel *labelExchangeRate;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *buttonChange;
@property (nonatomic) int selectedNumber;
@property (nonatomic) float exchangeRate;
@property (nonatomic) BOOL isChanged;
@property (nonatomic) BOOL isCurrencyOneTextChanged;
@property (weak, nonatomic) IBOutlet UIView *viewCurrency1;
@property (weak, nonatomic) IBOutlet UIView *viewCurrency2;

@property (weak, nonatomic) IBOutlet UITextField *textFieldCurrency1;
@property (weak, nonatomic) IBOutlet UITextField *textFieldCurrency2;
@property (strong, nonatomic) CurrencyService *currencyService;

@property (weak, nonatomic) IBOutlet UIView *containerChartView;

@property (strong, nonatomic) CurrencyChartVC *currencyChartVC;
@property (weak, nonatomic) IBOutlet UIView *viewChart;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorChartHistory;
@property (weak, nonatomic) IBOutlet UIButton *buttonRetry;


@end

static NSString *nibName = @"CurrencyHistoryCell";
@implementation CurrencyConverterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.appState = [AppState instance];
    self.currency1 = self.appState.defaultCurrency1;
    self.currency2 = self.appState.defaultCurrency2;
    self.currencyService = [[CurrencyService alloc] init];
    
    [self initializeView];
    [self updateCurrencyLabel];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
          style:UIBarButtonItemStylePlain target:nil action:nil];
    [self updateExchangeRate];
    
    [self.textFieldCurrency1 addTarget:self
                  action:@selector(textFieldCurrency1DidChange:)
        forControlEvents:UIControlEventEditingChanged];
    [self.textFieldCurrency2 addTarget:self
                                action:@selector(textFieldCurrency2DidChange:)
                      forControlEvents:UIControlEventEditingChanged];
    self.navigationController.view.backgroundColor = [UIColor colorWithRed:0.0f
        green:145.0f/255.0f blue:147.0f/255.0f alpha:1];

    if (!self.appState.isFavoriteCurrencySelected){
        [AlertUtils showTwoActionsAlertWithTitle:@"Favorite currency" message:@"Please select your favorite currency."
            positiveText:@"Now" negativeText:@"Later" controller:self onAction:^(BOOL isPositive) {
            if (isPositive){
                [self selectCurrencyNumber:0];
            }
        }];
    }
    
}

- (void) initializeView{
    self.viewChart.backgroundColor = [AppState instance].offWhite;
    [UIUtils roundImage:self.imageViewCurrency1 radius:35.0f border:1.0f borderColor:[UIColor lightGrayColor]];
    [UIUtils roundImage:self.imageViewCurrency2 radius:35.0f border:1.0f borderColor:[UIColor lightGrayColor]];
    [UIUtils roundImage:self.buttonChange radius:20.0f border:1.0f borderColor:[UIColor lightGrayColor]];
    [UIUtils roundImage:self.viewChart radius:10.0f border:0.0f borderColor:[UIColor lightGrayColor]];
    
}

- (void)textFieldCurrency1DidChange:(UITextField *)textField {
    if ([self.textFieldCurrency1.text hasPrefix:@"0"]) {
        self.textFieldCurrency1.text = [self.textFieldCurrency1.text substringFromIndex:1];
    }
    if([self.textFieldCurrency1.text isEqualToString:@""]){
        self.textFieldCurrency1.text = @"0";
    }
    NSString *text = self.textFieldCurrency1.text;
    float c = [text floatValue];
    if(c <= 0.0f)
        self.textFieldCurrency2.text = @"0";
    else
        self.textFieldCurrency2.text = [NSString stringWithFormat:@"%.2f",c*self.exchangeRate];
}

- (void) textFieldCurrency2DidChange:(UITextField *)textField {
    if([self.textFieldCurrency2.text hasPrefix:@"0"]) {
        self.textFieldCurrency2.text = [self.textFieldCurrency2.text substringFromIndex:1];
    }
    if([self.textFieldCurrency2.text isEqualToString:@""]){
        self.textFieldCurrency2.text = @"0";
    }
    NSString *text = self.textFieldCurrency2.text;
    float c = [text floatValue];
    if(c <= 0.0f)
        self.textFieldCurrency1.text = @"0";
    else
        self.textFieldCurrency1.text = [NSString stringWithFormat:@"%.2f",c*(1/self.exchangeRate)];
}




- (void)selectCurrencyNumber: (int) currencyNumber {
    CurrencyTableVC *controller = [[CurrencyTableVC alloc] init];
    controller.index = currencyNumber;
    if(currencyNumber != 0)
        controller.excludeCurrencies = @[self.currency1, self.currency2];
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

- (void)updateCurrencyLabel {
    self.labelCurrency1.text = self.currency1.currencyID;
    NSString *imageName = [NSString stringWithFormat:@"%@.png", self.currency1.countryID];
    [self.imageViewCurrency1 setImage:[UIImage imageNamed: imageName.lowercaseString]];
    self.labelCurrency2.text = self.currency2.currencyID;
    imageName = [NSString stringWithFormat:@"%@.png", self.currency2.countryID];
    [self.imageViewCurrency2 setImage:[UIImage imageNamed: imageName.lowercaseString]];
}

- (void)updateExchangeRate {
    self.labelExchangeRate.text = @"";
    NSLog(@"%@",self.currency2.countryID);
    [self.activityIndicator startAnimating];
    [self.currencyService fetchExchangeRateWithFirstCurrency:self.currency1.currencyID
                                            secondCurrency:self.currency2.currencyID
                                                  success:^(float exchangeRate) {
        [self.activityIndicator stopAnimating];
        self.exchangeRate = exchangeRate;
        NSLog(@"Exchange Rate: %.2f",exchangeRate);
        [self updateExhangeRateView];
    } failure:^(NSError *error) {
        [self.activityIndicator stopAnimating];
        [AlertUtils showAlert:error.localizedDescription duration:5 controller:self];
        NSLog(@"Error: %@",error);
        self.exchangeRate = -1;
        self.labelExchangeRate.text = @"Rate unavailable";
        [self updateExhangeRateView];
    }];
    [self updateRateHistory];
}

- (void)updateRateHistory {
    [self.indicatorChartHistory startAnimating];
    self.currencyChartVC.view.hidden = YES;
    self.buttonRetry.hidden = YES;
    [self.currencyService fetchOneWeekHsitoryWithFirstCurrency:self.currency1.currencyID
                                                secondCurrency:self.currency2.currencyID
    success:^(NSDictionary *dictionary) {
    [self.indicatorChartHistory stopAnimating];
        NSString *key = [NSString stringWithFormat:@"%@_%@", self.currency1.currencyID,
                         self.currency2.currencyID];
        if(self.isChanged)
            key = [NSString stringWithFormat:@"%@_%@", self.currency2.currencyID,
                   self.currency1.currencyID];
        NSDictionary *data = dictionary[key];
        
        self.currencyChartVC = [[CurrencyChartVC alloc] init];
        self.currencyChartVC.data = data;
        self.currencyChartVC.view.frame = self.containerChartView.bounds;
        [self.containerChartView addSubview:self.currencyChartVC.view];
        [self addChildViewController:self.currencyChartVC];
        [self.currencyChartVC didMoveToParentViewController:self];
        
        [self viewDidLayoutSubviews];
        
    } failure:^(NSError *error) {
       [self.indicatorChartHistory stopAnimating];
        self.buttonRetry.hidden = NO;
    }];
}

- (void)updateExhangeRateView{
    if(self.exchangeRate == -1){
        self.labelCurrency1Rate.hidden = YES;
        self.labelCurrency2Rate.hidden = YES;
        return;
    }
    self.labelCurrency1Rate.hidden = NO;
    self.labelCurrency2Rate.hidden = NO;
    NSString *symbol1 = self.currency1.currencySymbol ? self.currency1.currencySymbol : self.currency1.currencyID;
    NSString *symbol2 = self.currency2.currencySymbol ? self.currency2.currencySymbol : self.currency2.currencyID;
    self.labelCurrency1Rate.text = [NSString stringWithFormat:@"%@ 1.0 = %@ %.02f", symbol1, symbol2, self.exchangeRate];
    self.labelCurrency2Rate.text = [NSString stringWithFormat:@"%@ 1.0 = %@ %.02f", symbol2, symbol1, 1/self.exchangeRate];
    if (!self.isChanged) {
        [self textFieldCurrency1DidChange:nil];
    } else {
        [self textFieldCurrency2DidChange:nil];
    }
}

- (IBAction)changeAction:(UIButton *)sender {
    self.isChanged = (self.viewCurrency1.frame.origin.y < self.viewCurrency2.frame.origin.y);
    [UIUtils repositioningView:self.isChanged? self.viewCurrency1:self.viewCurrency2  vertical:120 horizontal:0];
    [UIUtils repositioningView:self.isChanged? self.viewCurrency2:self.viewCurrency1  vertical:-120 horizontal:0];
    if (!self.isChanged) {
        self.textFieldCurrency1.text = self.textFieldCurrency2.text;
        [self textFieldCurrency1DidChange:nil];
    } else {
        self.textFieldCurrency2.text = self.textFieldCurrency1.text;
        [self textFieldCurrency2DidChange:nil];
    }
    [self updateRateHistory];
}

- (IBAction)buttonRetryAction:(UIButton *)sender {
    [self updateRateHistory];
}

#pragma mark - CurrencyTableVCDelegate

- (void)currencyTableVC:(CurrencyTableVC *)currencyTableVC selectedCurrency:(Currency *)currency keyIndex:(int)keyIndex{
    [currencyTableVC.navigationController popViewControllerAnimated:YES];
    BOOL alreadySelected=YES;
    if(keyIndex == 0){
        self.appState.isFavoriteCurrencySelected = true;
        self.appState.defaultCurrency1 = currency;
        self.currency1 = currency;
        [self.appState saveToLocal];
        alreadySelected = NO;
    }
    
    if(keyIndex == 1){
        if(![self.currency2.countryID isEqualToString:currency.countryID]){
            if(self.currency1 != currency){
                alreadySelected = NO;
                self.currency1 = currency;
                [UIUtils shakeView:self.viewCurrency1 repeat:3 point:20];
            }
        }
    }
    if(keyIndex == 2){
        if(![self.currency1.currencyID isEqualToString:currency.currencyID]){
            if(self.currency2 != currency) {
                alreadySelected = NO;
                self.currency2 = currency;
                 [UIUtils shakeView:self.viewCurrency2 repeat:3 point:20];
            }
        }
    }
    if(alreadySelected){
        return;
    }
    [self updateCurrencyLabel];
    [self updateExchangeRate];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.currencyChartVC.view.frame = self.containerChartView.bounds;
}


@end
