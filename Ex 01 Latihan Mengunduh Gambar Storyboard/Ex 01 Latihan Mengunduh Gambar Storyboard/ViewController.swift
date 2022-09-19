//
//  ViewController.swift
//  Ex 01 Latihan Mengunduh Gambar Storyboard
//
//  Created by septe habudin on 18/09/22.
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: "movieTableViewCell", for: indexPath) as? MovieTableViewCell{
            cell.movieTitle.text = movies[indexPath.row].title
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}

