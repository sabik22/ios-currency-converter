//
//  HistoryChartVC.m
//  IosCurrencyConverter
//
//  Created by Bikash Shrestha on 10/2/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import "CurrencyChartVC.h"
#import "Charts-Swift.h"
#import "CurrencyHistory.h"
#import "Utils.h"

@interface CurrencyChartVC () <ChartViewDelegate, IChartAxisValueFormatter>

@property (strong, nonatomic) LineChartView *lineChartView;
@property (strong, nonatomic) NSMutableArray *array;
@property (weak, nonatomic) ChartIndexAxisValueFormatter *chartIndexAxisValueFormatter;

@end

@implementation CurrencyChartVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.lineChartView = [[LineChartView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    [self prepareData];
    [self initializeView];
    self.lineChartView.delegate = self;
    self.chartIndexAxisValueFormatter = self;
    [self setChartData];
    self.lineChartView.xAxis.valueFormatter = self.chartIndexAxisValueFormatter;
    [self.view addSubview:self.lineChartView];
    
}

- (void)initializeView {
    
    self.lineChartView.backgroundColor = [AppState instance].offWhite;
    [UIUtils roundImage:self.lineChartView radius:30.0f border:0.0f borderColor:[UIColor lightGrayColor]];
    self.lineChartView.chartDescription.enabled = NO;
    self.lineChartView.drawGridBackgroundEnabled = NO;
    self.lineChartView.pinchZoomEnabled = YES;
    [self.lineChartView setScaleEnabled:NO];
    self.lineChartView.rightAxis.drawLabelsEnabled = NO;
    self.lineChartView.minOffset = 20.0f;
    self.lineChartView.leftAxis.xOffset = 10.0f;
    self.lineChartView.xAxis.labelPosition = XAxisLabelPositionBottom;
    self.lineChartView.legend.enabled = NO;
    self.lineChartView.xAxis.drawGridLinesEnabled = NO;
    self.lineChartView.rightAxis.drawGridLinesEnabled = NO;
    
}

-(void)setChartData{
    
    LineChartDataSet *set1 = nil;
    set1 = [[LineChartDataSet alloc] initWithValues:self.array label:@"DataSet 1"];
    set1.axisDependency = AxisDependencyLeft;
    [set1 setColor:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
    [set1 setCircleColor: [AppState instance].primaryColor];
    set1.lineWidth = 2.0;
    set1.circleRadius = 3.0;
    set1.drawCircleHoleEnabled = YES;
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    
    LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
    [data setValueTextColor: [AppState instance].primaryColor];
    [data setValueFont:[UIFont systemFontOfSize:9.f]];
    
    self.lineChartView.data = data;
    
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.lineChartView.frame = self.view.bounds;
}

- (void)prepareData{
    self.array = [[NSMutableArray alloc] init];
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    float maxLeftAxis = 0.0f;
    float minLeftAxis = 10000000.0f;
    double maxXAxis = 0;
    double minXAxis = 0;
    for(NSString *key in self.data.allKeys){
        
        CurrencyHistory *history = [[CurrencyHistory alloc] init];
        history.date = [DateUtils dateFromString:key format:@"yyyy-MM-dd"];
        history.rate = [self.data[key] floatValue];
        [dataArray addObject:history];
        maxLeftAxis = maxLeftAxis < history.rate ? history.rate : maxLeftAxis;
        minLeftAxis = minLeftAxis > history.rate ? history.rate : minLeftAxis;
        
        double dateTimeStamp = (double) history.date.timeIntervalSince1970;
        if (maxXAxis == 0) {
            maxXAxis = dateTimeStamp;
            minXAxis = dateTimeStamp;
        } else {
            maxXAxis = maxXAxis < dateTimeStamp ? dateTimeStamp : maxXAxis;
            minXAxis = minXAxis > dateTimeStamp ? dateTimeStamp : minXAxis;
        }
        
    }
    
    dataArray = [NSMutableArray arrayWithArray:[Utils sortArray:dataArray sortDescriptorWithKey:@"date" ascending:YES]];
    self.lineChartView.leftAxis.axisMaximum = maxLeftAxis + (maxLeftAxis * .01);
    self.lineChartView.leftAxis.axisMinimum = minLeftAxis - (minLeftAxis * .01);
    self.lineChartView.xAxis.axisMaximum = maxXAxis + 20000;
    self.lineChartView.xAxis.axisMinimum = minXAxis - 20000;
    [self.lineChartView.leftAxis setLabelCount:4 force:YES];
    [self.lineChartView.xAxis setLabelCount:dataArray.count force:YES];
    
    for (CurrencyHistory *history in dataArray) {
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:(double) history.date.timeIntervalSince1970 y:history.rate];
        [self.array addObject:entry];
    }
    
}


- (NSString * _Nonnull)stringForValue:(double)value axis:(ChartAxisBase * _Nullable)axis {
    
    NSString *month = [DateUtils stringFromDate:[NSDate dateWithTimeIntervalSince1970:value] format:@"MM"];
    NSString *day = [DateUtils stringFromDate:[NSDate dateWithTimeIntervalSince1970:value] format:@"dd"];
    if([month hasPrefix:@"0"])
        month = [month substringFromIndex:1];
    if([day hasPrefix:@"0"])
        day = [day substringFromIndex:1];
    return [NSString stringWithFormat:@"%@/%@",month,day];

}


@end
