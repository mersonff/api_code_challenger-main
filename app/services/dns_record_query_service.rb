# frozen_string_literal: true

class DnsRecordQueryService
  attr_accessor :page, :included_hostnames, :excluded_hostnames, :records

  def initialize(params)
    self.page = params['page']
    self.included_hostnames = parse_params(params['included'])
    self.excluded_hostnames = parse_params(params['excluded'])
  end

  def call
    retrieve_records
    build_response
  end

  private

  def retrieve_records
    self.records = DnsRecord
                   .search(included_records_ids, excluded_records_ids)
                   .order(:id)
                   .page(page)
  end

  def included_records_ids
    DnsRecord
      .joins(:hostnames)
      .where(hostnames: { hostname: included_hostnames })
      .group(:id)
      .having('COUNT(*) = ?', included_hostnames.length)
      .pluck(:id)
  end

  def excluded_records_ids
    DnsRecord
      .joins(:hostnames)
      .where(hostnames: { hostname: excluded_hostnames })
      .pluck(:id)
  end

  def build_response
    {
      total_records: records.length,
      records: build_records_response,
      related_hostnames: build_related_hostnames
    }
  end

  def build_records_response
    records.map do |record|
      {
        id: record.id,
        ip: record.ip
      }
    end
  end

  def build_related_hostnames
    hostnames = records.flat_map { |record| uniq_hostnames_for_dns(record) }

    filtered_hostnames = if included_hostnames.present?
                           Hostname.joins(:dns_records).where(dns_records: { id: records.ids }).where(hostname: included_hostnames).uniq do |h|
                             h['hostname']
                           end
                         else
                           Hostname.joins(:dns_records).where(dns_records: { id: records.ids }).uniq do |h|
                             h['hostname']
                           end
                         end

    filtered_hostnames.map do |hostname|
      {
        hostname: hostname['hostname'],
        count: hostnames.count { |h| h[:hostname] == hostname['hostname'] }
      }
    end
  end

  def uniq_hostnames_for_dns(record)
    record.hostnames.uniq do |hostname|
      hostname['hostname']
    end.map do |hostname|
      {
        hostname: hostname['hostname']
      }
    end
  end

  def parse_params(param)
    return [] unless param

    param.split(',').flatten
  end
end
