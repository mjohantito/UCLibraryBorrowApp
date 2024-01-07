//
//  CatalogueView.swift
//  UCLibraryCatalogue
//
//  Created by Manuel Johan Tito on 06/01/24.
//

import SwiftUI

struct CatalogueView: View {
    

    
    @State var data: Data?
    
    @StateObject var booksViewModel = BooksCatalogueViewModel()

    
    
    var body: some View {
        NavigationView{
            List{
                //show list of books
                ForEach(booksViewModel.books, id: \.self){ book in
                    NavigationLink(destination: BookDetailView(book_id: book.book_id, book_title: book.book_title, book_author: book.book_author, book_year: book.book_year, book_desc: book.book_desc, book_image: book.book_image, availability: book.availability, borrower: 0)){
                        HStack{
                            URLImage(urlString: book.book_image, data: nil)
                            VStack{
                                Text(book.book_title)
                                    .font(.title)
                                    .fontWeight(.bold)
                                Text(book.book_author)
                            }
                            Spacer()
                            VStack{
                                if(book.availability == "1"){
                                    Text("Available")
                                        .foregroundStyle(.green)
                                }else{
                                    Text("Borrowed")
                                        .foregroundColor(.red)
                                }
                            }
                            
                        }
                        .padding(3)
                    }
                }
                .onDelete(perform: { indexSet in
                    booksViewModel.deleteBook(indexSet: IndexSet())
                })
            }
            .navigationTitle("Books")
            .onAppear{
                
                //fetching books from viewmodel
                booksViewModel.fetchAllBooks()
            }
        }
        
        
        
        
    }
    
    
}

#Preview {
    CatalogueView()
}
