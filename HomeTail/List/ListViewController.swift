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
    private let tableView: UITableView = create {
        $0.separatorStyle = .none
        $0.backgroundColor = .appMainColor(.subSkyBlueColor)
    }
    
    var fpc: FloatingPanelController!
    
    let listViewModel = ListViewModel()
    
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
        self.navigationController?.pushViewController(recipeVC, animated: true)
    }
}

// MARK: - UI

extension ListViewController {
    
    override func setupProperties() {
        
    }
    
    override func setupConfiguration() {
        
        navigationSetUp()
        
        view.addSubview(tableView)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(ListTableCell.self)

    }
    
    override func setupConstraints() {
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view)
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
