//
//  PresentAnimator.swift
//  HomeTail
//
//  Created by taeuk on 2021/07/07.
//

import UIKit

enum PresentationType {

    case present
    case dismiss

    var isPresenting: Bool {
        return self == .present
    }
}

final class CustomAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var selectedCellImage: UIView?
    
    static let duration: TimeInterval = 0.6
    
    private let type: PresentationType
    private let listViewController: ListViewController
    private let recipeViewController: RecipeViewController
    private let selectedCellImageViewSnapshot: UIView
    private let cellImageViewRect: CGRect
    
    init?(type: PresentationType,
          listViewController: ListViewController,
          recipeViewController: RecipeViewController,
          selectedCellImageViewSnapshot: UIView) {
        
        self.type = type
        self.listViewController = listViewController
        self.recipeViewController = recipeViewController
        self.selectedCellImageViewSnapshot = selectedCellImageViewSnapshot
        
        guard let window = listViewController.view.window ?? recipeViewController.view.window,
              let selectedCell = listViewController.tableCell
        else { return nil }
        
        self.cellImageViewRect = selectedCell.infoGraphicImage.convert(selectedCell.infoGraphicImage.bounds, to: window)
    }
    
    // 시간
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Self.duration
    }
    
    // 애니메이션
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        guard let toView = recipeViewController.view else {
            transitionContext.completeTransition(false)
            return
        }
        containerView.addSubview(toView)
        
        guard let selectedCell = listViewController.tableCell,
              let window = listViewController.view.window ?? recipeViewController.view.window,
              let cellImageSnapshot = selectedCell.infoGraphicImage.snapshotView(afterScreenUpdates: true),
              let recipeInfoImageSnapshot = recipeViewController.infoGraphicImage.snapshotView(afterScreenUpdates: true)
        else {
            transitionContext.completeTransition(true)
            return
        }
        
        let isPresenting = type.isPresenting
        
        let infoImageViewSnapshot: UIView
        
        if isPresenting {
            infoImageViewSnapshot = cellImageSnapshot
        } else {
            infoImageViewSnapshot = recipeInfoImageSnapshot
        }
        
        toView.alpha = 0
        
        [infoImageViewSnapshot].forEach {
            containerView.addSubview($0)
        }
        
        let controllerImageViewRect = recipeViewController.infoGraphicImage.convert(recipeViewController.infoGraphicImage.bounds, to: window)
        
        [infoImageViewSnapshot].forEach {
            $0.frame = isPresenting ? cellImageViewRect : controllerImageViewRect
        }
        
        UIView.animateKeyframes(withDuration: Self.duration,
                                delay: 0,
                                options: .calculationModeCubic) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                infoImageViewSnapshot.frame = isPresenting ? controllerImageViewRect : self.cellImageViewRect
            }
        } completion: { _ in
            infoImageViewSnapshot.removeFromSuperview()
            
            toView.alpha = 1
            
            transitionContext.completeTransition(true)
        }

    }

}
