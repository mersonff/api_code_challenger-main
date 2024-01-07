class CreateDnsRecordsHostnamesJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :dns_records, :hostnames do |t|
      t.index :dns_record_id
      t.index :hostname_id
    end
  end
end
