defmodule Cldr.DateTime.Interval.Backend do
  @moduledoc false

  def define_date_time_interval_module(config) do
    backend = config.backend
    config = Macro.escape(config)

    quote location: :keep, bind_quoted: [config: config, backend: backend] do
      defmodule DateTime.Interval do
        def to_string(%CalendarInterval{} = interval) do
          Cldr.DateTime.Interval.to_string(interval, unquote(backend), [])
        end

        def to_string(%CalendarInterval{} = interval, options) do
          Cldr.DateTime.Interval.to_string(interval, unquote(backend), options)
        end

        def to_string(from, to) do
          Cldr.DateTime.Interval.to_string(from, to, unquote(backend), [])
        end


        def to_string(from, to, options) do
          Cldr.DateTime.Interval.to_string(from, to, unquote(backend), options)
        end
      end

      defmodule Date.Interval do
        def to_string(%Elixir.Date.Range{} = interval) do
          Cldr.Date.Interval.to_string(interval, unquote(backend), [])
        end

        def to_string(%Elixir.Date.Range{} = interval, options) do
          Cldr.Date.Interval.to_string(interval, unquote(backend), options)
        end

        def to_string(from, to, options \\ []) do
          Cldr.Date.Interval.to_string(from, to, unquote(backend), options)
        end
      end

      defmodule Time.Interval do
        def to_string(from, to, options \\ []) do
          Cldr.Time.Interval.to_string(from, to, unquote(backend), options)
        end
      end
    end
  end
end