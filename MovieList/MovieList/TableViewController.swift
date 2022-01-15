//
//  TableViewController.swift
//  MovieList
//  Created by esraa on 1/9/22.
//  Copyright © 2022 esraa. All rights reserved.
//

import UIKit
import Foundation
import  Kingfisher
class TableViewController: UITableViewController ,AddMovie{
    var movies:[Movies] = []
    var dataSql = DataBaseSQLite.instance
    override func viewDidLoad() {
        super.viewDidLoad()
        movies = dataSql.query()
        print("----------------------------------")
        print(movies.count)
    }
    @IBOutlet var tab: UITableView!
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! CustomCellTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.myTitle.text = movies[indexPath.row].title
        cell.myimag.kf.setImage(with: URL(string: movies[indexPath.row].img),placeholder: "im.jpg" as? Placeholder)
        cell.imageView?.layer.cornerRadius = 25
        cell.imageView?.layer.masksToBounds = true
        cell.myGenere.text = movies[indexPath.row].genre
        cell.myRating.text = String(movies[indexPath.row].rating)
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            let alert = UIAlertController(title: "Warinig", message: "Are you sure you want to delete?", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                self.dataSql.deleteFromData(id: self.movies[indexPath.row].iD)
                self.movies.remove(at: indexPath.row)
                self.tab.reloadData()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func add(movie: Movies) {
           dataSql.insertDataInSQL(movies: movie)
           movies.removeAll()   
           movies = dataSql.query()
           tab.reloadData()
          }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? ViewController
        vc?.movie = movies[tab?.indexPathForSelectedRow?.row ?? 0]
        let vc2 = segue.destination as? SecondViewController
        vc2?.add = self
    }
    

}
