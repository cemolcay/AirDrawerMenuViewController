AirDrawerMenuViewController
===========================

legendary airbnb drawer menu in swift

Demo
----

![alt tag](https://raw.githubusercontent.com/cemolcay/AirDrawerMenuViewController/master/demo.gif)

Install
-------

##### Manual

Copy & paste `AirDrawerMenuViewController` folder into your project.

##### Cocoapods

``` ruby
	pod 'AirDrawerMenuViewController', '~> 0.1'
```

Usage
-----

Create a subclass of `AirDrawerMenuViewController` and implement its `AirDrawerMenuViewControllerDataSource`.

``` swift
    
    func AirDrawerMenuViewControllerNumberOfViewControllersInContentView () -> Int {
        return containerViewControllers.count
    }
    
    func AirDrawerMenuViewController (viewControllerAtIndex: Int) -> UIViewController {
        return containerViewControllers[viewControllerAtIndex]
    }
    
```


In `viewDidLoad` method, assign its `leftMenuViewController` and set its `dataSource` as self.  

``` swift
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...3 {
            containerViewControllers.append(vc ("\(i) vc"))
        }
        
        leftMenuViewController = UIStoryboard (name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LeftMenuViewController") as! LeftMenuViewController
        dataSource = self
    }
```


In `viewDidAppear:` method, call `reloadDrawer()`.

``` swift
    override func viewDidAppear(animated: Bool) {
        reloadDrawer()
    }    
```

The Drawer
----------

UIViewController's has `airDrawerMenu` property.
You can call `self.airDrawerMenu.openMenu()` and `self.airDrawerMenu.closeMenu()` for opening and closing drawer.

Also you can write custom animations for your `AirDrawerMenuLeftViewController`.

AirDrawerMenuLeftViewController
-------------------------------

It's an abstract class with its protocol methods.

```swift

protocol AirDrawerMenuLeftViewControllerDelegate {
    
    func reloadLeftMenu ()
    func openLeftMenuAnimation (completion: (() -> Void)?)
    func closeLeftMenuAnimation (completion: (() -> Void)?)
    
}

class AirDrawerMenuLeftViewController: UIViewController, AirDrawerMenuLeftViewControllerDelegate {

    
    // MARK: AirDrawerMenuLeftViewControllerDelegate
    // Override these methods in your subclass

    func reloadLeftMenu() {
        
    }
    
    func openLeftMenuAnimation(completion: (() -> Void)?) {
        
    }
    
    func closeLeftMenuAnimation(completion: (() -> Void)?) {
        
    }
}

```

You can sublass it and write you own opening & closing animations for left menu.
Also you can notify your left menu when `AirMenuDrawerViewController` `reload`s itself.
