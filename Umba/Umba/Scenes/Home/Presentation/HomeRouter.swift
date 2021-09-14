//
//  HomeRouter.swift
//  Umba
//
//  Created by Nivardo Ibarra on 9/13/21.
//

import UIKit

@objc protocol HomeRoutingLogic {}

protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get }
}

class HomeRouter: NSObject, HomeRoutingLogic, HomeDataPassing {
    
    // MARK: - Properties
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
}
