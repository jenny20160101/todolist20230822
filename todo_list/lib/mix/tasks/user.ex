defmodule Mix.Tasks.User.Add do
  @moduledoc """
  todo login -u user
  """
  use Mix.Task

  @shortdoc "add user"
  def run(args) do
    # This will start our application
    Mix.Task.run("app.start")

    [user_name, pwd] = args

    {:ok, _} = User.add(user_name, pwd)

    IO.puts("add user <#{user_name}> success!")
  end
end
