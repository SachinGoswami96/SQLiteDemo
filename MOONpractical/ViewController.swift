//
//  ViewController.swift
//  MOONpractical
//
//  Created by SACHIN on 06/04/1944 Saka.
//

import UIKit
import Alamofire
import Kingfisher

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {

    var db:DBHelper = DBHelper()
    
    var persons:[Person] = []
    @IBOutlet weak var img:UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    let data = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
        "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
        "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
        "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
        "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]

    var filteredData: [Person]!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        searchBar.delegate = self
        persons =  db.read()
        if persons.count == 0{
            getRequestAPICall(parameters_name: "String")
        }
            
            filteredData = persons
            
        
        
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! MainTableViewCell
//        cell.textLabel?.text = filteredData[indexPath.row].full_name
        cell.img?.kf.setImage(with: URL(string: "https://cdn.arstechnica.net/wp-content/uploads/2018/06/macOS-Mojave-Dynamic-Wallpaper-transition.jpg"))
//        downloaded(from: )
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }

    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        filteredData = searchText.isEmpty ? persons : persons.filter({(personss) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return personss.full_name?.range(of: searchText, options: .caseInsensitive) != nil
        })

        tableView.reloadData()
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
                            self.setimage(arr: arr)
                            
                            
                        }
                        catch{
                            
                        }
                        
                        
                        
                        
                    }
                }
        }
    
    func setimage(arr : Json4Swift_Base)  {
        for item in arr.data! {
            
//            AF.request(item.profile_pic_url!, method: .get, encoding: JSONEncoding.default)
//                .responseJSON { response in
//                    if response.data != nil{
//                        let image  =  UIImage.init(named: "Myimage")
//                        let imageData:NSData = (image! ?? UIImage()).pngData()! as NSData
//                        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
                    
            self.db.insert(profile_pic_url: item.profile_pic_url ?? "", id: item.id ?? 0, full_name: item.full_name ?? "", email: item.email ?? "", profile_pic: item.profile_pic ?? "" ?? "", phone: item.phone ?? "", address: item.address ?? "", dob: item.dob ?? "", gender: item.gender ?? "", designation: item.designation ?? "", salary: item.salary ?? 0, created_at: item.created_at ?? "", updated_at: item.updated_at ?? "")
//                        }
//                    }
                
                    
                    
                }
            
            
        self.persons = self.db.read()
        print(self.persons)
        filteredData =  self.persons
        tableView.reloadData()
        
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

