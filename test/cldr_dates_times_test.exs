defmodule Cldr.DatesTimes.Test do
  use ExUnit.Case, async: true

  for year <- 0001..3000 do
    starts = Cldr.Calendar.ISOWeek.first_day_of_year(year)
    ends = Cldr.Calendar.ISOWeek.last_day_of_year(year)

    test "that we have either 52 or 53 weeks in the year starting #{inspect starts} ending #{inspect ends}" do
      days = Date.diff(unquote(Macro.escape(ends)), unquote(Macro.escape(starts))) + 1
      weeks = div(days,7)
      assert weeks in 52..53
    end

    test "that the number of weeks in a year correlates for year #{inspect year}" do
      days = Date.diff(unquote(Macro.escape(ends)), unquote(Macro.escape(starts))) + 1
      weeks = div(days,7)

      assert weeks == Cldr.Calendar.ISOWeek.weeks_in_year(unquote(year))
    end

    test "that #{year} abuts the next year #{year + 1}" do
      assert Cldr.Calendar.next_day(Cldr.Calendar.ISOWeek.last_day_of_year(unquote(Macro.escape(year)))) ==
       Cldr.Calendar.ISOWeek.first_day_of_year(unquote(Macro.escape(year) + 1))
    end
  end

  import PropertyTest
  property "that a date fits within the start and end dates for that year" do
    check all  day   <- StreamData.int(1..28),
               month <- StreamData.int(1..12),
               year  <- StreamData.int(1..3000),
               max_runs: 1_000
    do
      {:ok, date} = Date.new(year, month, day)
      starts = struct(Date, Cldr.Calendar.ISOWeek.first_day_of_year(date))
      ends = struct(Date, Cldr.Calendar.ISOWeek.last_day_of_year(date))
      assert Date.compare(starts, date) in [:lt, :eq] and Date.compare(ends, date) in [:gt, :eq]
    end
  end
end
