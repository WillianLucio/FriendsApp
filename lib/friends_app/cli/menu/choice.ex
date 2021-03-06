defmodule FriendsApp.CLI.Menu.Choice do
  alias Mix.Shell.IO, as: Shell
  alias FriendsApp.CLI.Menu.Items
  alias FriendsApp.DB.CSV

  def start do
    Shell.cmd("clear")
    Shell.info("Escolha uma opção:")

    menu_items = Items.all()
    find_menu_by_index = &Enum.at(menu_items, &1, :error)

    menu_items
    |> Enum.map(& &1.label)
    |> display_options()
    |> generate_question()
    |> Shell.prompt()
    |> parser_answer()
    |> find_menu_by_index.()
    |> confirm_menu_item()
    |> confirm_message()
    |> CSV.perform()
  end

  defp display_options(options) do
    options
    |> Enum.with_index(1)
    |> Enum.each(fn {option, index} ->
      Shell.info("#{index} - #{option}")
    end)

    options
  end

  defp generate_question(options) do
    options = Enum.join(1..Enum.count(options), ", ")
    "Qual das opções acima você escolhe? [#{options}]"
  end

  defp parser_answer(answer) do
    case Integer.parse(answer) do
      :error -> invalid_option()
      {option, _} -> option - 1
    end
  end

  defp invalid_option do
    Shell.cmd("clear")
    Shell.error("Opção inválida!")
    Shell.prompt("Precione para tentar novamente.")
    start()
  end

  defp confirm_menu_item(chosen_menu_item) do
    case chosen_menu_item do
      :error -> invalid_option()
      _ -> chosen_menu_item
    end
  end

  defp confirm_message(chosen_menu_item) do
    Shell.cmd("clear")
    Shell.info("Você escolheu... [#{chosen_menu_item.label}]")

    if Shell.yes?("Confirma?") do
      chosen_menu_item
    else
      start()
    end
  end
end
