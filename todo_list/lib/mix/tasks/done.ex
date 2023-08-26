defmodule Mix.Tasks.Todo.Done do
  @moduledoc """
  todo done <itemIndex>
  Item <itemIndex> done.
  """
  use Mix.Task

  @shortdoc "完成todo项"
  def run(args) do
    # This will start our application
    Mix.Task.run("app.start")

    index = List.first(args)

    result = TodoList.done(index)

    case result do
      {:ok, _} -> IO.puts("Item <#{index}> done.")
      {:error, msg} -> IO.puts(msg)
    end
  end
end
