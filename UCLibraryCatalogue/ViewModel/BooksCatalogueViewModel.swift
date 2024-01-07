//
//  BooksCatalogueViewModel.swift
//  UCLibraryCatalogue
//
//  Created by Manuel Johan Tito on 06/01/24.
//

import Foundation
import SwiftUI


class BooksCatalogueViewModel: ObservableObject{
    
    @Published var books: [BooksCatalogueModel] = []
    
    //fetch all books data from database
    func fetchAllBooks() {
        guard let url = URL(string:"http://localhost/library-php-api/books/readbookcollection.php") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            // convert to JSON
            do {
                let books = try JSONDecoder().decode([BooksCatalogueModel].self, from: data)
                DispatchQueue.main.async {
                    self?.books = books
                }
            }
            catch {
                print(error)
                
            }
            
        }
        task.resume()
    }
    
    
    //unused
    func fetchFirstBook() {
        guard let url = URL(string: "http://localhost/library-php-api/books/readbookcollection.php") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            // Convert to JSON
            do {
                let books = try JSONDecoder().decode([BooksCatalogueModel].self, from: data)
                
                if let firstBook = books.first {
                    DispatchQueue.main.async {
                        self?.books = [firstBook]
                    }
                }
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
    
  
    //unused
    func deleteBook(indexSet: IndexSet){

    }
    
    //update availibility into 1 (available)
    func updateBookReturn(book_id: String){
        guard let url = URL(string:"http://localhost/library-php-api/books/updatereturnedbook.php?book_id=\(book_id)") else {
            return
        }
        
        let body:[String: AnyHashable] = [:]
        
        var request = URLRequest(url:url)
        request.httpMethod = "PUT"
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print("success: \(response)")
            }
            catch {
                print(error)
            }
        }
        task.resume()
        
    }
    
    //update availibility into 2 (borrowed)
    func updateBookBorrow(book_id: String){
        guard let url = URL(string:"http://localhost/library-php-api/books/updatebooks.php?book_id=\(book_id)") else {
            return
        }
        
//        let data = try! JSONSerialization.data(withJSONObject: parameters)
        let body:[String: AnyHashable] = [:]
        
        var request = URLRequest(url:url)
        request.httpMethod = "PUT"
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print("success: \(response)")
            }
            catch {
                print(error)
            }
        }
        task.resume()
        
    }
    

    
    
}
