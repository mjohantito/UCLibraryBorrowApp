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
    
//    let date = NSDate()
//    let calendar = NSCalendar.current
//    @State var h7Now = Calendar.current.date(byAdding: .day, value: 7, to: Date.now)
//    
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
//                            // Create Date
//                            let date = dateNow
//                            let returndate = dateNow.addingTimeInterval(86400*7)
//
//                            // Create Date Formatter
//                            let dateFormatter = DateFormatter()
//
//                            // Convert Date to String
//                            dateFormatter.string(from: date)
//                            dateFormatter.string(from: returndate)
                            
//                            let today = dateNow
//                            let formatter1 = DateFormatter()
//                            formatter1.dateStyle = .short
//                            print(formatter1.string(from: today))
//                            
//                            let returndate = dateNow.addingTimeInterval(86400*7)
//                            let formatter2 = DateFormatter()
//                            formatter2.dateStyle = .short
//                            print(formatter1.string(from: returndate))
//                            borrowerViewModel.fetchFirstBorrowerbyName(borrower_name: borrowerName)
                            
                            borrowerViewModel.createBorrower(borrowername: borrowerName, borrowed_book: book_id)
                            
                            bookViewModel.updateBookBorrow(book_id: book_id)
                            // get borrower id, cari cara date to string
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
            borrowerViewModel.fetchAllBorrowers()
        }
        
    }
    

}

#Preview {
    BorrowView(book_id:"2")
}
