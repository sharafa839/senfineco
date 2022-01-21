//
//  SlideInTransition.swift
//  SlideInTransition
//
//  Created by Gary Tokman on 1/13/19.
//  Copyright © 2019 Gary Tokman. All rights reserved.
//

import UIKit
import MOLH

class SlideInTransition: NSObject, UIViewControllerAnimatedTransitioning {

    var isPresenting = false
    let dimmingView = UIView()
    var timerValue = 0.3
    var widthValue:CGFloat = 0.5

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return timerValue
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        guard let toViewController = transitionContext.viewController(forKey: .to),
            let fromViewController = transitionContext.viewController(forKey: .from) else { return }

        let containerView = transitionContext.containerView

        let finalWidth = toViewController.view.bounds.width
        let finalHeight = toViewController.view.bounds.height
        

        if isPresenting {
            // Add dimming view
            dimmingView.backgroundColor = .black
            dimmingView.alpha = 0.0
            containerView.addSubview(dimmingView)
            dimmingView.frame = containerView.bounds
            // Add menu view controller to container
            containerView.addSubview(toViewController.view)

            // Init frame off the screen
            if LocalizationManager.shared.getLanguage() == .English {
               toViewController.view.frame = CGRect(x: finalWidth, y: 0, width: finalWidth, height: finalHeight)
            }else{
               toViewController.view.frame = CGRect(x: -finalWidth, y: 0, width: finalWidth, height: finalHeight)
            }
            
            
        }

        // Move on screen
        let transform = {
            self.dimmingView.alpha = 0.5
            //print("lan is \(MOLHLanguage.currentAppleLanguage())")
            if  LocalizationManager.shared.getLanguage() == .English{
              toViewController.view.transform = CGAffineTransform(translationX: -finalWidth, y: 0)
            }else{
               toViewController.view.transform = CGAffineTransform(translationX: finalWidth, y: 0)
            }
            
        }


        // Move back off screen
        let identity = {
            self.dimmingView.alpha = 0.0
            fromViewController.view.transform = .identity
        }

        // Animation of the transition
        let duration = transitionDuration(using: transitionContext)
        let isCancelled = transitionContext.transitionWasCancelled
        UIView.animate(withDuration: duration, animations: {
            self.isPresenting ? transform() : identity()
        }) { (_) in
            transitionContext.completeTransition(!isCancelled)
        }
    }

}
