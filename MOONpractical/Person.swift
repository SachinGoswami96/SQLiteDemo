
import Foundation

class Person
{
    var profile_pic_url : String?
    var id : Int?
    var full_name : String?
    var email : String?
    var profile_pic : String?
    var phone : String?
    var address : String?
    var dob : String?
    var gender : String?
    var designation : String?
    var salary : Int?
    var created_at : String?
    var updated_at : String?
    
    init(profile_pic_url : String, id : Int, full_name : String, email : String, profile_pic : String, phone : String, address : String, dob : String, gender : String, designation : String, salary : Int, created_at : String, updated_at : String)
    
    {
        self.profile_pic_url = profile_pic_url
        self.id = id
        self.full_name = full_name
        self.email = email
        self.profile_pic = profile_pic
        self.phone = phone
        self.address = address
        self.dob = dob
        self.gender = gender
        self.designation = designation
        self.salary = salary
        self.created_at = created_at
        self.updated_at = updated_at
        self.profile_pic_url = profile_pic_url
        self.id = id
        self.full_name = full_name
    }
    
}
