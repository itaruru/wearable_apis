require 'oauth'
require 'wearable_apis/garmin/base'

module WearableApis
  module Garmin
    class Health < Base
      def get_dailies(start_time, end_time, backfill = false, all = false)
        response = @client.get(build_path_and_params('dailies', start_time, end_time, backfill))
        resp = parse_response(response)

        case
        when response.code == '403'
          then raise OAuth::Error, resp['errorMessage']
        end

        if all
          resp
        else
          r = {}
          resp.each { |d| r.merge!({ d['startTimeInSeconds'] => d }) }
          r.map { |_, v| v }
        end
      end

      def get_activities(start_time, end_time, backfill = false)
        response = @client.get(build_path_and_params('activities', start_time, end_time, backfill))
        parse_response(response)
      end

      def get_third_party_dailies(start_time, end_time)
        response = @client.get(build_path_and_params('thirdPartyDailies', start_time, end_time, false))
        parse_response(response)
      end

      def get_manually_updated_activities(start_time, end_time)
        response = @client.get(build_path_and_params('manuallyUpdatedActivities', start_time, end_time, false))
        parse_response(response)
      end

      def get_epochs(start_time, end_time, backfill = false)
        response = @client.get(build_path_and_params('epochs', start_time, end_time, backfill))
        parse_response(response)
      end

      def get_sleeps(start_time, end_time, backfill = false, all = false)
        response = @client.get(build_path_and_params('sleeps', start_time, end_time, backfill))
        resp = parse_response(response)

        case
        when response.code == '403'
          then raise OAuth::Error, resp['errorMessage']
        end

        if all
          resp
        else
          return [] if resp.size < 1
          resp.max { |a, b| a['durationInSeconds'] <=> b['durationInSeconds'] }
        end
      end

      def get_body_comps(start_time, end_time, backfill = false)
        response = @client.get(build_path_and_params('bodyComps', start_time, end_time, backfill))
        parse_response(response)
      end

      def get_stress_details(start_time, end_time, backfill = false)
        response = @client.get(build_path_and_params('stressDetails', start_time, end_time, backfill))
        parse_response(response)
      end

      def get_user_metrics(start_time, end_time, backfill = false)
        response = @client.get(build_path_and_params('userMetrics', start_time, end_time, backfill))
        parse_response(response)
      end

      def get_moveiq(start_time, end_time, backfill = false)
        response = @client.get(build_path_and_params('moveiq', start_time, end_time, backfill))
        parse_response(response)
      end

      private

      def build_path_and_params(method, start_time, end_time, backfill = false)
        start_time = start_time.utc.to_i
        end_time = end_time.utc.to_i
        if backfill
          "/wellness-api/rest/backfill/#{method}?summaryStartTimeInSeconds=#{start_time}&summaryEndTimeInSeconds=#{end_time}"
        else
          "/wellness-api/rest/#{method}?uploadStartTimeInSeconds=#{start_time}&uploadEndTimeInSeconds=#{end_time}"
        end
      end
    end
  end
end
