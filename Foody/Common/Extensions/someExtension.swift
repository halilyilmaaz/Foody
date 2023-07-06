//
//  someExtension.swift
//  Foody
//
//  Created by halil yılmaz on 22.06.2023.
//

import UIKit

class BottomSheetPresentationController: UIPresentationController {
    override var shouldRemovePresentersView: Bool {
        return true
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else {
            return .zero
        }
        return CGRect(x: 0, y: containerView.bounds.height * 0.6, width: containerView.bounds.width, height: containerView.bounds.height * 0.4)
    }
    
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView, let presentedView = presentedView else {
            return
        }
        containerView.addSubview(presentedView)
        presentedView.frame = frameOfPresentedViewInContainerView
        presentedView.layer.cornerRadius = 16
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPresentedViewController))
        containerView.addGestureRecognizer(tapGesture)
    }
    
    override func dismissalTransitionWillBegin() {
        presentedView?.endEditing(true)
    }
    
    @objc func dismissPresentedViewController() {
        presentingViewController.dismiss(animated: true, completion: nil)
    }
}

extension UIViewController {
  func presentInFullScreen(_ viewController: UIViewController,
                           animated: Bool,
                           completion: (() -> Void)? = nil) {
    viewController.modalPresentationStyle = .fullScreen
    present(viewController, animated: animated, completion: completion)
  }
}


class BottomSheetPresentationControllers: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else {
            return CGRect.zero
        }
        
        // Calculate the frame for the presented view
        let safeAreaInsets = containerView.safeAreaInsets
        let yPosition = containerView.bounds.height - presentedViewController.preferredContentSize.height - safeAreaInsets.bottom
        return CGRect(x: 0, y: yPosition, width: containerView.bounds.width, height: containerView.bounds.height)
    }
    
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView, let presentedView = presentedView else {
            return
        }
        
        // Add the presented view to the container view
        containerView.addSubview(presentedView)
        
        // Set up the initial state for the presentation animation
        presentedView.frame = frameOfPresentedViewInContainerView
        presentedView.layer.cornerRadius = 16
        presentedView.layer.masksToBounds = true
        presentedView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        // Apply a dimming view behind the presented view
        let dimmingView = UIView(frame: containerView.bounds)
        dimmingView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        dimmingView.alpha = 0
        containerView.insertSubview(dimmingView, at: 0)
        
        // Perform the presentation animation
        if let coordinator = presentingViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                presentedView.frame = self.frameOfPresentedViewInContainerView
                dimmingView.alpha = 1
            }, completion: nil)
        }
    }
    
    override func dismissalTransitionWillBegin() {
        guard let containerView = containerView else {
            return
        }
        
        // Remove the dimming view during the dismissal animation
        if let dimmingView = containerView.subviews.first(where: { $0.backgroundColor == UIColor(white: 0, alpha: 0.5) }) {
            if let coordinator = presentingViewController.transitionCoordinator {
                coordinator.animate(alongsideTransition: { _ in
                    dimmingView.alpha = 0
                }, completion: { _ in
                    dimmingView.removeFromSuperview()
                })
            } else {
                dimmingView.removeFromSuperview()
            }
        }
    }
}
