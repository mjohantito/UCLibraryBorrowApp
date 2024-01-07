//
//  BookDetailView.swift
//  UCLibraryCatalogue
//
//  Created by Manuel Johan Tito on 06/01/24.
//

import SwiftUI

struct BookDetailView: View {
    
    var book_id: String
    var book_title: String
    var book_author: String
    var book_year: String
    var book_desc: String
    var book_image: String
    var availability: String
    var borrower: Int
//    var borrow_date: String?
//    var return_date: String?
    
    
    
    @State private var showingsheet = false
    
    @StateObject var booksViewModel = BooksCatalogueViewModel()
    
    @StateObject var borrowerViewModel = BorrowerViewModel()
    
//    var borrowerNamee = ""
//    var borrowedBookk = ""
//    var borrowDatee = ""
//    var returnDatee = ""
    
    var body: some View {
        
        NavigationView{
            VStack{
                ZStack{
                    URLImageBackground(urlString: book_image, data: nil)
                    VStack{
                        Spacer()
                        HStack{
                            Text(book_title)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .padding()
                                
                            Spacer()
                        }
                        .shadow(radius: 30)
                        
                    }
                }
                Text(book_author)
                    .font(.title)
                Text(book_year)
                    .font(.title3)
                Text(book_desc)
                    .font(.caption)
                    .multilineTextAlignment(.trailing)
                if(availability == "1"){
                    Text("AVAILABLE")
                }else{
                    Text("BORROWED")
                }
                
                
                Button(action: {
                    showingsheet.toggle()
                    
                    borrowerViewModel.fetchFirstBorrowerbyBook(borrowed_book: book_id)
                    print("book id \(book_id)")
                    
                    
                }, label: {
                    if(availability == "1"){
                        Text("Borrow")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .font(.system(size: 18))
                            .padding()
                            .foregroundColor(.gray)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.black, lineWidth: 2))
                    }else{
                        Text("Return")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .font(.system(size: 18))
                            .padding()
                            .foregroundColor(.gray)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.black, lineWidth: 2))
                    }
                    
                })
                .sheet(isPresented: $showingsheet){
                    if(availability == "1"){
                        BorrowView(book_id:book_id)
                    }else{
                        
                        
                        let borrowerNamee = borrowerViewModel.singleBorrowers?.borrower_name
                        let borrowedBookk = borrowerViewModel.singleBorrowers?.borrowed_book
                        let borrowDatee = borrowerViewModel.singleBorrowers?.borrow_date
                        let returnDatee = borrowerViewModel.singleBorrowers?.return_date
                        
//                        print(borrowerNamee ?? "gaada borrower")
//                        print(borrowedBookk ?? "gaada book")
//                        print(borrowDatee ?? "ga dapet daet")
//                        print(returnDatee ?? "ga dapet return date")
                        
                        
                        ReturnView(borrower_name: borrowerNamee ?? "gadapet name", borrowed_book: borrowedBookk ?? "gadapet book", borrow_date: borrowDatee ?? "ga dapet date", return_date: returnDatee ?? "ga dapet return date")
                        
                    }
                    
                }
                
            }
            .onAppear{
                borrowerViewModel.fetchFirstBorrowerbyBook(borrowed_book: book_id)
                
                
            }
            
            
        }
        
    }
}

#Preview {
    BookDetailView(book_id: "2", book_title: "Rich Dad Poor Dad", book_author: "Kamu", book_year: "2000", book_desc: "Lorem Ipsum", book_image: "https://m.media-amazon.com/images/I/81bsw6fnUiL._AC_UF1000,1000_QL80_.jpg", availability: "1", borrower: 0)
}
