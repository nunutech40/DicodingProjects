//
//  DetailGame.swift
//  SubmissionDicodingSwiftUI
//
//  Created by mac on 28/9/21.
//

import SwiftUI

struct DetailGame: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                TemplateImageLarge()
                    .background(Color.gray)
                    .frame(height: 337)
                    .padding(.top, 16)
                Spacer(minLength: 22)
                Text("Judul Game")
                    .font(.system(size: 25, weight: .medium))
                    .frame(height: 36)
                Text("Genre")
                    .font(.system(size: 12, weight: .light))
                Spacer(minLength: 8)
                Text("About Game")
                    .font(.system(size: 14, weight: .medium))
                    .frame(height: 21)
                Text("Lorem Ipsum is simply dummy text of the printing and type setting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.")
                    .font(.system(size: 12, weight: .light))
                
            }
            .padding(.horizontal, 16)
        }
    }
}

struct TemplateImageLarge: View {
    var body: some View {
        Image("imageGame1")
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}

struct DetailGame_Previews: PreviewProvider {
    static var previews: some View {
        DetailGame()
    }
}
