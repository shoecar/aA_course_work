class Flash
  def self.now(req, message)
    Flash.new(req, message)
  end

  def self.later(res, message)
    Flash.new(res, message)
  end

  def self.message(req, res)
    message = nil
    req.cookies.each do |cookie|
      if cookie.name == "flash" && cookie.value != "empty"
        message = cookie.value
        Flash.overwrite(res)
      end
    end
    message
  end

  def self.overwrite(res)
    res.cookies << WEBrick::Cookie.new('flash', "empty")
  end

  def initialize(type, message)
    cookie = WEBrick::Cookie.new('flash', message)
    cookie.path = "/"
    type.cookies << cookie
  end
end
