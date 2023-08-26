defmodule Mix.Tasks.Todo.Add do
  @moduledoc "The hello mix task: `mix help todo.add`"
  use Mix.Task

  @shortdoc "添加todo项"
  def run(args) do
    # This will start our application
    Mix.Task.run("app.start")

    item_content = List.first(args)

    {:ok, item} = TodoList.add(item_content)
    IO.puts("#{item.index}. #{item.item_content}")
    IO.puts("Item<#{item.index}>added")
  end
end
