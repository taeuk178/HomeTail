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
    
    // 뒤로가기 버튼
    private let dismissButton: UIButton = {
        $0.setImage(UIImage(named: "back"), for: .normal)
        return $0
    }(UIButton())
    
    private let tableView: UITableView = {
        $0.separatorStyle = .none
        $0.backgroundColor = .appMainColor(.subSkyBlueColor)
        $0.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
        return $0
    }(UITableView())
    
    var floatingPanelController: FloatingPanelController!
    
    let listViewModel = ListViewModel()
    
    var homeViewModel: HomeViewModel?
    
    // transition
    
    var tableCell: ListTableCell?
    var selectedCellImageViewSnapshot: UIView?
    
    var animator: CustomAnimator?
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpFloatingPanel()
        listViewModel.readCockTailFireStoreData {
            self.tableView.reloadData()
        }
        
    }
    
    @objc func dismissAction(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        homeViewModel?.connectCase.value = .taste
        homeViewModel?.showColor.value = .taste
        SelectedItems.shared.taste = nil
        SelectedItems.shared.base = nil
        SelectedItems.shared.alcohol = nil

    }
}

// MARK: - Table

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.cockTailList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ListTableCell = tableView.dequeueTableCell(for: indexPath)
        
        guard let datas = listViewModel.cockTailList?[indexPath.row] else { fatalError() }
        
        cell.setUpCell(mainString: datas.name, subString: datas.subName, alchol: datas.alcohol)
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
        
        self.dismissButton.addTarget(self, action: #selector(dismissAction(_:)), for: .touchUpInside)
    }
    
    override func setupConfiguration() {
        
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
            $0.top.equalTo(view)
            $0.leading.trailing.equalTo(view)
            $0.bottom.equalTo(view).offset(-100)
        }
    }
    
    func setUpFloatingPanel() {
        
        floatingPanelController = FloatingPanelController()
        floatingPanelController.surfaceView.layer.cornerRadius = 15
        floatingPanelController.surfaceView.clipsToBounds = true
        floatingPanelController.surfaceView.backgroundColor = .clear
        // Assign self as the delegate of the controller.
        floatingPanelController.delegate = self // Optional
        
        // Set a content view controller.
        let contentVC = FilteringViewController()
        contentVC.floatingPanel = floatingPanelController
        floatingPanelController.set(contentViewController: contentVC)

        // Track a scroll view(or the siblings) in the content view controller.
        floatingPanelController.track(scrollView: contentVC.tableView)
        floatingPanelController.layout = contentVC
        // Add and show the views managed by the `FloatingPanelController` object to self.view.
        floatingPanelController.addPanel(toParent: self)
    }
    
}

// MARK: - TransitionDelegate

extension ListViewController: UIViewControllerTransitioningDelegate {
    
    // Present
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard let listViewController = presenting as? ListViewController,
              let recipeViewController = presented as? RecipeViewController,
              let selectedCellImageSnapshot = selectedCellImageViewSnapshot else { return nil}
        
        animator = CustomAnimator(type: .present,
                                   listViewController: listViewController,
                                   recipeViewController: recipeViewController,
                                   selectedCellImageViewSnapshot: selectedCellImageSnapshot)
        return animator
        
    }
    
    // Dismiss
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let recipeViewController = dismissed as? RecipeViewController,
                let selectedCellImageViewSnapshot = selectedCellImageViewSnapshot
                else { return nil }

            animator = CustomAnimator(type: .dismiss,
                                       listViewController: self,
                                       recipeViewController: recipeViewController,
                                       selectedCellImageViewSnapshot: selectedCellImageViewSnapshot)
            return animator
    }
}
