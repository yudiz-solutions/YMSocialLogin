//
//  ViewController.swift
//  YMSocialLogin
//
//  Created by Yudiz Solutions Pvt.Ltd. on 16/01/17.
//  Copyright © 2017 Yudiz Solutions Pvt.Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var lblFirstName:UILabel!
    @IBOutlet var lblLastName:UILabel!
    @IBOutlet var lblEmailtName:UILabel!
    @IBOutlet var lblBdayName:UILabel!
    @IBOutlet var lblGendertName:UILabel!
    @IBOutlet var imgProfile: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func loginBtnTap() {
        LoginManager().loginWithFacebook(appId:"681737115335163") { (sucess,profile,message) in
            
            if sucess {
                DispatchQueue.main.sync {
                    self.imgProfile.loadFromURL(photoUrl:(profile?.imgURL)!)
                    self.lblFirstName.text = "First Name : " + (profile?.firstName)!
                    self.lblLastName.text = "Last Name : " + (profile?.lastName)!
                    self.lblEmailtName.text = "Email : " + (profile?.email)!
                    self.lblBdayName.text = "Birth Date : " + (profile?.birthday)!
                    self.lblGendertName.text = "Genger : " + (profile?.gender)!
                }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension UIImageView {
    
    
    //load image async from inaternet
    func loadFromURL(photoUrl:String){
        //NSURL
        let url = URL(string: photoUrl)
        //Request
        let request = URLRequest(url:url!);
        //Session
        let session = URLSession.shared
        //Data task
        
        let datatask = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                DispatchQueue.main.sync {
                    self.image = UIImage(data:data!)
                }
            }
        }
        datatask.resume()
    }
    
    
}
