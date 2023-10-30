//
//  HomeViewController.swift
//  DragonBall
//
//  Created by Gonzalo Gregorio on 29/10/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - IBOutlet -
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    
    
    // MARK: - Public Properties -
    var viewModel: HomeViewControllerDelegate?
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        setObservers()
        viewModel?.onViewAppear()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "HOME_TO_DETAIL",
              let index = sender as? Int,
              let detailViewController = segue.destination as? DetailViewController,
              let detailViewModel = viewModel?.detailViewModel(index: index) else { return }
        
        detailViewController.viewModel = detailViewModel
    }
    
    // MARK: - Private functions -
    private func initViews() {
        tableView.register(
            UINib(nibName: CharacterViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CharacterViewCell.identifier
        )
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setObservers() {
        viewModel?.viewState = { [weak self] state in
            DispatchQueue.main.async {
                switch state {
                case .loading(let isLoading):
                    self?.loadingView.isHidden = !isLoading
                    
                case .updateData:
                    self?.tableView.reloadData()
                }
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.totalCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        CharacterViewCell.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterViewCell.identifier,
                                                       for: indexPath) as? CharacterViewCell else {
            return UITableViewCell()
        }
        
        if let character = viewModel?.getCharacterBy(index: indexPath.row) {
            cell.updateView(
                name: character.name,
                picture: character.photo,
                description: character.description
            )
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "HOME_TO_DETAIL",
                     sender: indexPath.row)
    }
}
