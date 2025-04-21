import UIKit

class SettingsViewController: UIViewController {
  
  // MARK: – Outlets
  @IBOutlet weak var focusDurationTextField: UITextField!
  @IBOutlet weak var breakDurationTextField: UITextField!
  @IBOutlet weak var saveButton: UIButton!

  // MARK: – Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Dark styling (as before)…
    overrideUserInterfaceStyle = .dark
    view.backgroundColor = .black
    navigationController?.navigationBar.barStyle = .black
    navigationController?.navigationBar.tintColor = .white
    
    // Show the current settings as minutes in the fields
    focusDurationTextField.text = String(Int(TimerSettings.workDuration / 60))
    breakDurationTextField.text = String(Int(TimerSettings.breakDuration / 60))
  }

  // MARK: – Actions
  @IBAction func saveTapped(_ sender: UIButton) {
    // 1) Read & validate focus minutes
    if let text = focusDurationTextField.text,
       let mins = Double(text),
       mins > 0 {
      TimerSettings.workDuration = mins * 60
    }

    // 2) Read & validate break minutes
    if let text = breakDurationTextField.text,
       let mins = Double(text),
       mins > 0 {
      TimerSettings.breakDuration = mins * 60
    }

    // 3) Pop back to the timer screen
    navigationController?.popViewController(animated: true)
  }
}
