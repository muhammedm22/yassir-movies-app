//
//  MovieDetailsViewController.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import UIKit
import SDWebImage

class MovieDetailsViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var deccLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    // MARK: Properties
    private var viewModel: MovieDetailsViewModelProtocol?
    // MARK: Init
    init(viewModel: MovieDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.getDetails(completion: { [weak self] in
            guard let self else { return }
            DispatchQueue.main.async {
                self.setUI()
            }
        })
    }
    private func setUI() {
        imageView.contentMode = .scaleToFill
        guard let movie = viewModel?.movie else { return }
        imageView.sd_setImage(with: movie.imageURL)
        titleLabel.text = movie.title
        deccLabel.text = movie.desc
        dateLabel.text = movie.releaseYear
    }

}
