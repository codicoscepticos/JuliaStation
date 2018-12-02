/// Global interconnect
pub struct Interconnect {
  /// Basic Input/Output memory
  bios: Bios
}

impl Interconnect {
  pub fn new(bios: Bios) -> Interconnect {
    Interconnect {bios: bios}
  }
}