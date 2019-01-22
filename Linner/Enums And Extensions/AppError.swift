//
//  AppError.swift
//  Linner
//
//  Created by C4Q on 1/22/19.
//  Copyright © 2019 Iram Fattah. All rights reserved.
//

import Foundation
public enum AppError: Error {
    case badData
    case badImageData
    case badImageURL(string: String)
    case badStatusCode(num: Int)
    case badURL(string: String)
    case couldNotParseJSON(rawError: Error)
    case noInternet
    case other(rawError: Error)
}
