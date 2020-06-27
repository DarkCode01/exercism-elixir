defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(markdown) do
    markdown
    |> String.split("\n")
    |> Enum.map(&String.split/1)
    |> Enum.map_join(&process/1)
    |> close_list_tag
  end

  defp process([tag? | text]) do
    cond do
      String.match?(tag?, ~r/^(#+)$/) ->
        tag?
        |> String.length
        |> parser_header(text)
      String.match?(tag?, ~r/(\*+)$/) -> parser_list(text)
      true -> parser_paragraph([tag? | text])
    end
  end

  defp parser_header(header, text) do
    "<h#{header}>#{Enum.join(text, " ")}</h#{header}>"
  end

  defp parser_list(text) do
    "<li>#{parser_words(text)}</li>"
  end

  defp parser_paragraph(text) do
    "<p>#{parser_words(text)}</p>"
  end

  defp parser_words(text) do
    text
    |> Enum.map(&replace_prefix_md/1)
    |> Enum.map(&replace_suffix_md/1)
    |> Enum.join(" ")
  end

  defp replace_prefix_md(w) do
    cond do
      w =~ ~r/^#{"__"}{1}/ -> String.replace(w, ~r/^#{"__"}{1}/, "<strong>", global: false)
      w =~ ~r/^[#{"_"}{1}][^#{"_"}+]/ -> String.replace(w, ~r/_/, "<em>", global: false)
      true -> w
    end
  end

  defp replace_suffix_md(w) do
    cond do
      w =~ ~r/#{"__"}{1}$/ -> String.replace(w, ~r/#{"__"}{1}$/, "</strong>")
      w =~ ~r/[^#{"_"}{1}]/ -> String.replace(w, ~r/_/, "</em>")
      true -> w
    end
  end

  defp close_list_tag(tag) do
    tag
    |> String.replace("<li>", "<ul><li>", global: false)
    |> String.replace_suffix("</li>", "</li></ul>")
  end
end