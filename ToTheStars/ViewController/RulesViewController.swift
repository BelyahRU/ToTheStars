//
//  RulesViewController.swift
//  ToTheStars
//
//  Created by Александр Андреев on 09.08.2023.
//

import UIKit

class RulesViewController: UIViewController {
    
    private let rulesView = RulesView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        // Do any additional setup after loading the view.
    }
    

    private func configure() {
        view.addSubview(rulesView)
        
        rulesView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        rulesView.backButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
    }

}

private extension RulesViewController {
    @objc func backPressed() {
        navigationController?.popViewController(animated: true)
    }
}
