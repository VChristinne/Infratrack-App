import EventKit

class CalendarManager: ObservableObject {
    static let shared = CalendarManager()
    private let store = EKEventStore()
    
    @Published var eventAddedSuccessfully: Bool = false
    @Published var didError: Bool = false
    @Published var errorMessage: String = ""
    
    func requestPermission(completion: @escaping (Bool) -> Void) {
        store.requestFullAccessToEvents { granted, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error requesting calendar access: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                completion(granted)
            }
        }
    }
    
    func addEvent(title: String, date: Date) {
        requestPermission { granted in
            guard granted else {
                self.didError = true
                self.errorMessage = "Permission not granted"
                return
            }
            
            let event = EKEvent(eventStore: self.store)
            event.title = title
            event.startDate = date
            event.endDate = date.addingTimeInterval(3600) // 1h
            event.calendar = self.store.defaultCalendarForNewEvents
            
            do {
                try self.store.save(event, span: .thisEvent)
                self.eventAddedSuccessfully = true
            } catch let error {
                self.didError = true
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
