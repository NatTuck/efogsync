defmodule Efserv.FileView do
  use Efserv.Web, :view

  def render("index.json", %{files: files}) do
    %{data: render_many(files, Efserv.FileView, "file.json")}
  end

  def render("show.json", %{file: file}) do
    %{data: render_one(file, Efserv.FileView, "file.json")}
  end

  def render("file.json", %{file: file}) do
    %{id: file.id,
      share_id: file.share_id,
      name: file.name}
  end
end
