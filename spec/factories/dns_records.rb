FactoryBot.define do
  factory :dns_record do
    ip { Faker::Internet.ip_v4_address }

    trait :with_hostnames do
      transient do
        hostnames_count { 5 }
      end

      after(:create) do |dns_record, evaluator|
        create_list(:hostname, evaluator.hostnames_count, dns_records: [dns_record])
      end
    end
  end
end
