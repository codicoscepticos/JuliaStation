const BIOS_SIZE = 524288 # = 512*1024

# BIOS image
struct BIOS
  # BIOS data
  data::Vector{UInt8}
end

function load_BIOS_data_from(path::String)
  # Open the BIOS file:
  try
    file = open(path, "r")
  catch error
    println("Can't open file: $error")
  end

  # Read the BIOS file:
  try
    data = read(file, BIOS_SIZE)
  catch error
    println("Can't read file: $error")
  end

  if sizeof(data) == BIOS_SIZE
    bios = BIOS(data)
  else
    throw(ErrorException("Invalid BIOS size"))
  end

  close(file)

  return bios
end