//
//  RemainderListViewModel.swift
//  RemindEase
//
//  Created by MTPC-206 on 05/08/24.
//

import Foundation
import RealmSwift

class RemainderListViewModel {
    
    private let remainderListService = RemainderListService()
    var items: Results<Remainder>?
    
}
