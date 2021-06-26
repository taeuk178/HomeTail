//
//  ListViewController.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/26.
//

import UIKit
import SnapKit

class ListViewController: BaseViewController {

    // MARK: - Properties
    private let tableView: UITableView = create {
        $0.separatorStyle = .none
        $0.backgroundColor = .lightGray
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}

// MARK: - Table

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ListTableCell = tableView.dequeueTableCell(for: indexPath)
        
        cell.setUpCell(mainString: "main", subString: "sub")
        
        return cell
    }
}

// MARK: - UI

extension ListViewController {
    
    override func setupProperties() {
        
    }
    
    override func setupConfiguration() {
        
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
}
