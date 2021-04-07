defmodule FriendsApp.CLI.MenuItems do
  alias FriendsApp.CLI.Menu

  def all, do: [
    %Menu{ label: "Cadastrar um amigo", id: :create },
    %Menu{ label: "Lista os amigos",    id: :read },
    %Menu{ label: "Atualiza um amigo",  id: :update },
    %Menu{ label: "Deleta um amigo",    id: :delete },
  ]
end