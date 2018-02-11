defmodule Catcasts.Videos.Video do
  use Ecto.Schema
  import Ecto.Changeset
  alias Catcasts.Videos.Video


  schema "videos" do
    field :duration, :string
    field :thumbnail, :string
    field :title, :string
    field :video_id, :string, unique: true
    field :view_count, :integer
    field :user_id, :id

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
