//
//  ContentView.swift
//  Fashion
//
//  Created by App Designer2 on 09.06.20.
//  Copyright © 2020 App Designer2. All rights reserved.
//

import SwiftUI

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
         NSSortDescriptor(keyPath: \Food.date, ascending: true),
        NSSortDescriptor(keyPath: \Food.oldPrice, ascending: true)
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
    
    var columns : [GridItem] = Array(repeating: .init(.fixed(180)), count: 2)
    
    @State var collection = false
     var body: some View {
         
         
          NavigationView {
             ScrollView(.vertical, showsIndicators: false) {
                 if self.mode {
                    withAnimation(Animation.easeInOut.delay(0.2)) {
                 SearchsBar(text: self.$search)
                     .cornerRadius(18)
                     }.animation(Animation.linear(duration: 0.2))
                 } else {}
                
                
                LazyVGrid(columns: columns, spacing: 9) {
                 ForEach(foods.filter({self.search.isEmpty ? true : $0.items!.localizedCaseInsensitiveContains(self.search)}), id: \.items) { info in
                     VStack {
                         //VStack(alignment: .leading, spacing: 9) {
                         
                             NavigationLink(destination: DetailView(detail: info, image: self.image, order: false, comment: false)) {
                                 
                            //NavigationLink(destination: DetailView(detail: info, image: self.image)) {
                                
                                Image(uiImage: UIImage(data: info.imageD ?? self.image)!)
                                .renderingMode(.original)
                            .resizable()
                                    
                                    //.scaledToFit()
                               .frame(width: 180, height: 160)
                                .cornerRadius(6)
                                
                            //}//NavigationLink
                                 
                             //}//NavigationLink
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
                             /*VStack(alignment: .leading, spacing: 9) {
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
                                    Text("€\(info.oldPrice)").strikethrough()
                                     .foregroundColor(.gray)
                                    Text("€\(info.prices)").underline(true, color: .red)
                                     .foregroundColor(.red)
                                     
                                     Spacer()
                                     
                                     //Text("\(info.msg!)")
                                     
                                         Image(systemName: "bubble.right.fill")
                                             .foregroundColor(.gray)
                                     
                                 }
                                 
                             }*/
                         }//NvtLink
                        // Spacer()
                         
                     //}Main VStack
                         
                         
                     }
                 
                     }.onDelete(perform: delete)
                     //.padding()//ForEach
             }//LazyVGrid
                
             }
             .navigationBarTitle(Text("Foodies"))
                .navigationBarItems(leading: Button(action: {
                    self.show.toggle()
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("items")
                    }
                    
                }, trailing: HStack { Button(action: {
                    self.mode.toggle()
                }) {
                    Image(systemName: "magnifyingglass")
                }
                Button(action: {
                    self.collection.toggle()
                }) {
                    Image(systemName: self.collection ? "square.grid.2x2": "list.dash")
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
/*
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
             Image(systemName: "persong.circle.fill")
             .resizable()
                 .frame(width: 20, height: 20)
         }
     })
 */



/*
 
 if self.collection {
 LazyVGrid(columns: columns, spacing: 9) {
  ForEach(foods.filter({self.search.isEmpty ? true : $0.items!.localizedCaseInsensitiveContains(self.search)}), id: \.items) { info in
      VStack {
          //VStack(alignment: .leading, spacing: 9) {
          
              NavigationLink(destination: DetailView(detail: info, image: self.image, order: false, comment: false)) {
                  
             //NavigationLink(destination: DetailView(detail: info, image: self.image)) {
                 
                 Image(uiImage: UIImage(data: info.imageD ?? self.image)!)
                 .renderingMode(.original)
             .resizable()
                     
                     //.scaledToFit()
                .frame(width: 180, height: 160)
                 .cornerRadius(6)
                 
             //}//NavigationLink
                  
              //}//NavigationLink
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
              /*VStack(alignment: .leading, spacing: 9) {
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
                     Text("€\(info.oldPrice)").strikethrough()
                      .foregroundColor(.gray)
                     Text("€\(info.prices)").underline(true, color: .red)
                      .foregroundColor(.red)
                      
                      Spacer()
                      
                      //Text("\(info.msg!)")
                      
                          Image(systemName: "bubble.right.fill")
                              .foregroundColor(.gray)
                      
                  }
                  
              }*/
          }//NvtLink
         // Spacer()
          
      //}Main VStack
          
          
      }
  
      }.onDelete(perform: delete)
      //.padding()//ForEach
}//LazyVGrid
 } else {
     //Start
      ForEach(foods.filter({self.search.isEmpty ? true : $0.items!.localizedCaseInsensitiveContains(self.search)}), id: \.items) { infos in
          VStack {
              VStack(alignment: .leading, spacing: 9) {
              
                  NavigationLink(destination: DetailView(detail: infos, image: self.image, order: false, comment: false)) {
                      
                 //NavigationLink(destination: DetailView(detail: info, image: self.image)) {
                     
                     Image(uiImage: UIImage(data: infos.imageD ?? self.image)!)
                     .renderingMode(.original)
                 .resizable()
                         
                         //.scaledToFit()
                    .frame(width: 180, height: 160)
                     .cornerRadius(6)
                     
                 //}//NavigationLink
                      
                  //}//NavigationLink
                  .contextMenu {
                      Button(action: {
                          UIImageWriteToSavedPhotosAlbum(UIImage(data: infos.imageD ?? self.image)!, 1, nil, nil)
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
                      Text("\(infos.items!)")
                  .bold()
                          .font(.headline)
                      Text("\(infos.detail!)")
                          .lineLimit(2)
                      
                      HStack {
                          ForEach(0..<5) { star in
                              HStack {
                                  Image(systemName: infos.rating >= star ? "star.fill": "star")
                                  .foregroundColor(infos.rating >= star ? .yellow : .gray)
                                  
                              }
                          }
                      }
                      
                      
                      Text("\(infos.date ?? self.date, formatter: Self.dateFormatter)")
                      .font(.caption)
                      .foregroundColor(.secondary)
                          
                      
                      HStack {
                         Text("€\(infos.oldPrice)").strikethrough()
                          .foregroundColor(.gray)
                         Text("€\(infos.prices)").underline(true, color: .red)
                          .foregroundColor(.red)
                          
                          Spacer()
                          
                          //Text("\(infos.msg!)")
                          
                              Image(systemName: "bubble.right.fill")
                                  .foregroundColor(.gray)
                          
                      }
                      
                  }
              }//NvtLink
             // Spacer()
              
          }//Main VStack
              
              
          }
      
          }.onDelete(perform: delete)
          .padding()//ForEach
  
     //End
 
 }
 
 */

