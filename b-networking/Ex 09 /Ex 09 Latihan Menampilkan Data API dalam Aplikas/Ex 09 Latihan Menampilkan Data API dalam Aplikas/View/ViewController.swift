//
//  ViewController.swift
//  Ex 09 Latihan Menampilkan Data API dalam Aplikas
//
//  Created by septe habudin on 24/09/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var movieTableView: UITableView!
    
    private var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        movieTableView.dataSource = self
        movieTableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "movieCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       Task { await getMovies() }
     }
    
    func getMovies() async {
        let network = NetworkService()
        do {
          movies = try await network.getMovies()
          movieTableView.reloadData()
        } catch {
          fatalError("Error: connection failed.")
        }
      }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = movieTableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieCell {
            
            let movie = movies[indexPath.row]
            
            cell.movieTitle.text = movie.title
            cell.movieImage.image = movie.image
            
            if movie.state == .new {
                cell.indicatorLoadin.isHidden = false
                cell.indicatorLoadin.startAnimating()
                
                startDownload(movie: movie, indexPath: indexPath)
            }else{
                cell.indicatorLoadin.isHidden = true
                cell.indicatorLoadin.stopAnimating()
            }
            
            return cell
        }
        
        
        return UITableViewCell()
    }
    
    fileprivate func startDownload(movie: Movie, indexPath: IndexPath){
        let imageDownloader = ImageDownloader()
        
        if movie.state == .new {
            Task {
                do {
                    let image = try await imageDownloader.downloadImage(url: movie.posterPath)
                    movie.state = .download
                    movie.image = image
                    
                    self.movieTableView.reloadRows(at: [indexPath], with: .automatic)
                }catch{
                    movie.state = .failed
                    movie.image = nil
                }
            }
        }
    }
}



