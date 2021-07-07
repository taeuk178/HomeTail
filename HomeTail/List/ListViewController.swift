//
//  ListViewController.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/26.
//

import UIKit
import SnapKit
import FloatingPanel

class ListViewController: BaseViewController, FloatingPanelControllerDelegate {

    // MARK: - Properties
    
    private let dismissButton: UIButton = create {
        $0.setImage(UIImage(named: "back"), for: .normal)
    }
    
    private let tableView: UITableView = create {
        $0.separatorStyle = .none
        $0.backgroundColor = .appMainColor(.subSkyBlueColor)
    }
    
    var fpc: FloatingPanelController!
    
    let listViewModel = ListViewModel()
    
    // transition
    
    var tableCell: ListTableCell?
    var selectedCellImageViewSnapshot: UIView?
    
    var animator: PresentAnimator?
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fpc = FloatingPanelController()
        fpc.surfaceView.layer.cornerRadius = 15
        fpc.surfaceView.clipsToBounds = true
        fpc.surfaceView.backgroundColor = .clear
        // Assign self as the delegate of the controller.
        fpc.delegate = self // Optional
        
        // Set a content view controller.
        let contentVC = FilteringViewController()
        fpc.set(contentViewController: contentVC)

        // Track a scroll view(or the siblings) in the content view controller.
        fpc.track(scrollView: contentVC.tableView)
        fpc.layout = contentVC
        // Add and show the views managed by the `FloatingPanelController` object to self.view.
        fpc.addPanel(toParent: self)
        
        listViewModel.readCockTailList()
        dismissButton.addTarget(self, action: #selector(dismissAction(_:)), for: .touchUpInside)
    }
    
    @objc func dismissAction(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Table

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.cockList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ListTableCell = tableView.dequeueTableCell(for: indexPath)
        
        guard let datas = listViewModel.cockList?[indexPath.row] else { fatalError() }
        
        cell.setUpCell(mainString: datas.name, subString: datas.subName)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipeVC = RecipeViewController()
        recipeVC.recipeViewModel.service = listViewModel.service
        recipeVC.recipeViewModel.cockTailIndex.value = indexPath.row
        recipeVC.transitioningDelegate = self
        recipeVC.modalPresentationStyle = .custom
        
        tableCell = tableView.cellForRow(at: indexPath) as? ListTableCell
        selectedCellImageViewSnapshot = tableCell?.infoGraphicImage.snapshotView(afterScreenUpdates: false)
        
        self.present(recipeVC, animated: true, completion: nil)
    }
}

// MARK: - UI

extension ListViewController {
    
    override func setupProperties() {
        
    }
    
    override func setupConfiguration() {
        
        navigationSetUp()
        
        view.backgroundColor = .appMainColor(.subSkyBlueColor)
        view.addSubview(tableView)
        view.addSubview(dismissButton)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(ListTableCell.self)

    }
    
    override func setupConstraints() {
        
        dismissButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalTo(view).offset(20)
            $0.width.equalTo(40)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(dismissButton.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalTo(view)
        }
    }
    
    func navigationSetUp() {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let backButton = UIBarButtonItem(image: UIImage(named: "back"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(backButtonAction(_:)))
        
        self.navigationItem.leftBarButtonItem = backButton
        
    }
    
    @objc func backButtonAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ListViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard let firstVC = presenting as? ListViewController,
              let secondVC = presented as? RecipeViewController,
              let selectedCellImageSnapshot = selectedCellImageViewSnapshot else { return nil}
        
        animator = PresentAnimator(type: .present,
                                   firstViewController: firstVC,
                                   secondViewController: secondVC,
                                   selectedCellImageViewSnapshot: selectedCellImageSnapshot)
        return animator
        
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let secondViewController = dismissed as? RecipeViewController,
                let selectedCellImageViewSnapshot = selectedCellImageViewSnapshot
                else { return nil }

            animator = PresentAnimator(type: .dismiss,
                                       firstViewController: self,
                                       secondViewController: secondViewController,
                                       selectedCellImageViewSnapshot: selectedCellImageViewSnapshot)
            return animator
    }
}

final class PresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var selectedCellImage: UIView?
    
    static let duration: TimeInterval = 1.25
    
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
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Self.duration
    }
    
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

enum PresentationType {

    case present
    case dismiss

    var isPresenting: Bool {
        return self == .present
    }
}
