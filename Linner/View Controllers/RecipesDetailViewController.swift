//
//  RecipesDetailViewController.swift
//  Linner
//
//  Created by C4Q on 1/22/19.
//  Copyright © 2019 Iram Fattah. All rights reserved.
//

import UIKit

class RecipesDetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    
    var viewModel: RecipeDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.accessibilityIdentifier = "recipeDetailView"
        
        setupView()
    }
    
    func setupView() {
        nameLabel.text = viewModel.getRecipeName()
        descriptionLabel.text = viewModel.getDescription()
        viewModel.setRecipeImage(recipeImageView)
    }
}
