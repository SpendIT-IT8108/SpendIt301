//
//  WalkthroughPVC.swift
//  SpendIt301
//
//  Created by Nawra Alhaji on 02/01/2023.
//

import UIKit

class WalkthroughPVC: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    

    

    
    //define array of walkthrough pages to be able to display them all
    var arrayOfContainers = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //instainte instances
        let vc1 = self.storyboard?.instantiateViewController(withIdentifier: "page1")
        
        
        let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "page2")
        
        let vc3 = self.storyboard?.instantiateViewController(withIdentifier: "page3")
        
        let vc4 = self.storyboard?.instantiateViewController(withIdentifier: "page4")
        
        
        //force unwrap to all view controllers and add them to the array
        arrayOfContainers.append(vc1!)
        arrayOfContainers.append(vc2!)
        arrayOfContainers.append(vc3!)
        arrayOfContainers.append(vc4!)
  

    
    }
    
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        //use gaurd to be able to access the variable
        guard let currentIndex = arrayOfContainers.firstIndex(of: viewController) else{
            return nil
        }
        
        //if the first page is the crrent one? don't display a dot before it
        let previousIndex = currentIndex - 1
        guard previousIndex >= 0 else{
            return nil
        }
        
        return arrayOfContainers[previousIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        //check the current page and store it in the current index
        guard let currentIndex = arrayOfContainers.firstIndex(of: viewController) else{
            return nil
        }
        
        //transfer to the next page
        let afterIndex = currentIndex + 1
        
        //check if the after index is less than the size of the array
        guard afterIndex < arrayOfContainers.count else{
            return nil
        }
        
        //return the next page
        return arrayOfContainers[afterIndex]
        
    }



}

