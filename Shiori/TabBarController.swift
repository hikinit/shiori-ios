//
//  MainNavigationController.swift
//  Shiori
//
//  Created by hikinit on 24/08/20.
//

import UIKit

class TabBarController: UITabBarController {
  override func viewDidLoad() {
    super.viewDidLoad()

    setupViewControllers()
  }

  private func setupViewControllers() {
    let seriesVC: SeriesListViewController = SeriesListViewController.loadFromStoryboard()
    seriesVC.title = SeriesListViewController.TabConfiguration.title
    seriesVC.tabBarItem = SeriesListViewController.TabConfiguration.item

    let controllers = [seriesVC]

    viewControllers = controllers.map {
      let navController = UINavigationController(rootViewController: $0)
      navController.navigationBar.prefersLargeTitles = true
      navController.view.backgroundColor = .systemBackground

      return navController
    }
  }
}
