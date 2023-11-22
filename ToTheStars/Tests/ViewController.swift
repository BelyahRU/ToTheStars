//
//  ViewController.swift
//  ToTheStars
//
//  Created by Александр Андреев on 09.08.2023.
//

import UIKit
import SnapKit

class PlayViewww: UIView {
    public lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        // Устанавливаем начальное смещение скролла внизу
        scrollView.setContentOffset(CGPoint(x: 0, y: UIScreen.main.bounds.height * 5), animated: false)
        //scrollView.contentOffset = CGPoint(x: 0, y: UIScreen.main.bounds.height * 5)

        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 5)
        return scrollView
    }()
    
    private let phoneImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "background"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let grayBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(scrollView)
        scrollView.addSubview(phoneImageView)
        scrollView.addSubview(grayBackground)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        grayBackground.snp.makeConstraints { make in
            make.top.equalToSuperview()
           // make.bottom.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(UIScreen.main.bounds.height * 4)
        }
        phoneImageView.snp.makeConstraints { make in
            make.top.equalTo(grayBackground.snp.bottom)
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(UIScreen.main.bounds.height)
        }
    }
}

class ddds: UIViewController {
    let pla = PlayViewww()
    override func viewDidLoad() {
        view.addSubview(pla)
        pla.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
