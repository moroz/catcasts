defmodule CatcastsWeb.VideoControllerTest do
  use CatcastsWeb.ConnCase
  import Catcasts.Factory
  alias Catcasts.Videos.Video

  @create_attrs %{video_id: "https://www.youtube.com/watch?v=wZZ7oFKsKzY"}
  @invalid_attrs %{video_id: ""}

  def fixture(:video) do
    user = insert(:user)
    video = Catcasts.Repo.insert! %Video{
      duration: "PT2M2S",
      thumbnail: "https://i.ytimg.com/vi/1rlSjdnAKY4/hqdefault.jpg",
      title: "Super Troopers (2/5) Movie CLIP - The Cat Game (2001) HD",
      video_id: "1rlSjdnAKY4",
      view_count: 658281,
      user_id: user.id
    }

    {:ok, video: video, user: user}
  end

  describe "index" do
    test "lists all videos", %{conn: conn} do
      conn = get conn, video_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Videos"
    end
  end

  describe "new video" do
    test "renders form", %{conn: conn} do
      conn = get conn, video_path(conn, :new)
      assert html_response(conn, 200) =~ "Add video"
    end
  end

  describe "create video" do
    test "redirects to show when data is valid", %{conn: conn} do
      user = insert(:user)

      conn = conn
      |> assign(:user, user)
      |> post(video_path(conn, :create), video: @create_attrs)

      video = Video |> Ecto.Query.last |> Catcasts.Repo.one
      assert redirected_to(conn) == video_path(conn, :show, video)
      assert get_flash(conn, :info) == "Video created successfully."
    end

    test "renders errors when data is invalid", %{conn: conn} do
      user = insert(:user)

      conn = conn
      |> assign(:user, user)
      |> post(video_path(conn, :create), video: @invalid_attrs)

      assert html_response(conn, 200) =~ "Add video"
    end
  end

  describe "delete video" do
    setup [:create_video]

    test "deletes chosen video", %{conn: conn, video: video} do
      conn = delete conn, video_path(conn, :delete, video)
      assert redirected_to(conn) == video_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, video_path(conn, :show, video)
      end
    end
  end

  defp create_video(_) do
    fixture(:video)
  end
end
