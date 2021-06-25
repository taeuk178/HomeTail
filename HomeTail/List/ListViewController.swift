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
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

// MARK: - Table

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ListTableCell = tableView.dequeueTableCell(for: indexPath)
        cell.textLabel?.text = "A"
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
