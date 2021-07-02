//
//  MovieTableViewCell.swift
//  Web-Consuming
//
//  Created by Natália Brocca dos Santos on 01/07/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var moviewShortDescription: UILabel!
    @IBOutlet weak var movieRanking: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImage.image = nil
        movieTitle.text = nil
        moviewShortDescription.text = nil
        movieRanking.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
