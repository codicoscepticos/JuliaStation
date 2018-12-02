/// BIOS image
pub struct Bios {
  /// BIOS memory
  data: Vec<u8>
}

impl Bios {
  /// Load a BIOS image from the file located at 'path'
  pub fn new(path: &Path) -> Result<Bios> {
    let file = try!(File::open(path));

    let mut data = Vec::new();

    // Load the BIOS
    try!(file.take(BIOS_SIZE)).read_to_end(&mut data));

    if data.len() == BIOS_SIZE as usize {
      Ok( Bios {data: data} )
    } else {
      Err(Error::new(ErrorKind::InvalidInput, "Invalid_BIOS_size"))
    }
  }

  /// Fetch the 32 bit little endian word at 'offset'
  pub fn load32(&self, offset: u32) -> u32 {
    let offset = offset as usize;

    let b0 = self.data[offset] as u32;
    let b1 = self.data[offset+1] as u32;
    let b2 = self.data[offset+2] as u32;
    let b3 = self.data[offset+3] as u32;

    b0 | (b1 << 8) | (b2 << 16) | (b3 << 24)
  }
}

/// BIOS images are always 512KB in length
const BIOS_SIZE: u64 = 512*1024;