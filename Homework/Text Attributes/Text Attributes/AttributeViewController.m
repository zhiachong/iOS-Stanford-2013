//
//  AttributeViewController.m
//  Text Attributes
//
//  Created by Zhia Hwa Chong on 6/5/13.
//  Copyright (c) 2013 Zhia Hwa Chong. All rights reserved.
//

#import "AttributeViewController.h"

@interface AttributeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *selectedWordLabel;
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (weak, nonatomic) IBOutlet UIStepper *selectedWordStepper;

@end

@implementation AttributeViewController

-(void)addAttributes:(NSDictionary *)attributes range:(NSRange)range
{
    if (range.location != NSNotFound){
        NSMutableAttributedString *mutableAttributedString = [self.wordLabel.attributedText mutableCopy];
        [mutableAttributedString addAttributes:attributes range:range];
        self.wordLabel.attributedText = mutableAttributedString;
    }
}

-(void)addSelectedWordAttributes:(NSDictionary *)attributes
{
    NSRange range = [[self.wordLabel.attributedText string] rangeOfString:self.selectedWordLabel.text];
    [self addAttributes:attributes range:range];
}


- (IBAction)underLine {
    [self addSelectedWordAttributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)}];
}

- (IBAction)revertUnderline {
    [self addSelectedWordAttributes:@{NSUnderlineStyleAttributeName:@( NSUnderlineStyleNone)}];
}

- (IBAction)changeWordColor:(UIButton *)sender {
    [self addSelectedWordAttributes:@{NSForegroundColorAttributeName: (sender.backgroundColor)}];
}

- (IBAction)changeFont:(UIButton *)sender {
    CGFloat fontSize = [UIFont systemFontSize];
    
    NSDictionary *attributes = [self.wordLabel.attributedText attributesAtIndex:0 effectiveRange:NULL];
    UIFont *existingFont = attributes[NSFontAttributeName]; //finds the font of the existing thing
    
    if (existingFont) fontSize = existingFont.pointSize;
    
    UIFont *font = [sender.titleLabel.font fontWithSize:fontSize];
    [self addSelectedWordAttributes:@{ NSFontAttributeName: font}];
}



-(NSArray*)wordList
{
    NSArray *wordList = [[self.wordLabel.attributedText string] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([wordList count])
        return wordList;
    else
        return @[@""];
}

- (IBAction)updateSelectedWord {
    self.selectedWordStepper.maximumValue = [[self wordList] count] - 1;
    self.selectedWordLabel.text = [self selectedWord];
}

-(NSString *)selectedWord
{
    return [self wordList][(int)self.selectedWordStepper.value];
    self.selectedWordLabel.text = [self selectedWord];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self updateSelectedWord];
}


@end
