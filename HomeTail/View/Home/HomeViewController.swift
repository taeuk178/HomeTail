//
//  HomeViewController.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/06.
//

import SnapKit
import UIKit
import CoreData

/*
 진 = 1000
 보드카 = 2000
 럼 = 3000
 데낄라 = 4000
 리큐르 = 5000
 위스키 = 6000
 브랜디 = 7000
 논알콜 = 8000
 기타 = 9000
 몰라요 = 10000
 
 source = "출처" -> 변수명 변경 필요
 */

class HomeViewController: BaseViewController {
    
    // MARK: - Properties
    
    let homeVM = HomeViewModel()
    
    let topView: UIView = create {
        $0.backgroundColor = .white
    }
    
    let bottomView: UIView = create {
        $0.backgroundColor = .white
    }
    
    let textLabel: UILabel = create {
        $0.text = "Home Tail"
        $0.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
    }

    // test
    let cockList = CockTailListModel(cockID: 5000,
                                     name: "스크류 드라이버",
                                     source: "2", // source -> 다른 변수명 변경필요
                                     taste: "달다",
                                     base: "보드카",
                                     alcohol: "5.5",
                                     explain: "스크류 드라이버 설명.",
                                     recipe: ["보드카", "오렌지 주스"],
                                     cocktailimageurl: "https://image")
    // test
    var context: NSManagedObjectContext? {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return nil
            }
            
            return appDelegate.persistentContainer.viewContext
        }
    
    // MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        homeVM.readService()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // test
        guard let context = context else { return }
        
        guard let entity = NSEntityDescription.entity(forEntityName: "CockTailList", in: context) else { return }
        
        let person = NSManagedObject(entity: entity,
                                     insertInto: context)
        
        // 3
        person.setValue(cockList.cockID, forKey: "cockID")
        person.setValue(cockList.name, forKey: "name")
        person.setValue(cockList.source, forKey: "source")
        person.setValue(cockList.base, forKey: "base")
        person.setValue(cockList.taste, forKey: "taste")
        person.setValue(cockList.alcohol, forKey: "alcohol")
        person.setValue(cockList.explain, forKey: "explain")
        person.setValue(cockList.recipe, forKey: "recipe")
        person.setValue(cockList.cocktailimageurl, forKey: "cocktailimageurl")
        
        do {
            try context.save()

        } catch {
            print(error.localizedDescription)

        }
    }
}

// MARK: - UI

extension HomeViewController {
    
    override func setupConfiguration() {

        // Child ViewController 생성
        let iconViewController = HomeTopViewController()
        let selectViewController = HomeBottomViewController()

        // ViewModel 주소 전달
        iconViewController.customViewModel = homeVM
        selectViewController.customViewModel = homeVM

        self.addChild(iconViewController)
        self.addChild(selectViewController)

        // view를 생성해야 ViewController 생명주기 불림
        self.topView.addSubview(iconViewController.view)
        self.bottomView.addSubview(selectViewController.view)
        
        iconViewController.view.frame = topView.bounds
        selectViewController.view.frame = bottomView.bounds
        
        iconViewController.didMove(toParent: self)
        selectViewController.didMove(toParent: self)
        
        view.addSubview(topView)
        view.addSubview(bottomView)
    
    }
    
    override func setupConstraints() {
        
        topView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view)
            $0.bottom.equalTo(view).offset(-view.frame.size.height / 2)
        }
        
        bottomView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(view)
            $0.top.equalTo(topView.snp.bottom)
        }
    }
}
