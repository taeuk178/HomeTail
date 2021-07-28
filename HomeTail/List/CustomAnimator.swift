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
    private var selectedCellImageViewSnapshot: UIView
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
        
        let backgroundView: UIView
        let fadeView = UIView(frame: containerView.bounds)
        fadeView.backgroundColor = recipeViewController.view.backgroundColor
        
        if isPresenting {
            selectedCellImageViewSnapshot = cellImageSnapshot
            
            backgroundView = UIView(frame: containerView.bounds)
            backgroundView.addSubview(fadeView)
            fadeView.alpha = 0
        } else {
            backgroundView = listViewController.view.snapshotView(afterScreenUpdates: true) ?? fadeView
            backgroundView.addSubview(fadeView)
        }
        
        toView.alpha = 0
        
        [backgroundView, selectedCellImageViewSnapshot, recipeInfoImageSnapshot].forEach {
            containerView.addSubview($0)
        }
        
        let controllerImageViewRect = recipeViewController.infoGraphicImage.convert(recipeViewController.infoGraphicImage.bounds, to: window)
        
        [selectedCellImageViewSnapshot, recipeInfoImageSnapshot].forEach {
            $0.frame = isPresenting ? cellImageViewRect : controllerImageViewRect
        }
        
        recipeInfoImageSnapshot.alpha = isPresenting ? 0 : 1
        
        selectedCellImageViewSnapshot.alpha = isPresenting ? 1 : 0
        
        UIView.animateKeyframes(withDuration: Self.duration,
                                delay: 0,
                                options: .calculationModeCubic) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self.selectedCellImageViewSnapshot.frame = isPresenting ? controllerImageViewRect : self.cellImageViewRect
                recipeInfoImageSnapshot.frame = isPresenting ? controllerImageViewRect : self.cellImageViewRect
                
                fadeView.alpha = isPresenting ? 1 : 0
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.6) {
                self.selectedCellImageViewSnapshot.alpha = isPresenting ? 0 : 1
                recipeInfoImageSnapshot.alpha = isPresenting ? 1 : 0
            }
        } completion: { _ in
            
            self.selectedCellImageViewSnapshot.removeFromSuperview()
            recipeInfoImageSnapshot.removeFromSuperview()
            
            backgroundView.removeFromSuperview()
            
            toView.alpha = 1
            
            transitionContext.completeTransition(true)
        }

    }

}
