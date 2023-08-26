defmodule Mix.Tasks.Todo.Clear do
  @moduledoc "The hello mix task: `mix help todo.clear`"
  use Mix.Task

  @shortdoc "删除所有todo项"
  def run(_) do
    # This will start our application
    Mix.Task.run("app.start")

    TodoList.clear()

    #     todo add <item>
    # 1. <item>
    # Item <itemIndex> added
  end
end
