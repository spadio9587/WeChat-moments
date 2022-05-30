#if !os(WASI)

    #if canImport(Foundation)
        import Foundation

        internal class NotificationCollector {
            private(set) var observedNotifications: [Notification]
            private let notificationCenter: NotificationCenter
            private let names: Set<Notification.Name>
            private var tokens: [NSObjectProtocol]

            required init(notificationCenter: NotificationCenter, names: Set<Notification.Name> = []) {
                self.notificationCenter = notificationCenter
                observedNotifications = []
                self.names = names
                tokens = []
            }

            func startObserving() {
                func addObserver(forName name: Notification.Name?) -> NSObjectProtocol {
                    return notificationCenter.addObserver(forName: name, object: nil, queue: nil) { [weak self] notification in
                        // linux-swift gets confused by .append(n)
                        self?.observedNotifications.append(notification)
                    }
                }

                if names.isEmpty {
                    tokens.append(addObserver(forName: nil))
                } else {
                    names.forEach { name in
                        tokens.append(addObserver(forName: name))
                    }
                }
            }

            deinit {
                tokens.forEach { token in
                    notificationCenter.removeObserver(token)
                }
            }
        }

        private let mainThread = pthread_self()

        private func _postNotifications<Out>(
            _ predicate: Predicate<[Notification]>,
            from center: NotificationCenter,
            names: Set<Notification.Name> = []
        ) -> Predicate<Out> {
            _ = mainThread // Force lazy-loading of this value
            let collector = NotificationCollector(notificationCenter: center, names: names)
            collector.startObserving()
            var once = false

            return Predicate { actualExpression in
                let collectorNotificationsExpression = Expression(
                    memoizedExpression: { _ in
                        collector.observedNotifications
                    },
                    location: actualExpression.location,
                    withoutCaching: true
                )

                assert(pthread_equal(mainThread, pthread_self()) != 0, "Only expecting closure to be evaluated on main thread.")
                if !once {
                    once = true
                    _ = try actualExpression.evaluate()
                }

                let actualValue: String
                if collector.observedNotifications.isEmpty {
                    actualValue = "no notifications"
                } else {
                    actualValue = "<\(stringify(collector.observedNotifications))>"
                }

                var result = try predicate.satisfies(collectorNotificationsExpression)
                result.message = result.message.replacedExpectation { message in
                    .expectedCustomValueTo(message.expectedMessage, actual: actualValue)
                }
                return result
            }
        }

        public func postNotifications<Out>(
            _ predicate: Predicate<[Notification]>,
            from center: NotificationCenter = .default
        ) -> Predicate<Out> {
            _postNotifications(predicate, from: center)
        }

        #if os(macOS)
            public func postDistributedNotifications<Out>(
                _ predicate: Predicate<[Notification]>,
                from center: DistributedNotificationCenter = .default(),
                names: Set<Notification.Name>
            ) -> Predicate<Out> {
                _postNotifications(predicate, from: center, names: names)
            }
        #endif

    #endif // #if canImport(Foundation)

#endif // #if !os(WASI)
