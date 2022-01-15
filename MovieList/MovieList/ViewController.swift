//
//  ViewController.swift
//  MovieList
//
//  Created by esraa on 1/9/22.
//  Copyright © 2022 esraa. All rights reserved.
//

import UIKit
import Kingfisher
class ViewController: UIViewController{
    public var movie = Movies()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+300)
        myTitle.title = movie.title
        releaseYear?.text = String(movie.releaseYear)
        genere?.text = movie.genre
        rating?.text = String(movie.rating)
        imView?.kf.setImage(with: URL(string: movie.img),placeholder: "im.jpg" as? Placeholder)
        
    
    }

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var imView: UIImageView!

    @IBOutlet weak var myTitle: UINavigationItem!
    @IBOutlet weak var releaseYear: UILabel!
    
    @IBOutlet weak var genere: UILabel!
}

