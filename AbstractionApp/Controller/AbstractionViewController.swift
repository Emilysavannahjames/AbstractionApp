//
//  AbstractionViewController.swift
//  AbstractionApp
//
//  Created by James, Emily on 12/6/18.
//  Copyright © 2018 CTEC. All rights reserved.
//

import UIKit

class AbstractionViewController: UIPageViewController, UIPageViewControllerDataSource
{
    //MARK:- Data members
    private lazy var orderedAbstractionViews : [UIViewController] =
    {
        return [
            self.newAbstractionViewController(abstractionLevel: "Swift"),
            self.newAbstractionViewController(abstractionLevel: "Block"),
            self.newAbstractionViewController(abstractionLevel: "ByteCode"),
            self.newAbstractionViewController(abstractionLevel: "Binary"),
            self.newAbstractionViewController(abstractionLevel: "LogicalGate")
            ]
    }()
    
    //MARK: Helper method to retrieve the correct ViewController based on the data member
    private func newAbstractionViewController(abstractionLevel : String) -> UIViewController
    {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(abstractionLevel)ViewController")
    }
    
    //MARK:- Lifecycle methods
    public override func viewDidLoad()
    {
        super.viewDidLoad()
        dataSource = self
        
        if let firstViewController = orderedAbstractionViews.first
        {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    //MARK:- Datasource required methods
    //Swipe Left
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        guard let viewControllerIndex = orderedAbstractionViews.index(of: viewController)
        else
        {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0
        else
        {
            return orderedAbstractionViews.last
        }
        
        guard orderedAbstractionViews.count > previousIndex
        else
        {
            return nil
        }
        
        return orderedAbstractionViews[previousIndex]
    }
    
    //Swipe Right
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        guard let viewControllerIndex = orderedAbstractionViews.index(of: viewController)
            else
        {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex >= 0
            else
        {
            return nil
        }
        
        guard nextIndex < orderedAbstractionViews.count
            else
        {
            return orderedAbstractionViews.first
        }
        
        return orderedAbstractionViews[nextIndex]
    }
    
    //MARK:- Optional Support for the dots in the UIPageViewController
    public func presentationCount(for pageViewController: UIPageViewController) -> Int
    {
        return orderedAbstractionViews.count
    }
    
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int
    {
        guard let firstViewController = viewControllers?.first, let firstViewControllerIndex =
            orderedAbstractionViews.index(of: firstViewController)
        else
        {
            return 0
        }
        
        return firstViewControllerIndex
    }

}
