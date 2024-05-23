import Foundation
import XCTest

@testable import TuistSupport

open class TuistUnitTestCase: TuistTestCase {
    public var system: MockSystem!
    public var developerEnvironment: MockDeveloperEnvironment!
    public var xcodeController: MockXcodeController!

    override open func setUp() {
        super.setUp()
        // System
        system = MockSystem()
        System.shared = system

        // Developer environment
        developerEnvironment = MockDeveloperEnvironment()
        DeveloperEnvironment.shared = developerEnvironment
    }

    override open func tearDown() {
        // System
        system = nil
        System.shared = System()

        // Environment
        environment = nil
        Environment.shared = Environment()

        // Developer environment
        developerEnvironment = nil
        DeveloperEnvironment.shared = DeveloperEnvironment()

        super.tearDown()
    }
}
