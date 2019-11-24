class NilParamsError < StandardError
  def message
    "params can't be empty, please enter amount, source-currency and target-currency"
  end
end

class InvalidSourceCurrencyParamError < StandardError
  def message
    "Source currency not supported"
  end
end

class InvalidTargetCurrencyParamError < StandardError
  def message
    "Target currency not supported"
  end
end