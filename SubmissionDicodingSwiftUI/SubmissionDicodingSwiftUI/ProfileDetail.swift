//
//  ProfileDetail.swift
//  SubmissionDicodingSwiftUI
//
//  Created by mac on 28/9/21.
//

import SwiftUI

struct ProfileDetail: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                CardProfile()
                    .background(Color.blue)
                    .cornerRadius(16)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                Spacer(minLength: 44)
                Text("About Me")
                    .font(.system(size: 24))
                    .bold()
                    .frame(height: 36)
                Spacer(minLength: 8)
                Text("Lorem Ipsum is simply dummy text of the printing and type setting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap intoelectronic typesetting, remaining essentially unchanged. Lorem Ipsum is simply dummy text of the printing and type setting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.")
            }
        }
        .padding(.top, 28)
        .padding(.horizontal, 16)
    }
}

struct CardProfile: View {
    var body: some View {
        HStack(spacing: 32) {
            Image("photoProfile")
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fill)
                .frame(width: 94, height: 94)
                .clipShape(Circle())
            VStack(alignment: .leading, spacing: 16) {
                Text("Nunu Nugraha")
                    .bold()
                    .font(.system(size: 24))
                Text("Ios Developer")
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .padding(.vertical, 38)
    }
}

struct ProfileDetail_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetail()
    }
}
