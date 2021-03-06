require "./protocol/*"

module Kafka::Protocol
  # See `Kafka::Api` for available protocol names
  protocol Produce, 0
  protocol Produce, 1
  protocol Produce, 3
  protocol Produce, 5
  protocol Fetch, 0
  protocol Fetch, 6
  protocol ListOffsets, 0
  protocol Metadata, 0
  protocol Metadata, 5
  protocol Heartbeat, 0
  protocol InitProducerId, 0
  protocol ApiVersions, 0
  protocol ApiVersions, 1
end
