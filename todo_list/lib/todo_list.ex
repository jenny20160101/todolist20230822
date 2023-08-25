defmodule TodoList do
  @moduledoc """
  TodoList keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  @file_path "./todo_list.txt"
  @storage_location :file

  def add(item_content) do
    new_item = %{item_content: item_content, index: get_index()}
    save_new_item(new_item, @storage_location)
    {:ok, new_item}
  end

  defp save_new_item(new_item, :file) do
    new_items =
      exist_items(@storage_location)
      |> List.insert_at(0, new_item)
      |> Jason.encode!()

    :ok = File.write(@file_path, new_items)
  end

  defp get_index do
    latest_item = exist_items(@storage_location) |> List.first()

    if is_nil(latest_item) do
      1
    else
      latest_item.index + 1
    end
  end

  defp exist_items(:file) do
    file_content()
    |> Jason.decode!()
    |> AtomizeKeys.atomize_string_keys()
  end

  defp file_content() do
    result = File.read(@file_path)

    case result do
      {:ok, content} -> content
      {:error, :enoent} -> "[]"
      _ -> raise "File.read(#{@file_path})： #{inspect(result)}"
    end
  end
end