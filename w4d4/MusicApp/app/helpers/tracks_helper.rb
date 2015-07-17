module TracksHelper
  def ugly_lyrics(lyrics)
    pre_string = ""
    lyrics.split("\n").each do |line|
      pre_string += "&#9835; " + "#{h(line)}"
    end
    pre_string.html_safe
  end
end
