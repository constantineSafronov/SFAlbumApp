//
//  SFCollectionViewCell.h
//  AlbumsApp
//
//  Created by Constantine on 9/5/13.
//  Copyright (c) 2013 Privat. All rights reserved.
//
#import "SFCollectionViewCell.h"


@implementation SFCollectionViewCell


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = TRUE;
        self.imageView.layer.edgeAntialiasingMask = kCALayerLeftEdge | kCALayerRightEdge | kCALayerBottomEdge | kCALayerTopEdge;
        [[self contentView] addSubview:self.imageView];
    }
    return self;
}


@end
