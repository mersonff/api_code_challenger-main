require 'rails_helper'

describe DnsRecord do
  it { should have_and_belong_to_many(:hostnames) }
end
