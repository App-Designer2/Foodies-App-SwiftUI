//
//  SearchBar.swift
//  LivingsRoom
//
//  Created by App-Designer2 . on 27.08.19.
//  Copyright © 2019 App-Designer2 . All rights reserved.
//

import Foundation
import SwiftUI
import UIKit


struct SearchsBar: UIViewRepresentable {
    
    @Binding var text: String
    
    
    class Coordinator: NSObject,UISearchBarDelegate {
        
        let searchBar = UISearchBar(frame: .zero)
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
            
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }
    func makeCoordinator() -> SearchsBar.Coordinator {
        return Coordinator(text: $text)
    }
    //I just want to compare and see why it doesnt works
    func makeUIView(context: UIViewRepresentableContext<SearchsBar>) -> UISearchBar {
        let searchsBar = UISearchBar(frame: .zero)
        searchsBar.delegate = context.coordinator
        searchsBar.isSearchResultsButtonSelected = true
        searchsBar.placeholder = "Search to eat..."
        searchsBar.barStyle = .default
        searchsBar.enablesReturnKeyAutomatically = true
        
        
        return searchsBar
        
    }
     func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchsBar>) {
        uiView.text = text
        uiView.endEditing(true)
    }
    
    }
    //Start
    

    //End

// I uploaded a tutorial about how to implement UISearchBar in our SwiftUI apps, you can also take a look
