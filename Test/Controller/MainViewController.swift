//
//  MainViewController.swift
//  Test
//
//  Created by Macbook on 01/02/2021.
//

import UIKit
import Alamofire
import SDWebImage
import KRProgressHUD

class MainViewController: UIViewController{

    @IBOutlet weak var moviesCollectionView: UICollectionView!
    // variabls
    var responseData: Data?
    let jsonDecoder = JSONDecoder()
    var resultsArray: [Movie] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        getData()

    }
    func setup(){
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self
        self.moviesCollectionView.register(UINib(nibName: "FilmsCell", bundle: nil), forCellWithReuseIdentifier: "FilmsCell")

    }
    private func getData(){
        KRProgressHUD.show()
        Alamofire.request(URL(string: APIKey.BASE_API_URL.rawValue)!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON {[weak self] (response) in
            if let self = self {
                self.responseData = response.data
                self.decodeResponseData()
            }else{
                return
            }
        }
    }
    private func decodeResponseData(){
        let model = try? jsonDecoder.decode(MoviesPlayList.self, from: self.responseData!)
        self.resultsArray = model!.results
        self.moviesCollectionView.reloadData()
        KRProgressHUD.dismiss()
    }
    

   

}
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: "FilmsCell", for: indexPath) as! FilmsCell
        cell.config(movie: resultsArray[indexPath.row])
        return cell
        
    }
}
