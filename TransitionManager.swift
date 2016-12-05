//
//  TransitionMananger.swift
//  Stundaskra
//
//  Created by Gudmundur Halldorsson on 13/11/15.
//  Copyright © 2015 Gudmundur Halldorsson. All rights reserved.
//

import UIKit

class TransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    var presenting = false
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {

        let container = transitionContext.containerView()
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        let offScreenRight = CGAffineTransformMakeTranslation(container!.frame.width, 0)
        let offScreenLeft = CGAffineTransformMakeTranslation(-container!.frame.width, 0)
        //let offScreenZoomIn = CGAffineTransformMakeScale(960, 1704)
        
        container!.addSubview(toView)
        container!.addSubview(fromView)
        
        let duration = self.transitionDuration(transitionContext)
        if (presenting){
        toView.transform = offScreenRight
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.CurveLinear, animations: {
            
           fromView.transform = offScreenLeft
           toView.transform = CGAffineTransformIdentity
            
            }, completion: { finished in
                
                transitionContext.completeTransition(true)
                
        })
        }
        else
        {
            UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.CurveLinear, animations: {
                
                fromView.transform = offScreenRight
                toView.transform = CGAffineTransformIdentity
                
                }, completion: { finished in
                    
                    transitionContext.completeTransition(true)
                    
            })
        }
        
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    func animationControllerForPresentedController(presented: UIViewController, presentingController: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presenting = true
        return self
    }
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presenting = false
        return self
    }

}
