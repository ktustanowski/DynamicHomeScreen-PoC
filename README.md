# DynamicHomeScreen - Proof of Concept
Purpose of this application is to develop working solution that will enable fast and simple switching of View Controllers who share (more or less) similar functionality i.e. to support entirely different home screen layouts. Requirements:
- switchable View Controllers focus only on UI
- share functionalities
- minimal impact on existing codebase when adding View Controllers
- minimal effort when adding View Controllers
- done as separate framework

Use cases:
- switch View Controller from one layout to another (i.e. list & grid)
- use different View Controller based on Feature Toggling or configuration
- easy multiple View Controller support

##Solution overview
The simplest solution is to have multiple View Controllers and just add them to the storyboard and in runtime choose which one to be used using segues, but:
- all segues have to be added for every View Controller
- needs shared Storyboard updates when adding new View Controller
- code duplication even if View Controllers share most of it
- many steps to remember when adding new View Controller
- harder to move to framework

Proposed solution is based on Child View Controller embedding. The idea: create Container View Controller in the application which is used in storyboards for navigation and in the framework maintain only Child View Controllers which then be embedded into this Container View Controller. Container View Controller injects behavior directly to Child View Controllers so they don't know what is going on when user taps on a button. They just invoke behavior received from parent.

Example:

Child View Controller implements HomeActions protocol, which gathers all actions that can be made on Home screen. 
```swift
public protocol HomeActions: class {    
    var longSelected: ((_ identifier: HomeItem)->())? { get set }
    var shortSelected: ((_ identifier: HomeItem)->())? { get set }
    var streamSelected: ((_ identifier: HomeItem)->())? { get set }
    var replaceWith: ((_ viewController: UIViewController)->())? { get set }
    var settingsSelected: (()->())? { get set }
}
```
Layouts and visuals may change radically between View Controllers but they always know what actions mean what. Then in View Controllers we call this closures when needed:

```swift
override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let selectedItem = viewModel?.items?[indexPath.row] else { return }
        
    longSelected?(selectedItem)
}
```

In this View Controller tapping on a cell means that long content was selected. In another long content may be requested by tapping on item in collection view etc. This View Controllers know how to translate actions to correct closures, its their responsibility, but they don't know what will happen next. Container View Controller is aware of its surroundings and expectations thats why its injecting correct behaviors right on the start:
```swift
guard let actionViewController = viewController as? HomeActions else { return }

actionViewController.longSelected = { [weak self] item in
    self?.performSegue(withIdentifier: SegueIdentifier.homeToLong.rawValue, sender: item)
}
```

Thanks to this approach Container View Controller can gather data for its children, decorate them with correct behaviors to handle user actions, analytics reporting etc. so they don't have to know about this logic at all. Yep - this is a bad parent who wants his children to be as dumb as possible 😱

![alt text](https://github.com/ktustanowski/DynamicHomeScreen-PoC/blob/master/embedded.navigation.png "Embedded navigation in Storybaord")

##It's all about protocols
Dumb children is one but this parent also doesn't want to know which child is which. He doesn't care whether he speaks to View Controller with table view or collection view. He shields children from outside world but doesn't want to know more than necessary about them. To achieve this we use protocols:
**Home Actions** which is all about stuff that can be done on Home:
```swift
public protocol HomeActions: class {
    var longSelected: ((_ identifier: HomeItem)->())? { get set }
    var shortSelected: ((_ identifier: HomeItem)->())? { get set }
    var streamSelected: ((_ identifier: HomeItem)->())? { get set }
    var replaceWith: ((_ viewController: UIViewController)->())? { get set }
    var settingsSelected: (()->())? { get set }
}
```
Which in Container View controller is just about injecting behaviors:
```swift
guard let actionViewController = viewController as? HomeActions else { return }
        
actionViewController.settingsSelected = { [weak self] in
    self?.performSegue(withIdentifier: SegueIdentifier.homeToSettings.rawValue, sender: self)
}
        
actionViewController.longSelected = { [weak self] item in
    self?.performSegue(withIdentifier: SegueIdentifier.homeToLong.rawValue, sender: item)
}
        
actionViewController.shortSelected = { [weak self] item in
    self?.performSegue(withIdentifier: SegueIdentifier.homeToShort.rawValue, sender: item)
}
        
actionViewController.streamSelected = { [weak self] item in
    self?.performSegue(withIdentifier: SegueIdentifier.homeToStream.rawValue, sender: item)
}
        
actionViewController.replaceWith = { [weak self] newViewController in
    guard let viewController = self?.childViewControllers.first else { return }

    self?.replace(viewController: viewController, with: newViewController)
    self?.loadData()
}
```
**HomeReporting** which gathers all stuff used for reporting:
```swift
public protocol HomeReporting: class {
    var didHorizontalSwipe: (()->())? { get set }
    var didLaunch: (()->())? { get set }
}
```
Which again is only about injecting behaviors:
```swift
guard let reportingViewController = viewController as? HomeReporting else { return }
        
reportingViewController.didLaunch = {
    print("Report: Did Launch")
}
        
reportingViewController.didHorizontalSwipe = {
    print("Report: Did Horizontal Swipe")
}
```
**HasViewModel** so parent can pass data to children:
```swift
public protocol HasViewModel: class {    
    var baseViewModel: BaseHomeViewModel? { get }    
}
```
**Refreshable** so parent can reload its child UI when new data is passed:
```swift
public protocol Refreshable {
    func refresh()
}

```
This time it's a bit different because we pass items to concrete Child View Controller view model and after this we refresh the UI:
```swift
ContentProvider.loadContent { [weak self] contents in
    guard
        let contents = contents,
        let viewControllerWithViewModel = self?.childViewControllers.first as? HasViewModel,
        let refreshableViewController = self?.childViewControllers.first as? Refreshable
        else { return }
            
viewControllerWithViewModel.baseViewModel?.items = contents.map({ $0 as HomeItem })
refreshableViewController.refresh()
}
```
We could create the whole view model and set it to View Controller but then we would have to know what view model to create  because every child view controller has its own subclass of BaseHomeViewModel.

Long story short -  Container View Controller uses 
```swift
public static func create(withStyle style: Int) -> UIViewController?
```
function of **HomeFactory** to get concrete Child View Controller as UIViewController and behaviors and data are injected for all protocols that child is implementing.

##Data flow
In order to display data in Child View Controllers they have their own view models which require items that conform to **HomeItem** protocol:
```swift
public protocol HomeItem {
    var identifier: String { get }
    var title: String { get }
    var description: String? { get }
}
```
Thanks to this we only have to implement this protocol in regular application models to be able to use them in the process:
```swift
/* contents is application model struct */
viewControllerWithViewModel.baseViewModel?.items = contents.map({ $0 as HomeItem })
```
Whenever user make action that will be handled by the application and requires more context an item will be passed to the closure. This item will be the same application model that was passed in the beginning and wolud need only casting to unleash its full potential:
```swift
actionViewController.streamSelected = { [weak self] item in
    self?.performSegue(withIdentifier: SegueIdentifier.homeToStream.rawValue, sender: item)
}
[...]
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier != SegueIdentifier.homeToSettings.rawValue else { return }
        
    if let destination = segue.destination as? HasContent,
        let content = sender as? Content {
        destination.content = content
    }
}
```
HasContent protocol is part of the sample application, not the framework, and its just created for convnience.

##Feature Toggling (work in progress)
This sample application contains very simple Feature Toggle support. More detailed information on this approach to toggles can be found here -> https://github.com/ktustanowski/feature-toggle-proof-of-concept.
