//
//  RecipeViewModel.swift
//  HomeTail
//
//  Created by taeuk on 2021/07/04.
//

import Foundation

class RecipeViewModel {
    
    var service: CockTailService?
    
    var cockTailIndex: Dynamic<Int> = Dynamic(0)
    var cockRecipe: CockTailListModel?
    
    func showList() {
        guard let recipeDatas = service?.objectData?[cockTailIndex.value] else { return }
        
        cockRecipe = CockTailListModel(cockID: recipeDatas.value(forKey: "cockID") as? Int16 ?? 0,
                          name: recipeDatas.value(forKey: "name") as? String ?? "",
                          subname: recipeDatas.value(forKey: "subname") as? String ?? "",
                          source: recipeDatas.value(forKey: "source") as? String ?? "",
                          taste: recipeDatas.value(forKey: "taste") as? String ?? "",
                          base: recipeDatas.value(forKey: "base") as? String ?? "",
                          alcohol: recipeDatas.value(forKey: "alcohol") as? String ?? "",
                          alcoholkind: recipeDatas.value(forKey: "alcoholkind") as? String ?? "",
                          explain: recipeDatas.value(forKey: "explain") as? String ?? "",
                          recipe: recipeDatas.value(forKey: "recipe") as? [String] ?? [],
                          cocktailimageurl: recipeDatas.value(forKey: "cocktailimageurl") as? String ?? "")
    }
    
    func convertRecipe() -> String {
        guard let explain = cockRecipe?.explain else { return "" }
        var description: String = ""
        for separ in explain.components(separatedBy: "\\n") {
            description += String(separ)+"\n"
        }
        return description
    }
}
