//
//  DetailViewController.h
//  Flixer
//
//  Created by Oluwanifemi Kolawole on 6/17/22.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UILabel *posterView;
@property (weak, nonatomic) NSDictionary *movie;

@end

NS_ASSUME_NONNULL_END
