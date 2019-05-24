defmodule ShortmanWeb.Router do
  use ShortmanWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", ShortmanWeb do
    pipe_through :browser
    get("/:hashid", LinkController, :show)
  end
end
