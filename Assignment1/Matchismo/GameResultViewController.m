//
//  GameResultViewController.m
//  Matchismo
//
//  Created by Zhia Hwa Chong on 6/6/13.
//  Copyright (c) 2013 Zhia Hwa Chong. All rights reserved.

#import "GameResultViewController.h"
#import "GameResult.h"

@interface GameResultViewController ()
@property (weak, nonatomic) IBOutlet UITextView *display;

@property (nonatomic) SEL sortSelector; // added after lecture
@end

@implementation GameResultViewController

-(void)addAttributes:(NSDictionary *)dictionary range:(NSRange)range
{
    if (range.location != NSNotFound)
    {
        NSMutableAttributedString *mutableCopyOfDisplayText = [self.display.attributedText mutableCopy];
        [mutableCopyOfDisplayText addAttributes:dictionary range:range];
        self.display.attributedText = mutableCopyOfDisplayText;
    }
}

-(void)addSelectedWordAttributes:(NSDictionary*)dictionary forString:(NSString *)string
{
    //find the range to apply
    NSRange range = NSMakeRange(0, self.display.text.length);
    
    NSMutableAttributedString *mutableAttributedString = [self.display.attributedText mutableCopy];

    //finds all the words to highlight in the text
    while(range.location != NSNotFound)
    {
        range = [[mutableAttributedString string] rangeOfString:string options:0 range:range];
        if(range.location != NSNotFound) {
            [self addAttributes:dictionary range:range];
            range = NSMakeRange(range.location + range.length, mutableAttributedString.length - (range.location + range.length));
        }
    }
}

- (void)updateUI
{
    NSString *displayText = @"";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init]; // added after lecture
    [formatter setDateStyle:NSDateFormatterShortStyle];          // added after lecture
    [formatter setTimeStyle:NSDateFormatterShortStyle];          // added after lecture
    // for (GameResult *result in [GameResult allGameResults]) { // version in lecture
    
    for (GameResult *result in [[GameResult allGameResults] sortedArrayUsingSelector:self.sortSelector]) { // sorted
        // displayText = [displayText stringByAppendingFormat:@"Score: %d (%@, %0g)\n", result.score, result.end, round(result.duration)]; // version in lecture
        displayText = [displayText  stringByAppendingFormat:@"Score: %d (End: %@, Duration: %0g)\n", result.score,[formatter stringFromDate:result.end], round(result.duration)];  // formatted date
    }
    self.display.text = displayText;
    [self addSelectedWordAttributes:@{ NSForegroundColorAttributeName : [UIColor greenColor]} forString:@"Score"];
}

#pragma mark - View Controller Lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

// Sorting section added after lecture.
// See also the Sorting section in GameResult.[mh].
// Wire up the three IBActions to the three buttons in the View.

#pragma mark - Sorting

@synthesize sortSelector = _sortSelector;  // because we implement BOTH setter and getter

// return default sort selector if none set (by score)

- (SEL)sortSelector
{
    if (!_sortSelector) _sortSelector = @selector(compareScoreToGameResult:);
    return _sortSelector;
}

// update the UI when changing the sort selector

- (void)setSortSelector:(SEL)sortSelector
{
    _sortSelector = sortSelector;
    [self updateUI];
}

- (IBAction)sortByDate
{
    self.sortSelector = @selector(compareEndDateToGameResult:);
}

- (IBAction)sortByScore {
     self.sortSelector = @selector(compareScoreToGameResult:);
}

- (IBAction)sortByDuration
{
    self.sortSelector = @selector(compareDurationToGameResult:);
}

#pragma mark - (Unused) Initialization before viewDidLoad

- (void)setup
{
    // initialization that can't wait until viewDidLoad
}

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self setup];
    return self;
}

@end
