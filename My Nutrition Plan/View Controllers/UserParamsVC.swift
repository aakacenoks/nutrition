//
//  UserParamsVC.swift
//  My Nutrition Plan
//
//  Created by Andris Akačenoks on 15/06/2018.
//  Copyright © 2018 Andris Akačenoks. All rights reserved.
//

import UIKit

class UserParamsVC: UIPageViewController, UIPageViewControllerDataSource {
    
    static var paramsEntered: Bool = false
    
    lazy var pageControllerList:[UIViewController] = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let page1 = storyboard.instantiateViewController(withIdentifier: "GenderVC")
        let page2 = storyboard.instantiateViewController(withIdentifier: "AgeVC")
        let page3 = storyboard.instantiateViewController(withIdentifier: "HeightVC")
        let page4 = storyboard.instantiateViewController(withIdentifier: "WeightVC")

        return [page1, page2, page3, page4]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated:true)
        self.dataSource = self
        
        if let firstViewController = pageControllerList.first{
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }

    }

    // Before
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let pageIndex = pageControllerList.index(of: viewController) else { return nil }
        let previousIndex = pageIndex - 1
        guard previousIndex >= 0 else { return nil }
        guard pageControllerList.count > previousIndex else { return nil }
        
        return pageControllerList[previousIndex]
    }
    
    
    // After
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let pageIndex = pageControllerList.index(of: viewController) else { return nil }
        let nextIndex = pageIndex + 1
        guard pageControllerList.count != nextIndex else {return nil}
        guard pageControllerList.count > nextIndex else {return nil}
        
        return pageControllerList[nextIndex]
    }
    


}
