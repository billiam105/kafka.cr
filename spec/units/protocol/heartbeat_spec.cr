require "./spec_helper"

describe Kafka::Protocol::HeartbeatRequestV0 do
  it "to_kafka" do
    req = Kafka::Protocol::HeartbeatRequestV0.new(0, "x", "y", -1, "cr")
    expect(req.to_slice).to eq(bytes(0, 12, 0, 0, 0, 0, 0, 0, 0, 1, 120, 0, 1, 121, 255, 255, 255, 255, 0, 2, 99, 114))
  end
end

describe Kafka::Protocol::HeartbeatResponseV0 do
  it "from_kafka" do
    res = Kafka::Protocol::HeartbeatResponseV0.from_kafka(bytes(0, 0, 0, 0, 0, 16))
    expect(res.correlation_id).to eq(0)
    expect(res.error_code).to eq(16)
  end
end
