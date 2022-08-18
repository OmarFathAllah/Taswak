//
//  UserDefaults+Extensions.swift
//  Taswak
//
//  Created by omar  on 20/07/2022.
//

import Foundation
extension UserDefaults{
    
    enum userDefaultKeys:String {
        case isSignedIn
        case signedInUserData
        case isOnBoarded
    }
    var isOnBoarded:Bool{
        get{
            bool(forKey: userDefaultKeys.isOnBoarded.rawValue)
        }
        set{
            setValue(newValue, forKey: userDefaultKeys.isOnBoarded.rawValue)
        }
    }
    var IsSignedIn:Bool{
        get{
            bool(forKey: userDefaultKeys.isSignedIn.rawValue)
        }
        set{
            setValue(newValue, forKey: userDefaultKeys.isSignedIn.rawValue)
        }
    }
    var signedInUserData:LoginData?{
        get{
            if let data = object(forKey: userDefaultKeys.signedInUserData.rawValue) as? Data{
                let loginData = try? JSONDecoder().decode(LoginData.self, from: data)
                return loginData
            }
            return nil
        }
        set{
            if newValue == nil{
                removeObject(forKey: userDefaultKeys.signedInUserData.rawValue)
            }else{
                if let data = try? JSONEncoder().encode(newValue){
                    setValue(data, forKey: userDefaultKeys.signedInUserData.rawValue)
                }
            }
        }
    }
}
