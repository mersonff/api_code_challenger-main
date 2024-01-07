describe DnsRecord do
  it { should have_many(:hostnames) }
end
