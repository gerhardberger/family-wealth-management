# HW01: Family wealth management

partner_1: address
partner_2: address
heir: address

value: public(wei_value)
last_access: public(timestamp)

@public
def __init__(_partner: address, _heir: address):
    self.partner_1 = _partner
    self.partner_2 = msg.sender
    self.heir = _heir
    self.last_access = block.timestamp


@public
@payable
def pay():
    assert msg.sender == self.partner_1 or msg.sender == self.partner_2

    assert block.timestamp <= (self.last_access + 60 * 60 * 24 * 365)

    self.value += msg.value


@public
def withdraw(amount: wei_value):
    assert msg.sender == self.partner_1 or msg.sender == self.partner_2

    assert block.timestamp <= (self.last_access + 60 * 60 * 24 * 365)

    assert amount <= 1000000000000000000

    assert (self.value - amount) >= 0

    self.value -= amount
    self.last_access = block.timestamp

    send(msg.sender, amount)


@public
def inherit():
    assert block.timestamp >= (self.last_access + 60 * 60 * 24 * 365)

    selfdestruct(self.heir)


