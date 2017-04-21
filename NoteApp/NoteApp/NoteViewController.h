//
//  NoteViewController.h
//  NoteApp
//
//  Created by 陳維漢 on 2016/6/16.
//  Copyright © 2016年 陳維漢. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
#import "NoteListViewController.h"

@protocol NoteViewControllerDelegate <NSObject>
@optional
-(void)didFinishUpdateNote:(Note*)note;
@end

@interface NoteViewController : UIViewController

@property (nonatomic) Note *currentNote;
@property (nonatomic,weak) id<NoteViewControllerDelegate> delegate;

@end
