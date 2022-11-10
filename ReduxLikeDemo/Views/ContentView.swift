//
//  ContentView.swift
//  ReduxLikeDemo
//
//  Created by M W on 09/11/2022.
//

import SwiftUI

struct ContentView: View {
    
    let recipe: Recipe
    @EnvironmentObject var store: AppStore
    @State private var searchQuery: String = ""
    
    
    var body: some View {
        VStack {
            SearchView(query: $searchQuery, results: store.state.searchResult) {
                fetchResults()
            }
            
            
        }
        .padding()
 
    }
    
    private func fetchResults() {
        //store.send
    }
}


struct SearchView: View {
    @Binding var query: String
    let results: [Recipe]
    let onCommit: () -> Void
    
    var body: some View {
        NavigationView {
            List {
                TextField("Type something", text: $query, onCommit: onCommit)

                if results.isEmpty {
                    Text("Loading...")
                } else {
                    ForEach(results) { recipe in
                         // subview to display results
                    }
                }
            }.navigationBarTitle(Text("Search"))
        }
    }
}



/*struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
*/
