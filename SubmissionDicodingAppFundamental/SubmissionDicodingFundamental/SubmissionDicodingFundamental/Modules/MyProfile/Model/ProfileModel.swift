//
//  ProfileModel.swift
//  SubmissionDicodingFundamental
//
//  Created by mac on 10/10/21.
//

import UIKit

struct ProfileModel {
    
    static let nameKey          = "name"
    static let professionKey    = "profession"
    static let aboutMeKey       = "aboutMe"
    
    static var name: String {
        get {
            return UserDefaults.standard.string(forKey: nameKey) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: nameKey)
        }
    }
    
    static var profession: String {
        get {
            return UserDefaults.standard.string(forKey: professionKey) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: professionKey)
        }
    }
    
    static var aboutMe: String {
        get {
            return UserDefaults.standard.string(forKey: aboutMeKey) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: aboutMeKey)
        }
    }
    
    static func syncronize() {
        UserDefaults.standard.synchronize()
    }
}

