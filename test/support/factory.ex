defmodule Catcasts.Factory do
  use ExMachina.Ecto, repo: Catcasts.Repo

  def user_factory do
    %Catcasts.User{
      token: "papierzak2137420420",
      email: "papierz@2137.com",
      first_name: "Jan", last_name: "Paweł",
      provider: "google"
    }
  end
end
