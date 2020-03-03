defmodule ErlefWeb.EventSubmissionController do
  use ErlefWeb, :controller
  action_fallback ErlefWeb.FallbackController

  def create(conn, %{"event" => params}) do
    case Erlef.Members.submit_event(maybe_read_file_param(params)) do
      {:ok, _event} ->
        conn
        |> put_flash(
          :success,
          "<h3>Thanks! 😁 Your event will be reviewed by an admin shortly...</h3>"
        )
        |> redirect(to: "/")

      {:error, changeset} ->
        render(conn, "new.html",
          changeset: %{changeset | action: :insert},
          event_types: event_types()
        )
    end
  end

  def new(conn, _params) do
    render(conn, changeset: Erlef.Members.new_event(), event_types: event_types())
  end

  defp maybe_read_file_param(params) do
    case params["organizer_brand_logo"] do
      %Plug.Upload{} = upload ->
        organizer_brand_logo = File.read!(upload.path)
        Map.put(params, "organizer_brand_logo", organizer_brand_logo)

      _ ->
        params
    end
  end

  defp event_types do
    Erlef.Data.Schema.EventType
    |> Erlef.Data.Repo.all()
    |> Enum.map(fn x -> [key: x.name, value: x.id] end)
  end
end
