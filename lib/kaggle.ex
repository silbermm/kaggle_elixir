defmodule Kaggle do

  def doit do
    data = open_file
    train_data(data)
  end

  def open_file do 
    File.stream!("./winequality-data.csv") 
    |> CSV.decode 
    |> Enum.to_list
    |> Enum.drop(1)
  end

  def train_data(data) do
    bayes = SimpleBayes.init()
    Enum.each(data, fn(d) -> 
      quality = Enum.at(d, 11)
      d = Enum.drop(d, -2)
      SimpleBayes.train(bayes, quality, Enum.join(d, " "))
    end)
    bayes
  end
end
