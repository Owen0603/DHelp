//
//  DSplitView.h
//  New NSSplitView class with multiple subviews resize behaviors and animated transitions
//
//  Created by Daniele Margutti (me@danielemargutti.com) on 12/21/12.
//  Copyright (c) 2012 http://www.danielemargutti.com. All rights reserved.
//	Licensed under MIT License
//

#import <Cocoa/Cocoa.h>

/** Describe the state of subview */
enum {
    /** state of subview is collapsed */
    DSplitViewStateCollapsed   = 0,
    /** state of subview is expanded */
    DSplitViewStateExpanded    = 1
}; typedef NSUInteger DSplitViewState;


@class DSplitView;
@protocol DSplitViewDelegate <NSObject>
@optional
/** Inform delegate about the status of the animation (if set).
 @param	splitView	target DSplitView instance
 @param	animating	YES if animating is started, NO if animation is ended
 */
- (void) splitView:(DSplitView *)splitView splitViewIsAnimating:(BOOL)animating;

/** Sent when a divider is moved via user drag. You don't receive this message when animating divider position or set it programmatically
 @param splitView       target DSplitView instance
 @param dividerIndex    index of the divider
 @param newPosition     the new divider position
 */
- (void) splitView:(DSplitView *)splitView divider:(NSInteger) dividerIndex movedAt:(CGFloat) newPosition;

/** A subview previously expanded is now collapsed or viceversa
 @param splitView       target MKSplitView instance
 @param subviewIndex    index of target subview
 @param newState        DSplitViewStateCollapsed (collapsed) or DSplitViewStateExpanded (expanded)
 */
- (void) splitView:(DSplitView *)splitView subview:(NSUInteger) subviewIndex stateChanged:(DSplitViewState) newState;
@end

/** DSplitView behavior */
enum {
	/** This is the default behavior of NSSplitView */
	DSplitViewResizeModeProportional		= 0,
	/** Resize each subview using a priority list */
	DSplitViewResizeModePriorityBased		= 1,
	/** Resize all subviews by distributing equal shares of space simultaeously */
	DSplitViewResizeModeUniform			= 2
}; typedef NSUInteger DSplitViewResizeMode;

/** DSplitView is a revisited version of the standard OSX's NSSplitView control.
 The e problem with NSSplitView is that some things which should be simple require implementing unintuitive delegate methods, which gets to be pretty annoying.
 DSplitView offer a powerful control over some important settings of NSSplitView such like:
 
 - subview's size and constraint (Specificy uniform, proportional, or priority-based resizing, min/max sizes for subviews)
 - dividers positions
 - collapsible subviews (specify whether a subview can collapse)
 - animatable transitions (both on dividers and subview's sizes)
 - control over divider thickness and style
 - save/restore state of dividers (using standard's OS X autosave feature)
 
 Special thanks:
 
 - CocoaWithLove blog for it's work on priority based NSSplitView implementation (http://www.cocoawithlove.com/2009/09/nssplitview-delegate-for-priority-based.html)
 - Seth Willits for it's AGNSSplitView implementation (https://github.com/swillits/AGNSSplitView).
 
 */
@interface DSplitView : NSSplitView <NSSplitViewDelegate> { }

/** @name Behavior properties */
#pragma mark Behavior Properties

/* set subview resize behavior. Available settings are:
 
 - *DSplitViewResizeModeProportional*     This is the default behavior of NSSplitView
 - *DSplitViewResizeModePriorityBased*    Resize each subview using a priority list
 - *DSplitViewResizeModeUniform*          Resize all subviews by distributing equal shares of space simultaeously
 */
@property (assign)              DSplitViewResizeMode       subviewsResizeMode;

/* the new delegate of DSplitView. *Do not set splitview's standard delegate* */
@property (retain)				id <DSplitViewDelegate>	eventsDelegate;

#pragma mark - NSSplitView appearance

/** set divider thickness value */
@property (assign)              CGFloat                     dividerThickness;
/** should draw splitview divider. NO to use default NSSplitView behavior */
@property (nonatomic,assign)    BOOL                        shouldDrawDivider;
/** set divider's color */
@property (copy)                NSColor*                    dividerColor;
/** set divider draw rect edge */
@property (nonatomic,assign)    NSRectEdge                  dividerRectEdge;
/** should draw divider handle */
@property (nonatomic,assign)    BOOL                        shouldDrawDividerHandle;

#pragma mark - Initialization

/** @name Initialization */

/** Initialize a new DSplitView control
 @param      frameRect       the rect of the object
 @return                     a new instance of the DSplitView control
 */
- (id) initWithFrame:(NSRect)frameRect;

#pragma mark - Working with priorities
/** @name Priorities */

