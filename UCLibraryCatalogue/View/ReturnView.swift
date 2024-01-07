//
//  ReturnView.swift
//  UCLibraryCatalogue
//
//  Created by Manuel Johan Tito on 06/01/24.
//

import Foundation
import SwiftUI

struct ReturnView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var borrowerViewModel = BorrowerViewModel()
    @StateObject var bookViewModel = BooksCatalogueViewModel()
    

    
    var borrower_name: String
    var borrowed_book: String
    var borrow_date: String
    var return_date: String
    
    var borrowed_book_title: String
    
    let tes = ["tes","tes"]

    
    var body: some View {
        NavigationView{
            
            VStack{
                Form{
                    Section{
                        Text("Borrower Name : \(borrower_name)")
                        Text("Borrowed Book : \(borrowed_book_title)")
                        
                    } header: {
                        Text("Borrower Data")
                    }
                    Section{
                        Text("Borrow Date : \(borrow_date)")
                        Text("Return Date : \(return_date)")
                    } header: {
                        Text("Date Data")
                    }
                    

                }
            }

            .navigationTitle("Return")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()

                    }, label: {
                        Text("Cancel")
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // update book data (availability) in database
                        bookViewModel.updateBookReturn(book_id: borrowed_book)
                        
                        // delete borrower in database
                        borrowerViewModel.deleteBorrower(borrowed_book: borrowed_book)
                        print(borrower_name)
                        print(borrowed_book)
                        dismiss()
                    }, label: {
                        Text("Return")
                    })
                    
                }
            }
            
        }
        
    }
}

#Preview {
    ReturnView(borrower_name: "Tes", borrowed_book: "10", borrow_date: "borrow date", return_date: "return date", borrowed_book_title: "Title")
}
