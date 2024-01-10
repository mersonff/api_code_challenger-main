# frozen_string_literal: true

class DnsRecord < ApplicationRecord
  has_and_belongs_to_many :hostnames

  accepts_nested_attributes_for :hostnames

  def self.search(included_hostnames_ids, excluded_hostnames_ids)
    query = all.includes(:hostnames)

    if included_hostnames_ids.present? && excluded_hostnames_ids.present?
      query = query.where.not(id: excluded_hostnames_ids)
                   .where(id: included_hostnames_ids)
    elsif included_hostnames_ids.present?
      query = query.where(id: included_hostnames_ids)
    elsif excluded_hostnames_ids.present?
      query = query.where.not(id: excluded_hostnames_ids)
    end

    query.distinct
  end
end
