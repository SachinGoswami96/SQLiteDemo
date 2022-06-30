/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Data : Codable {
	let profile_pic_url : String?
	let id : Int?
	let full_name : String?
	let email : String?
	let profile_pic : String?
	let phone : String?
	let address : String?
	let dob : String?
	let gender : String?
	let designation : String?
	let salary : Int?
	let created_at : String?
	let updated_at : String?

	enum CodingKeys: String, CodingKey {

		case profile_pic_url = "profile_pic_url"
		case id = "id"
		case full_name = "full_name"
		case email = "email"
		case profile_pic = "profile_pic"
		case phone = "phone"
		case address = "address"
		case dob = "dob"
		case gender = "gender"
		case designation = "designation"
		case salary = "salary"
		case created_at = "created_at"
		case updated_at = "updated_at"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		profile_pic_url = try values.decodeIfPresent(String.self, forKey: .profile_pic_url)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		full_name = try values.decodeIfPresent(String.self, forKey: .full_name)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		profile_pic = try values.decodeIfPresent(String.self, forKey: .profile_pic)
		phone = try values.decodeIfPresent(String.self, forKey: .phone)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		dob = try values.decodeIfPresent(String.self, forKey: .dob)
		gender = try values.decodeIfPresent(String.self, forKey: .gender)
		designation = try values.decodeIfPresent(String.self, forKey: .designation)
		salary = try values.decodeIfPresent(Int.self, forKey: .salary)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
	}

}