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
    var islands = [IslandData]()
    lazy var museumVC = MuseumViewController()
    lazy var critterVC = CritterInformationViewController()
    
    let weatherLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    lazy var weatherVC = WeatherViewController(collectionViewLayout: weatherLayout)

    
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
    
    lazy var weatherTabBarVC: UITabBarController = {
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
        let islandData = IslandDataController(mainContext: CoreDataStack.shared.mainContext)
        var isUserIsland = false
        do {
            isUserIsland = try islandData.isSavedIsland()
            if !(isUserIsland){
                loadCreateIsland()
            } else {
                updateIsland()
                loadChildVCs()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func updateIsland(){

        let islandData = IslandDataController(mainContext: CoreDataStack.shared.mainContext)
        let islandInit = islandData.getIslandInitDate()

        let createdDate = islandData.getIslandCreatedAtDate()
        let interval = Date().timeIntervalSince(createdDate)
        let newDate = Date.init(timeInterval: interval, since: islandInit)
        do {
         try islandData.updateIslandDate(newDate: newDate)
        } catch {}
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
        case .weather:
            self.addWeather()
        }
    }
    
    func backToIsland() {
        museumTabBarVC.view.removeFromSuperview()
        museumTabBarVC.didMove(toParent: nil)
        weatherTabBarVC.view.removeFromSuperview()
        weatherTabBarVC.didMove(toParent: nil)
        islandVC.reloadData()
        toggleMenu(completion: nil)
    }
    
    func addWeather() {
        
        let weatherNavVC = PortraitLockedNavigationController(rootViewController: weatherVC)
        
        weatherVC.weatherDelegate = self
        weatherTabBarVC.setViewControllers([weatherNavVC], animated: false)
        addChild(weatherTabBarVC)
        weatherTabBarVC.view.frame = tabBarVC.view.frame
        weatherVC.collectionView.sizeToFit()
        weatherTabBarVC.view.frame.origin.x = self.tabBarVC.view.frame.origin.x
        view.addSubview(weatherTabBarVC.view)
        weatherTabBarVC.didMove(toParent: self)

        toggleMenu(completion: nil)
    }
    
    func addMuseum() {
        let museumNavVC = UINavigationController(rootViewController: museumVC)
        let bugVC = BugViewController()
        let bugNavVC = UINavigationController(rootViewController: bugVC)
        let fishVC = FishViewController()
        let fishNavVC = UINavigationController(rootViewController: fishVC)
        let seaVC = SeaCreatureViewController()
        let seaNavVC = UINavigationController(rootViewController: seaVC)
        
        museumVC.menuDelegate = self
        fishVC.fishDelegate = self
        bugVC.bugDelegate = self
        seaVC.creatureDelegate = self
        
        museumTabBarVC.setViewControllers([museumNavVC, bugNavVC, fishNavVC, seaNavVC], animated: false)
        addChild(museumTabBarVC)
        museumTabBarVC.view.frame = tabBarVC.view.frame
        museumTabBarVC.view.frame.origin.x = self.tabBarVC.view.frame.origin.x
        view.addSubview(museumTabBarVC.view)
        museumTabBarVC.didMove(toParent: self)
        museumNavVC.tabBarItem.image = UIImage(systemName: "building.columns")
        bugNavVC.tabBarItem.image = UIImage(systemName: "ladybug")
        fishNavVC.tabBarItem.image = UIImage(systemName: "tortoise")
        seaNavVC.tabBarItem.image = UIImage(systemName: "allergens")

        toggleMenu(completion: nil)
    }
}

extension DataCrossingViewController: FishViewControllerDelegate, BugViewControllerDelegate, SeaCreatureViewControllerDelegate {
    
    func didTapFish(fish: Fish, index: Int) {
        critterVC.critter = fish
        critterVC.index = index
        present(critterVC, animated: true)
    }
    
    func didTapBug(bug: Bug, index: Int){
        critterVC.critter = bug
        critterVC.index = index
        present(critterVC, animated: true)
    }
    
    func didTapSeaCreature(creature: SeaCreature, index: Int) {
        critterVC.critter = creature
        critterVC.index = index
        present(critterVC, animated: true)
    }
}

extension DataCrossingViewController: IslandDataViewControllerDelegate, MuseumViewControllerDelegate, WeatherViewControllerDelegate {
    
    func didTapMenuButton() {
        toggleMenu(completion: nil)
    }
    func toggleMenu(completion: (() -> Void)?){
        switch menuState {
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.tabBarVC.view.frame.origin.x = self.islandVC.view.frame.size.width - 100
                self.museumTabBarVC.view.frame.origin.x = self.museumVC.view.frame.size.width - 100
                self.weatherTabBarVC.view.frame.origin.x = self.weatherVC.view.frame.size.width - 100
            } completion: {[weak self] done in
                if done{
                    self?.menuState = .opened
                }
            }
        case .opened:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.tabBarVC.view.frame.origin.x = 0
                self.museumTabBarVC.view.frame.origin.x = 0
                self.weatherTabBarVC.view.frame.origin.x = 0
               
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


