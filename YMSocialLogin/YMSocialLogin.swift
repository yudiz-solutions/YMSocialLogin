//
//  YMSocialLogin.swift
//  YMSocialLogin
//
//  Created by Yudiz Solutions Pvt.Ltd. on 16/01/17.
//  Copyright © 2017 Yudiz Solutions Pvt.Ltd. All rights reserved.
//

import Social
import Accounts

class FacebookProfile:NSObject {
    var email = ""
    var firstName = ""
    var lastName = ""
    var birthday = ""
    var gender = ""
    var imgURL = ""
    var fbID = ""
    init(dictData:[String:Any]) {
        super.init()
        for key in dictData.keys {
            switch key {
            case "id":
                self.fbID = dictData[key] as! String
            case "email":
                self.email = dictData[key] as! String
            case "first_name":
                self.firstName = dictData[key] as! String
            case "last_name":
                self.lastName = dictData[key] as! String
            case "birthday":
                self.birthday = dictData[key] as! String
            case "gender":
                self.gender = dictData[key] as! String
            default :
                break
            }
        }
        self.imgURL = "https://graph.facebook.com/\(fbID)/picture?width=400&height=400"
    }
    override init() {
        super.init()
    }
    override var description: String {
        var desc = ""
        for propety in Mirror(reflecting: self).children {
            desc = desc + propety.label! + ":" + String(describing: propety.value) + ","
        }
        if desc.characters.count > 0 {
            desc.characters.removeLast()
        }
        return desc
    }
    
}

class LoginManager: NSObject {
    
    var facebookAppId     = ""
    var facebookAccount: ACAccount?
    var successMessage = "Received facebook profile"
    var errorMsg = "Please go to settings and add at least one faceook account."
    func getDataFromFB(completion: @escaping (_ credential: ACAccountCredential?,_ error:Error?) -> Void) {
        let store = ACAccountStore()
        let facebook = store.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierFacebook)
        let apiKey = facebookAppId
        let loginParameters: [String: Any] = [ACFacebookAppIdKey: apiKey, ACFacebookPermissionsKey: ["email"]]
        store.requestAccessToAccounts(with: facebook, options: loginParameters) { granted, error in
            if granted {
                let accounts = store.accounts(with: facebook)
                self.facebookAccount = accounts?.last as? ACAccount
                let credentials = self.facebookAccount?.credential
                completion(credentials,nil)
            } else {
                completion(nil,error)
            }
        }
    }
    
    func loginWithFacebook(appId:String,completeHandler:@escaping (_ success:Bool,_ response:FacebookProfile?,_ message:String) -> Void) {
        if SLComposeViewController.isAvailable(forServiceType:SLServiceTypeFacebook) {
            facebookAppId = appId
            self.getDataFromFB { (account,error) in
                if error == nil {
                    let fbFields  = "email,first_name,last_name,birthday,gender"
                    let request :SLRequest = SLRequest(forServiceType: SLServiceTypeFacebook, requestMethod: SLRequestMethod.GET, url:URL(string: "https://graph.facebook.com/me"), parameters: ["fields":fbFields])
                    request.account = self.facebookAccount
                    request.perform(handler: { (data, response, error) -> Void in
                        if error == nil {
                            do {
                                let dictData = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject]
                                completeHandler(true,FacebookProfile(dictData:dictData!),self.successMessage)
                            } catch let error as NSError {
                                completeHandler(false,FacebookProfile(),error.localizedDescription)
                            }
                        } else {
                            completeHandler(false,FacebookProfile(),(error?.localizedDescription)!)
                        }
                    })
                } else {
                    completeHandler(false,FacebookProfile(),(error?.localizedDescription)!)
                }
            }
        } else {
            completeHandler(false,FacebookProfile(),errorMsg)
        }
    }
}
