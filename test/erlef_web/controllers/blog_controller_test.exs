defmodule ErlefWeb.BlogControllerTest do
  use ErlefWeb.ConnCase

  test "GET /news", %{conn: conn} do
    conn = get(conn, Routes.news_path(conn, :index))
    assert html_response(conn, 200) =~ "Find all the related news"
  end

  test "GET /news/:topic", %{conn: conn} do
    conn = get(conn, Routes.news_path(conn, :index, "fellowship"))
    assert html_response(conn, 200) =~ "members for a fellowship role"
  end

  test "GET /news/:topic/:id", %{conn: conn} do
    conn = get(conn, Routes.news_path(conn, :show, "fellowship", "honoring-our-fellows"))
    assert html_response(conn, 200) =~ "The First Fellows"
  end

  test "GET /news/:topic does not exist", %{conn: conn} do
    conn = get(conn, Routes.news_path(conn, :index, "eh"))
    assert html_response(conn, 404) =~ "Not Found"
  end
end
