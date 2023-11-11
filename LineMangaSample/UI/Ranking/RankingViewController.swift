//
//  RankingViewController.swift
//  LineMangaSample
//
//  Created by 鈴木楓香 on 2023/11/10.
//

import UIKit

final class RankingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        configureHierarchy()
    }
}

extension RankingViewController {
    private func configureHierarchy() {
        navigationItem.title = "ランキング"
        navigationController?.addCommonButton(to: self)
    }
}
