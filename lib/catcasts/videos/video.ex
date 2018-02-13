defmodule Catcasts.Videos.Video do
  use Ecto.Schema
  import Ecto.Changeset
  alias Catcasts.Videos.Video
  alias Catcasts.User

  schema "videos" do
    field :duration, :string
    field :thumbnail, :string
    field :title, :string
    field :video_id, :string, unique: true
    field :view_count, :integer
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(%Video{} = video, attrs) do
    video
    |> cast(attrs, [:video_id, :title, :duration, :thumbnail, :view_count])
    |> validate_required([:video_id, :title, :duration, :thumbnail, :view_count])
    |> unique_constraint(:video_id)
  end
end
