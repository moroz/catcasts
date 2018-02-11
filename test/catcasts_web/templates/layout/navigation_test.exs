defmodule CatcastsWeb.NavigationTest do
  use CatcastsWeb.ConnCase
  import Catcasts.Factory

  test "shows a sign in with Google link when not signed in", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Sign in with Google"
  end

  test "shows a sign out link when signed in", %{conn: conn} do
    user = insert(:user)

    conn = conn
    |> assign(:user, user)
    |> get("/")

    assert html_response(conn, 200) =~ "Sign out"
  end

  test "shows a link to the videos index", %{conn: conn} do
    conn = get conn, "/"

    assert html_response(conn, 200) =~ "<a href=\"/videos\">Videos</a>"
  end

  test "shows a link to add video for a signed in user", %{conn: conn} do
    user = insert(:user)

    conn = conn
    |> assign(:user, user)
    |> get("/")

    assert html_response(conn, 200) =~ "<a href=\"/videos/new\">Add video</a>"
  end
end
