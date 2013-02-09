module TapUnless
  ##
  # See TapIf
  #
  def tap_unless(*args)
    yield self if ((args.empty? && !self) || (args.any? && respond_to?(args.first) && !send(*args)))
    #
    self
  end
end

Object.send(:include, TapUnless)
