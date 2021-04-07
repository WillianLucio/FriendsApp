defmodule FriendsApp do
  def hello do
    :world
  end

  def meu_ambiente do
    case Mix.env() do
      :prod -> "Ambiente de produção"
      :dev -> "Ambiente de desenvolvimento"
      :test -> "Ambiente de testes"
    end
  end
  
end