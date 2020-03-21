from typing import List, Tuple

# global Variables
bus_bits: List[bool] = [False] * 16


def add_bits(bit1: bool, bit2: bool, carry: bool = False) -> Tuple[bool, bool]:
    partial_bit: bool = bit1 ^ bit2
    carry_bit: bool = (partial_bit & partial_bit) | (bit1 & bit2)
    sum_bit: bool = partial_bit ^ carry
    return sum_bit, carry_bit


def sub_bits(bit1: bool, bit2: bool, carry: bool = False) -> Tuple[bool, bool]:
    return add_bits(bit1, not bit2, not carry)


class Register:
    def __init__(self):
        self.bits: List[bool] = [False] * 16

    def read_bus(self):
        global bus_bits
        self.bits = list(bus_bits)

    def write_bus(self):
        global bus_bits
        bus_bits = list(self.bits)

    def read_lower_into_lower_register(self):
        global bus_bits
        self.bits[:8] = list(bus_bits[:8])

    def read_lower_into_higher_register(self):
        global bus_bits
        self.bits[8:] = list(bus_bits[:8])

    def write_lower_register_into_lower(self):
        global bus_bits
        bus_bits[:8] = list(self.bits[:8])

    def write_higher_register_into_lower(self):
        global bus_bits
        bus_bits[8:] = list(self.bits[:8])


class HiddenRegister(Register):
    def __init__(self):
        super().__init__()

    def write_to_private_bus(self, private_bus: List[bool]):
        private_bus[0:16] = list(self.bits)

    def read_from_private_bus(self, private_bus: List[bool]):
        self.bits[0:16] = list(private_bus[0:16])


class RegisterBank:
    def __init__(self):
        self.registers: List[Register] = [Register() for _ in range(16)]

    def read_bus(self, register_number):
        self.registers[register_number].read_bus()

    def write_bus(self, register_number):
        self.registers[register_number].write_bus()

    def read_lower_into_lower_register(self, register_number):
        self.registers[register_number].read_lower_into_lower_register()

    def read_lower_into_higher_register(self, register_number):
        self.registers[register_number].read_lower_into_higher_register()

    def write_lower_register_into_lower(self, register_number):
        self.registers[register_number].write_lower_register_into_lower()

    def write_higher_register_into_lower(self, register_number):
        self.registers[register_number].write_higher_register_into_lower()


class SimpleALUComponent:
    carry: bool
    output_bus: List[bool]
    bus1: List[bool]
    bus2: List[bool]

    def __init__(self):
        self.bus1 = [False] * 32
        self.bus2 = [False] * 32
        self.output_bus = [False] * 32
        self.carry = False

    def read_to_bus(self, bits: List[bool], mode: int, bus_select: bool):
        selected_bus: List[bool] = self.bus2 if bus_select else self.bus1
        selected_bus[:2 ** (mode + 3)] = bits

    def write_to_bus(self, private_bus: List[bool], mode: int):
        private_bus[:2 ** (3 + mode)] = self.output_bus[:2 ** (3 + mode)]


class SimpleAdder(SimpleALUComponent):
    def add_bits(self, carry: bool, mode: int):
        self.carry = carry
        for i in range(2 ** (3 + mode)):
            self.output_bus[i], self.carry = add_bits(self.bus1[i], self.bus2[i], self.carry)


class SimpleSubtract(SimpleALUComponent):

    def subtract_bits(self, carry: bool, mode: int):
        self.carry = carry
        for i in range(2 ** (3 + mode)):
            self.output_bus[i], self.carry = sub_bits(self.bus1[i], self.bus2[i], self.carry)


class Multiplier(SimpleALUComponent):
    adders: List[List[SimpleAdder]]

    def __init__(self):
        super().__init__()
        adders_level_1 = [SimpleAdder() for _ in range(8)]
        adders_level_2 = [SimpleAdder() for _ in range(4)]
        adders_level_3 = [SimpleAdder() for _ in range(2)]
        adders_level_4 = [SimpleAdder() for _ in range(1)]
        self.adders = [adders_level_1, adders_level_2, adders_level_3, adders_level_4]

        temp_buses: List[List[bool]] = [[False] * 32 for _ in range(16)]
        temp_output_1: List[List[bool]] = [[False] * 32 for _ in range(8)]
        temp_output_2: List[List[bool]] = [[False] * 32 for _ in range(4)]
        temp_output_3: List[List[bool]] = [[False] * 32 for _ in range(2)]
        self.bus_levels: List[List[List[bool]]] = [temp_buses, temp_output_1, temp_output_2, temp_output_3,
                                                   self.output_bus]

    def multiply(self):
        self.carry = False

        select_number: int
        for select_number in range(8):
            self.bus_levels[0][select_number * 2] = [False] * (select_number * 2) + self.bus1[:16] + [False] * (
                    16 - select_number * 2)
            self.bus_levels[0][select_number * 2 + 1] = [False] * (select_number * 2 + 1) + self.bus2[:16] + [False] * (
                    15 - select_number * 2)

        for level in range(4):
            temp_carry: bool = False
            for select_number in range(2 ** (3 - level)):
                self.adders[level][select_number].read_to_bus(self.bus_levels[level][select_number * 2], 2, False)
                self.adders[level][select_number].read_to_bus(self.bus_levels[level][select_number * 2 + 1], 2, True)
                self.adders[level][select_number].add_bits(temp_carry, 2)
                self.adders[level][select_number].write_to_bus(self.bus_levels[level + 1][select_number], 2)
                temp_carry = self.adders[level][select_number].carry
            self.carry = self.carry | temp_carry


class Divider:
    buses: List[List[bool]]
    carry: bool
    output_bus: List[bool]
    bus2: List[bool]
    bus1: List[bool]

    def __init__(self):
        self.bus1 = [False] * 32
        self.bus2 = [False] * 32
        self.output_bus = [False] * 32
        self.carry = False

        self.subtractors = [SimpleSubtract() for _ in range(16)]
        self.buses = [[False] * 32 for _ in range(16)]

    def divide(self):

        select_number: int
        for select_number in range(16):
            self.buses[select_number] = [False] * (15 - select_number) + self.bus2 + [False] * (select_number + 1)
            self.subtractors[select_number].read_to_bus(self.bus1, 1, False)
            self.subtractors[select_number].read_to_bus(self.buses[select_number], 2, True)
            self.subtractors[select_number].subtract_bits(False, 2)
            self.carry = self.subtractors[select_number].carry
            if not self.carry:
                self.subtractors[select_number].write_to_bus(self.bus1, 1)
            self.output_bus[31 - select_number] = self.carry
        self.subtractors[15].write_to_bus(self.output_bus, 1)


class ArithmeticAndLogicUnit:
    def __init__(self):
        self.private_bus = [False] * 16
        self.x_register = HiddenRegister()
        self.y_register = HiddenRegister()
        self.w_register = HiddenRegister()
        self.z_register = HiddenRegister()
        self.adder = SimpleAdder()
        self.subtractor = SimpleSubtract()
        self.multiplier = Multiplier()
        self.multiplier = Divider()


