class Array
  def clean
    join(" ").clean
  end
end

class String
  def clean
    gsub(/^:/, '')
  end
end