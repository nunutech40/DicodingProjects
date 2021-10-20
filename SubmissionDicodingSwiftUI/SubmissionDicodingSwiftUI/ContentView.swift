//
//  ContentView.swift
//  SubmissionDicodingSwiftUI
//
//  Created by mac on 28/9/21.
//

import SwiftUI

struct ContentView: View {
    var navBarAppearance = UINavigationBarAppearance()
    var body: some View {
        NavigationView {
            DashboarGameDownload()
          }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
