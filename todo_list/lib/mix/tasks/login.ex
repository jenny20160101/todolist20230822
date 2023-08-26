defmodule Mix.Tasks.Login do
  @moduledoc """
  todo login -u user
  """
  use Mix.Task

  @shortdoc "login"
  def run(args) do
    # This will start our application
    Mix.Task.run("app.start")
    [user_name | _] = args
    IO.puts("Password:")
    pwd = IO.gets("") |> String.trim()

    case Login.login(user_name, pwd) do
      {:ok, _} ->
        IO.puts("Login success!")

      {:error, msg} ->
        IO.puts("Login failed: #{msg}")
    end
  end
end
