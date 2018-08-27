//
//  MainModelDelegate.swift
//  linxoTestCode
//
//  Created by Hugo GUTIERREZ on 25/08/2018.
//  Copyright © 2018 Hugo GUTIERREZ. All rights reserved.
//

import Foundation

protocol MainDataModelDelegate {
    func getDataFromURLDone<T>(with data:[T]...)
}
