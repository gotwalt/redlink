module Redlink
  class Redthing
    def initialize(raw)
      raw.each do |k, v|
        self.send("#{k}=", v) if self.respond_to?("#{k}=")
      end
    end
  end
end
