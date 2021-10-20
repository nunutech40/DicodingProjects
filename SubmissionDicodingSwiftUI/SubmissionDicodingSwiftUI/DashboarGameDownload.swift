//
//  DashboarGameDownload.swift
//  SubmissionDicodingSwiftUI
//
//  Created by mac on 29/9/21.
//

import SwiftUI

struct DashboarGameDownload: View {
    @State private var searchTf: String = "Hemm"
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                TextField("Email", text: self.$searchTf)
                                .textFieldStyle(MyTextFieldStyle()).border(Color.blue)
                GreetingView()
                    .frame(height: 90)
                    .background(Color.blue)
                    .cornerRadius(16)
                Spacer(minLength: 12)
                Text("Best Game")
                    .font(.system(size: 24, weight: .medium))
                    .frame(height: 36)
                HStack(spacing: 16) {
                    CardBestGame()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    CardBestGame()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                }
                .padding(.all, 5)
                Spacer(minLength: 12)
                Text("Recommended Game")
                    .font(.system(size: 24, weight: .medium))
                    .frame(height: 36)
            }
        }
        .padding(.horizontal, 16)
    }
}

struct MyTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
        .padding(30)
        .background(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(Color.black, lineWidth: 1)
        ).padding()
    }
}

struct GreetingView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Good Morning")
                .frame(height: 21)
                .font(.system(size: 14, weight: .medium))
                .padding(.horizontal, 12)
                .foregroundColor(.white)
            Text("Game apa yang kamu cari hari ini?")
                .font(.system(size: 18, weight: .medium))
                .padding(.horizontal, 12)
                .padding(.trailing, 100)
                .foregroundColor(.white)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}

struct MainViewBestGame: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            TemplateImageLarge()
                .background(Color.gray)
                .frame(width: 150, height: 95)
                .cornerRadius(8)
            Text("Top Eleven")
                .frame(height: 24)
                .font(.system(size: 16, weight: .medium))
            Text("Sports")
                .frame(height: 18)
                .font(.system(size: 12))
            HStack(spacing: 4) {
                Image("Star5")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                Text("4.5")
                    .frame(height: 18)
                    .font(.system(size: 12, weight: .medium))
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
    }
}

struct CardBestGame: View {
    var body: some View {
      MainViewBestGame()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color.black, radius: 2, x: 0, y: 0)
    }
}

struct RecommendedGameRow: View {
    var body: some View {
        HStack(spacing: 8) {
            TemplateImageLarge()
                .background(Color.gray)
                .frame(width: 68, height: 68)
                .cornerRadius(8)
            VStack(alignment: .leading) {
                Text("Top Eleven")
                    .frame(height: 24)
                    .font(.system(size: 16, weight: .medium))
                Text("Sports")
                    .frame(height: 18)
                    .font(.system(size: 12))
                HStack(spacing: 4) {
                    Image("Star5")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                    Text("4.5")
                        .frame(height: 18)
                        .font(.system(size: 12, weight: .medium))
                }
            }
        }
    }
}

struct DashboarGameDownload_Previews: PreviewProvider {
    static var previews: some View {
        DashboarGameDownload()
        RecommendedGameRow()
    }
}
