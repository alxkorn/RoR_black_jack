module Symbolics
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def suites
      ['♣', '♦', '♥', '♠']
    end

    def ranks
      [*'2'..'10'] + %w[J Q K A]
    end
  end
end