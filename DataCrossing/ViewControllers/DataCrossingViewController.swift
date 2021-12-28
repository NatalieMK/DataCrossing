//
//  ViewController.swift
//  DataCrossing
//
//  Created by Natalie on 11/16/21.
//

import UIKit

class DataCrossingViewController: UIViewController {
    
    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    
    let menuVC = MenuViewController()
    let islandVC = IslandDataViewController()
    lazy var museumVC = MuseumViewController()
    
    let tabBarVC: UITabBarController = {
        let tabBar = UITabBarController()
        tabBar.view.backgroundColor = .acWhite
        tabBar.modalPresentationStyle = .fullScreen
        return tabBar
    }()
    
    lazy var museumTabBarVC: UITabBarController = {
        let tabBar = UITabBarController()
        tabBar.view.backgroundColor = .acWhite
        return tabBar
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .acWhite
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let islandData = IslandDataController()
        var isUserIsland = false
        do {
            isUserIsland = try islandData.isSavedIsland()
            if !(isUserIsland){
                loadCreateIsland()
            } else {
                loadChildVCs()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func loadCreateIsland(){
        let newIslandVC = CreateIslandViewController()
        newIslandVC.islandDelegate = self
        newIslandVC.modalPresentationStyle = .fullScreen
        present(newIslandVC, animated: false)
    }
    
    private func loadChildVCs() {
        menuVC.chosenItemDelegate = self
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        islandVC.menuDelegate = self

        let islandNavVC = UINavigationController(rootViewController: islandVC)
        tabBarVC.setViewControllers([islandNavVC], animated: false)
        islandNavVC.title = "Island"
        islandNavVC.tabBarItem.image = UIImage(systemName: "house.fill")
        
        addChild(tabBarVC)
        view.addSubview(tabBarVC.view)
        tabBarVC.didMove(toParent: self)
    }
    
}

extension DataCrossingViewController: CreateIslandDelegate {
    
    func didCreateIsland(){
        loadChildVCs()
    }
}

extension DataCrossingViewController: MenuViewControllerDelegate {
    func didSelect(menuItem: MenuViewController.MenuOptions) {
        switch menuItem {
        case .island:
            self.backToIsland()
        case .museum:
            self.addMuseum()
        }
    }
    
    func backToIsland() {
        museumTabBarVC.view.removeFromSuperview()
        museumTabBarVC.didMove(toParent: nil)
        islandVC.reloadData()
        toggleMenu(completion: nil)
    }
    
    func addMuseum() {
        let museumNavVC = UINavigationController(rootViewController: museumVC)
        let bugVC = UINavigationController(rootViewController: BugViewController())
        let fishVC = UINavigationController(rootViewController: FishViewController())
        let seaVC = UINavigationController(rootViewController: SeaCreatureViewController())
        let artVC = UINavigationController(rootViewController: ArtViewController())
        
        museumVC.menuDelegate = self
        museumTabBarVC.setViewControllers([museumNavVC, bugVC, fishVC, seaVC], animated: false)
        addChild(museumTabBarVC)
        museumTabBarVC.view.frame = tabBarVC.view.frame
        museumTabBarVC.view.frame.origin.x = self.tabBarVC.view.frame.origin.x
        view.addSubview(museumTabBarVC.view)
        museumTabBarVC.didMove(toParent: self)
        museumNavVC.tabBarItem.image = UIImage(systemName: "building.columns")
        bugVC.tabBarItem.image = UIImage(systemName: "ladybug")
        fishVC.tabBarItem.image = UIImage(systemName: "tortoise")
        seaVC.tabBarItem.image = UIImage(systemName: "allergens")

        toggleMenu(completion: nil)
    }
}

extension DataCrossingViewController: IslandDataViewControllerDelegate, MuseumViewControllerDelegate {
    
    func didTapMenuButton() {
        toggleMenu(completion: nil)
    }
    func toggleMenu(completion: (() -> Void)?){
        switch menuState {
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.tabBarVC.view.frame.origin.x = self.islandVC.view.frame.size.width - 100
                self.museumTabBarVC.view.frame.origin.x = self.museumVC.view.frame.size.width - 100
            } completion: {[weak self] done in
                if done{
                    self?.menuState = .opened
                }
            }
        case .opened:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                
                self.tabBarVC.view.frame.origin.x = 0
                self.museumTabBarVC.view.frame.origin.x = 0
                
            } completion: { [weak self] done in
                if done{
                    self?.menuState = .closed
                    DispatchQueue.main.async {
                        completion?()
                    }
                
                }
            }
        }
    }
}


