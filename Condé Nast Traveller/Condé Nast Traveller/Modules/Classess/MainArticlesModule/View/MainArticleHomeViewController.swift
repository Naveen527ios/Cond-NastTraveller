//
//  MainArticleHomeViewController.swift
//  Condé Nast Traveller
//
//  Created by Naveen Kumar on 19/03/25.
//

import UIKit

class MainArticleHomeViewController: UIViewController {
    
    
    
    @IBOutlet weak var articleTableView: UITableView!
    
    let viewModel = MainArticleViewModel()
    private var selectedCategory:String = AvailableCategory.business.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Top Stories"
        self.apiCall(category: AvailableCategory.business.rawValue)
        self.setUpTableView()
        
        self.addRightBarButton()
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    //MARK: - rightBarButton Setup
    
    private func addRightBarButton() {
        
        let rightBarButton = UIBarButtonItem(
            title: "Category",
            style: .plain,
            target: self,
            action: nil
        )
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        let business = UIAction(title: AvailableCategory.business.rawValue.capitalized) { [self] _ in
            selectedCategory =  AvailableCategory.business.rawValue
            self.updateTheCategory()
        }
        
        let entertainment = UIAction(title: AvailableCategory.entertainment.rawValue.capitalized) { [self] _ in
            selectedCategory =  AvailableCategory.entertainment.rawValue
            self.updateTheCategory()
        }
        
        let general = UIAction(title: AvailableCategory.general.rawValue.capitalized) { [self] _ in
            selectedCategory =  AvailableCategory.general.rawValue
            self.updateTheCategory()
        }
        
        let health = UIAction(title: AvailableCategory.health.rawValue.capitalized) { [self] _ in
            selectedCategory =  AvailableCategory.health.rawValue
            self.updateTheCategory()        }
        
        let sports = UIAction(title: AvailableCategory.sports.rawValue.capitalized) { [self] _ in
            selectedCategory =  AvailableCategory.sports.rawValue
            self.updateTheCategory()        }
        
        let science = UIAction(title: AvailableCategory.science.rawValue.capitalized) { [self] _ in
            selectedCategory =  AvailableCategory.science.rawValue
            self.updateTheCategory()        }
        
        let technology = UIAction(title: AvailableCategory.technology.rawValue.capitalized) { [self] _ in
            selectedCategory =  AvailableCategory.technology.rawValue.capitalized
            self.updateTheCategory()
        }
        
        //  menu items
        let menu = UIMenu(title: "Choose Category", children: [business,entertainment,technology, science, sports,health,general])
        rightBarButton.menu = menu
        
    }
    
    func updateTheCategory(){
        apiCall(category: selectedCategory)
    }
    
    
    
    //MARK: - API Calls
    
    private func apiCall(category:String){
        
        CustomLoaderView.shared.show(in: self)
        viewModel
            .getTheTopArticlesBusiness(category: category) { [weak self] (
                resp
            ) in
                CustomLoaderView.shared.hide()
                guard self != nil else {
                    return
                }
                
                switch resp {
                case .success(let isSuccess):
                    if isSuccess {
                        DispatchQueue.main.async {
                            self?.articleTableView.reloadData()
                            self?.articleTableView
                                .scrollToRow(
                                    at: IndexPath(row: 0, section: 0),
                                    at: .top,
                                    animated: true
                                )
                        }
                    }
                    break
                case  .failure(let error):
                    print(error)
                    break
                }
            }
    }
    
    //MARK: - Custom Navigation
    
    private func navigateToDetailedPage(selectedItem:Article){
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailedArticleViewController") as? DetailedArticleViewController
        vc?.article = selectedItem
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    
}

extension MainArticleHomeViewController:UITableViewDelegate,UITableViewDataSource {
    
    private func setUpTableView(){
        articleTableView.dataSource = self
        articleTableView.delegate = self
        articleTableView.estimatedRowHeight = 200
        articleTableView.rowHeight = UITableView.automaticDimension
        
        articleTableView
            .register(
                UINib(nibName: BaseAriticleTableViewCell.reuseIdentifier,bundle: nil),
                forCellReuseIdentifier:BaseAriticleTableViewCell.reuseIdentifier
            )
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        viewModel.topArticles?.articles?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "BaseAriticleTableViewCell"
        ) as? BaseAriticleTableViewCell
        
        let data = viewModel.topArticles?.articles?[indexPath.row]
        cell?.setUp(article: data)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let selectedData = viewModel.topArticles?.articles?[indexPath.row]
        self.navigateToDetailedPage(selectedItem: selectedData!)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        selectedCategory.uppercased()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60
    }

    
}
