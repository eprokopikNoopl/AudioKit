// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/
// This file was auto-autogenerated by scripts and templates at http://github.com/AudioKit/AudioKitDevTools/

import AVFoundation
import CAudioKit

/// The output for reson appears to be very hot, so take caution when using this module.
public class ResonantFilter: Node, AudioUnitContainer, Toggleable {

    /// Unique four-letter identifier "resn"
    public static let ComponentDescription = AudioComponentDescription(effect: "resn")

    /// Internal type of audio unit for this node
    public typealias AudioUnitType = InternalAU

    /// Internal audio unit 
    public private(set) var internalAU: AudioUnitType?

    // MARK: - Parameters

    /// Specification details for frequency
    public static let frequencyDef = NodeParameterDef(
        identifier: "frequency",
        name: "Center frequency of the filter, or frequency position of the peak response.",
        address: akGetParameterAddress("ResonantFilterParameterFrequency"),
        range: 100.0 ... 20_000.0,
        unit: .hertz,
        flags: .default)

    /// Center frequency of the filter, or frequency position of the peak response.
    @Parameter public var frequency: AUValue

    /// Specification details for bandwidth
    public static let bandwidthDef = NodeParameterDef(
        identifier: "bandwidth",
        name: "Bandwidth of the filter.",
        address: akGetParameterAddress("ResonantFilterParameterBandwidth"),
        range: 0.0 ... 10_000.0,
        unit: .hertz,
        flags: .default)

    /// Bandwidth of the filter.
    @Parameter public var bandwidth: AUValue

    // MARK: - Audio Unit

    /// Internal Audio Unit for ResonantFilter
    public class InternalAU: AudioUnitBase {
        /// Get an array of the parameter definitions
        /// - Returns: Array of parameter definitions
        public override func getParameterDefs() -> [NodeParameterDef] {
            [ResonantFilter.frequencyDef,
             ResonantFilter.bandwidthDef]
        }

        /// Create the DSP Refence for this node
        /// - Returns: DSP Reference
        public override func createDSP() -> DSPRef {
            akCreateDSP("ResonantFilterDSP")
        }
    }

    // MARK: - Initialization

    /// Initialize this filter node
    ///
    /// - Parameters:
    ///   - input: Input node to process
    ///   - frequency: Center frequency of the filter, or frequency position of the peak response.
    ///   - bandwidth: Bandwidth of the filter.
    ///
    public init(
        _ input: Node,
        frequency: AUValue = 4_000.0,
        bandwidth: AUValue = 1_000.0
        ) {
        super.init(avAudioNode: AVAudioNode())

        instantiateAudioUnit { avAudioUnit in
            self.avAudioUnit = avAudioUnit
            self.avAudioNode = avAudioUnit

            guard let audioUnit = avAudioUnit.auAudioUnit as? AudioUnitType else {
                fatalError("Couldn't create audio unit")
            }
            self.internalAU = audioUnit

            self.frequency = frequency
            self.bandwidth = bandwidth
        }
        connections.append(input)
    }
}
