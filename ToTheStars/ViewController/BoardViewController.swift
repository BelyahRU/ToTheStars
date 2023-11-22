//
//  BoardViewController.swift
//  ToTheStars
//
//  Created by Александр Андреев on 09.08.2023.
//

import UIKit

class BoardViewController: UIViewController {
    
    private let boardView = BoardView()
    private var resultTableView = UITableView()
    private var resultsArray = Results.makeArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupUser()
        setupTableView()
    }
    
    private func setupUser() {
        let User = Result1(name: "you", score: AppDelegate.shared.record)
        resultsArray.append(User)
        resultsArray = resultsArray.sorted { $0.score > $1.score }

    }
    
    private func setupTableView() {
        resultTableView = boardView.resultsTableView
        
        resultTableView.dataSource = self
        resultTableView.delegate = self
        resultTableView.register(ResultsTableViewCell.self, forCellReuseIdentifier: ResultsTableViewCell.reuseId)
        
    }

    private func configure() {
        view.addSubview(boardView)
        
        boardView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        boardView.backButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        
    }

}

extension BoardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        resultsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = resultTableView.dequeueReusableCell(withIdentifier: "ResultsTableViewCell", for: indexPath) as? ResultsTableViewCell else { fatalError() }
        
        cell.configure(result: resultsArray[indexPath.row])
        
        return cell
    }
    
    
}

private extension BoardViewController {
    @objc func backPressed() {
        navigationController?.popViewController(animated: true)
    }
}
