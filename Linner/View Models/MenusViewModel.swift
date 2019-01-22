//
//  MenusViewModel.swift
//  Linner
//
//  Created by C4Q on 1/22/19.
//  Copyright © 2019 Iram Fattah. All rights reserved.
//

import Foundation
class MenusViewModel {
    var apiClient: APIClient!
    var menus: [Menu]?
    
    init(with apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func getMenus(_ completionHandler: @escaping () -> Void) {
        guard let menusUrl = UrlBuilder.manager.getURLforMenu() else { return }
        
        let completionHandler = { [weak self] (data: Data) in
            DispatchQueue.main.async {
                do {
                    let menus = try JSONDecoder().decode([Menu].self, from: data)
                    
                    self?.menus = menus
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
        
        apiClient.performDataTask(with: menusUrl, completionHandler: completionHandler, errorHandler: errorHandler)
    }
    
    func numberOfItemsToDisplay(in section: Int) -> Int {
        return menus?.count ?? 0
    }
    
    func menuTitleToDisplay(for indexPath: IndexPath) -> String {
        return menus?[indexPath.row].title ?? ""
    }
    
}
