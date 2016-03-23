module RequestOperations
  protected def execute(request)
    bytes = request.to_slice
    connect do |socket|
      spawn do
        socket.write bytes
        socket.flush
        sleep 0
      end
      return request.class.response.from_kafka(socket)
    end
  end

  protected def build_offset_request(topics, partition, replica = -1)
    po = Kafka::Protocol::Structure::Partition.new(partition, latest_offset = -1_i64, max_offsets = 999999999)
    taps = topics.map { |t| Kafka::Protocol::Structure::TopicAndPartitions.new(t, [po]) }
    return Kafka::Protocol::OffsetRequest.new(0, app_name, replica, taps)
  end

  protected def fetch_offset(topics, partition, replica = -1)
    execute build_offset_request(topics, partition, replica)
  end

  protected def fetch_topic_names
    names = [] of String

    req = Kafka::Protocol::MetadataRequest.new(0, app_name, [] of String)
    res = execute req
    res.topics.map do |meta|
      unless meta.error_code == 0
        errmsg = Kafka::Protocol.errmsg(meta.error_code)
        STDERR.puts "#{meta.name}#\t#{errmsg}"
        next
      end

      case meta.name
      when "__consumer_offsets"
        next # skip
      else
        names << meta.name
      end
    end

    return names
  end
  protected def resolve_leader!(topic, partition)
    meta = fetch_topic_metadata([topic], app_name)
    meta.topics.each do |t|
      if t.name == topic
        t.partitions.each do |p|
          if p.id == partition
            if p.error_code == -1
              errmsg = Kafka::Protocol.errmsg(p.error_code)
              raise "#{t.name}##{p.id}\t#{errmsg}"
            else
              return meta.broker!(p.leader)
            end
          end
        end
      end
    end

    raise "[BUG?] leader not found for #{topic}##{partition}"
  end
end