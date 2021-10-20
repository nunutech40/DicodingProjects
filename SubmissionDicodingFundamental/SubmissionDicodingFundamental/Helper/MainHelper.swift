//
//  MainHelper.swift
//  SubmissionDicodingFundamental
//
//  Created by mac on 2/10/21.
//

import UIKit
import AlamofireImage

class MainHelper {
    
    static func getDecoder() -> JSONDecoder {
        let decoder                 = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    static func setImage(_ imageView: UIImageView, _ url:String, _ defaultImage: UIImage){
        if let imageUrl = URL(string: url){
            imageView.af_setImage(withURL: imageUrl, placeholderImage: defaultImage)
        } else {
            imageView.image = defaultImage
        }
    }
}
