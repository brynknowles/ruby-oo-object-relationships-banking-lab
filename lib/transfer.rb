require 'pry'

class Transfer
  attr_accessor :sender, :receiver, :amount, :status

  def initialize (sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end

  def valid?
    sender.valid?
    receiver.valid?
  end

  def execute_transaction
    if valid? && sender.balance > self.amount && self.status == "pending" 
      sender.balance -= self.amount
      receiver.balance += self.amount
      self.status = "complete"
    else
      reject_transfer
    end
  end

  def reverse_transfer
    if status == "complete"
      receiver.balance -= self.amount
      sender.balance += self.amount
      self.status = "reversed"
    end
  end

  def reject_transfer
    self.status = "rejected"
    "Transaction rejected. Please check your account balance."
  end

end

