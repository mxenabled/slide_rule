module SlideRule
  module DistanceCalculators
    class DayOfYear
      DAYS_IN_YEAR = 365

      def calculate(date_1, date_2, options={})
        date_1 = cleanse_date(date_1)
        date_2 = cleanse_date(date_2)
        threshold = options[:threshold] || DAYS_IN_YEAR
        days_apart = (date_1.mjd - date_2.mjd).abs

        return 1 if days_apart >= threshold

        distance = days_apart.to_f / threshold
        distance.round(2)
      end

      private

      def cleanse_date(date)
        date = Time.at(date).utc.to_date if date.is_a?(::Integer)
        date = Date.parse(date) unless date.is_a?(::Date) || date.is_a?(::Time)
        date = date.to_date if date.is_a?(::Time)

        date
      end
    end
  end
end
