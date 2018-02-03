defmodule CatcastsWeb.NavigationTest do
  use CatcastsWeb.ConnCase

  test "shows a sign in with Google link when not signed in", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Sign in with Google"
  end
end
