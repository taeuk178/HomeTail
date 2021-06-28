//
//  FilteringViewController.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/28.
//

import UIKit
import FloatingPanel

class FilteringViewController: BaseViewController, FloatingPanelLayout {
    
    // MARK: - Properties
    
    private let filteringLabel: UILabel = create {
        $0.text = "필터링"
        $0.font = .systemFont(ofSize: 30)
        $0.textAlignment = .left
    }
    
    private let tableView: UITableView = create {
        $0.separatorStyle = .none
    }
    
    // FloatingPannel
    var position: FloatingPanelPosition = .bottom
    
    var initialState: FloatingPanelState = .tip
    
    var anchors: [FloatingPanelState : FloatingPanelLayoutAnchoring] {
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 16.0, edge: .top, referenceGuide: .safeArea),
            .half: FloatingPanelLayoutAnchor(fractionalInset: 0.5, edge: .bottom, referenceGuide: .safeArea),
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 44.0, edge: .bottom, referenceGuide: .safeArea)
        ]
    }
    //
    
    // MARK: - LifeCycle
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    }

}

extension FilteringViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 4
        case 2:
            return 5
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        
        let headerTitle: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        headerTitle.font = .systemFont(ofSize: 28, weight: .medium)
        headerTitle.textAlignment = .left
        
        header.addSubview(headerTitle)
        
        headerTitle.snp.makeConstraints {
            $0.leading.equalTo(header).offset(20)
            $0.centerY.equalTo(header)
            $0.width.greaterThanOrEqualTo(50)
        }
        
        switch section {
        case 0:
            headerTitle.text = "맛"
        case 1:
            headerTitle.text = "기주"
        case 2:
            headerTitle.text = "도수"
        default:
            return nil
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell: FilteringTableCell = tableView.dequeueTableCell(for: indexPath)
            cell.textShow("abc")
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell: FilteringTableCell = tableView.dequeueTableCell(for: indexPath)
            cell.textShow("123")
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell: FilteringTableCell = tableView.dequeueTableCell(for: indexPath)
            cell.textShow("ABC")
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension FilteringViewController {
    
    override func setupConfiguration() {
        
        view.addSubview(tableView)
        view.addSubview(filteringLabel)
        tableView.registerCell(FilteringTableCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func setupConstraints() {
        
        filteringLabel.snp.makeConstraints {
            $0.top.equalTo(view).offset(30)
            $0.leading.equalTo(view).offset(10)
            $0.width.greaterThanOrEqualTo(80)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(filteringLabel.snp.bottom).offset(40)
            $0.leading.trailing.bottom.equalTo(view)
        }
    }
}
