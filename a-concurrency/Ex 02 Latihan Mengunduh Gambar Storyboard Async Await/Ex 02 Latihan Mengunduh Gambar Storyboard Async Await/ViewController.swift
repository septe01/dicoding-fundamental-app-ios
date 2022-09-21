//
//  ViewController.swift
//  Ex 02 Latihan Mengunduh Gambar Storyboard Async Await
//
//  Created by septe habudin on 20/09/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var movieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // MARK: menghubungkan table view cell yang menggunakan xib
        movieTableView.dataSource = self
        movieTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "movieTableViewCell")
    }


}


extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = movieTableView.dequeueReusableCell(withIdentifier: "movieTableViewCell", for: indexPath) as? MovieTableViewCell {
            
            let movie = movies[indexPath.row]
            
            cell.movieTitle.text = movie.title
            cell.movieImage.image = movie.image
            
            if movie.state == .new {
                cell.indicatorLoading.isHidden = false
                cell.indicatorLoading.startAnimating()
                startDownload(movie:movie, indexPath: indexPath)
            }else {
                cell.indicatorLoading.stopAnimating()
                cell.indicatorLoading.isHidden = true
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    fileprivate func startDownload(movie: Movie, indexPath: IndexPath){
        let imageDownloader = ImageDownloader()
        
        if movie.state == .new{
            Task{
                do{
                    let image = try await imageDownloader.downloadImage(url: movie.poster)
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
