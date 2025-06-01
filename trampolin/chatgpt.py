import lief

# 1. Parse ELF target
binary = lief.parse("target") #compile with -no-pie -fno-PIE

# 2. Simpan entrypoint asli
original_entry = binary.header.entrypoint	#0x8049080
mylittle = "\x80\x90\x04\x08"
xmylittle = "\xb3\x91\x04\x08"	#0x080491b3 -> main

print(hex(original_entry))


shellcode = (
	"\xeb\x16\x31\xc0\x31\xdb\x31\xd2\xb0\x04\xb3"
	"\x01\x59\xb2\x11\xcd\x80\xb8"+mylittle+"\xff\xe0\xe8\xe5\xff\xff\xff\x48\x65\x6c\x6c\x6f"
	"\x20\x7a\x7a\x7a\x7a\x7a\x7a\x7a\x7a\x7a\x7a\x0a"

)
shellcode_bytes = list(shellcode.encode('latin'))



# 5. Buat segment baru
segment = lief.ELF.Segment()
segment.content = shellcode_bytes
segment.virtual_address = 0
segment.alignment = 0x1000
segment.flags = lief.ELF.Segment.FLAGS.R | lief.ELF.Segment.FLAGS.X
segment.type = lief.ELF.Segment.TYPE.LOAD

# 6. Tambahkan ke ELF
added_segment = binary.add(segment)
payload_va = added_segment.virtual_address

# 7. Ubah entrypoint ke shellcode
binary.header.entrypoint = payload_va

# 8. Simpan hasilnya
binary.write("patched_binary")
