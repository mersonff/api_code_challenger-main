module Api
  module V1
    class DnsRecordsController < ApplicationController
      # GET /dns_records

      def index
        if request.format.html?
          render json: { error: 'Invalid format' }, status: :unprocessable_entity
          return
        end

        records = DnsRecordQueryService.new(params).call

        render json: records, status: :ok
      end

      # POST /dns_records
      def create
        dns_record = DnsRecord.new(dns_record_params)

        if dns_record.save
          render json: { id: dns_record.id }, status: :created
        else
          render json: dns_record.errors, status: :unprocessable_entity
        end
      end

      private

      def dns_record_params
        params.require(:dns_record).permit(:ip, hostnames_attributes: [:hostname])
      end
    end
  end
end
