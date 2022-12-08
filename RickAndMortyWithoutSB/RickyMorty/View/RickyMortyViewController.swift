//
//  RickyMortyViewController.swift
//  RickAndMortyWithoutSB
//
//  Created by mert Kanak on 8.12.2022.
//

import UIKit
import SnapKit


protocol RickyMortyOutput {
    func changeLoading(isLoad: Bool)
    func saveDatas(values: [Result])
}


final class RickyMortyViewController: UIViewController {
    
    private let labelTitle = UILabel()
    private let tableView = UITableView()
    private let indicator = UIActivityIndicatorView()

    private var results : [Result] = []
    
    lazy var viewModel : IRickyMortyViewModel = RickyMortyViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        viewModel.setDelegate(output: self)
        viewModel.fetchItems()

        // Do any additional setup after loading the view.
    }

    private func configure() {
        view.addSubview(labelTitle)
        view.addSubview(tableView)
        view.addSubview(indicator)
        
        drawDesign()
        makeTableView()
        makeLabelTitle()
        makeIndicator()
    }
    
    private func drawDesign() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RickyMortyTableViewCell.self, forCellReuseIdentifier: RickyMortyTableViewCell.Identifier.custom.rawValue)
        tableView.rowHeight = 200
        
        DispatchQueue.main.async {
            self.view.backgroundColor = .systemBackground
            self.tableView.backgroundColor = .systemBackground
            self.labelTitle.font = .boldSystemFont(ofSize: 25)
            self.labelTitle.text = "Rick And Morty"
            self.indicator.color = .white
        }
        self.indicator.startAnimating()
    }
}

extension RickyMortyViewController : RickyMortyOutput {
    func changeLoading(isLoad: Bool) {
        isLoad ? self.indicator.startAnimating() : self.indicator.stopAnimating()

    }
    
    func saveDatas(values: [Result]) {
        results = values
        tableView.reloadData()
    }
    
    
}

// MARK: - Delegate DataSource

extension RickyMortyViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell : RickyMortyTableViewCell = tableView.dequeueReusableCell(withIdentifier: RickyMortyTableViewCell.Identifier.custom.rawValue) as? RickyMortyTableViewCell else {
            return UITableViewCell()
        }
        cell.saveModel(model: results[indexPath.row])
        return cell
    }
    
    
}

// MARK: - Constraints
extension RickyMortyViewController {
    func makeTableView()  {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(labelTitle.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
            make.left.right.equalTo(labelTitle)
            
        }
    }
    
    func makeIndicator() {
        indicator.snp.makeConstraints { make in
            make.top.equalTo(labelTitle)
            make.right.equalTo(labelTitle).offset(-5)
            make.top.equalTo(labelTitle)
        }
    }
    
    func makeLabelTitle() {
        labelTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.height.greaterThanOrEqualTo(10)
        }
    }
    
    
}
