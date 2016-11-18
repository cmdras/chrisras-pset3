//
//  MovieSearchViewController.swift
//  WatchList
//
//  Created by Christopher Ras on 18/11/2016.
//  Copyright © 2016 Chris Ras. All rights reserved.
//

import UIKit

class MovieSearchViewController: UIViewController {
    var moviesList = [Movie]()
    var movie = Movie()
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var descriptionView: UITextView!

    @IBOutlet weak var movieSearchBox: UITextField!
    
    @IBOutlet weak var addMovieButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchPressed(_ sender: Any) {
        if movieSearchBox.text != nil && (movieSearchBox.text?.characters.count)! > 1 {
            let urlString = "https://www.omdbapi.com/?t=\(movieSearchBox.text!)&y=&plot=short&r=json"
            let urlWithEscapes = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
            let url = URL(string: urlWithEscapes!)
            let session = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                guard error == nil && data != nil else {
                    print("Error:", error!)
                    return
                }
                let httpStatus = response as? HTTPURLResponse
                if httpStatus?.statusCode == 200 {
                    if data?.count != 0 {
                        let responseString = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
                        DispatchQueue.main.sync {
                            if responseString["Error"] == nil {
                                self.addMovieButton.isHidden = false
                                self.titleLabel.text = responseString["Title"] as? String
                                self.movie.title = (responseString["Title"] as? String)!
                                self.titleLabel.isHidden = false
                                self.yearLabel.text = responseString["Year"] as? String
                                self.movie.year = (responseString["Year"] as? String)!
                                self.yearLabel.isHidden = false
                                self.directorLabel.text = responseString["Director"] as? String
                                self.movie.director = (responseString["Director"] as? String)!
                                self.directorLabel.isHidden = false
                                self.genreLabel.text = responseString["Genre"] as? String
                                self.movie.genre = (responseString["Genre"] as? String)!
                                self.genreLabel.isHidden = false
                                self.descriptionView.text = responseString["Plot"] as? String
                                self.movie.description = (responseString["Plot"] as? String)!
                                self.descriptionView.isHidden = false
                                self.movie.poster = (responseString["Poster"] as? String)!
                                let posterUrl = URL(string: (responseString["Poster"] as? String)!)
                                let posterData = try? Data(contentsOf: posterUrl!)
                                if posterData != nil {
                                    self.poster.image = UIImage(data: posterData!)
                                    self.poster.isHidden = false
                                }
                            } else {
                                self.descriptionView.text = "Sorry, that movie can't be found"
                                self.descriptionView.isHidden = false
                                self.titleLabel.isHidden = true
                                self.yearLabel.isHidden = true
                                self.directorLabel.isHidden = true
                                self.genreLabel.isHidden = true
                                self.poster.isHidden = true
                                self.addMovieButton.isHidden = true
                            }
                        }
                    } else {
                        print("No data from URL")
                    }
                } else {
                    print("Error httpStatusCode: ", httpStatus!.statusCode)
                }
            }
            session.resume()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var appendMovie = true
        if segue.identifier == "addMovieSegue" {
            if let TableVC = segue.destination as? ViewController {
                if self.moviesList.count == 0{
                    self.moviesList.append(self.movie)
                    appendMovie = false
                }else{
                    for i in self.moviesList {
                        if i === self.movie {
                            appendMovie = false
                        }
                    }
                    if appendMovie {
                        self.moviesList.append(self.movie)
                    }
                }
                TableVC.movies = moviesList
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
