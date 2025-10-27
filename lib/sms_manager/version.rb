module SmsManager
  class Version
    MAJOR = 0
    MINOR = 4
    PATCH = 0

    class << self
      def to_s
        [MAJOR, MINOR, PATCH].compact.join(".")
      end
    end
  end
end
