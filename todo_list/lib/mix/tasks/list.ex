defmodule Mix.Tasks.Todo.List do
  @moduledoc """
  查看 Todo 列表，缺省情况下，只列出未完成的 Todo 项。
  todo list
  1. <item1>
  2. <item2>
  Total: 2 items

  使用 all 参数，查看所有的 Todo 项
  todo list --all
  1. <item1>
  2. <item2>
  3. [Done] <item3>
  Total: 3 items, 1 item done
  """
  use Mix.Task

  @shortdoc "完成todo项"
  def run(args) do
    # This will start our application
    Mix.Task.run("app.start")

    # index = List.first(args)

    result =
      if length(args) > 0 and hd(args) == "all" do
        TodoList.list(:all)
      else
        TodoList.list()
      end

    result
    |> Enum.each(fn item ->
      if item.status == "done" do
        IO.puts("[Done] <#{item.index}> #{item.item_content}")
      else
        IO.puts("<#{item.index}> #{item.item_content}")
      end
    end)

    IO.puts("Total: #{length(result)} items")
  end
end
