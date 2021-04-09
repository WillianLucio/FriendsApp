defmodule FriendsApp.CLI.MenuChoise do
  alias Mix.Shell.IO, as: Shell

  def start do
    Shell.cmd("clear")
    Shell.info("Escolha uma opção:")

    menu_items = FriendsApp.CLI.MenuItems.all()
    find_menu_by_index = &Enum.at(menu_items, &1)

    menu_items
    |> Enum.map(& &1.label)
    |> display_options()
    |> generate_question()
    |> Shell.prompt
    |> parser_answer()
    |> find_menu_by_index.()
    |> confirm_menu_item()
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
    { option, _ } = Integer.parse(answer)
    option - 1
  end

  defp confirm_menu_item(chosen_menu_item) do
    Shell.cmd("clear")
    Shell.info("Você escolheu... [#{chosen_menu_item.label}]")

    if Shell.yes?("Confirma?") do
      Shell.info("... #{chosen_menu_item.label} ...")
    else
      start()
    end
  end
end
