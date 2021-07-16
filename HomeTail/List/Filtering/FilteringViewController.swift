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
    
    var floatingPanel: FloatingPanelController?
    
    private let filteringLabel: UILabel = create {
        $0.text = "필터링"
        $0.font = .appSansFont(.sansHWBold, size: 30)
        $0.textAlignment = .left
    }
    
    private let changedButton: UIButton = {
        $0.setTitle("변경완료", for: .normal)
        $0.setTitleColor(.appMainColor(.subOrangeColor), for: .normal)
        $0.titleLabel?.font = .apphelveticaFont(.helveticaMedium, size: 16)
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.appMainColor(.subOrangeColor).cgColor
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 15
        return $0
    }(UIButton(type: .system))
    
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

    @objc func changedAction(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.1) {
            self.floatingPanel?.move(to: .tip, animated: true)
        }
        
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
            cell.checkBox.addTarget(self, action: #selector(touchesAction(_:)), for: .touchUpInside)
            cell.checkBox.isSelected = false
            cell.selectItems(SelectedItems.shared)
            return cell
        case 1:
            let cell: FilteringTableCell = tableView.dequeueTableCell(for: indexPath)
            cell.textShow(SelectedCases.base.rawValues[indexPath.row])
            cell.selectionStyle = .none
            cell.checkBox.tag = indexPath.row
            cell.checkBox.addTarget(self, action: #selector(touchesAction(_:)), for: .touchUpInside)
            cell.selectItems(SelectedItems.shared)
            return cell
        case 2:
            let cell: FilteringTableCell = tableView.dequeueTableCell(for: indexPath)
            cell.textShow(SelectedCases.alcohol.rawValues[indexPath.row])
            cell.selectionStyle = .none
            cell.checkBox.tag = indexPath.row
            cell.checkBox.addTarget(self, action: #selector(touchesAction(_:)), for: .touchUpInside)
            cell.selectItems(SelectedItems.shared)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    @objc func touchesAction(_ sender: UIButton) {
        
        tableView.reloadData()
        
        sender.isSelected = !sender.isSelected
        
    }
}

// MARK: - UI

extension FilteringViewController {
    
    override func setupConfiguration() {
        
        view.addSubview(tableView)
        view.addSubview(filteringLabel)
        view.addSubview(changedButton)
        
        tableView.registerCell(FilteringTableCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func setupProperties() {
        
        changedButton.addTarget(self, action: #selector(changedAction(_:)   ), for: .touchUpInside)
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
        
        changedButton.snp.makeConstraints {
            $0.centerY.equalTo(filteringLabel.snp.centerY)
            $0.trailing.equalTo(view).offset(-20)
            $0.width.equalTo(100)
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
