require "./spec_helper"

describe Kafka::Commands::Produce do
  subject!(kafka) { Kafka.new }
  after { kafka.close }

  # [prepare]
  # kafka-topics.sh --zookeeper localhost:2181 --create --topic 'tmp' --replication-factor=1 --partitions 1

  # TODO: this test expects "tmp" topic exists
  describe "#produce(v0)" do
    it "returns error?=true when topic is missing" do
      mes = kafka.produce("_tmp", "v0")
      expect(mes).to be_a(Kafka::Protocol::ProduceV0Response)
      expect(mes.error?).to eq(true)
    end

    it "accepts string" do
      mes = kafka.produce("tmp", "v0")
      expect(mes).to be_a(Kafka::Protocol::ProduceV0Response)
      expect(mes.error?).to eq(false)
    end

    it "accepts strings" do
      mes = kafka.produce("tmp", ["v0#1", "v0#2"])
      expect(mes).to be_a(Kafka::Protocol::ProduceV0Response)
      expect(mes.error?).to eq(false)
    end

    it "accepts binary" do
      mes = kafka.produce("tmp", bytes(0,1,2))
      expect(mes).to be_a(Kafka::Protocol::ProduceV0Response)
      expect(mes.error?).to eq(false)
    end

    it "accepts binaries" do
      mes = kafka.produce("tmp", [bytes(0,1,2), bytes(3,4)])
      expect(mes).to be_a(Kafka::Protocol::ProduceV0Response)
      expect(mes.error?).to eq(false)
    end
  end

  describe "#produce(v1)" do
    it "returns error?=true when topic is missing" do
      mes = kafka.produce("_tmp", "v1", version: 1)
      expect(mes).to be_a(Kafka::Protocol::ProduceV1Response)
      expect(mes.error?).to eq(true)
    end

    it "accepts string" do
      mes = kafka.produce("tmp", "v1", version: 1)
      expect(mes).to be_a(Kafka::Protocol::ProduceV1Response)
      expect(mes.error?).to eq(false)
    end

    it "accepts strings" do
      mes = kafka.produce("tmp", ["v1#1", "v1#2"], version: 1)
      expect(mes).to be_a(Kafka::Protocol::ProduceV1Response)
      expect(mes.error?).to eq(false)
    end

    it "accepts binary" do
      mes = kafka.produce("tmp", bytes(0,1,2), version: 1)
      expect(mes).to be_a(Kafka::Protocol::ProduceV1Response)
      expect(mes.error?).to eq(false)
    end

    it "accepts binaries" do
      mes = kafka.produce("tmp", [bytes(0,1,2), bytes(3,4)], version: 1)
      expect(mes).to be_a(Kafka::Protocol::ProduceV1Response)
      expect(mes.error?).to eq(false)
    end
  end

  describe "#produce(v2)" do
    it "not implemented yet" do
      expect {
        kafka.produce("tmp", "v1", version: 2)
      }.to raise_error Kafka::NotImplemented
    end
  end
end
