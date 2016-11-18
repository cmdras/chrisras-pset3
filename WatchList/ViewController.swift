//
//  ViewController.swift
//  WatchList
//
//  Created by Christopher Ras on 16/11/2016.
//  Copyright © 2016 Chris Ras. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var movies = [Movie]()
    var shrek = Movie()
    
    var titles = ["Shrek", "Cinderella", "Poltergeist"]
    var descriptions =
        [
    "Shrek": "Funny",
    "Poltergeist": "Scary"
        ]

    override func viewDidLoad() {
        super.viewDidLoad()
        shrek.title = "Shrek"
        shrek.director = "Bla BLa"
        movies.append(shrek)
        self.tableView.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movie_cell", for: indexPath)
            as! MovieViewCell
        
        cell.movieTitle.text = movies[indexPath.row].title
        
        cell.movieDescription.text = movies[indexPath.row].director
        
        if let image = UIImage(named: titles[indexPath.row]) {
            cell.poster.image = image
        }
        
        return cell
    }


}

