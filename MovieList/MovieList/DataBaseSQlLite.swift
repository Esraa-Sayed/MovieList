 //
//  DataBaseSQlLite.swift
//  MovieList
//
//  Created by esraa on 1/14/22.
//  Copyright © 2022 esraa. All rights reserved.
//

import Foundation
 import UIKit
 import SQLite3
 class DataBaseSQLite{
    
    static let instance = DataBaseSQLite()
    private init()
    {
        createTable()
    }
    private func openDataBase() -> OpaquePointer? {
        var db: OpaquePointer?
        let dbName:String? = "movieList.sqlite"
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        .appendingPathComponent(dbName!)
        if sqlite3_open(fileURL.path,&db) == SQLITE_OK {
            print("Successfully open connection")
            return db
        }
        print("Unable to open database.")
        return nil
    }
    private func createTable() {
        let db = openDataBase()
        let createTableString = """
        create table IF NOT EXISTS contact(
        id INTEGER primary key AUTOINCREMENT,
        title TEXT,
        genre TEXT,
        releaseYear INTEGER,
        rating REAL,
        image TEXT
        )
        """
        var createTableStatement:OpaquePointer?
        if sqlite3_prepare_v2(db, createTableString,-1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("Contact table created .")
            }
            else
            {
                print("Table not created")
            }
        }else {
            print("Create table statment is not prepared.")
        }
        sqlite3_finalize(createTableStatement)
        sqlite3_close(db)
    }
    func insertDataInSQL(movies:Movies)
    {
        let insertStat = """
        INSERT INTO contact(title,genre, releaseYear, rating, image)   VALUES (?,?,?,?,?);
        """
        let db = openDataBase()
       var insertStatment:OpaquePointer?
       if sqlite3_prepare_v2(db, insertStat, -1, &insertStatment, nil) == SQLITE_OK
       {
            sqlite3_bind_text(insertStatment,1,(movies.title as NSString).utf8String,-1,nil)
            sqlite3_bind_text(insertStatment,2,(movies.genre as NSString).utf8String,-1,nil)
            sqlite3_bind_int(insertStatment, 3, Int32(movies.releaseYear))
            sqlite3_bind_double(insertStatment, 4, Double(movies.rating))
            sqlite3_bind_text(insertStatment,5,(movies.img as NSString).utf8String,-1,nil)
            if sqlite3_step(insertStatment) == SQLITE_DONE
            {
                print("Successfuly insrted row.")
            }
            else
            {
                print("Could not insert row .")
            }
        }
        else
       {
        print("INSERT statment is not prepared")
        }
        sqlite3_finalize(insertStatment)
        sqlite3_close(db)
    }
    func query()->[Movies]
    {
        let db = openDataBase()
        let queryStat = "select * from contact"
       var queryStatment:OpaquePointer?
       var movies:[Movies] = []
       if sqlite3_prepare_v2(db, queryStat, -1, &queryStatment, nil) == SQLITE_OK
       {
            while sqlite3_step(queryStatment) == SQLITE_ROW
            {
                let id = sqlite3_column_int(queryStatment, 0)
                let title = String(describing: String(cString: sqlite3_column_text(queryStatment, 1)))
                let gener = String(describing: String(cString: sqlite3_column_text(queryStatment, 2)))
                let releaseYear  = sqlite3_column_double(queryStatment, 3)
                let rating = sqlite3_column_int(queryStatment, 4)
                let image = String(describing: String(cString: sqlite3_column_text(queryStatment, 5)))
                movies.append(Movies(id: Int(id), t: title, i: image, rat: Float(rating), r: Int(releaseYear), g: gener))
            }
        }
     else
       {
         print("INSERT statment is not prepared")
        }
        sqlite3_finalize(queryStatment)
        sqlite3_close(db)
        return movies
    }
    func deleteFromData(id:Int) {
        let db = openDataBase()
        let deleteStat = "Delete from Contact Where id = \(id)"
        var deleteStatment :OpaquePointer?
        if sqlite3_prepare_v2(db, deleteStat, -1, &deleteStatment, nil) == SQLITE_OK
        {
            if sqlite3_step(deleteStatment) == SQLITE_DONE {
                print("Successfully deleted row .")
            }
            else{
                print("Could not delete row")
            }
        }
        else{
            print("Delete statment could not be prepared")
        }
        sqlite3_finalize(deleteStatment)
        sqlite3_close(db)
     }
 }
 
 
