//
//  CommentView.swift
//  Foodies
//
//  Created by App Designer2 on 15.06.20.
//  Copyright © 2020 App Designer2. All rights reserved.
//

import SwiftUI

/*
func add(title : String,msg: String,date: Date){

let format = DateFormatter()
       format.dateFormat = "dd/MM/YY"
       let day = format.string(from: date)
       format.dateFormat = "hh:mm a"
       let time = format.string(from: date)
       
       let app = UIApplication.shared.delegate as! AppDelegate
       let context = app.persistentContainer.viewContext
       let entity = NSEntityDescription.insertNewObject(forEntityName: "Todo", into: context)
       entity.setValue(msg, forKey: "msg")
       entity.setValue(title, forKey: "title")
       entity.setValue("\(date.timeIntervalSince1970)", forKey: "id")
       entity.setValue(time, forKey: "time")
       entity.setValue(day, forKey: "day")
*/

struct CommentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Comment.entity(), sortDescriptors: [])
    var coment : FetchedResults<Comment>
    
    
    @ObservedObject var food = Food()
    @State var comments = ""
    
    //Start date
    static var dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        
        return formatter
    }()
    var date = Date()
    //End date
    
    @State  var value : CGFloat = 0
    
    //Start hour
    static var formats : DateFormatter = {
        let format = DateFormatter()
        
        format.dateFormat = "hh:mm a"
        
        return format
    }()
     
    var hour = Date()
    //End hour
    var body: some View {
        NavigationView {
        VStack {
            ZStack {
                if self.coment.isEmpty {
                    VStack {
                        Indicator()
                        
                    Text("No comment yet!!")
                        .fontWeight(.heavy)
                        .foregroundColor(.gray)
                    }
                } else {
            Form {
                
                ForEach(coment, id: \.self) { write in
                    HStack {
                        Text("\(write.comment!)")
                            .padding()
                            .foregroundColor(Color.white)
                        
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("\(write.date ?? self.date, formatter: Self.dateFormatter)")
                        
                        
                            Text("\(write.date ?? self.date, formatter: Self.formats)")
                            
                        }.padding()
                        .font(.caption)
                        .foregroundColor(.secondary)
                        
                    }.background(Color.blue.opacity(0.80))
                        .clipShape(ChatBubble(commenta: true))
                        .shadow(radius: 6)
                    /*.onAppear {
                     write.date = self.date
                     try! self.moc.save()
                     }*/
                }.onDelete(perform: delete)
                
            
            }
                }
        }.navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(trailing: HStack {
                    Text("commentaries:").font(.callout)
                        .foregroundColor(.secondary)
                    
                    Text("\(self.coment.count)").font(.system(size: 12))
                    .foregroundColor(.primary)
                })
            Spacer()
            
            //Start add btn
            HStack {
                TextField("Comment...", text: self.$comments)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 10)
                    
                
                Button(action: {
                    let add = Comment(context: self.moc)
                    add.comment = self.comments
                    add.date = self.date
                    
                    
                    //self.food.msg = add.commentName
                    //add.food = Food(context: self.moc)
                    add.committedValues(forKeys: [self.comments])
                    
                    try! self.moc.save()
                    
                    self.comments = ""
                }) {
                    Image(systemName: self.comments.count > 1 ? "paperplane.fill": "paperplane")
                        .font(.system(size: 25))
                        .foregroundColor(self.comments.count > 1 ? .blue : .gray)
                    
                    
                }.disabled(self.comments.count > 1 ? false : true)
                    .rotationEffect(Angle.init(degrees: 50))
                
            }.padding()
                //End add btn
        
        }/*VStack*/
        .offset(y: -self.value)
        .animation(.spring())
        .onAppear {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti) in
                let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                let height = value.height
                
                self.value = height
                
            }
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti) in
                
                self.value = 0
            }
        }
            
        }
    }
    func delete(at offsets: IndexSet) {
        for index in offsets {
            let delet = coment[index]
            self.moc.delete(delet)
        }
        try! self.moc.save()
    }
}


struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView()
    }
}
struct ChatBubble : Shape {
    
    var commenta : Bool
    
    func path(in rect: CGRect) -> Path {
            
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topRight,.topLeft,commenta ? .bottomRight : .bottomLeft], cornerRadii: CGSize(width: 16, height: 35))
        
        return Path(path.cgPath)
    }
}

struct Indicator: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        
        return indicator
    }
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        //
    }
}
// I just wanted to show this project that im still creating, but you could have access to it, by joing it on my Patreon account, im keeping post some advanced project right there.

//Thanks very much for your support and thanks for your help.

//If you would to joing it, i will leave my Patreon Link on the description from this video

//Stay safe please on this hard time!!!!
