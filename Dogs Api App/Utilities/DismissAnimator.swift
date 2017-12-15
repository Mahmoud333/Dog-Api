//
//  DismissAnimator.swift
//  InteractiveModal
//
//  Created by Robert Chen on 1/8/16.
//  Copyright © 2016 Thorn Technologies. All rights reserved.
//

import UIKit

class DismissAnimator : NSObject {  }

extension DismissAnimator : UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return OUR_CUSTOM_DISMISS_SEGUE
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
            else {
                return
        }
        
        transitionContext.containerView.insertSubview(toVC.view, belowSubview: fromVC.view)

        let screenBounds = UIScreen.main.bounds
        let bottomLeftCorner = CGPoint(x: 0, y: -screenBounds.height)
        let finalFrame = CGRect(origin: bottomLeftCorner, size: screenBounds.size)
       
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                fromVC.view.frame = finalFrame
                
                //CornerRadius Animation
                fromVC.view.layer.cornerRadius =  fromVC.view.bounds.height * 1.0
                fromVC.view.clipsToBounds = true
            },
            completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        )
    }
}

//UIPercentDrivenInteractiveTransition: like the scrub bar of the video player. It can track the animation progress to a certain position. It can also finish or cancel the transition
class Interactor: UIPercentDrivenInteractiveTransition {
    var hasStarted = false
    var shouldFinish = false
}
