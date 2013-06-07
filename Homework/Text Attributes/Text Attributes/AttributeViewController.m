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

//find the range to apply
//then apply the attribute to the range
-(void)addAttributes:(NSDictionary *)dictionary range:(NSRange)range
{
    if (range.location != NSNotFound)
    {
        NSMutableAttributedString *mutableCopyOfDisplayText = [self.wordLabel.attributedText mutableCopy];
        [mutableCopyOfDisplayText addAttributes:dictionary range:range];
        self.wordLabel.attributedText = mutableCopyOfDisplayText;
    }
}

-(void)addSelectedWordAttributes:(NSDictionary*)dictionary
{
    //find the range to apply
    NSRange range = NSMakeRange(0, self.wordLabel.text.length);
    
    NSMutableAttributedString *mutableAttributedString = [self.wordLabel.attributedText mutableCopy];
    
    //finds all the words to highlight in the text
    while(range.location != NSNotFound)
    {
        range = [[mutableAttributedString string] rangeOfString:self.selectedWordLabel.text options:0 range:range];
        if(range.location != NSNotFound) {
            [self addAttributes:dictionary range:range];
            range = NSMakeRange(range.location + range.length, mutableAttributedString.length - (range.location + range.length));
        }
    }
    
    //for just a single occurrence
    /*
     NSRange range = [[self.wordLabel.attributedText string] rangeOfString:self.selectedWordLabel.text];
     [self addAttributes:dictionary range:range];
     */
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

//font consists of font and font size (2 attributes to configure)

//pick the attribute of the existing font
//find the font of the existing font from attribute
//replace font with the font of your choice and size
- (IBAction)changeFont:(UIButton *)sender {
    CGFloat fontSize = [UIFont systemFontSize];
    
    NSDictionary *attributes = [self.wordLabel.attributedText attributesAtIndex:0 effectiveRange:NULL];
    
    UIFont *existingFont = attributes[NSFontAttributeName]; //finds the font of the existing label
    
    if (existingFont) fontSize = existingFont.pointSize;
    
    UIFont *font = [sender.titleLabel.font fontWithSize:fontSize];
    [self addSelectedWordAttributes:@{ NSFontAttributeName: font}];
}

-(NSArray*)wordList
{
    //in the lecture, Paul used [self.wordLabel.attributedText string]
    NSArray *wordList = [self.wordLabel.text componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
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
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self updateSelectedWord];
}


@end
