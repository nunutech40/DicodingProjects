//
//  ReqHelper.swift
//  SubmissionDicodingFundamental
//
//  Created by mac on 3/10/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class ReqHelper {
    
    struct ResponseModel {
        var success : Bool
        var resCode : Int
        var data    : Data
        var json    : JSON
    }
    
    static func request(_ sender: UIViewController, _ url: URLConvertible, method: HTTPMethod = .get ,parameters: Parameters? = nil, completion: @escaping (ResponseModel) -> Void) {
        Alamofire.request(url, method: method, parameters: parameters, headers: getHeader()).responseString { response in
            switch response.result {
            case .success:
                let res     = response.result.value!
                let json    = JSON.init(parseJSON:res)
                print("============================= REQUEST LOG ====================================")
                print("- URL :\n", url)
                print("- RAW RES :\n", res)
                print("- PRETTY JSON :\n", json)
                print("============================== END REQUEST LOG ===============================")
                completion(ResponseModel(success: true, resCode: json["code"].intValue, data: response.data!, json: json))
            case .failure(let error):
                print(error)
                completion(ResponseModel(success: false, resCode: 404, data: Data(), json: JSON()))
            }
        }
    }
    
    static func getHeader() -> HTTPHeaders {
        let headers:HTTPHeaders      = [
            "Accept"        : "application/json"
        ]
        
        print(headers)
        
        return headers
    }
}
