require "../src/kafka"
require "spec2"

include Spec2::GlobalDSL

macro bytes(*array)
  Slice.new({{array.size}}) {|i| {{array}}[i].to_u8}
end
