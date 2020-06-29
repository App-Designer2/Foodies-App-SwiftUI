//
//  AddItems.swift
//  Foodies
//
//  Created by App Designer2 on 14.06.20.
//  Copyright © 2020 App Designer2. All rights reserved.
//

import SwiftUI
/*
 @NSManaged public var items: String?
 @NSManaged public var detail: String?
 @NSManaged public var rating: Int64
 @NSManaged public var imageD: Data?
 @NSManaged public var date: Date?
 @NSManaged public var prices: String?
 @NSManaged public var before: String?
 */



struct AddItems: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var dismiss
    
    @State var show = false
    @State var image : Data = .init(count: 0)
    @State private var sourceType : UIImagePickerController.SourceType = .camera
    @State var items = ""
    @State var detail = ""
    @State var url = ""
    @State var prices  = 0
    @State var oldPrice = 0
    
    @State var offer = 0
    
    @State var photo = false
    
    //Start date
    static var dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        
        return formatter
    }()
    
    var date = Date()
    //End date
    
    var body: some View {
        NavigationView {
            Form {
            VStack(spacing: 10) {
                Section(header: Text("")) {
                if self.image.count != 0 {
                    //Button(action: {
                        //self.photo.toggle()
                    //}) {
                Image(uiImage: UIImage(data: self.image)!)
                    .renderingMode(.original)
                .resizable()
                    .frame(width: 50, height: 50)
                .cornerRadius(6)
                    //}
                } else {
                    //Button(action: {
                        //self.photo.toggle()
                    //}) {
                    Image(systemName: "photo.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                        .foregroundColor(.gray)
                    .cornerRadius(6)
                    //}
                }
                }
                VStack(alignment: .leading) {
                    
                    Group {
                        
                    Text("Items Names").bold()
                        
                        TextField("Items names...", text: self.$items)
                    //Rectangle().fill(Color.gray)
                        //.frame(width: UIScreen.main.bounds.width - 32, height: 1)
                
                    }
                    
                Group {
                    
                    Text("Today Menu").bold()
                    
                    TextField("Menu of the day...", text: self.$detail)
                    //Rectangle().fill(Color.gray)
                    //.frame(width: UIScreen.main.bounds.width - 32, height: 1)
                }
                 
                    Group {
                        
                        Text("Restaurant website").bold()
                        
                        TextField("https://example.com", text: self.$url)
                        //URL Link is required
                    }
                    
                }
            }
                VStack(spacing: 12) {
                        Section {
                    Picker("Offer Price", selection: $prices) {
                        ForEach(1 ..< 100) { _ in
                            Text("€\(self.prices)")
                                .tag(0)
                        }
                    }
                        }
                    
                    }
                
                VStack(spacing: 12) {
                        Section {
                    Picker("Old Price", selection: $oldPrice) {
                        ForEach(0 ..< 100) { _ in
                            Text("€\(self.oldPrice)")
                                .tag(0)
                        }
                    }
                        }
                    
                    }
                //.padding()
                
                    
                
                Button(action: {
                    let add = Food(context: self.moc)
                    add.imageD = self.image
                    add.items = self.items
                    add.detail = self.detail
                    add.prices = Int64(self.prices)
                    add.oldPrice = Int64(self.oldPrice)
                    add.url = self.url
                    //add.offer = Int64(self.offer)
                    add.date = self.date
                    
                    try! self.moc.save()
                    
                    self.image.count = 0
                    self.items = ""
                    self.detail = ""
                    self.prices = 0
                    self.oldPrice = 0
                    self.items = ""
                    self.url = ""
                    
                    self.dismiss.wrappedValue.dismiss()
                    
                }) {
                    Text("Add items").bold()
                    .padding()
                        .foregroundColor(self.items.count > 5 && self.image.count > 0 && self.detail.count > 5 && self.url.count > 11 && (self.prices != 0) ? Color.blue : Color.gray)
                        //.background(self.items.count > 5 && self.image.count > 0 && self.detail.count > 5 ? Color.blue : Color.gray)
                    //.cornerRadius(10)
                    
                }.disabled(self.items.count > 5 && self.image.count > 0 && self.detail.count > 5 && self.url.count > 11 &&  (self.prices != 0) ? false : true)
            //}//Main VStack
                .actionSheet(isPresented: self.$photo) {
                    ActionSheet(title: Text(""), message: Text(""), buttons: [.default(Text("Camera")) {
                        
                        self.show.toggle()
                        self.sourceType = .camera
                        
                        }, .default(Text("Photo Library")) {
                            
                            self.show.toggle()
                            self.sourceType = .photoLibrary
                        },
                    .default(Text("SavedPhotosAlbum")){
                        self.show.toggle()
                        self.sourceType = .savedPhotosAlbum
                    },
                           .cancel()])
            }
            
            }.navigationBarTitle(Text("Add items"), displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                self.photo.toggle()
            }) {
                Image(systemName: "camera")
            },trailing: Button(action: {
                self.dismiss.wrappedValue.dismiss()
                
            }) { Text("Cancel")})//ScrollView
            Spacer()
        }
        .sheet(isPresented: self.$show) {
        ImagePicker(show: self.$show, image: self.$image, sourceType: self.sourceType)
        }
        
    }
}

struct AddItems_Previews: PreviewProvider {
    static var previews: some View {
        AddItems()
            
        
    }
}
