defmodule CatcastsWeb.AuthControllerTest do
  use CatcastsWeb.ConnCase
  alias Catcasts.{Repo, User}
  import Catcasts.Factory

  @ueberauth_auth %{credentials: %{token: "papierzak2137420420"},
                    info: %{email: "papierz@2137.com", first_name: "Jan",
                            last_name: "Paweł"},
                    provider: :google}

  test "redirects user to Google for authentication", %{conn: conn} do
    conn = get conn, "/auth/google?scope=email%20profile"
    assert redirected_to(conn, 302)
  end

  test "creates user from Google Information", %{conn: conn} do
    conn = conn
    |> assign(:ueberauth_auth, @ueberauth_auth)
    |> get("/auth/google/callback")

    users = User |> Repo.all
    assert Enum.count(users) == 1
    assert get_flash(conn, :info) == "Thank you for signing in!"
  end

  test "signs out a user", %{conn: conn} do
    user = insert(:user)

    conn = conn
    |> assign(:user, user)
    |> get("/auth/signout")
    |> get("/")

    assert conn.assigns.user == nil
  end
end
