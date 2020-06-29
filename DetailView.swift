//
//  DetailView.swift
//  Fashion
//
//  Created by App Designer2 on 09.06.20.
//  Copyright © 2020 App Designer2. All rights reserved.
//


import SwiftUI

struct DetailView: View {
    //var detail : Info
    @Environment(\.managedObjectContext) var moc
    
    //By only use @ObservedObject = entityName() we are allow to use all its data to display on the DetailView
    @ObservedObject var detail = Food()
    
    
    @State var image : Data = .init(count: 0)
    
    @State var order = false
    @State var comment = false
    
    static var dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        return formatter
    }()
    
    var date = Date()
    
     var offer : Int64 = 0
    
    
    //var url  = "https://app-designer2.io"
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack {
                Image(uiImage: UIImage(data: detail.imageD ?? self.image)!)
            .resizable()
                .frame(height: 300)
                
                if self.detail.oldPrice == self.offer {
                            
                   Text("Offer only for today")
                    .italic()
                    .padding()
                    .font(.system(size: 35))
                    .foregroundColor(Color.white.opacity(0.48))
                    .background(Color.black.opacity(0.48))
                    .cornerRadius(8)
                    .rotationEffect(Angle.degrees(-40))
                            
                } else {}
                        
                
                }
            
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .top) {
                    ForEach(0..<5) { star in
                        HStack {
                          Button(action: {
                            self.detail.rating = Int64(star)
                            
                            try! self.moc.save()
                          }) { Image(systemName: self.detail.rating >= star ? "star.fill": "star")
                            .foregroundColor(self.detail.rating >= star ? .yellow : .gray)
                          }
                        }
                    }
                    Text("\(detail.date ?? self.date, formatter: Self.dateFormatter)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    //
                    Text("\("")")
                    
                    Button(action: {
                        self.comment.toggle()
                    }) {
                        Image(systemName: "bubble.right.fill")
                        .foregroundColor(.gray)
                    
                    }
                        
                    /*Text("\(detail.items ?? "")")
                        .font(.headline)
                        //.foregroundColor(.white)*/
                    
            }//.padding()
                Text("\(detail.items!)")
                .font(.headline)
                
                Text("\(detail.detail!)")
                
                HStack {
                    Text("€\(detail.oldPrice)").strikethrough()
                        .foregroundColor(.gray)
                
                    Text("€\(detail.prices)")
                        .bold()
                        .underline(true, color: .red)
                        .foregroundColor(.red)
                }
                Spacer()
                VStack(spacing: 15) {
                Button(action: {
                    //self.detail.rating += 1
                    self.order.toggle()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        self.order = false
                        //After 4 second the alert pop will deseappear
                    }
                    
                }) {
                    HStack {
                        Image(systemName: "doc.text.fill")
                        
                        Text("order now")
                        
                        Text("€\(detail.prices)")
                        .bold()
                        
                    }.foregroundColor(.white)
                    .padding()
                        
                }.fixedSize()
                    .padding()
                .frame(width: UIScreen.main.bounds.width - 34, height: 55)
                    .background(Color.blue)
                .cornerRadius(8)
                Spacer()
                    //CircleShart()
                        
                    //This implementation will send us to Safari Browser to navigate on the website that we have added
                    Link("Visit our website", destination: URL(string: "\(self.detail.url ?? "")")!)
                        
                        
                    
            
                }
                }.padding()
            .alert(isPresented: self.$order) {
                Alert(title: Text("Thanks for your order"), message: Text("We've already received your order \(detail.items!.uppercased())!!"), dismissButton: .default(Text("😊")))
            }
            
        }.edgesIgnoringSafeArea(.top)//ScrollView
            .sheet(isPresented: self.$comment) {
                CommentView().environment(\.managedObjectContext, self.moc)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
