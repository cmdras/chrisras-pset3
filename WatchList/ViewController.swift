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
    let defaults = UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        //print(movies.count)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let SearchVC = segue.destination as? MovieSearchViewController {
            SearchVC.moviesList = movies
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movie_cell", for: indexPath)
            as! MovieViewCell
        
        cell.movieTitle.text = movies[indexPath.row].title
        
        cell.movieDescription.text = movies[indexPath.row].director
        
        cell.movieYear.text = movies[indexPath.row].year
        
        let posterUrl = URL(string: movies[indexPath.row].poster)
        let posterData = try? Data(contentsOf: posterUrl!)
        if posterData != nil {
            if let image = UIImage(data: posterData!) {
                cell.poster.image = image
            }
        }
        return cell
    }


}

