//
//  BorrowerModel.swift
//  UCLibraryCatalogue
//
//  Created by Manuel Johan Tito on 06/01/24.
//

import Foundation
import SwiftUI

struct BorrowerModel: Hashable, Codable {
    var borrower_id: String
    var borrower_name: String
    var borrowed_book: String
    var borrow_date: String
    var return_date: String
}
