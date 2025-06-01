## cuma menambah segmen baru
## panggil payload dengan modifikasi intruksi dengan radare2 atau yang lain

import lief

binary = lief.parse("target")


shellcode = (
	"\xeb\x10\x31\xc0\x31\xdb\x31\xd2\xb0\x04\xb3\x01\x59\xb2\x11"
	"\xcd\x80\xc3\xe8\xeb\xff\xff\xff\x48\x65\x6c\x6c\x6f\x20\x7a"
	"\x7a\x7a\x7a\x7a\x7a\x7a\x7a\x7a\x7a\x0a"
)
shellcode_bytes = list(shellcode.encode('latin'))



# 5. Buat segment baru
segment = lief.ELF.Segment()
segment.content = shellcode_bytes
segment.virtual_address = 0
segment.alignment = 0x1000
segment.flags = lief.ELF.Segment.FLAGS.R | lief.ELF.Segment.FLAGS.X
segment.type = lief.ELF.Segment.TYPE.LOAD

added_segment = binary.add(segment)
payload_va = added_segment.virtual_address

print(f"Segmen baru di: "+hex(added_segment.virtual_address))

binary.write("patched_binary")
