//
//  DetailedArticleViewController.swift
//  Condé Nast Traveller
//
//  Created by Naveen Kumar on 19/03/25.
//

import UIKit
import SDWebImage

class DetailedArticleViewController: UIViewController {
    
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var autherLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var publisherLabel: UILabel!
    var article :Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.intialSetUp()
        navigationController?.navigationBar.isHidden = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK: - IntialSetUp
    
    private func intialSetUp(){
        
        articleTitleLabel.text = article?.title ?? "NA"
        autherLabel.text = "Author          : \(article?.author ?? "Unknown")"
        
        publisherLabel.text = "Pusblished   : \(article?.publishedAt?.convertStringIntoDate() ?? "NA")"
        descriptionLabel.text = article?.description ?? "NA"
        articleImageView.setCornerRadious(radious: 10)
        
        if let imagrUrl = article?.urlToImage {
            articleImageView
                .sd_setImage(
                    with: URL(string:imagrUrl),
                    placeholderImage: UIImage.init(named: "No_image_available"))
            articleImageView.contentMode = .scaleAspectFill
        }else {
            articleImageView.image = UIImage.init(named: "No_image_available")
            articleImageView.contentMode = .scaleAspectFit
        }
    }
    
    //MARK: - Button Actions

    
    @IBAction func closeAct(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
