//
//  HomeViewController.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/06.
//

import SnapKit
import UIKit
import CoreData

final class HomeViewController: BaseViewController {
    
    // MARK: - Properties
    
    let textLabel: UILabel = create {
        $0.text = "Home Tail"
        $0.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
    }
    
    let cockList = CockTailListModel(id: 1,
                                     name: "1",
                                     source: "2",
                                     base: "3",
                                     taste: "4",
                                     technique: "5",
                                     glass: "6",
                                     explain: "7",
                                     amount: [0],
                                     recipe: [""],
                                     cocktailimageurl: "")
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "List", in: context) else { return }
        
        let person = NSManagedObject(entity: entity,
                                     insertInto: context)
        
        // 3
        //        person.setValue(name, forKeyPath: "name")
        person.setValue(cockList.id, forKey: "id")
        person.setValue(cockList.name, forKey: "name")
        person.setValue(cockList.source, forKey: "source")
        person.setValue(cockList.base, forKey: "base")
        person.setValue(cockList.taste, forKey: "taste")
        person.setValue(cockList.technique, forKey: "technique")
        person.setValue(cockList.glass, forKey: "glass")
        person.setValue(cockList.explain, forKey: "explain")
        person.setValue(cockList.amount, forKey: "amount")
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
        
        view.addSubview(textLabel)
    }
    
    override func setupConstraints() {
        
        textLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(100)
        }
    }
}
