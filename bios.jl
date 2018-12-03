module BIOS

const DATA_BYTES_SIZE = 524288 # = 512*1024

struct data
  bytes::Vector{UInt8}
end

function load_bytes_from(path::AbstractString)
  # Open the BIOS file (for reading):
  try
    file = open(path, "r")
  catch error
    close(file)
    println("Can't open file: $error")
  end

  # Read (512KB of) the BIOS file:
  try
    bytes = read(file, DATA_BYTES_SIZE)
  catch error
    println("Can't read file: $error")
  finally
    close(file)
  end

  if sizeof(bytes) == DATA_BYTES_SIZE
    return bytes
  else
    throw(ErrorException("Invalid BIOS size."))
  end
end

"""
Load 4 bytes (from 'bytes' at 'offset')
(each byte an 8 bit unsigned integer and
converted to a 32 bit unsigned integer),
arrange them in little-endian format and
return a 32 bit unsigned integer.
"""
function load4(bytes::Vector{UInt8}, offset::Integer)
  offset = UInt32(offset) # Does it really need to be converted?

  b1::UInt32 = bytes[offset]  # Probably because Julia uses 1 as the
                              # first index of an array, here
                              # it should start with 'offset+1'.
  b2::UInt32 = bytes[offset+1]
  b3::UInt32 = bytes[offset+2]
  b4::UInt32 = bytes[offset+3]

  return b1 | (b2 << 8) | (b3 << 16) | (b4 << 24)
end
# 'bytes' of course needs to be a Vector{UInt8}, because that's
# what 'load_bytes_from' returns
#
# 'offset' needs to be an Integer, but probably it doesn't
# matter which kind

end