//
//  SecondViewController.swift
//  MovieList
//
//  Created by esraa on 1/10/22.
//  Copyright © 2022 esraa. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var add:AddMovie?
    var genereS :[String] = []
    var genereChoosen:String?
    var movie = Movies()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chooseGenere.dataSource = self
        chooseGenere.delegate = self
        genereS = ["Action", "Drama", "Sci-Fi","Thriller"]
        genereChoosen = "Action"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addImageFromG(_ sender: UIButton) {
        let imgPicker = UIImagePickerController()
        imgPicker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imgPicker.sourceType = .camera
        }else {print("camera not found")}
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imgPicker.sourceType = .photoLibrary
               }else {print("photoLibrary not found")}
        self.present(imgPicker,animated: true,completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let img = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        addImg.image = img
        if let imgURL = info[UIImagePickerController.InfoKey.imageURL] as? URL
        {
            let imgName = imgURL.lastPathComponent
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
            let localpath = documentDirectory?.appending(imgName)
            let data = img.pngData()! as NSData
            data.write(toFile: localpath!, atomically: true)
            let photoURL = URL.init(fileURLWithPath: localpath!)
            movie.img = photoURL.absoluteString
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var chooseGenere: UIPickerView!
    @IBOutlet weak var addImg: UIImageView!
    
    @IBOutlet weak var addTitle: UITextField!
    
   @IBOutlet weak var addRate: UITextField!
    @IBOutlet weak var addTRYear: UITextField!
    @IBAction func addMovie(_ sender: Any) {
        
         movie.title = addTitle?.text! ?? ""
         movie.rating = Float(addRate?.text! ?? "0.0") ?? 0.0
         movie.releaseYear = Int(addTRYear?.text! ?? "0") ?? 0
         movie.genre = genereChoosen!
        add?.add(movie: movie)
        self.navigationController?.popViewController(animated: true)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genereS.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genereS[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genereChoosen = genereS[row]
    }
}
