//
//  File.swift
//  MovieList
//
//  Created by esraa on 1/9/22.
//  Copyright © 2022 esraa. All rights reserved.
//

import Foundation
import UIKit
class Movies{
    var iD:Int = 0
    var title:String = ""
    var img :String = ""
    var rating :Float = 0.0
    var releaseYear :Int = 0
    var genre :String = ""
    init() {
    
    }
    init(id:Int,t:String ,i:String,rat:Float,r:Int,g:String) {
        
        iD = id
        title = t
        img = i
        releaseYear = r
        rating = rat
        genre = g
    }
}
