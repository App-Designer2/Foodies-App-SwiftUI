//
//  ContentView.swift
//  Fashion
//
//  Created by App Designer2 on 09.06.20.
//  Copyright © 2020 App Designer2. All rights reserved.
//

import SwiftUI

struct Info : Identifiable {
    let id : Int
    let name,detail,prices,image,before,offer : String
    /*let detail : String
    let prices : String
    let image : String*/
    //let color : Color
}

//Start

struct ContentView: View {
   @State var search = ""
    
    @State var mode : Bool = false
    
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Food.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Food.items, ascending: true),
        NSSortDescriptor(keyPath: \Food.imageD, ascending: true),
        NSSortDescriptor(keyPath: \Food.detail, ascending: true),
        NSSortDescriptor(keyPath: \Food.rating, ascending: false),
        NSSortDescriptor(keyPath: \Food.prices, ascending: true),
        NSSortDescriptor(keyPath: \Food.date, ascending: true)
    ]) var foods : FetchedResults<Food>
    
    @State var image : Data = .init(count: 0)
    
    @State var show = false
    
    @State private var keyboard : CGFloat = 0.0
    
    static var dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        
        return formatter
    }()
    
    var date = Date()
    var body: some View {
        
        
         NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                if self.mode {
                    withAnimation(Animation.easeInOut.delay(0.2)) {
                SearchsBar(text: self.$search)
                    .cornerRadius(18)
                    }.animation(Animation.linear(duration: 0.2))
                } else {}
                
                ForEach(foods.filter({self.search.isEmpty ? true : $0.items!.localizedCaseInsensitiveContains(self.search)}), id: \.items) { info in
                    VStack {
                        HStack(alignment: .top) {
                        
                            NavigationLink(destination: DetailView(detail: info, image: self.image, order: false, comment: false)) {
                                
                                Image(uiImage: UIImage(data: info.imageD ?? self.image)!)
                                .renderingMode(.original)
                            .resizable()
                                .frame(width: 150, height: 160)
                                .cornerRadius(6)
                                
                            }//NavigationLink
                            .contextMenu {
                                Button(action: {
                                    UIImageWriteToSavedPhotosAlbum(UIImage(data: info.imageD ?? self.image)!, 1, nil, nil)
                                }) {
                                    HStack {
                                        Text("Save Photo")
                                    Image(systemName: "square.and.arrow.down")
                                    }
                                }
                                
                                //Start delete
                                
                                //end delete
                            }
                            VStack(alignment: .leading, spacing: 9) {
                                Text("\(info.items!)")
                            .bold()
                                    .font(.headline)
                                Text("\(info.detail!)")
                                    .lineLimit(2)
                                
                                HStack {
                                    ForEach(0..<5) { star in
                                        HStack {
                                            Image(systemName: info.rating >= star ? "star.fill": "star")
                                            .foregroundColor(info.rating >= star ? .yellow : .gray)
                                            
                                        }
                                    }
                                }
                                
                                
                                Text("\(info.date ?? self.date, formatter: Self.dateFormatter)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                    
                                
                                HStack {
                                Text("\(info.before!)").strikethrough()
                                    .foregroundColor(.gray)
                                    Text("\(info.prices!)").underline(true, color: .red)
                                    .foregroundColor(.red)
                                    
                                    Spacer()
                                    
                                    //Text("\(info.msg!)")
                                    
                                        Image(systemName: "bubble.right.fill")
                                            .foregroundColor(.gray)
                                    
                                }
                                
                            }
                        Spacer()
                        
                    }
                        
                        
                    }
                
                    }.onDelete(perform: delete)
                    .padding()//ForEach
                
            } 
            .navigationBarTitle(Text("Foodies"))
                .navigationBarItems(leading: Button(action: {
                    self.show.toggle()
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("items")
                    }
                    },trailing: HStack {
                        Button(action: {
                    self.mode.toggle()
                }) {
                    Image(systemName: "magnifyingglass")
            }
                        if self.image.count != 0 {
                        Button(action: {}) {
                            Image(uiImage: UIImage(data: self.image)!)
                                .renderingMode(.original)
                            .resizable()
                            .clipShape(Circle())
                                .frame(width: 20, height: 20)
                        }
                        } else {
                            Image(systemName: "person.circle.fill")
                            .resizable()
                                .frame(width: 20, height: 20)
                        }
                }).foregroundColor(Color("color"))
            
         }.sheet(isPresented: self.$show) {
            AddItems().environment(\.managedObjectContext, self.moc)
         }
    }
    func delete(at offsets: IndexSet) {
        for index in offsets {
            let remove = foods[index]
            self.moc.delete(remove)
        }
        try! self.moc.save()
    }
}

// End ContentView
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

