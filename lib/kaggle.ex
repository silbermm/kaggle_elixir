defmodule Kaggle do

  def doit do
    data = open_file
    train_data(data)
  end

  def open_file do 
    File.stream!("./winequality-data.csv") |> CSV.decode |> Enum.to_list
  end

  def train_data(data) do
    bayes = SimpleBayes.init()
    IO.puts("starting loop")
    Enum.each(data, fn(d) -> 
      quality = Enum.take(d, 11)
      d = Enum.drop(d, -2)
      SimpleBayes.train(bayes, quality, Enum.join(d, " "))
    end)
    IO.puts("end loop")
    bayes
  end
end
