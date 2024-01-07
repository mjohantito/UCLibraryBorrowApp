//
//  BorrowerViewModel.swift
//  UCLibraryCatalogue
//
//  Created by Manuel Johan Tito on 06/01/24.
//

import Foundation
import SwiftUI


class BorrowerViewModel: ObservableObject{
    
    @Published var borrowers: [BorrowerModel] = []
    
    @Published var singleBorrowers: BorrowerModel? = nil
    
    @Published var borrower_id = ""
    
    
    
//    func fetchBorrowerId(borrowername: String){
//        guard let url = URL(string:"http://localhost/library-php-api/books/readoneborrower.php?borrower_name=\(borrowername)") else {
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
//            if let data = data {
//                do{
//                    let borrower = try JSONDecoder().decode(BorrowerModel.self, from: data)
//                    DispatchQueue.main.async {
//                        // Update the books array or store the single book in a separate property
//                        // based on your design
//                        self?.borrowers = [borrower]
//                    }
//                }
//                catch {
//                    print(error)
//                }
//            }
//            
//            
//            
//        }
//        task.resume()
//    }
    
    func fetchAllBorrowers() {
        guard let url = URL(string:"http://localhost/library-php-api/books/readoneborrower.php") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            // convert to JSON
            do {
                let borrowers = try JSONDecoder().decode([BorrowerModel].self, from: data)
                DispatchQueue.main.async {
                    self?.borrowers = borrowers
                }
            }
            catch {
                print(error)
                
            }
            
        }
        task.resume()
    }
    
    
    
   

    
    func createBorrower(borrowername: String, borrowed_book: String){
        guard let url = URL(string:"http://localhost/library-php-api/books/createborrower.php") else {
            return
        }
        
//        let data = try! JSONSerialization.data(withJSONObject: parameters)
        
        
        let body:[String: AnyHashable] = [
            "borrower_name":"\(borrowername)",
            "borrowed_book":borrowed_book
        
        ]
        
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
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
    
    func updateBorrower(borrower_id: String){
        guard let url = URL(string:"http://localhost/library-php-api/books/createborrower.php?borrower_id=\(borrower_id)") else {
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
    
    func updateBorrowerReturned(borrower_id: String){
        guard let url = URL(string:"http://localhost/library-php-api/books/createborrower.php?borrower_id=\(borrower_id)") else {
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
    
    func fetchFirstBorrower(borrower_id: Int) {
        guard let url = URL(string: "http://localhost/library-php-api/books/updatereturnedborrower.php?borrower_id=\(borrower_id)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            // Convert to JSON
            do {
                let borrowers = try JSONDecoder().decode([BorrowerModel].self, from: data)
                
                if let firstBorrower = borrowers.first {
                    DispatchQueue.main.async {
                        self?.borrowers = [firstBorrower]
                    }
                }
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
    
    func fetchFirstBorrowerbyName(borrower_name: String) {
        guard let url = URL(string:"http://localhost/library-php-api/books/readoneborrower.php?borrower_name=\(borrower_name)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            // convert to JSON
            do {
                let borrowers = try JSONDecoder().decode([BorrowerModel].self, from: data)
                DispatchQueue.main.async {
                    self?.borrowers = borrowers
                }
            }
            catch {
                print("fetchbyName\(error)")
                
            }
            
        }
        task.resume()
    }
    
    func fetchFirstBorrowerbyBook(borrowed_book: String) {
        guard let url = URL(string:"http://localhost/library-php-api/books/readoneborrowerbybook.php?borrowed_book=\(borrowed_book)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            // decode JSON
            do {
                let borrowers = try JSONDecoder().decode(BorrowerModel.self, from: data)
                DispatchQueue.main.async {
                    self?.singleBorrowers = borrowers
                }
            }
            catch {
                print("fetchbyBook\(error)")
                
            }
            
        }
        task.resume()
    }
    
    func deleteBorrower(borrowed_book: String) {
        guard let url = URL(string:"http://localhost/library-php-api/books/deleteborrower.php?borrowed_book=\(borrowed_book)") else {
            return
        }
                
        
        let body:[String: AnyHashable] = [:]
        
        var request = URLRequest(url:url)
        request.httpMethod = "DELETE"
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
