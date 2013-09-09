//
//  SFStackLayout.h
//  AlbummApp
//
//  Created by Constantine on 9/6/13.
//  Copyright (c) 2013 Privat. All rights reserved.
//
@import UIKit;

@interface SFStackLayout : UICollectionViewLayout

@property (nonatomic, readwrite) NSInteger stackCount;
@property (nonatomic, readwrite) CGSize itemSize;
@property (nonatomic,assign) CGPoint targetCenter;

@end
