//
//  RecipesDetailViewModel.swift
//  Linner
//
//  Created by C4Q on 1/22/19.
//  Copyright © 2019 Iram Fattah. All rights reserved.
//

import UIKit
import Kingfisher

class RecipeDetailViewModel {
    var menu: Menu!
    var recipe: Recipe!
    
    init(with menu: Menu, recipe: Recipe) {
        self.menu = menu
        self.recipe = recipe
    }
    
    func getRecipeName() -> String {
        return recipe.name
    }
    
    func getDescription() -> String {
        return "\"\(recipe.description)!\""
    }
    
    func setRecipeImage(_ imageView: UIImageView) {
        let urlString = recipe.image
        guard let url = URL(string: urlString) else { return }
        
        imageView.kf.setImage(with: url) { (_, error, _, _) in
            if let _ = error {
                print(AppError.badImageURL(string: urlString))
            }
        }
    }
    
}
