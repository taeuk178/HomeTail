//
//  FilteringViewController.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/28.
//

import UIKit
import FloatingPanel

class FilteringViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let filteringLabel: UILabel = create {
        $0.text = "필터링"
        $0.font = .appSansFont(.sansHWBold, size: 30)
        $0.textAlignment = .left
    }
    
    let tableView: UITableView = create {
        $0.separatorStyle = .none
    }
    
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
            return SelectedCases.taste.allCount
        case 1:
            return SelectedCases.base.allCount
        case 2:
            return SelectedCases.alcohol.allCount
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        
        let headerTitle: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        headerTitle.font = .appSansFont(.sansHWBold, size: 28)
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 46
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell: FilteringTableCell = tableView.dequeueTableCell(for: indexPath)
            cell.textShow(SelectedCases.taste.rawValues[indexPath.row])
            cell.selectionStyle = .none
            cell.checkBox.tag = indexPath.row
            return cell
        case 1:
            let cell: FilteringTableCell = tableView.dequeueTableCell(for: indexPath)
            cell.textShow(SelectedCases.base.rawValues[indexPath.row])
            cell.selectionStyle = .none
            cell.checkBox.tag = indexPath.row
            return cell
        case 2:
            let cell: FilteringTableCell = tableView.dequeueTableCell(for: indexPath)
            cell.textShow(SelectedCases.alcohol.rawValues[indexPath.row])
            cell.selectionStyle = .none
            cell.checkBox.tag = indexPath.row
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UI

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

// MARK: - FloatingPanelLayout

extension FilteringViewController: FloatingPanelLayout {
    
    var position: FloatingPanelPosition {
        .bottom
    }
    
    var initialState: FloatingPanelState {
        .tip
    }
    
    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 30.0, edge: .top, referenceGuide: .safeArea),
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 60.0, edge: .bottom, referenceGuide: .safeArea)
        ]
    }
    
}
