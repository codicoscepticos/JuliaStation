const BIOS_DATA_BYTE_SIZE = 524288 # = 512*1024

struct BIOS
  data::Vector{UInt8}
end

function load_BIOS_data_from(path::AbstractString)
  # Open the BIOS file (for reading):
  try
    file = open(path, "r")
  catch error
    println("Can't open file: $error")
  end

  # Read (512KB of) the BIOS file:
  try
    data = read(file, BIOS_DATA_BYTE_SIZE)
  catch error
    println("Can't read file: $error")
  end

  close(file)

  if sizeof(data) == BIOS_DATA_BYTE_SIZE
    return data
  else
    throw(ErrorException("Invalid BIOS size."))
  end
end

# Fetch the 32 bit little endian word at 'offset'
function load4bytes(data::Vector{UInt8}, offset::Integer)
  offset = UInt32(offset) # Does it really need to be converted?

  b0::UInt32 = data[offset] # Probably because Julia uses 1 as the
                            # first index of an array, here
                            # it should start with 'offset+1'.
  b1::UInt32 = data[offset+1]
  b2::UInt32 = data[offset+2]
  b3::UInt32 = data[offset+3]

  return b0 | (b1 << 8) | (b2 << 16) | (b3 << 24)
end
# 'data' of course needs to be a Vector{UInt8}, because that's
# what 'load_BIOS_data_from' returns
#
# 'offset' needs to be an Integer, but probably it doesn't
# matter the exact kind