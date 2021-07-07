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
    
    static let duration: TimeInterval = 0.8
    
    private let type: PresentationType
    private let firstViewController: ListViewController
    private let secondViewController: RecipeViewController
    private let selectedCellImageViewSnapshot: UIView
    private let cellImageViewRect: CGRect
    
    init?(type: PresentationType, firstViewController: ListViewController, secondViewController: RecipeViewController, selectedCellImageViewSnapshot: UIView) {
        self.type = type
        self.firstViewController = firstViewController
        self.secondViewController = secondViewController
        self.selectedCellImageViewSnapshot = selectedCellImageViewSnapshot
        
        guard let window = firstViewController.view.window ?? secondViewController.view.window,
              let selectedCell = firstViewController.tableCell
        else { return nil }
        
        // B2 - 11
        self.cellImageViewRect = selectedCell.infoGraphicImage.convert(selectedCell.infoGraphicImage.bounds, to: window)
    }
    
    // 시간
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Self.duration
    }
    
    // 애니메이션
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        guard let toView = secondViewController.view else {
            transitionContext.completeTransition(false)
            return
        }
        containerView.addSubview(toView)
        
        guard let selectedCell = firstViewController.tableCell,
              let window = firstViewController.view.window ?? secondViewController.view.window,
              let cellImageSnapshot = selectedCell.infoGraphicImage.snapshotView(afterScreenUpdates: true),
              let controllerImageShapshot = secondViewController.infoGraphicImage.snapshotView(afterScreenUpdates: true)
        else {
            transitionContext.completeTransition(true)
            return
        }
        
        let isPresenting = type.isPresenting
        
        let imageViewSnapshot: UIView
        
        if isPresenting {
            imageViewSnapshot = cellImageSnapshot
        } else {
            imageViewSnapshot = controllerImageShapshot
        }
        
        toView.alpha = 0
        
        [imageViewSnapshot].forEach {
            containerView.addSubview($0)
        }
        
        let controllerImageViewRect = secondViewController.infoGraphicImage.convert(secondViewController.infoGraphicImage.bounds, to: window)
        
        [imageViewSnapshot].forEach {
            $0.frame = isPresenting ? cellImageViewRect : controllerImageViewRect
        }
        
        UIView.animateKeyframes(withDuration: Self.duration,
                                delay: 0,
                                options: .calculationModeCubic) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                imageViewSnapshot.frame = isPresenting ? controllerImageViewRect : self.cellImageViewRect
            }
        } completion: { _ in
            imageViewSnapshot.removeFromSuperview()
            
            toView.alpha = 1
            
            transitionContext.completeTransition(true)
        }

    }

}
