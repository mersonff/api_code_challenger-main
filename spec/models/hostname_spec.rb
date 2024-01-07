require 'rails_helper'

describe Hostname do
  it { should have_and_belong_to_many(:dns_records) }
end
