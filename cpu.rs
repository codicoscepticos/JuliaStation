mod interconnect

/// CPU State
pub struct CPU {
  /// The program counter register
  pc: u32,
  inter: Interconnect
}

impl CPU { // impls are used to define methods for Rust structs and enums
  pub fn new() -> CPU {
    CPU {
      // PC reset value at the beginning of the BIOS
      pc: 0xbfc00000
    }
  }

  pub fn run_next_instruction(&mut self) {
    let pc = self.pc;

    // Fetch instruction at PC
    let instruction = self.load32(pc);

    // Increment PC to point to the next instruction
    self.pc = pc.wrapping_add(4);

    self.decode_and_execute(instruction);
  }
}