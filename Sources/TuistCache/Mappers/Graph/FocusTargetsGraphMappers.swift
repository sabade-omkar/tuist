import Foundation
import TSCBasic
import TuistCore
import TuistGraph

/// `FocusTargetsGraphMappers` is used to filter out some targets and their dependencies and tests targets.
public final class FocusTargetsGraphMappers: GraphMapping {
    /// The targets name to be kept as non prunable with their respective dependencies and tests targets
    let includedTargets: Set<String>

    public init(includedTargets: Set<String>) {
        self.includedTargets = includedTargets
    }

    public func map(graph: Graph) throws -> (Graph, [SideEffectDescriptor]) {
        let graphTraverser = GraphTraverser(graph: graph)
        var graph = graph
        /// Tests targets from external projects that opted in for unit testing
        /// TODO: Can we include opt-in projects array to in parameters to this function avoid traversing all external projects and their targets?
        let externalTestsTargets: Set<String> = Set(
            graph
                .projects
                .values
                .flatMap { project in
                    project
                        .targets
                        .filter { target in
                            target.product == .unitTests || target.product == .uiTests
                        }.map(\.name)
                }
        )
        let includedTargets = includedTargets.isEmpty ?
            externalTestsTargets.union(graphTraverser.allInternalTargets().map(\.target.name)) :
            includedTargets

        let userSpecifiedSourceTargets = graphTraverser.allTargets().filter { includedTargets.contains($0.target.name) }
        let filteredTargets = Set(try topologicalSort(
            Array(userSpecifiedSourceTargets),
            successors: { graphTarget in
                Array(graphTraverser.directTargetDependencies(path: graphTarget.path, name: graphTarget.target.name))
            }
        ))

        graphTraverser.allTargets().forEach { graphTarget in
            if !filteredTargets.contains(graphTarget) {
                var target = graphTarget.target
                target.prune = true
                graph.targets[graphTarget.path]?[target.name] = target
            }
        }
        return (graph, [])
    }
}
