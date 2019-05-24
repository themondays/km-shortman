defmodule ShortmanAPI.Router do
  use ShortmanAPI, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ShortmanAPI do
    pipe_through :api

    scope "/1.0" do
      resources("/links", LinkController, only: [:create, :show])
      post("/links/submit", LinkController, :submit)
    end
  end
end
