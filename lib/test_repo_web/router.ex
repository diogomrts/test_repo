defmodule TestRepoWeb.Router do
  use TestRepoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {TestRepoWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TestRepoWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/v1" do
    pipe_through(:api)

    forward "/swagger-ui",
      OpenApiSpex.Plug.SwaggerUI,
      path: "/v1/open_api",
      default_model_expand_depth: 4

    forward "/redoc",
      Redoc.Plug.RedocUI,
      spec_url: "/v1/open_api"

    forward "/", TestRepo.JsonApiRouter
  end

  # Other scopes may use custom stacks.
  # scope "/api", TestRepoWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:test_repo, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: TestRepoWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
