# https://kafka.apache.org/protocol
enum Kafka::Api
  Produce              = 0
  Fetch                = 1
  ListOffsets          = 2
  Metadata             = 3
  LeaderAndIsr         = 4
  StopReplica          = 5
  UpdateMetadata       = 6
  ControlledShutdown   = 7
  OffsetCommit         = 8
  OffsetFetch          = 9
  FindCoordinator      = 10
  JoinGroup            = 11
  Heartbeat            = 12
  LeaveGroup           = 13
  SyncGroup            = 14
  DescribeGroups       = 15
  ListGroups           = 16
  SaslHandshake        = 17
  ApiVersions          = 18
  CreateTopics         = 19
  DeleteTopics         = 20
  DeleteRecords        = 21
  InitProducerId       = 22
  OffsetForLeaderEpoch = 23
  AddPartitionsToTxn   = 24
  AddOffsetsToTxn      = 25
  EndTxn               = 26
  WriteTxnMarkers      = 27
  TxnOffsetCommit      = 28
  DescribeAcls         = 29
  CreateAcls           = 30
  DeleteAcls           = 31
  DescribeConfigs      = 32
  AlterConfigs         = 33
  AlterReplicaLogDirs  = 34
  DescribeLogDirs      = 35
  SaslAuthenticate     = 36
  CreatePartitions     = 37

  def self.guess?(v : String) : Api?
    each do |member, value|
      if v =~ /\b#{member}\b/i
        return member
      end
    end
    return nil
  end
end
