//
//  CustomPush.swift
//  Dogs Api App
//
//  Created by Mahmoud Hamad on 12/14/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//


import UIKit

fileprivate let OUR_CUSTOM_PUSH_DISMISS_SEGUE = 0.35
let OUR_CUSTOM_DISMISS_SEGUE = 0.45

class SegueFromLeftToRight: UIStoryboardSegue {
    override func perform() {
        let src = self.source
        let dst = self.destination
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: -src.view.frame.size.width, y: 0)
        
        //0.25
        UIView.animate(withDuration: OUR_CUSTOM_PUSH_DISMISS_SEGUE,
                       delay: 0.0,
                       options: .curveEaseInOut,
                       animations: {
                        dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
        },
                       completion: { finished in
                        src.present(dst, animated: false, completion: nil)
        }
        )
    }
}

class SegueFromRightToLeft: UIStoryboardSegue {
    override func perform() {
        let src = self.source
        let dst = self.destination
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)
        
        //0.25
        UIView.animate(withDuration: OUR_CUSTOM_PUSH_DISMISS_SEGUE,
                       delay: 0.0,
                       options: .curveEaseInOut,
                       animations: {
                        dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
        },
                       completion: { finished in
                        src.present(dst, animated: false, completion: nil)
        }
        )
    }
}

class SegueFromTopToBottom: UIStoryboardSegue {
    override func perform() {
        let src = self.source
        let dst = self.destination
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: 0, y: -src.view.frame.size.height)
        dst.view.layer.cornerRadius = src.view.frame.size.height * 1.2
        dst.view.clipsToBounds = true
        
        //0.25  OUR_CUSTOM_PUSH_DISMISS_SEGUE
        UIView.animate(withDuration: OUR_CUSTOM_PUSH_DISMISS_SEGUE,
                       delay: 0.0,
                       options: .curveEaseInOut,
                       animations: {
                        dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
                        dst.view.layer.cornerRadius = 0

        },
                       completion: { finished in
                        src.present(dst, animated: false, completion: nil)
        }
        )
    }
}

class SegueFromTopRightToBottom: UIStoryboardSegue {
    override func perform() {
        let src = self.source
        let dst = self.destination
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: -src.view.frame.size.height)
        
        //0.25
        UIView.animate(withDuration: OUR_CUSTOM_PUSH_DISMISS_SEGUE,
                       delay: 0.0,
                       options: .curveEaseInOut,
                       animations: {
                        dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
        },
                       completion: { finished in
                        src.present(dst, animated: false, completion: nil)
        }
        )
    }
}

class SegueFromTopLeftToBottom: UIStoryboardSegue {
    override func perform() {
        let src = self.source
        let dst = self.destination
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: -src.view.frame.size.width, y: -src.view.frame.size.height)
        
        //0.25
        UIView.animate(withDuration: OUR_CUSTOM_PUSH_DISMISS_SEGUE,
                       delay: 0.0,
                       options: .curveEaseInOut,
                       animations: {
                        dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
        },
                       completion: { finished in
                        src.present(dst, animated: false, completion: nil)
        }
        )
    }
}

class SegueFromBottomToTop: UIStoryboardSegue {
    override func perform() {
        let src = self.source
        let dst = self.destination
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: 0, y: src.view.frame.size.height)
        
        //0.25
        UIView.animate(withDuration: OUR_CUSTOM_PUSH_DISMISS_SEGUE,
                       delay: 0.0,
                       options: .curveEaseInOut,
                       animations: {
                        dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
        },
                       completion: { finished in
                        src.present(dst, animated: false, completion: nil)
        }
        )
    }
}

//With CATransition
extension UIViewController {
    enum DismissPushDirection {
        case FromLeft
        case FromRight
        case FromTop
        case FromBottom
    }
    
    func dismissFrom(from: DismissPushDirection) {
        let transition: CATransition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionReveal
        switch from {
        case .FromLeft: transition.subtype = kCATransitionFromLeft
        case .FromRight: transition.subtype = kCATransitionFromRight
        case .FromTop:  transition.subtype = kCATransitionFromTop
        case .FromBottom:   transition.subtype = kCATransitionFromBottom
        }
        self.view.window!.layer.add(transition, forKey: nil)
    }
}

