//
//  BooksCatalogueModel.swift
//  UCLibraryCatalogue
//
//  Created by Manuel Johan Tito on 06/01/24.
//

import Foundation
import SwiftUI

struct BooksCatalogueModel: Hashable, Codable {
    var book_id: String
    var book_title: String
    var book_author: String
    var book_year: String
    var book_desc: String
    var book_image: String
    var availability: String
//    var borrow_date: String
//    var return_date: String
}
