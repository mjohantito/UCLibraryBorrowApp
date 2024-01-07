//
//  BorrowReturnView.swift
//  UCLibraryCatalogue
//
//  Created by Manuel Johan Tito on 06/01/24.
//

import SwiftUI

struct BorrowView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var borrowerViewModel = BorrowerViewModel()
    @StateObject var bookViewModel = BooksCatalogueViewModel()
    
    
    @State var book_id: String
    @State var borrowerId = ""
    @State var borrowerName = ""
      
    @State var dateNow = Date.now
    
    @State private var searchText = ""
    
    @State private var saveButtonEnable = false
    

    
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    Section{
                        TextField("Name",text: $borrowerName)
                        DatePicker("Borrowed Date", selection: $dateNow, displayedComponents: .date)
                    } header:{
                        Text("Borrower Data")
                    }
                    
                    
                }
            }
            .navigationTitle("Borrow")
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
                        if borrowerName != ""{
                            // if borrower name not null, CREATE borrower data in database
                            borrowerViewModel.createBorrower(borrowername: borrowerName, borrowed_book: book_id)
                            // update book data (availability) in database
                            bookViewModel.updateBookBorrow(book_id: book_id)
                        } else {
                            saveButtonEnable = true
                        }
                            
                        print(borrowerName)
                        print(book_id)
                        dismiss()
                    }, label: {
                        Text("Save")
                    }).disabled(saveButtonEnable)
                    
//
                    
                }
            }
            
        }
        .onAppear{
            
            //fetch borrowers data
            borrowerViewModel.fetchAllBorrowers()
        }
        
    }
    

}

#Preview {
    BorrowView(book_id:"2")
}
