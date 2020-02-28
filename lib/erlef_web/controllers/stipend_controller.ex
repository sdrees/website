defmodule ErlefWeb.StipendController do
  use ErlefWeb, :controller
  action_fallback ErlefWeb.FallbackController

  def index(conn, _params) do
    render(conn, errors: [], params: %{})
  end

  def create(%{private: %{phoenix_format: "html"}} = conn, params) do
    files = params["files"] || []

    case Erlef.StipendProposal.from_map(Map.put(params, "files", files)) do
      {:ok, proposal} ->
        Erlef.StipendMail.submission(proposal) |> Erlef.Mailer.send()
        Erlef.StipendMail.submission_copy(proposal) |> Erlef.Mailer.send()
        render(conn)

      {:error, errors} ->
        conn
        |> put_flash(:error, errors)
        |> render("index.html", params: params)
    end
  end
end
