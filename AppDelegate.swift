import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        NSApp.servicesProvider = self
    }

    @objc func checkSpellingOnline(_ pboard: NSPasteboard, userData: String, error: AutoreleasingUnsafeMutablePointer<NSString?>) {
        guard let items = pboard.pasteboardItems,
              let string = items.first?.string(forType: .string) else { return }
        
        let encodedString = string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? string
        let urlString = "https://www.google.com/search?q=\(encodedString)"
        
        if let url = URL(string: urlString) {
            NSWorkspace.shared.open(url)
        }
        
        // Terminate the app after the service is used
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            NSApp.terminate(nil)
        }
    }
}
