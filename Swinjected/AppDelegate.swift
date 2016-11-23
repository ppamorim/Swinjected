import UIKit
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  /**
   This container has the same behavior of the Dagger's component. Just
   to create the prove the instance needed to configure the ViewController
   structure.
   */
  let container = Container() { container in
    
    //Generate the component for the interactor.
    container.register(HomeInteractor.self) { _ in HomeInteractorImpl() }
    
    //Generate the component for the presenter and attach the interactor component.
    container.register(HomePresenter.self) { r in
      let presenter = HomePresenterImpl()
      presenter.homeInteractor = r.resolve(HomeInteractor.self)
      return presenter
    }
  }

  //Application view :3
  var window: UIWindow?

  //Application finishes the loading and prepare the view.
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    buildView()
    return true
  }
  
  /**
   Load the ViewController on the application window.
   After the container creation, this method will inject the
   dependency needed by the class, using the instance of this
   container. The instance of the interactor was loaded too.
   */
  func buildView() {
    let bounds = UIScreen.main.bounds
    window = UIWindow(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height))
    window?.backgroundColor = UIColor.white
    window?.rootViewController = HomeViewController(container.resolve(HomePresenter.self))
    window?.makeKeyAndVisible()
  }

}

