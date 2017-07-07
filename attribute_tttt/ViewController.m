//
//  ViewController.m
//  attribute_tttt
//
//  Created by 鹏 刘 on 2017/7/6.
//  Copyright © 2017年 鹏 刘. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UILabel *selectedLabel;
@property (nonatomic, strong) UIStepper *stepper;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createStepper];
    [self changeText];
    [self createSelectedLabel];
    [self createTextLabel];
    [self changeFontButton];
    [self changeColorButton];
    [self underLineButton];
    [self outLineButton];
}

- (void)createStepper
{
    self.stepper = [[UIStepper alloc] initWithFrame:CGRectMake(15, 20, 60, 45)];
    self.stepper.backgroundColor = [UIColor whiteColor];
    [self.stepper addTarget:self action:@selector(changeText) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:self.stepper];
}

- (IBAction)changeText
{
    self.stepper.maximumValue = [self wordList].count - 1;
    self.selectedLabel.text = [self selectedWord];
    
    [self addTextLabelAttribute:@{NSBackgroundColorAttributeName : [UIColor whiteColor]} range:NSMakeRange(0, self.textLabel.attributedText.length)];
    [self addSelectedLabelAttribute:@{NSBackgroundColorAttributeName : [UIColor yellowColor]}];
}

- (void)addTextLabelAttribute:(NSDictionary *)attribute range:(NSRange)range
{
    NSMutableAttributedString *ns = [self.textLabel.attributedText mutableCopy];
    if (ns) {
        [ns addAttributes:attribute range:range];
    }

    self.textLabel.attributedText = ns;
}

- (void)addSelectedLabelAttribute:(NSDictionary *)attribute
{
    NSRange range = [[self.textLabel.attributedText string] rangeOfString:[self selectedWord]];
    [self addTextLabelAttribute:attribute range:range];
}

- (void)createSelectedLabel
{
    self.selectedLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 13, 130, 45)];
    self.selectedLabel.text = @"Selected Word";
    self.selectedLabel.textAlignment = NSTextAlignmentCenter;
    self.selectedLabel.font = [UIFont fontWithName:@"Helvetcia" size:18];
    
    
    [self.view addSubview:self.selectedLabel];
}

- (void)createTextLabel
{
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 55, self.view.bounds.size.width, 250)];
    self.textLabel.numberOfLines = 0;
   // self.textLabel.font = [UIFont fontWithName:@"Helvetica" size:40];
    
    NSMutableParagraphStyle *ps = [[NSMutableParagraphStyle alloc] init];
    ps.lineSpacing = 9.0;
    ps.firstLineHeadIndent = 9.0;
    ps.paragraphSpacing = 4.5;
    
    NSMutableAttributedString *as = [[NSMutableAttributedString alloc] initWithString:@"CS193p is the most awesome class at stanford!"];
    [as addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:40] range:NSMakeRange(0, as.length)];
    [as addAttribute:NSParagraphStyleAttributeName value:ps range:NSMakeRange(0, as.length)];
    
    self.textLabel.attributedText = as;
    [self.view addSubview:self.textLabel];
    
}

- (NSArray *)wordList
{
    NSArray *list = [[self.textLabel.attributedText string] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (list) {
        return list;
    }
    else {
        return @[@""];
    }
}

- (NSString *)selectedWord
{
    return [self wordList][(int)self.stepper.value];
}

#define x_button 25
- (void)changeColorButton
{
    NSArray *titleArr = [[NSArray alloc] initWithObjects:@"Orange",@"Blue",@"Black",@"Green", nil];
    NSArray *colorArr = [[NSArray alloc] initWithObjects:[UIColor orangeColor],[UIColor blueColor],[UIColor blackColor],[UIColor greenColor], nil];

    for (int i = 0; i < titleArr.count; i ++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x_button + (55 + x_button) * i, 320, 75, 75)];
        [btn setTitle:[titleArr objectAtIndex:i] forState:UIControlStateNormal];
        [btn setBackgroundColor:[colorArr objectAtIndex:i]];
        [btn addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btn];
    }

}

- (IBAction)changeColor:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"Orange"]) {
        [self addSelectedLabelAttribute:@{NSBackgroundColorAttributeName : [UIColor orangeColor]}];
    }
    else if ([sender.titleLabel.text isEqualToString:@"Blue"]) {
        [self addSelectedLabelAttribute:@{NSBackgroundColorAttributeName : [UIColor blueColor]}];
    }
    else if ([sender.titleLabel.text isEqualToString:@"Black"]) {
        [self addSelectedLabelAttribute:@{NSBackgroundColorAttributeName : [UIColor blackColor]}];
    }
    else if ([sender.titleLabel.text isEqualToString:@"Green"]) {
        [self addSelectedLabelAttribute:@{NSBackgroundColorAttributeName : [UIColor greenColor]}];
    }
}

#define x_space 40
- (void)changeFontButton
{
    NSArray *titleArr = [[NSArray alloc] initWithObjects:@"Bold",@"Normal",@"Italic", nil];

    for (int i = 0; i < titleArr.count; i ++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x_space + (60 + x_space) * i, 420, 60, 45)];
       // btn.titleLabel.textColor = [UIColor blueColor];
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:[titleArr objectAtIndex:i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(changeFont:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:18.5];
        
        [self.view addSubview:btn];
    }
}

- (IBAction)changeFont:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"Bold"]) {
        [self addSelectedLabelAttribute:@{NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:18]}];
    }
    else if ([sender.titleLabel.text isEqualToString:@"Normal"]) {
        [self addSelectedLabelAttribute:@{NSFontAttributeName : [UIFont fontWithName:@"Helvetica" size:18]}];
    }
    else if ([sender.titleLabel.text isEqualToString:@"Italic"]) {
        [self addSelectedLabelAttribute:@{NSFontAttributeName : [UIFont fontWithName:@"Georgia-Italic" size:18]}];
    }
}

#define X_SPACE 50
- (void)underLineButton
{
    NSArray *titleArr = [[NSArray alloc] initWithObjects:@"Underline",@"No Underline", nil];

    for (int i = 0; i < titleArr.count; i ++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(X_SPACE + (75 + X_SPACE) * i, 490, 110, 45)];
        btn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:17];
       // btn.titleLabel.textColor = [UIColor blueColor];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn setTitle:[titleArr objectAtIndex:i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(changeUnderLine:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btn];
    }
}

- (IBAction)changeUnderLine:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"Underline"]) {
        [self addSelectedLabelAttribute:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)}];
    }
    else {
        [self addSelectedLabelAttribute:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleNone)}];
    }
}

#define X_BUTTON 50
- (void)outLineButton
{
    NSArray *titleArr = [[NSArray alloc] initWithObjects:@"Outline",@"No Outline", nil];

    for (int i = 0; i < titleArr.count; i ++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(X_BUTTON + (75 + X_BUTTON) * i , 550, 110, 45)];
        btn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:17];
       // btn.titleLabel.textColor = [UIColor blueColor];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn setTitle:[titleArr objectAtIndex:i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(changeOutLine:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btn];
    }
}

- (IBAction)changeOutLine:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"Outline"]) {
        [self addSelectedLabelAttribute:@{NSStrokeWidthAttributeName : @5}];
    }
    else {
        [self addSelectedLabelAttribute:@{NSStrokeWidthAttributeName : @0}];
    }
}

@end
