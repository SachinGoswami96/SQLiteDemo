

import Foundation
import SQLite3

class DBHelper
{
    init()
    {
        db = openDatabase()
        createTable()
    }

    let dbPath: String = "myDb.sqlite"
    var db:OpaquePointer?

    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    
    
    
    
//    "CREATE TABLE IF NOT EXISTS person(Id INTEGER PRIMARY KEY,name TEXT,age INTEGER);"
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS person(Id INTEGER PRIMARY KEY,profile_pic_url  TEXT,full_name TEXT,email TEXT,profile_pic TEXT,phone TEXT,address TEXT,dob TEXT,gender TEXT,designation TEXT,salary INTEGER,created_at TEXT,updated_at TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("person table created.")
            } else {
                print("person table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    
    func insert(profile_pic_url : String, id : Int, full_name : String, email : String, profile_pic : String, phone : String, address : String, dob : String, gender : String, designation : String, salary : Int, created_at : String, updated_at : String)
    {
        let persons = read()
        for p in persons
        {
            if p.id == id
            {
                return
            }
        }
        "INSERT INTO person (Id, name, age) VALUES (NULL, ?, ?);"
        let insertStatementString = "INSERT INTO person (Id, profile_pic_url, full_name, email, profile_pic, phone, address, dob, gender, designation, salary, created_at, updated_at) VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (profile_pic_url as NSString).utf8String, -1, nil)
//            sqlite3_bind_int(insertStatement, 1, Int32(id))
            sqlite3_bind_text(insertStatement, 2, (full_name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (profile_pic as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (phone as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, (address as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 7, (dob as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 8, (gender as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 9, (designation as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 10, Int32(truncatingIfNeeded: salary))
            sqlite3_bind_text(insertStatement, 11, (created_at as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 12, (updated_at as NSString).utf8String, -1, nil)
            
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func read() -> [Person] {
        let queryStatementString = "SELECT * FROM person;"
        var queryStatement: OpaquePointer? = nil
        var psns : [Person] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let profile_pic_url = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
//                let id = sqlite3_column_int(queryStatement, 1)
                let full_name = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let email = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let profile_pic = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let phone = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                let address = String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))
                let dob = String(describing: String(cString: sqlite3_column_text(queryStatement, 7)))
                let gender = String(describing: String(cString: sqlite3_column_text(queryStatement, 8)))
                let designation = String(describing: String(cString: sqlite3_column_text(queryStatement, 9)))
                let salary = sqlite3_column_int(queryStatement, 10)
                let created_at = String(describing: String(cString: sqlite3_column_text(queryStatement,11)))
                let updated_at = String(describing: String(cString: sqlite3_column_text(queryStatement, 12)))
               
//                let id = sqlite3_column_int(queryStatement, 0)
//                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
//                let year = sqlite3_column_int(queryStatement, 2)
                psns.append(Person(profile_pic_url : profile_pic_url, id: Int(id),full_name : full_name,email : email,profile_pic : profile_pic,phone : phone,address : address,dob : dob,gender : gender,designation : designation,salary : Int(salary),created_at : created_at,updated_at : updated_at))
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
    
    func deleteByID(id:Int) {
        let deleteStatementStirng = "DELETE FROM person WHERE Id = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    
}
