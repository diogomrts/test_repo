defmodule Helpdesk do
  @moduledoc """
  Documentation for `Helpdesk`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Helpdesk.hello()
      :world

  """
  def test do
    # no warning
    Ash.create!(Helpdesk.Support.PgFile, %{name: "name"})

    # with bulk_create and event logging for this action we get "Missed 1 notifications in action Helpdesk.Support.PgEvent.create."
    Ash.bulk_create!(
      [
        %{name: "name"},
        %{name: "name"}
      ],
      Helpdesk.Support.PgFile,
      :create
    )
  end
end
