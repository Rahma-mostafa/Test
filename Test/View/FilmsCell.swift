//
//  FilmsCell.swift
//  Test
//
//  Created by Macbook on 01/02/2021.
//

import UIKit

class FilmsCell: UICollectionViewCell {
    @IBOutlet weak var cornerView: UIView!
    @IBOutlet weak var moviesImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setCornerRaduis()
        
    }
    func setCornerRaduis(){
        moviesImageView.layer.cornerRadius = 8
        cornerView.layer.cornerRadius = 8
    }
    func config(movie: Movie){
        nameLabel.text = movie.originalTitle
        let postPath = URL(string: "\(APIKey.BASE_IMAGE_URL.rawValue)\(movie.posterPath)")
        moviesImageView.sd_setImage(with: postPath!)
    }
    

}
