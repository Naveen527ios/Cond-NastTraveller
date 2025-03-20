//
//  BaseAriticleTableViewCell.swift
//  Condé Nast Traveller
//
//  Created by Naveen Kumar on 19/03/25.
//

import UIKit
import SDWebImage

class BaseAriticleTableViewCell: UITableViewCell {
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var articleImageView: UIImageView!
    
    @IBOutlet weak var autherNameLabel: UILabel!

    @IBOutlet weak var articleTitleLabel: UILabel!
    
    static let reuseIdentifier = "BaseAriticleTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        articleImageView.setCornerRadious(radious: 10)
    }
    
    func setUp(article:Article?){
        autherNameLabel.text = article?.author ?? "unknown author"
        articleTitleLabel.text = article?.title ?? ""
        articleTitleLabel.numberOfLines = 0
        
        if let data = article?.urlToImage {
            articleImageView
                .sd_setImage(
                    with: URL(string: data),
                    placeholderImage: UIImage.init(
                        named: "No_image_available"))
            articleImageView.contentMode = .scaleAspectFill
        }else{
            articleImageView.image = UIImage.init(named: "No_image_available")
            articleImageView.contentMode = .scaleAspectFit

            
        }
        
    }

  
    
}
