//
//  AppDelegate.h
//  Flixer
//
//  Created by Oluwanifemi Kolawole on 6/15/22.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

