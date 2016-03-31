class Kafka
  module Commands
    module Produce
      include Kafka::Protocol

      record ProduceOption,
        required_acks : Int16,
        timeout_ms : Int32
      
      def ProduceOption.default
        ProduceOption.new(-1_i16, 1000)
      end

      def produce_v1(entry : Kafka::Entry, data : Kafka::Data, opt : ProduceOption)
        res = raw_produce_v1(entry, data, opt)
        return extract_produce_info!(res)
      end
  
      def raw_produce_v1(entry : Kafka::Entry, data : Kafka::Data, opt : ProduceOption)
        req = build_produce_request_v1(entry, data, opt)
        res = fetch_produce_response(req)
        return res
      end
  
      private def build_produce_request_v1(entry : Kafka::Entry, data : Kafka::Data, opt : ProduceOption)
        tp = Structure::TopicAndPartitionMessages.new(entry, data)
        Kafka::Protocol::ProduceV1Request.new(0, client_id, opt.required_acks, opt.timeout_ms.to_i32, [tp])
      end

      private def fetch_produce_response(req)
        execute(req)
      end

      private def extract_produce_info!(res)
        res
      end
    end
  end
end