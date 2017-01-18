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

Proposed solution is based on child View Controller embedding. The idea: create Container View Controller in the application which is used in storyboards for navigation and in the framework maintain only child View Controllers which then be embedded into this Container View Controller. Container View Controller injects behavior directly to Child View Controllers so they don't know what is going on when user taps on a button. They just invoke behavior received from parent.

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


##Feature Toggling (work in progress)
This sample application contains very simple Feature Toggle support. More detailed information on this approach to toggles can be found here -> https://github.com/ktustanowski/feature-toggle-proof-of-concept.