/** Set prirority of subview at index. Priority-based resizing nominates 1 view as the most important. This is normally the window's "main" view. This highest priority view is the only view that grows in size as the window grows.
 @param      priorityIndex   priority value
 @param      subviewIndex    target subview index
 */
- (void) setPriority:(NSInteger) priorityIndex ofSubviewAtIndex:(NSInteger) subviewIndex;

#pragma mark - Working with constraints
/** @name Working with constraints*/

/** Set the max position of the divider for subview at given index
 @param  maxSize             max subview size (position of the divider)
 @param  subviewIndex        index of subview
 */
- (void) setMaxSize:(CGFloat) maxSize ofSubviewAtIndex:(NSUInteger) subviewIndex;

/** Set the min position of the divider for subview at given index
 @param  minSize             min subview size (position of the divider)
 @param  subviewIndex        index of subview
 */
- (void) setMinSize:(CGFloat) minSize ofSubviewAtIndex:(NSUInteger) subviewIndex;

/** Return the min position of the divider for subview at given index
 @param  subviewIndex        max subview size (position of the divider)
 @return                     min size of given subview
 */
- (CGFloat) minSizeForSubviewAtIndex:(NSUInteger) subviewIndex;

/** Return the max position of the divider for subview at given index
 @param  subviewIndex        max subview size (position of the divider)
 @return                     max size of given subview
 */
- (CGFloat) maxSizeForSubviewAtIndex:(NSUInteger) subviewIndex;

#pragma mark - Collapse Subviews
/** @name Collapse subview */

/** Allows a subview to be collapsable via divider drag
 @param  canCollapse     YES to enable collapse feature for given subview
 @param  subviewIndex    target subview index
 */
- (void) setCanCollapse:(BOOL) canCollapse subviewAtIndex:(NSUInteger) subviewIndex;

/** Allows a subview to be collapsable by double clicking on divider
 @param  viewIndex       target subview index
 @param  dividerIndex    target divider index
 */
- (void) setCollapseSubviewAtIndex:(NSUInteger)viewIndex forDoubleClickOnDividerAtIndex:(NSUInteger)dividerIndex;

/** Return YES if subview at index can be collapsed
 @param  subviewIndex    target subview index
 @return                 YES if subview is collapsable
 */
- (BOOL) canCollapseSubviewAtIndex:(NSUInteger) subviewIndex;

/** Collapse or expand subview at given index
 @param     subviewIndex        index of subview to toggle
 @param     animated            use animated transitions
 @return                        YES if new subview state is collapsed
 */
- (BOOL) collapseOrExpandSubviewAtIndex:(NSUInteger) subviewIndex animated:(BOOL) animated;

/** Collapse or expand given subview
 @param     subview        target subview
 @param     animated            use animated transitions
 @return                        YES if new subview state is collapsed
 @warning                       only
 */
- (BOOL) collapseOrExpandSubview:(NSView *)subview animated:(BOOL) animated;

#pragma mark - Set divider position
/** @name Set divider position */

/** Set the new position of a divider at index.
 @param  position               the new divider position
 @param  dividerIndex           target divider index in this splitview
 @param	 animated               use animated transitions?
 @param  completition           completition block handler
 @return                        YES if you can animate your transitions
 */
- (BOOL) setPosition:(CGFloat)position ofDividerAtIndex:(NSInteger)dividerIndex animated:(BOOL) animated
   completitionBlock:(void (^)(BOOL isEnded)) completition;

/** Set more than one divider position at the same time
 @param  newPositions           an array of the new divider positions (pass it as NSNumber)
 @param  indexes                divider indexes array (set of NSNumber)
 @param	 animated               YES to animate
 @param  completition           completition block handler
 @return                        YES if you can animate your transitions
 */
- (BOOL) setPositions:(NSArray *)newPositions ofDividersAtIndexes:(NSArray *)indexes animated:(BOOL) animated
    completitionBlock:(void (^)(BOOL isEnded)) completition;

/** Set the new position of a divider at index.
 @param  dividerIndex           target divider index in this splitview
 @return                        target divider position
 */
- (CGFloat) positionOfDividerAtIndex:(NSInteger)dividerIndex;

#pragma mark - Working with subviews' sizes
/** @name Working with subviews' sizes */

/** Set the new size of given subview at index. A proportional shrink/grow is applied to involved dividers (left/right, left or right)
 @param     size                    the new size of target subview
 @param     subviewIndex            index of target subview
 @param     animated				YES to animate
 @param     completition            completition block handler
 */
- (BOOL) setSize:(CGFloat) size ofSubviewAtIndex:(NSInteger) subviewIndex animated:(BOOL) animated
    completition:(void (^)(BOOL isEnded)) completition;

@end
