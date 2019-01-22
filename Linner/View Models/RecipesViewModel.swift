//
//  RecipesViewModel.swift
//  Linner
//
//  Created by C4Q on 1/22/19.
//  Copyright © 2019 Iram Fattah. All rights reserved.
//

import Foundation
import Kingfisher

class RecipesViewModel {
    var apiClient: APIClient!
    var menu: Menu!
    var recipes: [Recipe]?
    
    init(with apiClient: APIClient, menu: Menu) {
        self.apiClient = apiClient
        self.menu = menu
    }
    
    func getMenuTitle() -> String {
        return menu.title
    }
    
    func getRecipes(_ completionHandler: @escaping () -> Void) {
        guard let recipesURL = UrlBuilder.manager.getURLforRecipe(at: menu.id) else { return }
        
        let completionHandler = { [weak self] (data: Data) in
            DispatchQueue.main.async {
                do {
                    let recipes = try JSONDecoder().decode([Recipe].self, from: data)
                    
                    self?.recipes = recipes
                    completionHandler()
                }
                catch {
                    print(AppError.couldNotParseJSON(rawError: error))
                }
            }
        }
        
        let errorHandler = { (error: Error) in
            print(AppError.couldNotParseJSON(rawError: error))
        }
        
        apiClient.performDataTask(with: recipesURL, completionHandler: completionHandler, errorHandler: errorHandler)
    }
    
    func numberOfItemsToDisplay(in section: Int) -> Int {
        return recipes?.count ?? 0
    }
    
    func recipeNameToDisplay(for indexPath: IndexPath) -> String {
        return recipes?[indexPath.row].name ?? ""
    }
    
    func recipeDescriptionToDisplay(for indexPath: IndexPath) -> String {
        return recipes?[indexPath.row].description ?? ""
    }
    
    func recipeImageToDisplay(for indexPath: IndexPath, _ imageView: UIImageView, _ completionHandler: @escaping () -> Void) {
        guard let urlString = recipes?[indexPath.row].image else { return }
        guard let url = URL(string: urlString) else { return }
        
        imageView.kf.setImage(with: url) { (image, _, _, _) in
            if let _ = image {
                completionHandler()
            }
        }
        
    }
}
