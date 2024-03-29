//
//  MoviesTableViewCell.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import UIKit
import SDWebImage

class MoviesTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet private weak var imgView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    func configureCell(movie: Movie) {
        titleLabel.text = movie.title
        yearLabel.text = movie.releaseYear
        imgView.sd_setImage(with: movie.imageURL)
    }
    
}
