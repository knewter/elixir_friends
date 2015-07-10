defmodule ElixirFriends.PostView do
  use ElixirFriends.Web, :view
  @total_links 10

  def pagination_links(paginator) do
    links = page_numbers(paginator)
            |> Enum.map(fn(number) -> page_link(number, paginator) end)
    content_tag(:div, links, class: "ui pagination menu")
  end

  def page_numbers(paginator) do
    page_numbers = (paginator.page_number..paginator.total_pages)
                   |> Enum.to_list

    if(paginator.page_number !== 1) do
      page_numbers = [{"<<", paginator.page_number - 1}, 1] ++ page_numbers
    end

    page_numbers = Enum.take(page_numbers, @total_links)

    if(paginator.page_number !== paginator.total_pages) do
      page_numbers = page_numbers ++ [paginator.total_pages, {">>", paginator.page_number + 1}]
    end

    page_numbers
  end

  def page_link({text, page_number}, paginator) do
    classes = ["item"]
    if paginator.page_number == page_number do
      classes = ["active" | classes]
    end
    link("#{text}", [to: "?page=#{page_number}", class: Enum.join(classes, " ")])
  end
  def page_link(page_number, paginator) do
    page_link({page_number, page_number}, paginator)
  end
end
