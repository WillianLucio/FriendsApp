defmodule FriendsApp.CLI.Main do
  alias Mix.Shell.IO, as: Shell

  def start_app do
    Shell.cmd("clear")
    welcome_message()
    Shell.prompt("Pressione ENTER para continuar...")
    starts_menu_choise
  end

  defp welcome_message do
    Shell.info("============ Friends App ============")
    Shell.info("Seja bem-vindo a sua agenda pessoal!")
    Shell.info("=====================================")
  end

  defp starts_menu_choise do
    FriendsApp.CLI.Menu.Choise.start()
  end
end
