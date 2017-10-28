require 'uri'
require 'oauth'
require 'wearable_apis/nokia/base'

module WearableApis
  module Nokia
    class Health < Base
      # Get the activity measures log for a user. Note that the service is limited to 60 calls per minute.
      #
      # @see https://developer.health.nokia.com/api/doc#api-Measure-get_activity
      #
      # @param [Integer] userid  Id of the user to fetch activity for.
      # @param [Hash] opts
      # @option opts [String] :date   Date for the log.
      #                               Either the lastupdate, the date or the stardateymd/enddateymd must be used.
      #                               With date or startdateymd/enddateymd params, this call returns every step activities including periods
      #                               with only calories data when user didn't have a step activity (key steps empty).
      # @option opts [String] :lastupdate Timestamp of last modified activity retrieved in a precedent call (set 0 for first call).
      #                                   Either the lastupdate, the date or the stardateymd/enddateymd must be used.
      #                                   With lastupdate params, this call returns only periods when user has steps data. (key steps non empty)
      # @option opts [type] :startdateymd   start date for the log (requires enddateymd).
      #                                     Either the lastupdate, the date or the stardateymd/enddateymd must be used.
      # @option opts [type] :enddateymd   end date for the log (requires startdateymd).
      #                                   Either the lastupdate, the date or the stardateymd/enddateymd must be used.
      # @option opts [type] :offset   Value to specify when a first call returns 'more=true' and 'offset=XX' with XX the value use.
      # @return [Hash, nil] return the api response.
      def get_activity_measureses(userid, opts={})
        opts.merge!({
                      action: 'getactivity',
                      userid: userid
                    })
        response = @client.get(build_path_and_params('/v2/measure', opts))
        parse_response(response)
      end

      # Get the body measures for a user
      #
      #
      #
      #
      #
      #
      #
      def get_body_measures(userid, opts={})
        opts.merge!({
                      action: 'getmeas',
                      userid: userid
                    })
        response = @client.get(build_path_and_params('/measure', opts))
        parse_response(response)
      end

      # Get intraday activity. Note that a specific limitation of 120 API calls per minute is in place on this webservice.
      # Note : if startdate and enddate are separated by more than 24h, enddate will be overwritten with 24h past startdate.
      #
      #
      #
      #
      #
      #
      #
      def get_intraday_activity(userid, startdate, enddate, opts={})
        opts.merge!({
                      action: 'getintradayactivity',
                      userid: userid,
                      startdate: startdate,
                      enddate: enddate
                    })
        response = @client.get(build_path_and_params('/v2/measure', opts))
        parse_response(response)
      end

      # The Sleep Measures API lets you reconstitute the full image of the
      # user’s night with the detail of each phase of their sleep cycle.
      # The data is made available when the measurements from
      # the Nokia activity trackers are synchronized with the Nokia Health database.
      # The Nokia Sleep Monitor synchronizes on the user’s initiative and automatically several times during the day.
      # The Nokia activity trackers synchronizes automatically at the end of each night, a few minutes after the user exists the bed.
      #
      #
      #
      #
      #
      #
      #
      def get_sleep_measures(userid, startdate, enddate, opts={})
        opts.merge!({
                      action: 'get',
                      userid: userid,
                      startdate: startdate,
                      enddate: enddate
                    })
        response = @client.get(build_path_and_params('/v2/sleep', opts))
        parse_response(response)
      end

      # The Sleep Summary API lets you access the basic information about a user’s night: the total time they slept,
      # how long it took them to fall asleep, how many times they woke up, etc.
      # The data is made available when the measurements from the Nokia activity trackers are synchronized with the Nokia Health database.
      # The Nokia activity trackers synchronizes on the user’s initiative and automatically several times during the day.
      # The Nokia activity trackers synchronizes automatically at the end of each night a few minutes after the user exists the bed.
      #
      # @param [Hash] opts
      # @option opts [String] :lastupdate Timestamp of last modified activity retrieved in a precedent call (set 0 for first call).
      #                                   Either the lastupdate, the date or the stardateymd/enddateymd must be used.
      #                                   With lastupdate params, this call returns only periods when user has steps data. (key steps non empty)
      # @option opts [type] :startdateymd   start date for the log (requires enddateymd).
      #                                     Either the lastupdate, the date or the stardateymd/enddateymd must be used.
      # @option opts [type] :enddateymd   end date for the log (requires startdateymd).
      #                                   Either the lastupdate, the date or the stardateymd/enddateymd must be used.
      # @option opts [type] :offset   Value to specify when a first call returns 'more=true' and 'offset=XX' with XX the value use.
      # @return [Hash, nil] return the api response.
      def get_sleep_summary(opts={})
        opts.merge!({
                      action: 'getsummary'
                    })
        response = @client.get(build_path_and_params('/v2/sleep', opts))
        parse_response(response)
      end

      # The Workouts API lets you retrieve the data relevant to workout sessions as measured by the Withigns activity trackers.
      # The data is presented as aggregates for each workout session of a given day.
      # Detailed minute-by-minute data for aall workout activities is also availble through the GetIntradayActivity service.
      #
      # @param [Integer] userid  Id of the user to fetch activity for.
      # @param [Hash] opts
      # @option opts [type] :startdateymd   start date for the log (requires enddateymd).
      #                                     Either the lastupdate, the date or the stardateymd/enddateymd must be used.
      # @option opts [type] :enddateymd   end date for the log (requires startdateymd).
      #                                   Either the lastupdate, the date or the stardateymd/enddateymd must be used.
      # @return [Hash, nil] return the api response.
      def get_workouts(userid, opts={})
        opts.merge!({
                      action: 'getworkouts',
                      userid: userid
                    })
        response = @client.get(build_path_and_params('/v2/measure', opts))
        parse_response(response)
      end

      private

      def build_path_and_params(path, opts)
        opts.delete_if { |k, v| v.nil? }
        "#{path}?#{URI.encode_www_form(opts)}"
      end
    end
  end
end
