//
//  RecommendationViewController.swift
//  LineMangaSample
//
//  Created by 鈴木楓香 on 2023/11/10.
//

import UIKit

final class RecommendationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        configureHierarchy()
    }
}

extension RecommendationViewController {
    private func configureHierarchy() {
        navigationItem.title = "おすすめ"
        navigationController?.addCommonButton(to: self)
    }
}
