//
//  ViewController.swift
//  MOONpractical
//
//  Created by SACHIN on 06/04/1944 Saka.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    var db:DBHelper = DBHelper()
    
    var persons:[Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getRequestAPICall(parameters_name: "String")
//        setIMAGEUPLOAD()
    }

    func getRequestAPICall(parameters_name: String)  {

            let todosEndpoint: String = "your_server_url" + "parameterName=\(parameters_name)"

            AF.request("https://beta2.moontechnolabs.com/practical_api/public/api/user", method: .get, encoding: JSONEncoding.default)
                .responseJSON { response in
                    debugPrint(response)

                    if let data = response.data{
                        // Response type-1
                        do{
                        let json = JSONDecoder()
                        let arr = try
                        json.decode(Json4Swift_Base.self, from: data)
                        print(arr)
                            
                            for item in arr.data! {
                                self.db.insert(profile_pic_url: item.profile_pic_url ?? "", id: item.id ?? 0, full_name: item.full_name ?? "", email: item.email ?? "", profile_pic: item.profile_pic ?? "", phone: item.phone ?? "", address: item.address ?? "", dob: item.dob ?? "", gender: item.gender ?? "", designation: item.designation ?? "", salary: item.salary ?? 0, created_at: item.created_at ?? "", updated_at: item.updated_at ?? "")
                            }
                        
                            self.persons = self.db.read()
                            print(self.persons)
                            
                        }
                        catch{
                            
                        }
                        
                        
                    }
                }
        }

    func setIMAGEUPLOAD()  {
        let image = UIImage.init(named: "Myimage")
        let imgData = image!.jpegData(compressionQuality: 0.2)!

         let parameters = ["full_name" : "abcd",
                           "email" : "abcd",

                           "phone" : "abcd",

                           "address" : "abcd",

                           "dob" : "abcd",

                           "gender" : "abcd",

                           "designation" : "abcd",

                           "salary" : "123344"] //Optional for extra parameter


            
        
        
        AF.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(imgData, withName: "profile_pic",fileName: "file.jpg", mimeType: "image/jpg")
                for (key, value) in parameters {
                        multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                    } //Optional for extra parameters
            },
                  to:"https://beta2.moontechnolabs.com/practical_api/public/api/user").response{
            (respnse) in
            if respnse != nil{
                print(respnse.result)
                do{
                let json = JSONDecoder()
                let arr = try
                    json.decode(Json4Swift_Base.self, from: respnse.data!)
                print(arr)
                }
                catch{
                    
                }
                
            }
        }
    }
    
    func setLocalData()  {
        
        
    }
}

