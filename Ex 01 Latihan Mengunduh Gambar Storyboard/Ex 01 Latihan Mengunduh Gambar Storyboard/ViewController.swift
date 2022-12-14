//
//  ViewController.swift
//  Ex 01 Latihan Mengunduh Gambar Storyboard
//
//  Created by septe habudin on 18/09/22.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var movieTableView: UITableView!
    
    // instance PendingOperation
    private let pendingOperations = PendingOperations()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // MARK: menghubungkan table view cell yang menggunakan xib
        movieTableView.dataSource = self
        movieTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "movieTableViewCell")
    }
    

    
}

//tak ingin gambar dibuka pada saat pengguna melakukan dragging di UITableView agar tidak terjadi lag.
//tunda sementara
extension ViewController: UIScrollViewDelegate {
    //untuk menghentikan sementara dan mengaktifkan proses pengunduhan
    fileprivate func toggleSuspendOperations(isSuspended: Bool){
        pendingOperations.downloadQueue.isSuspended = isSuspended
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        toggleSuspendOperations(isSuspended: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        toggleSuspendOperations(isSuspended: false)
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "movieTableViewCell", for: indexPath) as? MovieTableViewCell{
            
            let movie = movies[indexPath.row]
            cell.movieTitle.text = movies[indexPath.row].title
            
            cell.movieImage.image = movie.image
            
            // melakukan validasi. Ketika gambar belum diunduh oleh pengguna, aplikasi memunculkan indikator loading dan memulai proses pengunduhan gambar
            if movie.state == .new {
                cell.indicatorLoading.isHidden = false
                cell.indicatorLoading.startAnimating()
                startOperations(movie: movie, indexPath: indexPath)
            }else{
                cell.indicatorLoading.stopAnimating()
                cell.indicatorLoading.isHidden = true
            }            
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    //untuk memulai pengunduhan dan memonitor proses pengunduhan sampai selesai
    fileprivate func startOperations(movie: MovieModel, indexPath: IndexPath){
        
        if movie.state == .new {
            startDownload(movie: movie, indexPath: indexPath)
        }
    }
    
    
    // untuk melakukan validasi ketika proses pengunduhan berlangsung
    fileprivate func startDownload(movie: MovieModel, indexPath: IndexPath) {
      guard pendingOperations.downloadInProgress[indexPath] == nil else { return }

      let downloader = ImageDownloader(movie: movie)

        // Panggil completionBlock dari downloaderuntuk menangkap sinyal ketika proses unduh berhasil dilakukan
      downloader.completionBlock = {
        if downloader.isCancelled { return }
          
          // Gunakan DispatchQueue di thread utama untuk melakukan update nilai downloadInProgress dan melakukan reloadData
        DispatchQueue.main.async {
          self.pendingOperations.downloadInProgress.removeValue(forKey: indexPath)
          self.movieTableView.reloadRows(at: [indexPath], with: .automatic)
        }
      }

      pendingOperations.downloadInProgress[indexPath] = downloader
      pendingOperations.downloadQueue.addOperation(downloader)
    }
}


