//
//  ImageViewModel.swift
//  UCLibraryCatalogue
//
//  Created by Manuel Johan Tito on 06/01/24.
//

import Foundation
import SwiftUI

struct URLImage: View {
    let urlString: String
    
    @State var data: Data?
    
    var body: some View {
        if let data = data, let uiimage = UIImage(data: data) {
            Image(uiImage: uiimage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 130, height: 70)
                .background(Color.gray)
        }else {
            Image("")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 130, height: 70)
                .background(Color.gray)
                .onAppear(){
                    fetchData()
                }
            
        }
    }
    
    private func fetchData() {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            self.data = data
        }
        task.resume()
    }
}

struct URLImageBackground: View {
    let urlString: String
    
    @State var data: Data?
    
    var body: some View {
        if let data = data, let uiimage = UIImage(data: data) {
            ZStack{
                Image(uiImage: uiimage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 400, height: 200)
                    .background(Color.gray)
                    .ignoresSafeArea()
                    .blur(radius: 3.0)
                Rectangle()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [.black, .black.opacity(0)]),
                        startPoint: .bottom,
                        endPoint: .top))
                    .frame(width: 400, height: 600)

            }
            
        }else {
            ZStack{
                Image("")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 400, height: 200)
                    .background(Color.gray)
                    .ignoresSafeArea()
                    .blur(radius: /*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                    .onAppear(){
                        fetchData()
                        
                    }
                Rectangle()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [.black, .black.opacity(0)]),
                        startPoint: .bottom,
                        endPoint: .top))
                    .frame(width: 400, height: 600)
                
            }
        }
    }
    
    private func fetchData() {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            self.data = data
        }
        task.resume()
    }
}

#Preview {
    URLImageBackground(urlString: "https://m.media-amazon.com/images/I/81bsw6fnUiL._AC_UF1000,1000_QL80_.jpg")
}
