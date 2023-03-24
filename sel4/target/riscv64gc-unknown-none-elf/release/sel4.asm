
target/riscv64gc-unknown-none-elf/release/sel4:	file format elf64-littleriscv

Disassembly of section .text:

0000000080200000 <stext>:
80200000: 17 a1 08 00  	auipc	sp, 138
80200004: 13 01 81 7a  	addi	sp, sp, 1960
80200008: 97 10 00 00  	auipc	ra, 1
8020000c: e7 80 40 55  	jalr	1364(ra)
		...

0000000080201000 <__alltraps>:
80201000: 73 11 01 14  	csrrw	sp, sscratch, sp
80201004: 6d 71        	addi	sp, sp, -272
80201006: 06 e4        	sd	ra, 8(sp)
80201008: 0e ec        	sd	gp, 24(sp)
8020100a: 16 f4        	sd	t0, 40(sp)
8020100c: 1a f8        	sd	t1, 48(sp)
8020100e: 1e fc        	sd	t2, 56(sp)
80201010: a2 e0        	sd	s0, 64(sp)
80201012: a6 e4        	sd	s1, 72(sp)
80201014: aa e8        	sd	a0, 80(sp)
80201016: ae ec        	sd	a1, 88(sp)
80201018: b2 f0        	sd	a2, 96(sp)
8020101a: b6 f4        	sd	a3, 104(sp)
8020101c: ba f8        	sd	a4, 112(sp)
8020101e: be fc        	sd	a5, 120(sp)
80201020: 42 e1        	sd	a6, 128(sp)
80201022: 46 e5        	sd	a7, 136(sp)
80201024: 4a e9        	sd	s2, 144(sp)
80201026: 4e ed        	sd	s3, 152(sp)
80201028: 52 f1        	sd	s4, 160(sp)
8020102a: 56 f5        	sd	s5, 168(sp)
8020102c: 5a f9        	sd	s6, 176(sp)
8020102e: 5e fd        	sd	s7, 184(sp)
80201030: e2 e1        	sd	s8, 192(sp)
80201032: e6 e5        	sd	s9, 200(sp)
80201034: ea e9        	sd	s10, 208(sp)
80201036: ee ed        	sd	s11, 216(sp)
80201038: f2 f1        	sd	t3, 224(sp)
8020103a: f6 f5        	sd	t4, 232(sp)
8020103c: fa f9        	sd	t5, 240(sp)
8020103e: fe fd        	sd	t6, 248(sp)
80201040: f3 22 00 10  	csrr	t0, sstatus
80201044: 73 23 10 14  	csrr	t1, sepc
80201048: 16 e2        	sd	t0, 256(sp)
8020104a: 1a e6        	sd	t1, 264(sp)
8020104c: f3 23 00 14  	csrr	t2, sscratch
80201050: 1e e8        	sd	t2, 16(sp)
80201052: 0a 85        	mv	a0, sp
80201054: 97 10 00 00  	auipc	ra, 1
80201058: e7 80 a0 87  	jalr	-1926(ra)

000000008020105c <__restore>:
8020105c: 92 62        	ld	t0, 256(sp)
8020105e: 32 63        	ld	t1, 264(sp)
80201060: c2 63        	ld	t2, 16(sp)
80201062: 73 90 02 10  	csrw	sstatus, t0
80201066: 73 10 13 14  	csrw	sepc, t1
8020106a: 73 90 03 14  	csrw	sscratch, t2
8020106e: a2 60        	ld	ra, 8(sp)
80201070: e2 61        	ld	gp, 24(sp)
80201072: a2 72        	ld	t0, 40(sp)
80201074: 42 73        	ld	t1, 48(sp)
80201076: e2 73        	ld	t2, 56(sp)
80201078: 06 64        	ld	s0, 64(sp)
8020107a: a6 64        	ld	s1, 72(sp)
8020107c: 46 65        	ld	a0, 80(sp)
8020107e: e6 65        	ld	a1, 88(sp)
80201080: 06 76        	ld	a2, 96(sp)
80201082: a6 76        	ld	a3, 104(sp)
80201084: 46 77        	ld	a4, 112(sp)
80201086: e6 77        	ld	a5, 120(sp)
80201088: 0a 68        	ld	a6, 128(sp)
8020108a: aa 68        	ld	a7, 136(sp)
8020108c: 4a 69        	ld	s2, 144(sp)
8020108e: ea 69        	ld	s3, 152(sp)
80201090: 0a 7a        	ld	s4, 160(sp)
80201092: aa 7a        	ld	s5, 168(sp)
80201094: 4a 7b        	ld	s6, 176(sp)
80201096: ea 7b        	ld	s7, 184(sp)
80201098: 0e 6c        	ld	s8, 192(sp)
8020109a: ae 6c        	ld	s9, 200(sp)
8020109c: 4e 6d        	ld	s10, 208(sp)
8020109e: ee 6d        	ld	s11, 216(sp)
802010a0: 0e 7e        	ld	t3, 224(sp)
802010a2: ae 7e        	ld	t4, 232(sp)
802010a4: 4e 7f        	ld	t5, 240(sp)
802010a6: ee 7f        	ld	t6, 248(sp)
802010a8: 51 61        	addi	sp, sp, 272
802010aa: 73 11 01 14  	csrrw	sp, sscratch, sp
802010ae: 73 00 20 10  	sret	
802010b2: 00 00        	unimp	

00000000802010b4 <__switch>:
802010b4: 23 34 25 00  	sd	sp, 8(a0)
802010b8: 23 30 15 00  	sd	ra, 0(a0)
802010bc: 00 e9        	sd	s0, 16(a0)
802010be: 04 ed        	sd	s1, 24(a0)
802010c0: 23 30 25 03  	sd	s2, 32(a0)
802010c4: 23 34 35 03  	sd	s3, 40(a0)
802010c8: 23 38 45 03  	sd	s4, 48(a0)
802010cc: 23 3c 55 03  	sd	s5, 56(a0)
802010d0: 23 30 65 05  	sd	s6, 64(a0)
802010d4: 23 34 75 05  	sd	s7, 72(a0)
802010d8: 23 38 85 05  	sd	s8, 80(a0)
802010dc: 23 3c 95 05  	sd	s9, 88(a0)
802010e0: 23 30 a5 07  	sd	s10, 96(a0)
802010e4: 23 34 b5 07  	sd	s11, 104(a0)
802010e8: 83 b0 05 00  	ld	ra, 0(a1)
802010ec: 80 69        	ld	s0, 16(a1)
802010ee: 84 6d        	ld	s1, 24(a1)
802010f0: 03 b9 05 02  	ld	s2, 32(a1)
802010f4: 83 b9 85 02  	ld	s3, 40(a1)
802010f8: 03 ba 05 03  	ld	s4, 48(a1)
802010fc: 83 ba 85 03  	ld	s5, 56(a1)
80201100: 03 bb 05 04  	ld	s6, 64(a1)
80201104: 83 bb 85 04  	ld	s7, 72(a1)
80201108: 03 bc 05 05  	ld	s8, 80(a1)
8020110c: 83 bc 85 05  	ld	s9, 88(a1)
80201110: 03 bd 05 06  	ld	s10, 96(a1)
80201114: 83 bd 85 06  	ld	s11, 104(a1)
80201118: 03 b1 85 00  	ld	sp, 8(a1)
8020111c: 82 80        	ret

Disassembly of section .text._ZN4sel45tasks13run_next_task17h1b1964c9a804d163E.llvm.11147085046330256822:

000000008020111e <_ZN4sel45tasks13run_next_task17h1b1964c9a804d163E.llvm.11147085046330256822>:
8020111e: 39 71        	addi	sp, sp, -64
80201120: 06 fc        	sd	ra, 56(sp)
80201122: 22 f8        	sd	s0, 48(sp)
80201124: 80 00        	addi	s0, sp, 64

0000000080201126 <.LBB0_16>:
80201126: 17 95 07 00  	auipc	a0, 121
8020112a: 13 05 a5 ed  	addi	a0, a0, -294
8020112e: 97 10 00 00  	auipc	ra, 1
80201132: e7 80 c0 ef  	jalr	-260(ra)
80201136: 0c 61        	ld	a1, 0(a0)
80201138: 63 9d 05 10  	bnez	a1, 0x80201252 <.LBB0_24>
8020113c: 03 38 85 78  	ld	a6, 1928(a0)
80201140: 03 3e 05 79  	ld	t3, 1936(a0)
80201144: fd 56        	li	a3, -1
80201146: 13 06 18 00  	addi	a2, a6, 1
8020114a: b3 05 ce 00  	add	a1, t3, a2
8020114e: 14 e1        	sd	a3, 0(a0)
80201150: 2e 87        	mv	a4, a1
80201152: 63 63 b6 00  	bltu	a2, a1, 0x80201158 <.LBB0_16+0x32>
80201156: 32 87        	mv	a4, a2
80201158: 63 01 0e 08  	beqz	t3, 0x802011da <.LBB0_17+0x16>
8020115c: 93 03 85 00  	addi	t2, a0, 8
80201160: c1 48        	li	a7, 16
80201162: 93 02 80 07  	li	t0, 120
80201166: 05 43        	li	t1, 1
80201168: 63 05 c7 0a  	beq	a4, a2, 0x80201212 <.LBB0_20+0x16>
8020116c: b3 76 c6 03  	remu	a3, a2, t3
80201170: 63 fa 16 05  	bgeu	a3, a7, 0x802011c4 <.LBB0_17>
80201174: b3 85 56 02  	mul	a1, a3, t0
80201178: 9e 95        	add	a1, a1, t2
8020117a: 83 c7 05 07  	lbu	a5, 112(a1)
8020117e: 05 06        	addi	a2, a2, 1
80201180: e3 94 67 fe  	bne	a5, t1, 0x80201168 <.LBB0_16+0x42>
80201184: 93 85 05 07  	addi	a1, a1, 112
80201188: 7d 56        	li	a2, -1
8020118a: 10 e1        	sd	a2, 0(a0)
8020118c: 09 46        	li	a2, 2
8020118e: 23 80 c5 00  	sb	a2, 0(a1)
80201192: c1 45        	li	a1, 16
80201194: 23 34 d5 78  	sd	a3, 1928(a0)
80201198: 63 72 b8 06  	bgeu	a6, a1, 0x802011fc <.LBB0_20>
8020119c: 93 05 80 07  	li	a1, 120
802011a0: 33 06 b8 02  	mul	a2, a6, a1
802011a4: 18 61        	ld	a4, 0(a0)
802011a6: b3 85 b6 02  	mul	a1, a3, a1
802011aa: 1e 96        	add	a2, a2, t2
802011ac: 9e 95        	add	a1, a1, t2
802011ae: 93 06 17 00  	addi	a3, a4, 1
802011b2: 14 e1        	sd	a3, 0(a0)
802011b4: 32 85        	mv	a0, a2
802011b6: e2 70        	ld	ra, 56(sp)
802011b8: 42 74        	ld	s0, 48(sp)
802011ba: 21 61        	addi	sp, sp, 64
802011bc: 17 03 00 00  	auipc	t1, 0
802011c0: 67 00 83 ef  	jr	-264(t1)

00000000802011c4 <.LBB0_17>:
802011c4: 17 56 04 00  	auipc	a2, 69
802011c8: 13 06 c6 e9  	addi	a2, a2, -356
802011cc: c1 45        	li	a1, 16
802011ce: 36 85        	mv	a0, a3
802011d0: 97 20 00 00  	auipc	ra, 2
802011d4: e7 80 e0 a9  	jalr	-1378(ra)
802011d8: 00 00        	unimp	
802011da: 63 7c b6 02  	bgeu	a2, a1, 0x80201212 <.LBB0_20+0x16>

00000000802011de <.LBB0_18>:
802011de: 17 55 04 00  	auipc	a0, 69
802011e2: 13 05 25 e4  	addi	a0, a0, -446

00000000802011e6 <.LBB0_19>:
802011e6: 17 56 04 00  	auipc	a2, 69
802011ea: 13 06 a6 e1  	addi	a2, a2, -486
802011ee: 93 05 90 03  	li	a1, 57
802011f2: 97 20 00 00  	auipc	ra, 2
802011f6: e7 80 00 a5  	jalr	-1456(ra)
802011fa: 00 00        	unimp	

00000000802011fc <.LBB0_20>:
802011fc: 17 46 00 00  	auipc	a2, 4
80201200: 13 06 c6 e7  	addi	a2, a2, -388
80201204: c1 45        	li	a1, 16
80201206: 42 85        	mv	a0, a6
80201208: 97 20 00 00  	auipc	ra, 2
8020120c: e7 80 60 a6  	jalr	-1434(ra)
80201210: 00 00        	unimp	
80201212: 23 30 05 00  	sd	zero, 0(a0)

0000000080201216 <.LBB0_21>:
80201216: 17 45 00 00  	auipc	a0, 4
8020121a: 13 05 a5 e0  	addi	a0, a0, -502
8020121e: 23 38 a4 fc  	sd	a0, -48(s0)
80201222: 05 45        	li	a0, 1
80201224: 23 3c a4 fc  	sd	a0, -40(s0)
80201228: 23 30 04 fc  	sd	zero, -64(s0)

000000008020122c <.LBB0_22>:
8020122c: 17 45 00 00  	auipc	a0, 4
80201230: 13 05 45 dd  	addi	a0, a0, -556
80201234: 23 30 a4 fe  	sd	a0, -32(s0)
80201238: 23 34 04 fe  	sd	zero, -24(s0)

000000008020123c <.LBB0_23>:
8020123c: 97 45 00 00  	auipc	a1, 4
80201240: 93 85 45 e2  	addi	a1, a1, -476
80201244: 13 05 04 fc  	addi	a0, s0, -64
80201248: 97 20 00 00  	auipc	ra, 2
8020124c: e7 80 c0 9c  	jalr	-1588(ra)
80201250: 00 00        	unimp	

0000000080201252 <.LBB0_24>:
80201252: 17 45 00 00  	auipc	a0, 4
80201256: 13 05 e5 dd  	addi	a0, a0, -546

000000008020125a <.LBB0_25>:
8020125a: 97 46 00 00  	auipc	a3, 4
8020125e: 93 86 e6 f3  	addi	a3, a3, -194

0000000080201262 <.LBB0_26>:
80201262: 17 47 00 00  	auipc	a4, 4
80201266: 13 07 67 f6  	addi	a4, a4, -154
8020126a: c1 45        	li	a1, 16
8020126c: 13 06 04 fc  	addi	a2, s0, -64
80201270: 97 20 00 00  	auipc	ra, 2
80201274: e7 80 e0 a3  	jalr	-1474(ra)
80201278: 00 00        	unimp	

Disassembly of section .text._ZN4sel45tasks25exit_current_and_run_next17h7182b0dcba0aa63aE:

000000008020127a <_ZN4sel45tasks25exit_current_and_run_next17h7182b0dcba0aa63aE>:
8020127a: 01 11        	addi	sp, sp, -32
8020127c: 06 ec        	sd	ra, 24(sp)
8020127e: 22 e8        	sd	s0, 16(sp)
80201280: 00 10        	addi	s0, sp, 32

0000000080201282 <.LBB2_5>:
80201282: 17 95 07 00  	auipc	a0, 121
80201286: 13 05 e5 d7  	addi	a0, a0, -642
8020128a: 97 10 00 00  	auipc	ra, 1
8020128e: e7 80 00 da  	jalr	-608(ra)
80201292: 0c 61        	ld	a1, 0(a0)
80201294: a9 e5        	bnez	a1, 0x802012de <.LBB2_7>
80201296: 83 36 85 78  	ld	a3, 1928(a0)
8020129a: fd 55        	li	a1, -1
8020129c: 41 46        	li	a2, 16
8020129e: 0c e1        	sd	a1, 0(a0)
802012a0: 63 f4 c6 02  	bgeu	a3, a2, 0x802012c8 <.LBB2_6>
802012a4: 93 05 80 07  	li	a1, 120
802012a8: b3 85 b6 02  	mul	a1, a3, a1
802012ac: aa 95        	add	a1, a1, a0
802012ae: 0d 46        	li	a2, 3
802012b0: 23 8c c5 06  	sb	a2, 120(a1)
802012b4: 0c 61        	ld	a1, 0(a0)
802012b6: 85 05        	addi	a1, a1, 1
802012b8: 0c e1        	sd	a1, 0(a0)
802012ba: e2 60        	ld	ra, 24(sp)
802012bc: 42 64        	ld	s0, 16(sp)
802012be: 05 61        	addi	sp, sp, 32
802012c0: 17 03 00 00  	auipc	t1, 0
802012c4: 67 00 e3 e5  	jr	-418(t1)

00000000802012c8 <.LBB2_6>:
802012c8: 17 46 00 00  	auipc	a2, 4
802012cc: 13 06 06 de  	addi	a2, a2, -544
802012d0: c1 45        	li	a1, 16
802012d2: 36 85        	mv	a0, a3
802012d4: 97 20 00 00  	auipc	ra, 2
802012d8: e7 80 a0 99  	jalr	-1638(ra)
802012dc: 00 00        	unimp	

00000000802012de <.LBB2_7>:
802012de: 17 45 00 00  	auipc	a0, 4
802012e2: 13 05 25 d5  	addi	a0, a0, -686

00000000802012e6 <.LBB2_8>:
802012e6: 97 46 00 00  	auipc	a3, 4
802012ea: 93 86 26 eb  	addi	a3, a3, -334

00000000802012ee <.LBB2_9>:
802012ee: 17 47 00 00  	auipc	a4, 4
802012f2: 13 07 a7 ed  	addi	a4, a4, -294
802012f6: c1 45        	li	a1, 16
802012f8: 13 06 84 fe  	addi	a2, s0, -24
802012fc: 97 20 00 00  	auipc	ra, 2
80201300: e7 80 20 9b  	jalr	-1614(ra)
80201304: 00 00        	unimp	

Disassembly of section .text._ZN4sel46kernel6vspace17map_kernel_window17h77fa3b31719dc57eE:

0000000080201306 <_ZN4sel46kernel6vspace17map_kernel_window17h77fa3b31719dc57eE>:
80201306: 41 11        	addi	sp, sp, -16
80201308: 06 e4        	sd	ra, 8(sp)
8020130a: 22 e0        	sd	s0, 0(sp)
8020130c: 00 08        	addi	s0, sp, 16

000000008020130e <.LBB2_5>:
8020130e: 17 a8 88 00  	auipc	a6, 2186
80201312: 13 08 28 cf  	addi	a6, a6, -782
80201316: 93 08 f8 7f  	addi	a7, a6, 2047
8020131a: 13 86 18 00  	addi	a2, a7, 1
8020131e: 93 06 f0 0e  	li	a3, 239
80201322: 13 05 f0 ef  	li	a0, -257
80201326: 13 17 e5 01  	slli	a4, a0, 30
8020132a: b7 07 00 40  	lui	a5, 262144
8020132e: 37 05 00 10  	lui	a0, 65536
80201332: f5 55        	li	a1, -3
80201334: fa 05        	slli	a1, a1, 30
80201336: 14 e2        	sd	a3, 0(a2)
80201338: 3e 97        	add	a4, a4, a5
8020133a: 21 06        	addi	a2, a2, 8
8020133c: aa 96        	add	a3, a3, a0
8020133e: e3 6c b7 fe  	bltu	a4, a1, 0x80201336 <.LBB2_5+0x28>

0000000080201342 <.LBB2_6>:
80201342: 17 b6 88 00  	auipc	a2, 2187
80201346: 13 06 e6 cb  	addi	a2, a2, -834
8020134a: 13 55 26 00  	srli	a0, a2, 2
8020134e: b7 05 f0 ff  	lui	a1, 1048320
80201352: a9 81        	srli	a1, a1, 10
80201354: 6d 8d        	and	a0, a0, a1
80201356: 13 65 15 02  	ori	a0, a0, 33
8020135a: a3 b8 a8 00  	sd	a0, 17(a7)
8020135e: a3 b8 a8 7e  	sd	a0, 2033(a7)
80201362: 23 38 a8 00  	sd	a0, 16(a6)
80201366: 13 05 f0 bf  	li	a0, -1025
8020136a: 56 05        	slli	a0, a0, 21
8020136c: b7 05 00 20  	lui	a1, 131072
80201370: 9b 85 f5 0e  	addiw	a1, a1, 239
80201374: b7 06 20 00  	lui	a3, 512
80201378: 37 07 08 00  	lui	a4, 128
8020137c: b7 07 e0 bf  	lui	a5, 785920
80201380: 0c e2        	sd	a1, 0(a2)
80201382: 36 95        	add	a0, a0, a3
80201384: 21 06        	addi	a2, a2, 8
80201386: ba 95        	add	a1, a1, a4
80201388: e3 6c f5 fe  	bltu	a0, a5, 0x80201380 <.LBB2_6+0x3e>
8020138c: a2 60        	ld	ra, 8(sp)
8020138e: 02 64        	ld	s0, 0(sp)
80201390: 41 01        	addi	sp, sp, 16
80201392: 82 80        	ret

Disassembly of section .text._ZN4sel46kernel6vspace22activate_kernel_vspace17h45e1e4c8e602d25cE:

0000000080201394 <_ZN4sel46kernel6vspace22activate_kernel_vspace17h45e1e4c8e602d25cE>:
80201394: 41 11        	addi	sp, sp, -16
80201396: 06 e4        	sd	ra, 8(sp)
80201398: 22 e0        	sd	s0, 0(sp)
8020139a: 00 08        	addi	s0, sp, 16

000000008020139c <.LBB3_1>:
8020139c: 17 a5 88 00  	auipc	a0, 2186
802013a0: 13 05 45 c6  	addi	a0, a0, -924
802013a4: 22 05        	slli	a0, a0, 8
802013a6: 51 81        	srli	a0, a0, 20
802013a8: fd 55        	li	a1, -1
802013aa: fe 15        	slli	a1, a1, 63
802013ac: 4d 8d        	or	a0, a0, a1
802013ae: 73 10 05 18  	csrw	satp, a0
802013b2: 73 00 00 12  	sfence.vma
802013b6: a2 60        	ld	ra, 8(sp)
802013b8: 02 64        	ld	s0, 0(sp)
802013ba: 41 01        	addi	sp, sp, 16
802013bc: 82 80        	ret

Disassembly of section .text._ZN4core3ptr48drop_in_place$LT$core..str..error..Utf8Error$GT$17h9e31f42c699c2e38E.llvm.10631528657514373714:

00000000802013be <_ZN4core3ptr48drop_in_place$LT$core..str..error..Utf8Error$GT$17h9e31f42c699c2e38E.llvm.10631528657514373714>:
802013be: 41 11        	addi	sp, sp, -16
802013c0: 06 e4        	sd	ra, 8(sp)
802013c2: 22 e0        	sd	s0, 0(sp)
802013c4: 00 08        	addi	s0, sp, 16
802013c6: a2 60        	ld	ra, 8(sp)
802013c8: 02 64        	ld	s0, 0(sp)
802013ca: 41 01        	addi	sp, sp, 16
802013cc: 82 80        	ret

Disassembly of section .text._ZN4sel47syscall2fs9sys_write17hdd3ca81d921860cdE:

00000000802013ce <_ZN4sel47syscall2fs9sys_write17hdd3ca81d921860cdE>:
802013ce: 19 71        	addi	sp, sp, -128
802013d0: 86 fc        	sd	ra, 120(sp)
802013d2: a2 f8        	sd	s0, 112(sp)
802013d4: a6 f4        	sd	s1, 104(sp)
802013d6: 00 01        	addi	s0, sp, 128
802013d8: 85 46        	li	a3, 1
802013da: 63 16 d5 08  	bne	a0, a3, 0x80201466 <.LBB1_10>
802013de: b2 84        	mv	s1, a2
802013e0: 13 05 04 fb  	addi	a0, s0, -80
802013e4: 97 20 00 00  	auipc	ra, 2
802013e8: e7 80 c0 76  	jalr	1900(ra)
802013ec: 03 35 04 fb  	ld	a0, -80(s0)
802013f0: 45 e9        	bnez	a0, 0x802014a0 <.LBB1_12+0x16>
802013f2: 03 35 84 fb  	ld	a0, -72(s0)
802013f6: 83 35 04 fc  	ld	a1, -64(s0)
802013fa: 23 34 a4 f8  	sd	a0, -120(s0)
802013fe: 23 38 b4 f8  	sd	a1, -112(s0)
80201402: 13 05 84 f8  	addi	a0, s0, -120
80201406: 23 3c a4 f8  	sd	a0, -104(s0)

000000008020140a <.LBB1_7>:
8020140a: 17 15 00 00  	auipc	a0, 1
8020140e: 13 05 85 07  	addi	a0, a0, 120
80201412: 23 30 a4 fa  	sd	a0, -96(s0)
80201416: 13 05 04 fe  	addi	a0, s0, -32
8020141a: 23 34 a4 fa  	sd	a0, -88(s0)
8020141e: 23 38 04 fa  	sd	zero, -80(s0)

0000000080201422 <.LBB1_8>:
80201422: 17 45 00 00  	auipc	a0, 4
80201426: 13 05 65 d6  	addi	a0, a0, -666
8020142a: 23 30 a4 fc  	sd	a0, -64(s0)
8020142e: 05 45        	li	a0, 1
80201430: 23 34 a4 fc  	sd	a0, -56(s0)
80201434: 93 05 84 f9  	addi	a1, s0, -104
80201438: 23 38 b4 fc  	sd	a1, -48(s0)
8020143c: 23 3c a4 fc  	sd	a0, -40(s0)

0000000080201440 <.LBB1_9>:
80201440: 97 55 04 00  	auipc	a1, 69
80201444: 93 85 85 e5  	addi	a1, a1, -424
80201448: 13 05 84 fa  	addi	a0, s0, -88
8020144c: 13 06 04 fb  	addi	a2, s0, -80
80201450: 97 20 00 00  	auipc	ra, 2
80201454: e7 80 40 ec  	jalr	-316(ra)
80201458: 49 e1        	bnez	a0, 0x802014da <.LBB1_16>
8020145a: 26 85        	mv	a0, s1
8020145c: e6 70        	ld	ra, 120(sp)
8020145e: 46 74        	ld	s0, 112(sp)
80201460: a6 74        	ld	s1, 104(sp)
80201462: 09 61        	addi	sp, sp, 128
80201464: 82 80        	ret

0000000080201466 <.LBB1_10>:
80201466: 17 45 00 00  	auipc	a0, 4
8020146a: 13 05 a5 c7  	addi	a0, a0, -902
8020146e: 23 30 a4 fc  	sd	a0, -64(s0)
80201472: 23 34 d4 fc  	sd	a3, -56(s0)
80201476: 23 38 04 fa  	sd	zero, -80(s0)

000000008020147a <.LBB1_11>:
8020147a: 17 45 00 00  	auipc	a0, 4
8020147e: 13 05 65 c4  	addi	a0, a0, -954
80201482: 23 38 a4 fc  	sd	a0, -48(s0)
80201486: 23 3c 04 fc  	sd	zero, -40(s0)

000000008020148a <.LBB1_12>:
8020148a: 97 45 00 00  	auipc	a1, 4
8020148e: 93 85 e5 c7  	addi	a1, a1, -898
80201492: 13 05 04 fb  	addi	a0, s0, -80
80201496: 97 10 00 00  	auipc	ra, 1
8020149a: e7 80 e0 77  	jalr	1918(ra)
8020149e: 00 00        	unimp	
802014a0: 03 35 04 fc  	ld	a0, -64(s0)
802014a4: 83 35 84 fb  	ld	a1, -72(s0)
802014a8: 23 30 a4 fa  	sd	a0, -96(s0)
802014ac: 23 3c b4 f8  	sd	a1, -104(s0)

00000000802014b0 <.LBB1_13>:
802014b0: 17 45 00 00  	auipc	a0, 4
802014b4: 13 05 05 c7  	addi	a0, a0, -912

00000000802014b8 <.LBB1_14>:
802014b8: 97 46 00 00  	auipc	a3, 4
802014bc: 93 86 86 c9  	addi	a3, a3, -872

00000000802014c0 <.LBB1_15>:
802014c0: 17 47 00 00  	auipc	a4, 4
802014c4: 13 07 07 cb  	addi	a4, a4, -848
802014c8: 93 05 b0 02  	li	a1, 43
802014cc: 13 06 84 f9  	addi	a2, s0, -104
802014d0: 97 10 00 00  	auipc	ra, 1
802014d4: e7 80 e0 7d  	jalr	2014(ra)
802014d8: 00 00        	unimp	

00000000802014da <.LBB1_16>:
802014da: 17 55 04 00  	auipc	a0, 69
802014de: 13 05 e5 de  	addi	a0, a0, -530

00000000802014e2 <.LBB1_17>:
802014e2: 97 56 04 00  	auipc	a3, 69
802014e6: 93 86 66 e1  	addi	a3, a3, -490

00000000802014ea <.LBB1_18>:
802014ea: 17 57 04 00  	auipc	a4, 69
802014ee: 13 07 e7 e3  	addi	a4, a4, -450
802014f2: 93 05 b0 02  	li	a1, 43
802014f6: 13 06 04 fe  	addi	a2, s0, -32
802014fa: 97 10 00 00  	auipc	ra, 1
802014fe: e7 80 40 7b  	jalr	1972(ra)
80201502: 00 00        	unimp	

Disassembly of section .text._ZN4core3ptr47drop_in_place$LT$core..cell..BorrowMutError$GT$17h1c74932dfe841b87E.llvm.9544791052956948393:

0000000080201504 <_ZN4core3ptr47drop_in_place$LT$core..cell..BorrowMutError$GT$17h1c74932dfe841b87E.llvm.9544791052956948393>:
80201504: 41 11        	addi	sp, sp, -16
80201506: 06 e4        	sd	ra, 8(sp)
80201508: 22 e0        	sd	s0, 0(sp)
8020150a: 00 08        	addi	s0, sp, 16
8020150c: a2 60        	ld	ra, 8(sp)
8020150e: 02 64        	ld	s0, 0(sp)
80201510: 41 01        	addi	sp, sp, 16
80201512: 82 80        	ret

Disassembly of section .text._ZN4sel44trap7context11TrapContext16app_init_context17h534600b8bf72dac9E:

0000000080201514 <_ZN4sel44trap7context11TrapContext16app_init_context17h534600b8bf72dac9E>:
80201514: 79 71        	addi	sp, sp, -48
80201516: 06 f4        	sd	ra, 40(sp)
80201518: 22 f0        	sd	s0, 32(sp)
8020151a: 26 ec        	sd	s1, 24(sp)
8020151c: 4a e8        	sd	s2, 16(sp)
8020151e: 4e e4        	sd	s3, 8(sp)
80201520: 52 e0        	sd	s4, 0(sp)
80201522: 00 18        	addi	s0, sp, 48
80201524: f3 26 00 10  	csrr	a3, sstatus
80201528: 32 89        	mv	s2, a2
8020152a: ae 89        	mv	s3, a1
8020152c: aa 84        	mv	s1, a0
8020152e: 13 fa f6 ef  	andi	s4, a3, -257
80201532: 13 06 00 10  	li	a2, 256
80201536: 81 45        	li	a1, 0
80201538: 97 30 00 00  	auipc	ra, 3
8020153c: e7 80 20 f8  	jalr	-126(ra)
80201540: 23 b0 44 11  	sd	s4, 256(s1)
80201544: 23 b4 34 11  	sd	s3, 264(s1)
80201548: 23 b8 24 01  	sd	s2, 16(s1)
8020154c: a2 70        	ld	ra, 40(sp)
8020154e: 02 74        	ld	s0, 32(sp)
80201550: e2 64        	ld	s1, 24(sp)
80201552: 42 69        	ld	s2, 16(sp)
80201554: a2 69        	ld	s3, 8(sp)
80201556: 02 6a        	ld	s4, 0(sp)
80201558: 45 61        	addi	sp, sp, 48
8020155a: 82 80        	ret

Disassembly of section .text.rust_main:

000000008020155c <rust_main>:
8020155c: 39 71        	addi	sp, sp, -64
8020155e: 06 fc        	sd	ra, 56(sp)
80201560: 22 f8        	sd	s0, 48(sp)
80201562: 80 00        	addi	s0, sp, 64

0000000080201564 <.LBB4_1>:
80201564: 17 45 00 00  	auipc	a0, 4
80201568: 13 05 45 c9  	addi	a0, a0, -876
8020156c: 23 38 a4 fc  	sd	a0, -48(s0)
80201570: 05 45        	li	a0, 1
80201572: 23 3c a4 fc  	sd	a0, -40(s0)
80201576: 23 30 04 fc  	sd	zero, -64(s0)

000000008020157a <.LBB4_2>:
8020157a: 17 45 00 00  	auipc	a0, 4
8020157e: 13 05 e5 c1  	addi	a0, a0, -994
80201582: 23 30 a4 fe  	sd	a0, -32(s0)
80201586: 23 34 04 fe  	sd	zero, -24(s0)
8020158a: 13 05 04 fc  	addi	a0, s0, -64
8020158e: 97 00 00 00  	auipc	ra, 0
80201592: e7 80 00 7c  	jalr	1984(ra)
80201596: 97 00 00 00  	auipc	ra, 0
8020159a: e7 80 c0 25  	jalr	604(ra)
8020159e: 97 00 00 00  	auipc	ra, 0
802015a2: e7 80 80 d6  	jalr	-664(ra)
802015a6: 97 00 00 00  	auipc	ra, 0
802015aa: e7 80 e0 de  	jalr	-530(ra)
802015ae: 97 00 00 00  	auipc	ra, 0
802015b2: e7 80 20 01  	jalr	18(ra)
802015b6: 97 00 00 00  	auipc	ra, 0
802015ba: e7 80 00 07  	jalr	112(ra)
802015be: 00 00        	unimp	

Disassembly of section .text._ZN4sel46kernel4boot17try_inital_kernel17hcd5a0f72a134865cE:

00000000802015c0 <_ZN4sel46kernel4boot17try_inital_kernel17hcd5a0f72a134865cE>:
802015c0: 5d 71        	addi	sp, sp, -80
802015c2: 86 e4        	sd	ra, 72(sp)
802015c4: a2 e0        	sd	s0, 64(sp)
802015c6: 26 fc        	sd	s1, 56(sp)
802015c8: 80 08        	addi	s0, sp, 80
802015ca: 97 00 00 00  	auipc	ra, 0
802015ce: e7 80 00 2d  	jalr	720(ra)
802015d2: 97 00 00 00  	auipc	ra, 0
802015d6: e7 80 40 2e  	jalr	740(ra)
802015da: 13 05 00 22  	li	a0, 544
802015de: f3 25 45 10  	csrrs	a1, sie, a0
802015e2: 03 35 80 02  	ld	a0, 40(zero)
802015e6: 93 05 84 fb  	addi	a1, s0, -72
802015ea: 23 30 b0 02  	sd	a1, 32(zero)
802015ee: 23 34 05 00  	sd	zero, 8(a0)
802015f2: 23 30 05 00  	sd	zero, 0(a0)
802015f6: 93 04 84 fd  	addi	s1, s0, -40
802015fa: 23 34 90 02  	sd	s1, 40(zero)
802015fe: 13 05 84 fb  	addi	a0, s0, -72
80201602: 97 10 00 00  	auipc	ra, 1
80201606: e7 80 20 ea  	jalr	-350(ra)
8020160a: 4c 7d        	ld	a1, 184(a0)
8020160c: 13 06 84 fc  	addi	a2, s0, -56
80201610: 50 f9        	sd	a2, 176(a0)
80201612: 23 b4 05 00  	sd	zero, 8(a1)
80201616: 23 b0 05 00  	sd	zero, 0(a1)
8020161a: 44 fd        	sd	s1, 184(a0)
8020161c: a6 60        	ld	ra, 72(sp)
8020161e: 06 64        	ld	s0, 64(sp)
80201620: e2 74        	ld	s1, 56(sp)
80201622: 61 61        	addi	sp, sp, 80
80201624: 82 80        	ret

Disassembly of section .text._ZN4sel43sbi8shutdown17h66331878ed4ddfbbE:

0000000080201626 <_ZN4sel43sbi8shutdown17h66331878ed4ddfbbE>:
80201626: 39 71        	addi	sp, sp, -64
80201628: 06 fc        	sd	ra, 56(sp)
8020162a: 22 f8        	sd	s0, 48(sp)
8020162c: 80 00        	addi	s0, sp, 64
8020162e: a1 48        	li	a7, 8
80201630: 01 45        	li	a0, 0
80201632: 81 45        	li	a1, 0
80201634: 01 46        	li	a2, 0
80201636: 73 00 00 00  	ecall	

000000008020163a <.LBB2_1>:
8020163a: 17 55 04 00  	auipc	a0, 69
8020163e: 13 05 65 a5  	addi	a0, a0, -1450
80201642: 23 38 a4 fc  	sd	a0, -48(s0)
80201646: 05 45        	li	a0, 1
80201648: 23 3c a4 fc  	sd	a0, -40(s0)
8020164c: 23 30 04 fc  	sd	zero, -64(s0)

0000000080201650 <.LBB2_2>:
80201650: 17 55 04 00  	auipc	a0, 69
80201654: 13 05 85 a2  	addi	a0, a0, -1496
80201658: 23 30 a4 fe  	sd	a0, -32(s0)
8020165c: 23 34 04 fe  	sd	zero, -24(s0)

0000000080201660 <.LBB2_3>:
80201660: 97 55 04 00  	auipc	a1, 69
80201664: 93 85 05 a5  	addi	a1, a1, -1456
80201668: 13 05 04 fc  	addi	a0, s0, -64
8020166c: 97 10 00 00  	auipc	ra, 1
80201670: e7 80 80 5a  	jalr	1448(ra)
80201674: 00 00        	unimp	

Disassembly of section .text._ZN4sel47syscall7syscall17hc24d219189e4a5a1E:

0000000080201676 <_ZN4sel47syscall7syscall17hc24d219189e4a5a1E>:
80201676: 1d 71        	addi	sp, sp, -96
80201678: 86 ec        	sd	ra, 88(sp)
8020167a: a2 e8        	sd	s0, 80(sp)
8020167c: a6 e4        	sd	s1, 72(sp)
8020167e: 80 10        	addi	s0, sp, 96
80201680: 13 06 b0 07  	li	a2, 123
80201684: 23 30 a4 fa  	sd	a0, -96(s0)
80201688: 63 51 a6 06  	bge	a2, a0, 0x802016ea <.LBB3_17+0x2e>
8020168c: 13 06 c0 07  	li	a2, 124
80201690: 63 0b c5 06  	beq	a0, a2, 0x80201706 <.LBB3_18>
80201694: 13 06 90 0a  	li	a2, 169
80201698: 63 17 c5 10  	bne	a0, a2, 0x802017a6 <.LBB3_22+0x18>
8020169c: 88 61        	ld	a0, 0(a1)
8020169e: f3 25 10 c0  	rdtime	a1

00000000802016a2 <.LBB3_15>:
802016a2: 17 36 00 00  	auipc	a2, 3
802016a6: 13 06 e6 f3  	addi	a2, a2, -194
802016aa: 10 62        	ld	a2, 0(a2)
802016ac: 81 44        	li	s1, 0
802016ae: 33 b6 c5 02  	mulhu	a2, a1, a2

00000000802016b2 <.LBB3_16>:
802016b2: 97 36 00 00  	auipc	a3, 3
802016b6: 93 86 66 f3  	addi	a3, a3, -202
802016ba: 94 62        	ld	a3, 0(a3)

00000000802016bc <.LBB3_17>:
802016bc: 17 37 00 00  	auipc	a4, 3
802016c0: 13 07 47 f3  	addi	a4, a4, -204
802016c4: 18 63        	ld	a4, 0(a4)
802016c6: 0d 82        	srli	a2, a2, 3
802016c8: a1 81        	srli	a1, a1, 8
802016ca: b3 b5 d5 02  	mulhu	a1, a1, a3
802016ce: b3 36 e6 02  	mulhu	a3, a2, a4
802016d2: c9 82        	srli	a3, a3, 18
802016d4: 37 47 0f 00  	lui	a4, 244
802016d8: 1b 07 07 24  	addiw	a4, a4, 576
802016dc: b3 86 e6 02  	mul	a3, a3, a4
802016e0: 9d 81        	srli	a1, a1, 7
802016e2: 15 8e        	sub	a2, a2, a3
802016e4: 0c e1        	sd	a1, 0(a0)
802016e6: 10 e5        	sd	a2, 8(a0)
802016e8: 85 a0        	j	0x80201748 <.LBB3_18+0x42>
802016ea: 13 06 00 04  	li	a2, 64
802016ee: 63 1e c5 06  	bne	a0, a2, 0x8020176a <.LBB3_19+0x16>
802016f2: 88 61        	ld	a0, 0(a1)
802016f4: 90 65        	ld	a2, 8(a1)
802016f6: 84 69        	ld	s1, 16(a1)
802016f8: b2 85        	mv	a1, a2
802016fa: 26 86        	mv	a2, s1
802016fc: 97 00 00 00  	auipc	ra, 0
80201700: e7 80 20 cd  	jalr	-814(ra)
80201704: 91 a0        	j	0x80201748 <.LBB3_18+0x42>

0000000080201706 <.LBB3_18>:
80201706: 17 95 07 00  	auipc	a0, 121
8020170a: 13 05 a5 8f  	addi	a0, a0, -1798
8020170e: 97 10 00 00  	auipc	ra, 1
80201712: e7 80 c0 91  	jalr	-1764(ra)
80201716: 0c 61        	ld	a1, 0(a0)
80201718: bd e1        	bnez	a1, 0x8020177e <.LBB3_20>
8020171a: 83 36 85 78  	ld	a3, 1928(a0)
8020171e: fd 55        	li	a1, -1
80201720: 41 46        	li	a2, 16
80201722: 0c e1        	sd	a1, 0(a0)
80201724: 63 f8 c6 02  	bgeu	a3, a2, 0x80201754 <.LBB3_19>
80201728: 93 05 80 07  	li	a1, 120
8020172c: b3 85 b6 02  	mul	a1, a3, a1
80201730: aa 95        	add	a1, a1, a0
80201732: 05 46        	li	a2, 1
80201734: 23 8c c5 06  	sb	a2, 120(a1)
80201738: 0c 61        	ld	a1, 0(a0)
8020173a: 85 05        	addi	a1, a1, 1
8020173c: 0c e1        	sd	a1, 0(a0)
8020173e: 97 00 00 00  	auipc	ra, 0
80201742: e7 80 00 9e  	jalr	-1568(ra)
80201746: 81 44        	li	s1, 0
80201748: 26 85        	mv	a0, s1
8020174a: e6 60        	ld	ra, 88(sp)
8020174c: 46 64        	ld	s0, 80(sp)
8020174e: a6 64        	ld	s1, 72(sp)
80201750: 25 61        	addi	sp, sp, 96
80201752: 82 80        	ret

0000000080201754 <.LBB3_19>:
80201754: 17 46 00 00  	auipc	a2, 4
80201758: 13 06 c6 93  	addi	a2, a2, -1732
8020175c: c1 45        	li	a1, 16
8020175e: 36 85        	mv	a0, a3
80201760: 97 10 00 00  	auipc	ra, 1
80201764: e7 80 e0 50  	jalr	1294(ra)
80201768: 00 00        	unimp	
8020176a: 13 06 d0 05  	li	a2, 93
8020176e: 63 1c c5 02  	bne	a0, a2, 0x802017a6 <.LBB3_22+0x18>
80201772: 88 61        	ld	a0, 0(a1)
80201774: 97 10 00 00  	auipc	ra, 1
80201778: e7 80 80 c4  	jalr	-952(ra)
8020177c: 00 00        	unimp	

000000008020177e <.LBB3_20>:
8020177e: 17 45 00 00  	auipc	a0, 4
80201782: 13 05 25 8b  	addi	a0, a0, -1870

0000000080201786 <.LBB3_21>:
80201786: 97 46 00 00  	auipc	a3, 4
8020178a: 93 86 26 a1  	addi	a3, a3, -1518

000000008020178e <.LBB3_22>:
8020178e: 17 47 00 00  	auipc	a4, 4
80201792: 13 07 a7 a3  	addi	a4, a4, -1478
80201796: c1 45        	li	a1, 16
80201798: 13 06 84 fa  	addi	a2, s0, -88
8020179c: 97 10 00 00  	auipc	ra, 1
802017a0: e7 80 20 51  	jalr	1298(ra)
802017a4: 00 00        	unimp	
802017a6: 13 05 04 fa  	addi	a0, s0, -96
802017aa: 23 3c a4 fc  	sd	a0, -40(s0)

00000000802017ae <.LBB3_23>:
802017ae: 17 35 00 00  	auipc	a0, 3
802017b2: 13 05 85 b4  	addi	a0, a0, -1208
802017b6: 23 30 a4 fe  	sd	a0, -32(s0)

00000000802017ba <.LBB3_24>:
802017ba: 17 55 04 00  	auipc	a0, 69
802017be: 13 05 65 92  	addi	a0, a0, -1754
802017c2: 23 3c a4 fa  	sd	a0, -72(s0)
802017c6: 05 45        	li	a0, 1
802017c8: 23 30 a4 fc  	sd	a0, -64(s0)
802017cc: 23 34 04 fa  	sd	zero, -88(s0)
802017d0: 93 05 84 fd  	addi	a1, s0, -40
802017d4: 23 34 b4 fc  	sd	a1, -56(s0)
802017d8: 23 38 a4 fc  	sd	a0, -48(s0)

00000000802017dc <.LBB3_25>:
802017dc: 97 55 04 00  	auipc	a1, 69
802017e0: 93 85 c5 92  	addi	a1, a1, -1748
802017e4: 13 05 84 fa  	addi	a0, s0, -88
802017e8: 97 10 00 00  	auipc	ra, 1
802017ec: e7 80 c0 42  	jalr	1068(ra)
802017f0: 00 00        	unimp	

Disassembly of section .text._ZN4sel410heap_alloc9init_heap17h3294eb883f2849c6E:

00000000802017f2 <_ZN4sel410heap_alloc9init_heap17h3294eb883f2849c6E>:
802017f2: 01 11        	addi	sp, sp, -32
802017f4: 06 ec        	sd	ra, 24(sp)
802017f6: 22 e8        	sd	s0, 16(sp)
802017f8: 26 e4        	sd	s1, 8(sp)
802017fa: 4a e0        	sd	s2, 0(sp)
802017fc: 00 10        	addi	s0, sp, 32

00000000802017fe <.LBB0_3>:
802017fe: 17 95 88 00  	auipc	a0, 2185
80201802: 13 05 a5 fa  	addi	a0, a0, -86
80201806: 97 10 00 00  	auipc	ra, 1
8020180a: e7 80 a0 f0  	jalr	-246(ra)
8020180e: aa 84        	mv	s1, a0
80201810: 05 45        	li	a0, 1
80201812: 2f b9 a4 00  	amoadd.d	s2, a0, (s1)
80201816: 88 64        	ld	a0, 8(s1)
80201818: 0f 00 30 02  	fence	r, rw
8020181c: 63 09 25 01  	beq	a0, s2, 0x8020182e <.LBB0_3+0x30>
80201820: 0f 00 00 01  	fence	w, 0
80201824: 88 64        	ld	a0, 8(s1)
80201826: 0f 00 30 02  	fence	r, rw
8020182a: e3 1b 25 ff  	bne	a0, s2, 0x80201820 <.LBB0_3+0x22>
8020182e: 13 85 04 01  	addi	a0, s1, 16

0000000080201832 <.LBB0_4>:
80201832: 97 95 08 00  	auipc	a1, 137
80201836: 93 85 65 f7  	addi	a1, a1, -138
8020183a: 37 06 80 00  	lui	a2, 2048
8020183e: 97 10 00 00  	auipc	ra, 1
80201842: e7 80 e0 d6  	jalr	-658(ra)
80201846: 13 05 19 00  	addi	a0, s2, 1
8020184a: 0f 00 10 03  	fence	rw, w
8020184e: 88 e4        	sd	a0, 8(s1)
80201850: e2 60        	ld	ra, 24(sp)
80201852: 42 64        	ld	s0, 16(sp)
80201854: a2 64        	ld	s1, 8(sp)
80201856: 02 69        	ld	s2, 0(sp)
80201858: 05 61        	addi	sp, sp, 32
8020185a: 82 80        	ret

Disassembly of section .text._ZN5riscv8register6scause6Scause5cause17h6eb740bd40a4ecccE:

000000008020185c <_ZN5riscv8register6scause6Scause5cause17h6eb740bd40a4ecccE>:
8020185c: 01 11        	addi	sp, sp, -32
8020185e: 06 ec        	sd	ra, 24(sp)
80201860: 22 e8        	sd	s0, 16(sp)
80201862: 26 e4        	sd	s1, 8(sp)
80201864: 00 10        	addi	s0, sp, 32
80201866: 04 61        	ld	s1, 0(a0)
80201868: 97 10 00 00  	auipc	ra, 1
8020186c: e7 80 80 f4  	jalr	-184(ra)
80201870: 63 c7 04 00  	bltz	s1, 0x8020187e <_ZN5riscv8register6scause6Scause5cause17h6eb740bd40a4ecccE+0x22>
80201874: 97 10 00 00  	auipc	ra, 1
80201878: e7 80 40 f1  	jalr	-236(ra)
8020187c: 29 a0        	j	0x80201886 <_ZN5riscv8register6scause6Scause5cause17h6eb740bd40a4ecccE+0x2a>
8020187e: 97 10 00 00  	auipc	ra, 1
80201882: e7 80 20 ee  	jalr	-286(ra)
80201886: 93 75 f5 0f  	andi	a1, a0, 255
8020188a: 13 c5 f4 ff  	not	a0, s1
8020188e: 7d 91        	srli	a0, a0, 63
80201890: e2 60        	ld	ra, 24(sp)
80201892: 42 64        	ld	s0, 16(sp)
80201894: a2 64        	ld	s1, 8(sp)
80201896: 05 61        	addi	sp, sp, 32
80201898: 82 80        	ret

Disassembly of section .text._ZN4sel44trap4init17hc786936662feda75E:

000000008020189a <_ZN4sel44trap4init17hc786936662feda75E>:
8020189a: 41 11        	addi	sp, sp, -16
8020189c: 06 e4        	sd	ra, 8(sp)
8020189e: 22 e0        	sd	s0, 0(sp)
802018a0: 00 08        	addi	s0, sp, 16

00000000802018a2 <.LBB1_1>:
802018a2: 17 f5 ff ff  	auipc	a0, 1048575
802018a6: 13 05 e5 75  	addi	a0, a0, 1886
802018aa: 73 10 55 10  	csrw	stvec, a0
802018ae: a2 60        	ld	ra, 8(sp)
802018b0: 02 64        	ld	s0, 0(sp)
802018b2: 41 01        	addi	sp, sp, 16
802018b4: 82 80        	ret

Disassembly of section .text._ZN4sel44trap22enable_timer_interrupt17hf1078d39c670b34aE:

00000000802018b6 <_ZN4sel44trap22enable_timer_interrupt17hf1078d39c670b34aE>:
802018b6: 41 11        	addi	sp, sp, -16
802018b8: 06 e4        	sd	ra, 8(sp)
802018ba: 22 e0        	sd	s0, 0(sp)
802018bc: 00 08        	addi	s0, sp, 16
802018be: 13 05 00 02  	li	a0, 32
802018c2: 73 20 45 10  	csrs	sie, a0
802018c6: a2 60        	ld	ra, 8(sp)
802018c8: 02 64        	ld	s0, 0(sp)
802018ca: 41 01        	addi	sp, sp, 16
802018cc: 82 80        	ret

Disassembly of section .text.trap_handler:

00000000802018ce <trap_handler>:
802018ce: 75 71        	addi	sp, sp, -144
802018d0: 06 e5        	sd	ra, 136(sp)
802018d2: 22 e1        	sd	s0, 128(sp)
802018d4: a6 fc        	sd	s1, 120(sp)
802018d6: ca f8        	sd	s2, 112(sp)
802018d8: 00 09        	addi	s0, sp, 144
802018da: f3 24 20 14  	csrr	s1, scause
802018de: 23 3c 94 f6  	sd	s1, -136(s0)
802018e2: f3 25 30 14  	csrr	a1, stval
802018e6: 2a 89        	mv	s2, a0
802018e8: 23 30 b4 f8  	sd	a1, -128(s0)
802018ec: 13 05 84 f7  	addi	a0, s0, -136
802018f0: 97 10 00 00  	auipc	ra, 1
802018f4: e7 80 00 ec  	jalr	-320(ra)
802018f8: 63 cb 04 04  	bltz	s1, 0x8020194e <.LBB3_22+0x32>
802018fc: 97 10 00 00  	auipc	ra, 1
80201900: e7 80 c0 e8  	jalr	-372(ra)
80201904: 13 75 f5 0f  	andi	a0, a0, 255
80201908: ad 45        	li	a1, 11
8020190a: 63 e9 a5 18  	bltu	a1, a0, 0x80201a9c <.LBB3_32+0x18>
8020190e: 85 65        	lui	a1, 1
80201910: 9b 85 25 e5  	addiw	a1, a1, -430
80201914: b3 d5 a5 00  	srl	a1, a1, a0
80201918: 85 89        	andi	a1, a1, 1
8020191a: cd c5        	beqz	a1, 0x802019c4 <.LBB3_23+0x4e>

000000008020191c <.LBB3_22>:
8020191c: 17 85 07 00  	auipc	a0, 120
80201920: 13 05 45 6e  	addi	a0, a0, 1764
80201924: 97 00 00 00  	auipc	ra, 0
80201928: e7 80 60 70  	jalr	1798(ra)
8020192c: 0c 61        	ld	a1, 0(a0)
8020192e: 63 93 05 14  	bnez	a1, 0x80201a74 <.LBB3_30>
80201932: 83 36 85 78  	ld	a3, 1928(a0)
80201936: fd 55        	li	a1, -1
80201938: 41 46        	li	a2, 16
8020193a: 0c e1        	sd	a1, 0(a0)
8020193c: 63 fc c6 10  	bgeu	a3, a2, 0x80201a54 <.LBB3_28>
80201940: 93 05 80 07  	li	a1, 120
80201944: b3 85 b6 02  	mul	a1, a3, a1
80201948: aa 95        	add	a1, a1, a0
8020194a: 0d 46        	li	a2, 3
8020194c: a1 a8        	j	0x802019a4 <.LBB3_23+0x2e>
8020194e: 97 10 00 00  	auipc	ra, 1
80201952: e7 80 20 e1  	jalr	-494(ra)
80201956: 13 75 f5 0f  	andi	a0, a0, 255
8020195a: 95 45        	li	a1, 5
8020195c: 63 10 b5 14  	bne	a0, a1, 0x80201a9c <.LBB3_32+0x18>
80201960: 73 25 10 c0  	rdtime	a0
80201964: fd 65        	lui	a1, 31
80201966: 9b 85 85 84  	addiw	a1, a1, -1976
8020196a: 2e 95        	add	a0, a0, a1
8020196c: 81 45        	li	a1, 0
8020196e: 01 46        	li	a2, 0
80201970: 81 48        	li	a7, 0
80201972: 73 00 00 00  	ecall	

0000000080201976 <.LBB3_23>:
80201976: 17 85 07 00  	auipc	a0, 120
8020197a: 13 05 a5 68  	addi	a0, a0, 1674
8020197e: 97 00 00 00  	auipc	ra, 0
80201982: e7 80 c0 6a  	jalr	1708(ra)
80201986: 0c 61        	ld	a1, 0(a0)
80201988: f5 e5        	bnez	a1, 0x80201a74 <.LBB3_30>
8020198a: 83 36 85 78  	ld	a3, 1928(a0)
8020198e: fd 55        	li	a1, -1
80201990: 41 46        	li	a2, 16
80201992: 0c e1        	sd	a1, 0(a0)
80201994: 63 f5 c6 0c  	bgeu	a3, a2, 0x80201a5e <.LBB3_29>
80201998: 93 05 80 07  	li	a1, 120
8020199c: b3 85 b6 02  	mul	a1, a3, a1
802019a0: aa 95        	add	a1, a1, a0
802019a2: 05 46        	li	a2, 1
802019a4: 23 8c c5 06  	sb	a2, 120(a1)
802019a8: 0c 61        	ld	a1, 0(a0)
802019aa: 85 05        	addi	a1, a1, 1
802019ac: 0c e1        	sd	a1, 0(a0)
802019ae: 97 f0 ff ff  	auipc	ra, 1048575
802019b2: e7 80 00 77  	jalr	1904(ra)
802019b6: 4a 85        	mv	a0, s2
802019b8: aa 60        	ld	ra, 136(sp)
802019ba: 0a 64        	ld	s0, 128(sp)
802019bc: e6 74        	ld	s1, 120(sp)
802019be: 46 79        	ld	s2, 112(sp)
802019c0: 49 61        	addi	sp, sp, 144
802019c2: 82 80        	ret
802019c4: 89 45        	li	a1, 2
802019c6: 63 01 b5 04  	beq	a0, a1, 0x80201a08 <.LBB3_24>
802019ca: 9d 45        	li	a1, 7
802019cc: 63 18 b5 0c  	bne	a0, a1, 0x80201a9c <.LBB3_32+0x18>
802019d0: 03 35 89 10  	ld	a0, 264(s2)
802019d4: 11 05        	addi	a0, a0, 4
802019d6: 23 34 a9 10  	sd	a0, 264(s2)
802019da: 83 35 09 05  	ld	a1, 80(s2)
802019de: 03 36 89 05  	ld	a2, 88(s2)
802019e2: 83 36 09 06  	ld	a3, 96(s2)
802019e6: 03 35 89 08  	ld	a0, 136(s2)
802019ea: 23 34 b4 f8  	sd	a1, -120(s0)
802019ee: 23 38 c4 f8  	sd	a2, -112(s0)
802019f2: 23 3c d4 f8  	sd	a3, -104(s0)
802019f6: 93 05 84 f8  	addi	a1, s0, -120
802019fa: 97 00 00 00  	auipc	ra, 0
802019fe: e7 80 c0 c7  	jalr	-900(ra)
80201a02: 23 38 a9 04  	sd	a0, 80(s2)
80201a06: 45 bf        	j	0x802019b6 <.LBB3_23+0x40>

0000000080201a08 <.LBB3_24>:
80201a08: 17 35 00 00  	auipc	a0, 3
80201a0c: 13 05 05 f6  	addi	a0, a0, -160
80201a10: 08 61        	ld	a0, 0(a0)
80201a12: 09 d5        	beqz	a0, 0x8020191c <.LBB3_22>

0000000080201a14 <.LBB3_25>:
80201a14: 17 45 04 00  	auipc	a0, 68
80201a18: 13 05 45 74  	addi	a0, a0, 1860
80201a1c: 23 3c a4 f8  	sd	a0, -104(s0)
80201a20: 05 45        	li	a0, 1
80201a22: 23 30 a4 fa  	sd	a0, -96(s0)
80201a26: 23 34 04 f8  	sd	zero, -120(s0)

0000000080201a2a <.LBB3_26>:
80201a2a: 17 45 04 00  	auipc	a0, 68
80201a2e: 13 05 65 6f  	addi	a0, a0, 1782
80201a32: 23 34 a4 fa  	sd	a0, -88(s0)
80201a36: 23 38 04 fa  	sd	zero, -80(s0)

0000000080201a3a <.LBB3_27>:
80201a3a: 17 46 04 00  	auipc	a2, 68
80201a3e: 13 06 e6 74  	addi	a2, a2, 1870
80201a42: 13 05 84 f8  	addi	a0, s0, -120
80201a46: 85 45        	li	a1, 1
80201a48: 81 46        	li	a3, 0
80201a4a: 97 10 00 00  	auipc	ra, 1
80201a4e: e7 80 e0 0a  	jalr	174(ra)
80201a52: e9 b5        	j	0x8020191c <.LBB3_22>

0000000080201a54 <.LBB3_28>:
80201a54: 17 36 00 00  	auipc	a2, 3
80201a58: 13 06 46 65  	addi	a2, a2, 1620
80201a5c: 29 a0        	j	0x80201a66 <.LBB3_29+0x8>

0000000080201a5e <.LBB3_29>:
80201a5e: 17 36 00 00  	auipc	a2, 3
80201a62: 13 06 26 63  	addi	a2, a2, 1586
80201a66: c1 45        	li	a1, 16
80201a68: 36 85        	mv	a0, a3
80201a6a: 97 10 00 00  	auipc	ra, 1
80201a6e: e7 80 40 20  	jalr	516(ra)
80201a72: 00 00        	unimp	

0000000080201a74 <.LBB3_30>:
80201a74: 17 35 00 00  	auipc	a0, 3
80201a78: 13 05 c5 5b  	addi	a0, a0, 1468

0000000080201a7c <.LBB3_31>:
80201a7c: 97 36 00 00  	auipc	a3, 3
80201a80: 93 86 c6 71  	addi	a3, a3, 1820

0000000080201a84 <.LBB3_32>:
80201a84: 17 37 00 00  	auipc	a4, 3
80201a88: 13 07 47 74  	addi	a4, a4, 1860
80201a8c: c1 45        	li	a1, 16
80201a8e: 13 06 84 f8  	addi	a2, s0, -120
80201a92: 97 10 00 00  	auipc	ra, 1
80201a96: e7 80 c0 21  	jalr	540(ra)
80201a9a: 00 00        	unimp	
80201a9c: 13 05 84 f7  	addi	a0, s0, -136
80201aa0: 97 00 00 00  	auipc	ra, 0
80201aa4: e7 80 c0 db  	jalr	-580(ra)
80201aa8: 23 0c a4 fc  	sb	a0, -40(s0)
80201aac: a3 0c b4 fc  	sb	a1, -39(s0)
80201ab0: 13 05 84 fd  	addi	a0, s0, -40
80201ab4: 23 3c a4 fa  	sd	a0, -72(s0)

0000000080201ab8 <.LBB3_33>:
80201ab8: 17 15 00 00  	auipc	a0, 1
80201abc: 13 05 e5 d0  	addi	a0, a0, -754
80201ac0: 23 30 a4 fc  	sd	a0, -64(s0)
80201ac4: 13 05 04 f8  	addi	a0, s0, -128
80201ac8: 23 34 a4 fc  	sd	a0, -56(s0)

0000000080201acc <.LBB3_34>:
80201acc: 17 25 00 00  	auipc	a0, 2
80201ad0: 13 05 e5 43  	addi	a0, a0, 1086
80201ad4: 23 38 a4 fc  	sd	a0, -48(s0)

0000000080201ad8 <.LBB3_35>:
80201ad8: 17 45 04 00  	auipc	a0, 68
80201adc: 13 05 85 70  	addi	a0, a0, 1800
80201ae0: 23 3c a4 f8  	sd	a0, -104(s0)
80201ae4: 0d 45        	li	a0, 3
80201ae6: 23 30 a4 fa  	sd	a0, -96(s0)

0000000080201aea <.LBB3_36>:
80201aea: 17 45 04 00  	auipc	a0, 68
80201aee: 13 05 65 72  	addi	a0, a0, 1830
80201af2: 23 34 a4 f8  	sd	a0, -120(s0)
80201af6: 09 45        	li	a0, 2
80201af8: 23 38 a4 f8  	sd	a0, -112(s0)
80201afc: 93 05 84 fb  	addi	a1, s0, -72
80201b00: 23 34 b4 fa  	sd	a1, -88(s0)
80201b04: 23 38 a4 fa  	sd	a0, -80(s0)

0000000080201b08 <.LBB3_37>:
80201b08: 97 45 04 00  	auipc	a1, 68
80201b0c: 93 85 85 77  	addi	a1, a1, 1912
80201b10: 13 05 84 f8  	addi	a0, s0, -120
80201b14: 97 10 00 00  	auipc	ra, 1
80201b18: e7 80 00 10  	jalr	256(ra)
80201b1c: 00 00        	unimp	

Disassembly of section .text._ZN4core3ptr37drop_in_place$LT$core..fmt..Error$GT$17h8a07bd9b64186cfeE.llvm.17772250532125793796:

0000000080201b1e <_ZN4core3ptr54drop_in_place$LT$$RF$mut$u20$sel4..console..Stdout$GT$17he26c29928d3f96b5E.llvm.17772250532125793796>:
80201b1e: 41 11        	addi	sp, sp, -16
80201b20: 06 e4        	sd	ra, 8(sp)
80201b22: 22 e0        	sd	s0, 0(sp)
80201b24: 00 08        	addi	s0, sp, 16
80201b26: a2 60        	ld	ra, 8(sp)
80201b28: 02 64        	ld	s0, 0(sp)
80201b2a: 41 01        	addi	sp, sp, 16
80201b2c: 82 80        	ret

Disassembly of section .text._ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.17772250532125793796:

0000000080201b2e <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.17772250532125793796>:
80201b2e: 01 11        	addi	sp, sp, -32
80201b30: 06 ec        	sd	ra, 24(sp)
80201b32: 22 e8        	sd	s0, 16(sp)
80201b34: 00 10        	addi	s0, sp, 32
80201b36: 1b 85 05 00  	sext.w	a0, a1
80201b3a: 13 06 00 08  	li	a2, 128
80201b3e: 23 26 04 fe  	sw	zero, -20(s0)
80201b42: 63 76 c5 00  	bgeu	a0, a2, 0x80201b4e <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.17772250532125793796+0x20>
80201b46: 23 06 b4 fe  	sb	a1, -20(s0)
80201b4a: 05 45        	li	a0, 1
80201b4c: 51 a8        	j	0x80201be0 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.17772250532125793796+0xb2>
80201b4e: 1b d5 b5 00  	srliw	a0, a1, 11
80201b52: 19 ed        	bnez	a0, 0x80201b70 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.17772250532125793796+0x42>
80201b54: 13 d5 65 00  	srli	a0, a1, 6
80201b58: 13 65 05 0c  	ori	a0, a0, 192
80201b5c: 23 06 a4 fe  	sb	a0, -20(s0)
80201b60: 13 f5 f5 03  	andi	a0, a1, 63
80201b64: 13 65 05 08  	ori	a0, a0, 128
80201b68: a3 06 a4 fe  	sb	a0, -19(s0)
80201b6c: 09 45        	li	a0, 2
80201b6e: 8d a8        	j	0x80201be0 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.17772250532125793796+0xb2>
80201b70: 1b d5 05 01  	srliw	a0, a1, 16
80201b74: 05 e9        	bnez	a0, 0x80201ba4 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.17772250532125793796+0x76>
80201b76: 13 95 05 02  	slli	a0, a1, 32
80201b7a: 01 91        	srli	a0, a0, 32
80201b7c: 1b d6 c5 00  	srliw	a2, a1, 12
80201b80: 13 66 06 0e  	ori	a2, a2, 224
80201b84: 23 06 c4 fe  	sb	a2, -20(s0)
80201b88: 52 15        	slli	a0, a0, 52
80201b8a: 69 91        	srli	a0, a0, 58
80201b8c: 13 65 05 08  	ori	a0, a0, 128
80201b90: a3 06 a4 fe  	sb	a0, -19(s0)
80201b94: 13 f5 f5 03  	andi	a0, a1, 63
80201b98: 13 65 05 08  	ori	a0, a0, 128
80201b9c: 23 07 a4 fe  	sb	a0, -18(s0)
80201ba0: 0d 45        	li	a0, 3
80201ba2: 3d a8        	j	0x80201be0 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.17772250532125793796+0xb2>
80201ba4: 13 95 05 02  	slli	a0, a1, 32
80201ba8: 01 91        	srli	a0, a0, 32
80201baa: 13 16 b5 02  	slli	a2, a0, 43
80201bae: 75 92        	srli	a2, a2, 61
80201bb0: 13 66 06 0f  	ori	a2, a2, 240
80201bb4: 23 06 c4 fe  	sb	a2, -20(s0)
80201bb8: 13 16 e5 02  	slli	a2, a0, 46
80201bbc: 69 92        	srli	a2, a2, 58
80201bbe: 13 66 06 08  	ori	a2, a2, 128
80201bc2: a3 06 c4 fe  	sb	a2, -19(s0)
80201bc6: 52 15        	slli	a0, a0, 52
80201bc8: 69 91        	srli	a0, a0, 58
80201bca: 13 65 05 08  	ori	a0, a0, 128
80201bce: 23 07 a4 fe  	sb	a0, -18(s0)
80201bd2: 13 f5 f5 03  	andi	a0, a1, 63
80201bd6: 13 65 05 08  	ori	a0, a0, 128
80201bda: a3 07 a4 fe  	sb	a0, -17(s0)
80201bde: 11 45        	li	a0, 4
80201be0: 93 06 c4 fe  	addi	a3, s0, -20
80201be4: 33 87 a6 00  	add	a4, a3, a0
80201be8: 13 03 f0 0d  	li	t1, 223
80201bec: 13 08 00 0f  	li	a6, 240
80201bf0: b7 02 11 00  	lui	t0, 272
80201bf4: 85 48        	li	a7, 1
80201bf6: 01 a8        	j	0x80201c06 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.17772250532125793796+0xd8>
80201bf8: 85 06        	addi	a3, a3, 1
80201bfa: 81 45        	li	a1, 0
80201bfc: 01 46        	li	a2, 0
80201bfe: 73 00 00 00  	ecall	
80201c02: 63 8f e6 04  	beq	a3, a4, 0x80201c60 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.17772250532125793796+0x132>
80201c06: 83 85 06 00  	lb	a1, 0(a3)
80201c0a: 13 f5 f5 0f  	andi	a0, a1, 255
80201c0e: e3 d5 05 fe  	bgez	a1, 0x80201bf8 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.17772250532125793796+0xca>
80201c12: 03 c6 16 00  	lbu	a2, 1(a3)
80201c16: 93 75 f5 01  	andi	a1, a0, 31
80201c1a: 13 76 f6 03  	andi	a2, a2, 63
80201c1e: 63 77 a3 02  	bgeu	t1, a0, 0x80201c4c <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.17772250532125793796+0x11e>
80201c22: 83 c7 26 00  	lbu	a5, 2(a3)
80201c26: 1a 06        	slli	a2, a2, 6
80201c28: 93 f7 f7 03  	andi	a5, a5, 63
80201c2c: 5d 8e        	or	a2, a2, a5
80201c2e: 63 64 05 03  	bltu	a0, a6, 0x80201c56 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.17772250532125793796+0x128>
80201c32: 03 c5 36 00  	lbu	a0, 3(a3)
80201c36: f6 15        	slli	a1, a1, 61
80201c38: ad 91        	srli	a1, a1, 43
80201c3a: 1a 06        	slli	a2, a2, 6
80201c3c: 13 75 f5 03  	andi	a0, a0, 63
80201c40: 51 8d        	or	a0, a0, a2
80201c42: 4d 8d        	or	a0, a0, a1
80201c44: 63 0e 55 00  	beq	a0, t0, 0x80201c60 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.17772250532125793796+0x132>
80201c48: 91 06        	addi	a3, a3, 4
80201c4a: 45 bf        	j	0x80201bfa <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.17772250532125793796+0xcc>
80201c4c: 89 06        	addi	a3, a3, 2
80201c4e: 13 95 65 00  	slli	a0, a1, 6
80201c52: 51 8d        	or	a0, a0, a2
80201c54: 5d b7        	j	0x80201bfa <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.17772250532125793796+0xcc>
80201c56: 8d 06        	addi	a3, a3, 3
80201c58: 13 95 c5 00  	slli	a0, a1, 12
80201c5c: 51 8d        	or	a0, a0, a2
80201c5e: 71 bf        	j	0x80201bfa <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.17772250532125793796+0xcc>
80201c60: 01 45        	li	a0, 0
80201c62: e2 60        	ld	ra, 24(sp)
80201c64: 42 64        	ld	s0, 16(sp)
80201c66: 05 61        	addi	sp, sp, 32
80201c68: 82 80        	ret

Disassembly of section .text._ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_fmt17hea6da6f03dcdd814E.llvm.17772250532125793796:

0000000080201c6a <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_fmt17hea6da6f03dcdd814E.llvm.17772250532125793796>:
80201c6a: 5d 71        	addi	sp, sp, -80
80201c6c: 86 e4        	sd	ra, 72(sp)
80201c6e: a2 e0        	sd	s0, 64(sp)
80201c70: 80 08        	addi	s0, sp, 80
80201c72: 08 61        	ld	a0, 0(a0)
80201c74: 90 75        	ld	a2, 40(a1)
80201c76: 94 71        	ld	a3, 32(a1)
80201c78: 23 3c a4 fa  	sd	a0, -72(s0)
80201c7c: 23 34 c4 fe  	sd	a2, -24(s0)
80201c80: 23 30 d4 fe  	sd	a3, -32(s0)
80201c84: 88 6d        	ld	a0, 24(a1)
80201c86: 90 69        	ld	a2, 16(a1)
80201c88: 94 65        	ld	a3, 8(a1)
80201c8a: 8c 61        	ld	a1, 0(a1)
80201c8c: 23 3c a4 fc  	sd	a0, -40(s0)
80201c90: 23 38 c4 fc  	sd	a2, -48(s0)
80201c94: 23 34 d4 fc  	sd	a3, -56(s0)
80201c98: 23 30 b4 fc  	sd	a1, -64(s0)

0000000080201c9c <.LBB2_1>:
80201c9c: 97 45 04 00  	auipc	a1, 68
80201ca0: 93 85 c5 5f  	addi	a1, a1, 1532
80201ca4: 13 05 84 fb  	addi	a0, s0, -72
80201ca8: 13 06 04 fc  	addi	a2, s0, -64
80201cac: 97 10 00 00  	auipc	ra, 1
80201cb0: e7 80 80 66  	jalr	1640(ra)
80201cb4: a6 60        	ld	ra, 72(sp)
80201cb6: 06 64        	ld	s0, 64(sp)
80201cb8: 61 61        	addi	sp, sp, 80
80201cba: 82 80        	ret

Disassembly of section .text._ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hff577ac6e379d064E.llvm.17772250532125793796:

0000000080201cbc <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hff577ac6e379d064E.llvm.17772250532125793796>:
80201cbc: 41 11        	addi	sp, sp, -16
80201cbe: 06 e4        	sd	ra, 8(sp)
80201cc0: 22 e0        	sd	s0, 0(sp)
80201cc2: 00 08        	addi	s0, sp, 16
80201cc4: 41 c2        	beqz	a2, 0x80201d44 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hff577ac6e379d064E.llvm.17772250532125793796+0x88>
80201cc6: ae 86        	mv	a3, a1
80201cc8: 33 87 c5 00  	add	a4, a1, a2
80201ccc: 13 03 f0 0d  	li	t1, 223
80201cd0: 13 08 00 0f  	li	a6, 240
80201cd4: b7 02 11 00  	lui	t0, 272
80201cd8: 85 48        	li	a7, 1
80201cda: 01 a8        	j	0x80201cea <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hff577ac6e379d064E.llvm.17772250532125793796+0x2e>
80201cdc: 85 06        	addi	a3, a3, 1
80201cde: 81 45        	li	a1, 0
80201ce0: 01 46        	li	a2, 0
80201ce2: 73 00 00 00  	ecall	
80201ce6: 63 8f e6 04  	beq	a3, a4, 0x80201d44 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hff577ac6e379d064E.llvm.17772250532125793796+0x88>
80201cea: 83 85 06 00  	lb	a1, 0(a3)
80201cee: 13 f5 f5 0f  	andi	a0, a1, 255
80201cf2: e3 d5 05 fe  	bgez	a1, 0x80201cdc <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hff577ac6e379d064E.llvm.17772250532125793796+0x20>
80201cf6: 03 c6 16 00  	lbu	a2, 1(a3)
80201cfa: 93 75 f5 01  	andi	a1, a0, 31
80201cfe: 13 76 f6 03  	andi	a2, a2, 63
80201d02: 63 77 a3 02  	bgeu	t1, a0, 0x80201d30 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hff577ac6e379d064E.llvm.17772250532125793796+0x74>
80201d06: 83 c7 26 00  	lbu	a5, 2(a3)
80201d0a: 1a 06        	slli	a2, a2, 6
80201d0c: 93 f7 f7 03  	andi	a5, a5, 63
80201d10: 5d 8e        	or	a2, a2, a5
80201d12: 63 64 05 03  	bltu	a0, a6, 0x80201d3a <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hff577ac6e379d064E.llvm.17772250532125793796+0x7e>
80201d16: 03 c5 36 00  	lbu	a0, 3(a3)
80201d1a: f6 15        	slli	a1, a1, 61
80201d1c: ad 91        	srli	a1, a1, 43
80201d1e: 1a 06        	slli	a2, a2, 6
80201d20: 13 75 f5 03  	andi	a0, a0, 63
80201d24: 51 8d        	or	a0, a0, a2
80201d26: 4d 8d        	or	a0, a0, a1
80201d28: 63 0e 55 00  	beq	a0, t0, 0x80201d44 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hff577ac6e379d064E.llvm.17772250532125793796+0x88>
80201d2c: 91 06        	addi	a3, a3, 4
80201d2e: 45 bf        	j	0x80201cde <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hff577ac6e379d064E.llvm.17772250532125793796+0x22>
80201d30: 89 06        	addi	a3, a3, 2
80201d32: 13 95 65 00  	slli	a0, a1, 6
80201d36: 51 8d        	or	a0, a0, a2
80201d38: 5d b7        	j	0x80201cde <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hff577ac6e379d064E.llvm.17772250532125793796+0x22>
80201d3a: 8d 06        	addi	a3, a3, 3
80201d3c: 13 95 c5 00  	slli	a0, a1, 12
80201d40: 51 8d        	or	a0, a0, a2
80201d42: 71 bf        	j	0x80201cde <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hff577ac6e379d064E.llvm.17772250532125793796+0x22>
80201d44: 01 45        	li	a0, 0
80201d46: a2 60        	ld	ra, 8(sp)
80201d48: 02 64        	ld	s0, 0(sp)
80201d4a: 41 01        	addi	sp, sp, 16
80201d4c: 82 80        	ret

Disassembly of section .text._ZN4sel47console5print17hac8e0d72989ef035E:

0000000080201d4e <_ZN4sel47console5print17hac8e0d72989ef035E>:
80201d4e: 5d 71        	addi	sp, sp, -80
80201d50: 86 e4        	sd	ra, 72(sp)
80201d52: a2 e0        	sd	s0, 64(sp)
80201d54: 80 08        	addi	s0, sp, 80
80201d56: 0c 75        	ld	a1, 40(a0)
80201d58: 10 71        	ld	a2, 32(a0)
80201d5a: 93 06 84 fe  	addi	a3, s0, -24
80201d5e: 23 38 d4 fa  	sd	a3, -80(s0)
80201d62: 23 30 b4 fe  	sd	a1, -32(s0)
80201d66: 23 3c c4 fc  	sd	a2, -40(s0)
80201d6a: 0c 6d        	ld	a1, 24(a0)
80201d6c: 10 69        	ld	a2, 16(a0)
80201d6e: 14 65        	ld	a3, 8(a0)
80201d70: 08 61        	ld	a0, 0(a0)
80201d72: 23 38 b4 fc  	sd	a1, -48(s0)
80201d76: 23 34 c4 fc  	sd	a2, -56(s0)
80201d7a: 23 30 d4 fc  	sd	a3, -64(s0)
80201d7e: 23 3c a4 fa  	sd	a0, -72(s0)

0000000080201d82 <.LBB4_3>:
80201d82: 97 45 04 00  	auipc	a1, 68
80201d86: 93 85 65 51  	addi	a1, a1, 1302
80201d8a: 13 05 04 fb  	addi	a0, s0, -80
80201d8e: 13 06 84 fb  	addi	a2, s0, -72
80201d92: 97 10 00 00  	auipc	ra, 1
80201d96: e7 80 20 58  	jalr	1410(ra)
80201d9a: 09 e5        	bnez	a0, 0x80201da4 <.LBB4_4>
80201d9c: a6 60        	ld	ra, 72(sp)
80201d9e: 06 64        	ld	s0, 64(sp)
80201da0: 61 61        	addi	sp, sp, 80
80201da2: 82 80        	ret

0000000080201da4 <.LBB4_4>:
80201da4: 17 45 04 00  	auipc	a0, 68
80201da8: 13 05 45 52  	addi	a0, a0, 1316

0000000080201dac <.LBB4_5>:
80201dac: 97 46 04 00  	auipc	a3, 68
80201db0: 93 86 c6 54  	addi	a3, a3, 1356

0000000080201db4 <.LBB4_6>:
80201db4: 17 47 04 00  	auipc	a4, 68
80201db8: 13 07 47 57  	addi	a4, a4, 1396
80201dbc: 93 05 b0 02  	li	a1, 43
80201dc0: 13 06 84 fe  	addi	a2, s0, -24
80201dc4: 97 10 00 00  	auipc	ra, 1
80201dc8: e7 80 a0 ee  	jalr	-278(ra)
80201dcc: 00 00        	unimp	

Disassembly of section .text.rust_begin_unwind:

0000000080201dce <rust_begin_unwind>:
80201dce: 6d 71        	addi	sp, sp, -272
80201dd0: 06 e6        	sd	ra, 264(sp)
80201dd2: 22 e2        	sd	s0, 256(sp)
80201dd4: a6 fd        	sd	s1, 248(sp)
80201dd6: 00 0a        	addi	s0, sp, 272
80201dd8: aa 84        	mv	s1, a0
80201dda: 97 10 00 00  	auipc	ra, 1
80201dde: e7 80 60 e3  	jalr	-458(ra)
80201de2: 15 e5        	bnez	a0, 0x80201e0e <.LBB0_10+0x16>
80201de4: 26 85        	mv	a0, s1
80201de6: 97 10 00 00  	auipc	ra, 1
80201dea: e7 80 60 e2  	jalr	-474(ra)
80201dee: 31 ed        	bnez	a0, 0x80201e4a <.LBB0_12+0x16>

0000000080201df0 <.LBB0_9>:
80201df0: 17 45 04 00  	auipc	a0, 68
80201df4: 13 05 85 5f  	addi	a0, a0, 1528

0000000080201df8 <.LBB0_10>:
80201df8: 17 46 04 00  	auipc	a2, 68
80201dfc: 13 06 06 63  	addi	a2, a2, 1584
80201e00: 93 05 b0 02  	li	a1, 43
80201e04: 97 10 00 00  	auipc	ra, 1
80201e08: e7 80 e0 e3  	jalr	-450(ra)
80201e0c: 00 00        	unimp	
80201e0e: 0c 61        	ld	a1, 0(a0)
80201e10: 10 65        	ld	a2, 8(a0)
80201e12: 23 30 b4 f2  	sd	a1, -224(s0)
80201e16: 23 34 c4 f2  	sd	a2, -216(s0)
80201e1a: 08 49        	lw	a0, 16(a0)
80201e1c: 23 2a a4 f2  	sw	a0, -204(s0)
80201e20: 26 85        	mv	a0, s1
80201e22: 97 10 00 00  	auipc	ra, 1
80201e26: e7 80 a0 de  	jalr	-534(ra)
80201e2a: 7d e5        	bnez	a0, 0x80201f18 <.LBB0_18+0x24>

0000000080201e2c <.LBB0_11>:
80201e2c: 17 45 04 00  	auipc	a0, 68
80201e30: 13 05 c5 5b  	addi	a0, a0, 1468

0000000080201e34 <.LBB0_12>:
80201e34: 17 46 04 00  	auipc	a2, 68
80201e38: 13 06 46 66  	addi	a2, a2, 1636
80201e3c: 93 05 b0 02  	li	a1, 43
80201e40: 97 10 00 00  	auipc	ra, 1
80201e44: e7 80 20 e0  	jalr	-510(ra)
80201e48: 00 00        	unimp	
80201e4a: 23 34 a4 fa  	sd	a0, -88(s0)
80201e4e: 13 05 84 fa  	addi	a0, s0, -88
80201e52: 23 38 a4 ee  	sd	a0, -272(s0)

0000000080201e56 <.LBB0_13>:
80201e56: 17 05 00 00  	auipc	a0, 0
80201e5a: 13 05 45 61  	addi	a0, a0, 1556
80201e5e: 23 3c a4 ee  	sd	a0, -264(s0)

0000000080201e62 <.LBB0_14>:
80201e62: 17 45 04 00  	auipc	a0, 68
80201e66: 13 05 65 56  	addi	a0, a0, 1382
80201e6a: 23 38 a4 f4  	sd	a0, -176(s0)
80201e6e: 09 45        	li	a0, 2
80201e70: 23 3c a4 f4  	sd	a0, -168(s0)
80201e74: 23 30 04 f4  	sd	zero, -192(s0)
80201e78: 13 05 04 ef  	addi	a0, s0, -272
80201e7c: 23 30 a4 f6  	sd	a0, -160(s0)
80201e80: 05 45        	li	a0, 1
80201e82: 23 34 a4 f6  	sd	a0, -152(s0)
80201e86: 7d 45        	li	a0, 31
80201e88: 23 0a a4 f2  	sb	a0, -204(s0)
80201e8c: 13 05 10 03  	li	a0, 49
80201e90: 23 0c a4 f2  	sb	a0, -200(s0)
80201e94: 13 05 44 f3  	addi	a0, s0, -204
80201e98: 23 38 a4 f6  	sd	a0, -144(s0)

0000000080201e9c <.LBB0_15>:
80201e9c: 17 25 00 00  	auipc	a0, 2
80201ea0: 13 05 85 41  	addi	a0, a0, 1048
80201ea4: 23 3c a4 f6  	sd	a0, -136(s0)
80201ea8: 93 05 84 f3  	addi	a1, s0, -200
80201eac: 23 30 b4 f8  	sd	a1, -128(s0)
80201eb0: 23 34 a4 f8  	sd	a0, -120(s0)
80201eb4: 13 05 04 f4  	addi	a0, s0, -192
80201eb8: 23 38 a4 f8  	sd	a0, -112(s0)

0000000080201ebc <.LBB0_16>:
80201ebc: 17 15 00 00  	auipc	a0, 1
80201ec0: 13 05 65 42  	addi	a0, a0, 1062
80201ec4: 23 3c a4 f8  	sd	a0, -104(s0)
80201ec8: 13 05 04 fe  	addi	a0, s0, -32
80201ecc: 23 30 a4 f2  	sd	a0, -224(s0)
80201ed0: 23 38 04 fa  	sd	zero, -80(s0)

0000000080201ed4 <.LBB0_17>:
80201ed4: 17 45 04 00  	auipc	a0, 68
80201ed8: 13 05 45 48  	addi	a0, a0, 1156
80201edc: 23 30 a4 fc  	sd	a0, -64(s0)
80201ee0: 11 45        	li	a0, 4
80201ee2: 23 34 a4 fc  	sd	a0, -56(s0)
80201ee6: 13 05 04 f7  	addi	a0, s0, -144
80201eea: 23 38 a4 fc  	sd	a0, -48(s0)
80201eee: 0d 45        	li	a0, 3
80201ef0: 23 3c a4 fc  	sd	a0, -40(s0)

0000000080201ef4 <.LBB0_18>:
80201ef4: 97 45 04 00  	auipc	a1, 68
80201ef8: 93 85 45 3a  	addi	a1, a1, 932
80201efc: 13 05 04 f2  	addi	a0, s0, -224
80201f00: 13 06 04 fb  	addi	a2, s0, -80
80201f04: 97 10 00 00  	auipc	ra, 1
80201f08: e7 80 00 41  	jalr	1040(ra)
80201f0c: 75 e9        	bnez	a0, 0x80202000 <.LBB0_27>
80201f0e: 97 f0 ff ff  	auipc	ra, 1048575
80201f12: e7 80 80 71  	jalr	1816(ra)
80201f16: 00 00        	unimp	
80201f18: 23 3c a4 f2  	sd	a0, -200(s0)
80201f1c: 13 05 04 f2  	addi	a0, s0, -224
80201f20: 23 30 a4 f4  	sd	a0, -192(s0)

0000000080201f24 <.LBB0_19>:
80201f24: 17 05 00 00  	auipc	a0, 0
80201f28: 13 05 e5 55  	addi	a0, a0, 1374
80201f2c: 23 34 a4 f4  	sd	a0, -184(s0)
80201f30: 13 05 44 f3  	addi	a0, s0, -204
80201f34: 23 38 a4 f4  	sd	a0, -176(s0)

0000000080201f38 <.LBB0_20>:
80201f38: 17 25 00 00  	auipc	a0, 2
80201f3c: 13 05 e5 3a  	addi	a0, a0, 942
80201f40: 23 3c a4 f4  	sd	a0, -168(s0)
80201f44: 13 05 84 f3  	addi	a0, s0, -200
80201f48: 23 30 a4 f6  	sd	a0, -160(s0)

0000000080201f4c <.LBB0_21>:
80201f4c: 17 05 00 00  	auipc	a0, 0
80201f50: 13 05 e5 51  	addi	a0, a0, 1310
80201f54: 23 34 a4 f6  	sd	a0, -152(s0)

0000000080201f58 <.LBB0_22>:
80201f58: 17 45 04 00  	auipc	a0, 68
80201f5c: 13 05 05 50  	addi	a0, a0, 1280
80201f60: 23 30 a4 f0  	sd	a0, -256(s0)
80201f64: 11 45        	li	a0, 4
80201f66: 23 34 a4 f0  	sd	a0, -248(s0)
80201f6a: 23 38 04 ee  	sd	zero, -272(s0)
80201f6e: 93 05 04 f4  	addi	a1, s0, -192
80201f72: 23 38 b4 f0  	sd	a1, -240(s0)
80201f76: 8d 45        	li	a1, 3
80201f78: 23 3c b4 f0  	sd	a1, -232(s0)
80201f7c: 7d 46        	li	a2, 31
80201f7e: 23 03 c4 fa  	sb	a2, -90(s0)
80201f82: 13 06 10 03  	li	a2, 49
80201f86: a3 03 c4 fa  	sb	a2, -89(s0)
80201f8a: 13 06 64 fa  	addi	a2, s0, -90
80201f8e: 23 38 c4 f6  	sd	a2, -144(s0)

0000000080201f92 <.LBB0_23>:
80201f92: 17 26 00 00  	auipc	a2, 2
80201f96: 13 06 26 32  	addi	a2, a2, 802
80201f9a: 23 3c c4 f6  	sd	a2, -136(s0)
80201f9e: 93 06 74 fa  	addi	a3, s0, -89
80201fa2: 23 30 d4 f8  	sd	a3, -128(s0)
80201fa6: 23 34 c4 f8  	sd	a2, -120(s0)
80201faa: 13 06 04 ef  	addi	a2, s0, -272
80201fae: 23 38 c4 f8  	sd	a2, -112(s0)

0000000080201fb2 <.LBB0_24>:
80201fb2: 17 16 00 00  	auipc	a2, 1
80201fb6: 13 06 06 33  	addi	a2, a2, 816
80201fba: 23 3c c4 f8  	sd	a2, -104(s0)
80201fbe: 13 06 04 fe  	addi	a2, s0, -32
80201fc2: 23 34 c4 fa  	sd	a2, -88(s0)
80201fc6: 23 38 04 fa  	sd	zero, -80(s0)

0000000080201fca <.LBB0_25>:
80201fca: 17 46 04 00  	auipc	a2, 68
80201fce: 13 06 e6 38  	addi	a2, a2, 910
80201fd2: 23 30 c4 fc  	sd	a2, -64(s0)
80201fd6: 23 34 a4 fc  	sd	a0, -56(s0)
80201fda: 13 05 04 f7  	addi	a0, s0, -144
80201fde: 23 38 a4 fc  	sd	a0, -48(s0)
80201fe2: 23 3c b4 fc  	sd	a1, -40(s0)

0000000080201fe6 <.LBB0_26>:
80201fe6: 97 45 04 00  	auipc	a1, 68
80201fea: 93 85 25 2b  	addi	a1, a1, 690
80201fee: 13 05 84 fa  	addi	a0, s0, -88
80201ff2: 13 06 04 fb  	addi	a2, s0, -80
80201ff6: 97 10 00 00  	auipc	ra, 1
80201ffa: e7 80 e0 31  	jalr	798(ra)
80201ffe: 01 d9        	beqz	a0, 0x80201f0e <.LBB0_18+0x1a>

0000000080202000 <.LBB0_27>:
80202000: 17 45 04 00  	auipc	a0, 68
80202004: 13 05 85 2c  	addi	a0, a0, 712

0000000080202008 <.LBB0_28>:
80202008: 97 46 04 00  	auipc	a3, 68
8020200c: 93 86 06 2f  	addi	a3, a3, 752

0000000080202010 <.LBB0_29>:
80202010: 17 47 04 00  	auipc	a4, 68
80202014: 13 07 87 38  	addi	a4, a4, 904
80202018: 93 05 b0 02  	li	a1, 43
8020201c: 13 06 04 fe  	addi	a2, s0, -32
80202020: 97 10 00 00  	auipc	ra, 1
80202024: e7 80 e0 c8  	jalr	-882(ra)
80202028: 00 00        	unimp	

Disassembly of section .text._ZN4spin4once13Once$LT$T$GT$9call_once17h69331856e0aa39a3E:

000000008020202a <_ZN4spin4once13Once$LT$T$GT$9call_once17h69331856e0aa39a3E>:
8020202a: 13 01 01 81  	addi	sp, sp, -2032
8020202e: 23 34 11 7e  	sd	ra, 2024(sp)
80202032: 23 30 81 7e  	sd	s0, 2016(sp)
80202036: 23 3c 91 7c  	sd	s1, 2008(sp)
8020203a: 23 38 21 7d  	sd	s2, 2000(sp)
8020203e: 23 34 31 7d  	sd	s3, 1992(sp)
80202042: 23 30 41 7d  	sd	s4, 1984(sp)
80202046: 23 3c 51 7b  	sd	s5, 1976(sp)
8020204a: 23 38 61 7b  	sd	s6, 1968(sp)
8020204e: 23 34 71 7b  	sd	s7, 1960(sp)
80202052: 23 30 81 7b  	sd	s8, 1952(sp)
80202056: 23 3c 91 79  	sd	s9, 1944(sp)
8020205a: 23 38 a1 79  	sd	s10, 1936(sp)
8020205e: 23 34 b1 79  	sd	s11, 1928(sp)
80202062: 13 04 01 7f  	addi	s0, sp, 2032
80202066: 13 01 01 86  	addi	sp, sp, -1952
8020206a: aa 89        	mv	s3, a0
8020206c: 0f 00 30 03  	fence	rw, rw
80202070: 83 35 05 7a  	ld	a1, 1952(a0)
80202074: 13 05 05 7a  	addi	a0, a0, 1952
80202078: 0f 00 30 02  	fence	r, rw
8020207c: 63 92 05 2a  	bnez	a1, 0x80202320 <.LBB0_17+0xf4>
80202080: 05 46        	li	a2, 1
80202082: af 35 05 16  	lr.d.aqrl	a1, (a0)
80202086: 81 e5        	bnez	a1, 0x8020208e <_ZN4spin4once13Once$LT$T$GT$9call_once17h69331856e0aa39a3E+0x64>
80202088: af 36 c5 1e  	sc.d.aqrl	a3, a2, (a0)
8020208c: fd fa        	bnez	a3, 0x80202082 <_ZN4spin4once13Once$LT$T$GT$9call_once17h69331856e0aa39a3E+0x58>
8020208e: 63 99 05 28  	bnez	a1, 0x80202320 <.LBB0_17+0xf4>
80202092: fd 76        	lui	a3, 1048575
80202094: 9b 86 06 08  	addiw	a3, a3, 128
80202098: a2 96        	add	a3, a3, s0
8020209a: 88 e2        	sd	a0, 0(a3)
8020209c: 7d 75        	lui	a0, 1048575
8020209e: 1b 05 85 08  	addiw	a0, a0, 136
802020a2: 22 95        	add	a0, a0, s0
802020a4: 23 00 c5 00  	sb	a2, 0(a0)

00000000802020a8 <.LBB0_14>:
802020a8: 17 65 04 00  	auipc	a0, 70
802020ac: 13 05 85 f5  	addi	a0, a0, -168
802020b0: 83 3a 05 00  	ld	s5, 0(a0)
802020b4: 13 09 84 f1  	addi	s2, s0, -232
802020b8: 13 0a 84 88  	addi	s4, s0, -1912
802020bc: 13 05 04 81  	addi	a0, s0, -2032
802020c0: 13 06 10 07  	li	a2, 113
802020c4: 97 20 00 00  	auipc	ra, 2
802020c8: e7 80 60 3f  	jalr	1014(ra)
802020cc: 93 04 04 90  	addi	s1, s0, -1792
802020d0: 13 06 10 07  	li	a2, 113
802020d4: 52 85        	mv	a0, s4
802020d6: 81 45        	li	a1, 0
802020d8: 97 20 00 00  	auipc	ra, 2
802020dc: e7 80 20 3e  	jalr	994(ra)
802020e0: 13 0a 84 97  	addi	s4, s0, -1672
802020e4: 13 06 10 07  	li	a2, 113
802020e8: 26 85        	mv	a0, s1
802020ea: 81 45        	li	a1, 0
802020ec: 97 20 00 00  	auipc	ra, 2
802020f0: e7 80 e0 3c  	jalr	974(ra)
802020f4: 93 04 04 9f  	addi	s1, s0, -1552
802020f8: 13 06 10 07  	li	a2, 113
802020fc: 52 85        	mv	a0, s4
802020fe: 81 45        	li	a1, 0
80202100: 97 20 00 00  	auipc	ra, 2
80202104: e7 80 a0 3b  	jalr	954(ra)
80202108: 13 0a 84 a6  	addi	s4, s0, -1432
8020210c: 13 06 10 07  	li	a2, 113
80202110: 26 85        	mv	a0, s1
80202112: 81 45        	li	a1, 0
80202114: 97 20 00 00  	auipc	ra, 2
80202118: e7 80 60 3a  	jalr	934(ra)
8020211c: 93 04 04 ae  	addi	s1, s0, -1312
80202120: 13 06 10 07  	li	a2, 113
80202124: 52 85        	mv	a0, s4
80202126: 81 45        	li	a1, 0
80202128: 97 20 00 00  	auipc	ra, 2
8020212c: e7 80 20 39  	jalr	914(ra)
80202130: 13 0a 84 b5  	addi	s4, s0, -1192
80202134: 13 06 10 07  	li	a2, 113
80202138: 26 85        	mv	a0, s1
8020213a: 81 45        	li	a1, 0
8020213c: 97 20 00 00  	auipc	ra, 2
80202140: e7 80 e0 37  	jalr	894(ra)
80202144: 93 04 04 bd  	addi	s1, s0, -1072
80202148: 13 06 10 07  	li	a2, 113
8020214c: 52 85        	mv	a0, s4
8020214e: 81 45        	li	a1, 0
80202150: 97 20 00 00  	auipc	ra, 2
80202154: e7 80 a0 36  	jalr	874(ra)
80202158: 13 0a 84 c4  	addi	s4, s0, -952
8020215c: 13 06 10 07  	li	a2, 113
80202160: 26 85        	mv	a0, s1
80202162: 81 45        	li	a1, 0
80202164: 97 20 00 00  	auipc	ra, 2
80202168: e7 80 60 35  	jalr	854(ra)
8020216c: 93 04 04 cc  	addi	s1, s0, -832
80202170: 13 06 10 07  	li	a2, 113
80202174: 52 85        	mv	a0, s4
80202176: 81 45        	li	a1, 0
80202178: 97 20 00 00  	auipc	ra, 2
8020217c: e7 80 20 34  	jalr	834(ra)
80202180: 13 0a 84 d3  	addi	s4, s0, -712
80202184: 13 06 10 07  	li	a2, 113
80202188: 26 85        	mv	a0, s1
8020218a: 81 45        	li	a1, 0
8020218c: 97 20 00 00  	auipc	ra, 2
80202190: e7 80 e0 32  	jalr	814(ra)
80202194: 93 04 04 db  	addi	s1, s0, -592
80202198: 13 06 10 07  	li	a2, 113
8020219c: 52 85        	mv	a0, s4
8020219e: 81 45        	li	a1, 0
802021a0: 97 20 00 00  	auipc	ra, 2
802021a4: e7 80 a0 31  	jalr	794(ra)
802021a8: 13 0a 84 e2  	addi	s4, s0, -472
802021ac: 13 06 10 07  	li	a2, 113
802021b0: 26 85        	mv	a0, s1
802021b2: 81 45        	li	a1, 0
802021b4: 97 20 00 00  	auipc	ra, 2
802021b8: e7 80 60 30  	jalr	774(ra)
802021bc: 93 04 04 ea  	addi	s1, s0, -352
802021c0: 13 06 10 07  	li	a2, 113
802021c4: 52 85        	mv	a0, s4
802021c6: 81 45        	li	a1, 0
802021c8: 97 20 00 00  	auipc	ra, 2
802021cc: e7 80 20 2f  	jalr	754(ra)
802021d0: 13 06 10 07  	li	a2, 113
802021d4: 26 85        	mv	a0, s1
802021d6: 81 45        	li	a1, 0
802021d8: 97 20 00 00  	auipc	ra, 2
802021dc: e7 80 20 2e  	jalr	738(ra)
802021e0: 13 06 10 07  	li	a2, 113
802021e4: 4a 85        	mv	a0, s2
802021e6: 81 45        	li	a1, 0
802021e8: 97 20 00 00  	auipc	ra, 2
802021ec: e7 80 20 2d  	jalr	722(ra)
802021f0: 7d 75        	lui	a0, 1048575
802021f2: 1b 05 85 07  	addiw	a0, a0, 120
802021f6: 22 95        	add	a0, a0, s0
802021f8: 23 30 55 01  	sd	s5, 0(a0)
802021fc: 63 88 0a 0a  	beqz	s5, 0x802022ac <.LBB0_17+0x80>
80202200: 81 4b        	li	s7, 0

0000000080202202 <.LBB0_15>:
80202202: 17 45 02 00  	auipc	a0, 36
80202206: 13 05 e5 df  	addi	a0, a0, -514
8020220a: 09 6c        	lui	s8, 2
8020220c: 33 09 85 01  	add	s2, a0, s8

0000000080202210 <.LBB0_16>:
80202210: 17 45 00 00  	auipc	a0, 4
80202214: 13 05 05 df  	addi	a0, a0, -528
80202218: 9b 05 0c ef  	addiw	a1, s8, -272
8020221c: b3 04 b5 00  	add	s1, a0, a1
80202220: 13 05 10 20  	li	a0, 513
80202224: 13 1a 65 01  	slli	s4, a0, 22
80202228: 93 0c 00 78  	li	s9, 1920

000000008020222c <.LBB0_17>:
8020222c: 17 fd ff ff  	auipc	s10, 1048575
80202230: 13 0d 0d e3  	addi	s10, s10, -464
80202234: b7 0a 02 00  	lui	s5, 32
80202238: 7d 75        	lui	a0, 1048575
8020223a: 1b 05 85 07  	addiw	a0, a0, 120
8020223e: 22 95        	add	a0, a0, s0
80202240: 03 3b 05 00  	ld	s6, 0(a0)
80202244: 63 84 9b 07  	beq	s7, s9, 0x802022ac <.LBB0_17+0x80>
80202248: 13 05 04 81  	addi	a0, s0, -2032
8020224c: b3 0d 75 01  	add	s11, a0, s7
80202250: 7d 1b        	addi	s6, s6, -1
80202252: 7d 75        	lui	a0, 1048575
80202254: 1b 05 05 09  	addiw	a0, a0, 144
80202258: 22 95        	add	a0, a0, s0
8020225a: d2 85        	mv	a1, s4
8020225c: 4a 86        	mv	a2, s2
8020225e: 97 f0 ff ff  	auipc	ra, 1048575
80202262: e7 80 60 2b  	jalr	694(ra)
80202266: 7d 75        	lui	a0, 1048575
80202268: 1b 05 05 09  	addiw	a0, a0, 144
8020226c: b3 05 a4 00  	add	a1, s0, a0
80202270: 13 06 00 11  	li	a2, 272
80202274: 26 85        	mv	a0, s1
80202276: 97 20 00 00  	auipc	ra, 2
8020227a: e7 80 20 36  	jalr	866(ra)
8020227e: 23 b0 ad 01  	sd	s10, 0(s11)
80202282: 23 b4 9d 00  	sd	s1, 8(s11)
80202286: 13 85 0d 01  	addi	a0, s11, 16
8020228a: 13 06 00 06  	li	a2, 96
8020228e: 81 45        	li	a1, 0
80202290: 97 20 00 00  	auipc	ra, 2
80202294: e7 80 a0 22  	jalr	554(ra)
80202298: 05 45        	li	a0, 1
8020229a: 23 88 ad 06  	sb	a0, 112(s11)
8020229e: 93 8b 8b 07  	addi	s7, s7, 120
802022a2: e2 94        	add	s1, s1, s8
802022a4: 56 9a        	add	s4, s4, s5
802022a6: 62 99        	add	s2, s2, s8
802022a8: e3 1e 0b f8  	bnez	s6, 0x80202244 <.LBB0_17+0x18>
802022ac: 7d 75        	lui	a0, 1048575
802022ae: 1b 05 05 09  	addiw	a0, a0, 144
802022b2: 22 95        	add	a0, a0, s0
802022b4: 93 05 04 81  	addi	a1, s0, -2032
802022b8: 13 06 00 78  	li	a2, 1920
802022bc: 97 20 00 00  	auipc	ra, 2
802022c0: e7 80 c0 31  	jalr	796(ra)
802022c4: 05 45        	li	a0, 1
802022c6: 23 b0 a9 00  	sd	a0, 0(s3)
802022ca: 23 b4 09 00  	sd	zero, 8(s3)
802022ce: 13 85 09 01  	addi	a0, s3, 16
802022d2: fd 75        	lui	a1, 1048575
802022d4: 9b 85 05 09  	addiw	a1, a1, 144
802022d8: a2 95        	add	a1, a1, s0
802022da: 13 06 00 78  	li	a2, 1920
802022de: 97 20 00 00  	auipc	ra, 2
802022e2: e7 80 a0 2f  	jalr	762(ra)
802022e6: 23 b8 09 78  	sd	zero, 1936(s3)
802022ea: 7d 75        	lui	a0, 1048575
802022ec: 1b 05 85 07  	addiw	a0, a0, 120
802022f0: 22 95        	add	a0, a0, s0
802022f2: 08 61        	ld	a0, 0(a0)
802022f4: 23 bc a9 78  	sd	a0, 1944(s3)
802022f8: 7d 75        	lui	a0, 1048575
802022fa: 1b 05 85 08  	addiw	a0, a0, 136
802022fe: 22 95        	add	a0, a0, s0
80202300: 23 00 05 00  	sb	zero, 0(a0)
80202304: 0f 00 10 03  	fence	rw, w
80202308: 09 45        	li	a0, 2
8020230a: 23 b0 a9 7a  	sd	a0, 1952(s3)
8020230e: 7d 75        	lui	a0, 1048575
80202310: 1b 05 05 08  	addiw	a0, a0, 128
80202314: 22 95        	add	a0, a0, s0
80202316: 97 00 00 00  	auipc	ra, 0
8020231a: e7 80 60 27  	jalr	630(ra)
8020231e: 05 a0        	j	0x8020233e <.LBB0_17+0x112>
80202320: 05 46        	li	a2, 1
80202322: 63 9b c5 00  	bne	a1, a2, 0x80202338 <.LBB0_17+0x10c>
80202326: 0f 00 00 01  	fence	w, 0
8020232a: 0f 00 30 03  	fence	rw, rw
8020232e: 0c 61        	ld	a1, 0(a0)
80202330: 0f 00 30 02  	fence	r, rw
80202334: e3 89 c5 fe  	beq	a1, a2, 0x80202326 <.LBB0_17+0xfa>
80202338: 09 45        	li	a0, 2
8020233a: 63 93 a5 04  	bne	a1, a0, 0x80202380 <.LBB0_17+0x154>
8020233e: 13 85 89 00  	addi	a0, s3, 8
80202342: 13 01 01 7a  	addi	sp, sp, 1952
80202346: 83 30 81 7e  	ld	ra, 2024(sp)
8020234a: 03 34 01 7e  	ld	s0, 2016(sp)
8020234e: 83 34 81 7d  	ld	s1, 2008(sp)
80202352: 03 39 01 7d  	ld	s2, 2000(sp)
80202356: 83 39 81 7c  	ld	s3, 1992(sp)
8020235a: 03 3a 01 7c  	ld	s4, 1984(sp)
8020235e: 83 3a 81 7b  	ld	s5, 1976(sp)
80202362: 03 3b 01 7b  	ld	s6, 1968(sp)
80202366: 83 3b 81 7a  	ld	s7, 1960(sp)
8020236a: 03 3c 01 7a  	ld	s8, 1952(sp)
8020236e: 83 3c 81 79  	ld	s9, 1944(sp)
80202372: 03 3d 01 79  	ld	s10, 1936(sp)
80202376: 83 3d 81 78  	ld	s11, 1928(sp)
8020237a: 13 01 01 7f  	addi	sp, sp, 2032
8020237e: 82 80        	ret
80202380: 85 e1        	bnez	a1, 0x802023a0 <.LBB0_20>

0000000080202382 <.LBB0_18>:
80202382: 17 45 04 00  	auipc	a0, 68
80202386: 13 05 e5 1a  	addi	a0, a0, 430

000000008020238a <.LBB0_19>:
8020238a: 17 46 04 00  	auipc	a2, 68
8020238e: 13 06 e6 1c  	addi	a2, a2, 462
80202392: 93 05 80 02  	li	a1, 40
80202396: 97 10 00 00  	auipc	ra, 1
8020239a: e7 80 c0 8a  	jalr	-1876(ra)
8020239e: 00 00        	unimp	

00000000802023a0 <.LBB0_20>:
802023a0: 17 45 04 00  	auipc	a0, 68
802023a4: 13 05 05 11  	addi	a0, a0, 272

00000000802023a8 <.LBB0_21>:
802023a8: 17 46 04 00  	auipc	a2, 68
802023ac: 13 06 06 17  	addi	a2, a2, 368
802023b0: c5 45        	li	a1, 17
802023b2: 97 10 00 00  	auipc	ra, 1
802023b6: e7 80 00 89  	jalr	-1904(ra)
802023ba: 00 00        	unimp	

Disassembly of section .text._ZN4sel47syscall7process8sys_exit17hfad03a5e0ed4186aE:

00000000802023bc <_ZN4sel47syscall7process8sys_exit17hfad03a5e0ed4186aE>:
802023bc: 1d 71        	addi	sp, sp, -96
802023be: 86 ec        	sd	ra, 88(sp)
802023c0: a2 e8        	sd	s0, 80(sp)
802023c2: 80 10        	addi	s0, sp, 96
802023c4: 23 26 a4 fa  	sw	a0, -84(s0)

00000000802023c8 <.LBB0_3>:
802023c8: 17 25 00 00  	auipc	a0, 2
802023cc: 13 05 05 5a  	addi	a0, a0, 1440
802023d0: 08 61        	ld	a0, 0(a0)
802023d2: 89 45        	li	a1, 2
802023d4: 63 f9 a5 04  	bgeu	a1, a0, 0x80202426 <.LBB0_6+0x18>
802023d8: 13 05 c4 fa  	addi	a0, s0, -84
802023dc: 23 38 a4 fa  	sd	a0, -80(s0)

00000000802023e0 <.LBB0_4>:
802023e0: 17 25 00 00  	auipc	a0, 2
802023e4: 13 05 45 ee  	addi	a0, a0, -284
802023e8: 23 3c a4 fa  	sd	a0, -72(s0)

00000000802023ec <.LBB0_5>:
802023ec: 17 45 04 00  	auipc	a0, 68
802023f0: 13 05 c5 1a  	addi	a0, a0, 428
802023f4: 23 38 a4 fc  	sd	a0, -48(s0)
802023f8: 05 45        	li	a0, 1
802023fa: 23 3c a4 fc  	sd	a0, -40(s0)
802023fe: 23 30 04 fc  	sd	zero, -64(s0)
80202402: 93 05 04 fb  	addi	a1, s0, -80
80202406: 23 30 b4 fe  	sd	a1, -32(s0)
8020240a: 23 34 a4 fe  	sd	a0, -24(s0)

000000008020240e <.LBB0_6>:
8020240e: 17 46 04 00  	auipc	a2, 68
80202412: 13 06 a6 1c  	addi	a2, a2, 458
80202416: 13 05 04 fc  	addi	a0, s0, -64
8020241a: 8d 45        	li	a1, 3
8020241c: 81 46        	li	a3, 0
8020241e: 97 00 00 00  	auipc	ra, 0
80202422: e7 80 a0 6d  	jalr	1754(ra)
80202426: 97 f0 ff ff  	auipc	ra, 1048575
8020242a: e7 80 40 e5  	jalr	-428(ra)

000000008020242e <.LBB0_7>:
8020242e: 17 45 04 00  	auipc	a0, 68
80202432: 13 05 a5 1f  	addi	a0, a0, 506
80202436: 23 38 a4 fc  	sd	a0, -48(s0)
8020243a: 05 45        	li	a0, 1
8020243c: 23 3c a4 fc  	sd	a0, -40(s0)
80202440: 23 30 04 fc  	sd	zero, -64(s0)

0000000080202444 <.LBB0_8>:
80202444: 17 45 04 00  	auipc	a0, 68
80202448: 13 05 c5 12  	addi	a0, a0, 300
8020244c: 23 30 a4 fe  	sd	a0, -32(s0)
80202450: 23 34 04 fe  	sd	zero, -24(s0)

0000000080202454 <.LBB0_9>:
80202454: 97 45 04 00  	auipc	a1, 68
80202458: 93 85 45 1e  	addi	a1, a1, 484
8020245c: 13 05 04 fc  	addi	a0, s0, -64
80202460: 97 00 00 00  	auipc	ra, 0
80202464: e7 80 40 7b  	jalr	1972(ra)
80202468: 00 00        	unimp	

Disassembly of section .text._ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hc83fb63968e07dbeE:

000000008020246a <_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hc83fb63968e07dbeE>:
8020246a: 41 11        	addi	sp, sp, -16
8020246c: 06 e4        	sd	ra, 8(sp)
8020246e: 22 e0        	sd	s0, 0(sp)
80202470: 00 08        	addi	s0, sp, 16
80202472: 08 61        	ld	a0, 0(a0)
80202474: a2 60        	ld	ra, 8(sp)
80202476: 02 64        	ld	s0, 0(sp)
80202478: 41 01        	addi	sp, sp, 16
8020247a: 17 13 00 00  	auipc	t1, 1
8020247e: 67 00 83 e6  	jr	-408(t1)

Disassembly of section .text._ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17he9e9b4aa0ef791bdE:

0000000080202482 <_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17he9e9b4aa0ef791bdE>:
80202482: 41 11        	addi	sp, sp, -16
80202484: 06 e4        	sd	ra, 8(sp)
80202486: 22 e0        	sd	s0, 0(sp)
80202488: 00 08        	addi	s0, sp, 16
8020248a: 10 61        	ld	a2, 0(a0)
8020248c: 14 65        	ld	a3, 8(a0)
8020248e: 2e 87        	mv	a4, a1
80202490: 32 85        	mv	a0, a2
80202492: b6 85        	mv	a1, a3
80202494: 3a 86        	mv	a2, a4
80202496: a2 60        	ld	ra, 8(sp)
80202498: 02 64        	ld	s0, 0(sp)
8020249a: 41 01        	addi	sp, sp, 16
8020249c: 17 13 00 00  	auipc	t1, 1
802024a0: 67 00 43 57  	jr	1396(t1)

Disassembly of section .text._ZN4sel46kernel6object10objecttype14cap_get_capPtr17h66df656170e7b0bcE:

00000000802024a4 <_ZN4sel46kernel6object10objecttype14cap_get_capPtr17h66df656170e7b0bcE>:
802024a4: 41 11        	addi	sp, sp, -16
802024a6: 06 e4        	sd	ra, 8(sp)
802024a8: 22 e0        	sd	s0, 0(sp)
802024aa: 00 08        	addi	s0, sp, 16
802024ac: aa 85        	mv	a1, a0
802024ae: 10 61        	ld	a2, 0(a0)
802024b0: 93 56 b6 03  	srli	a3, a2, 59
802024b4: 13 87 f6 ff  	addi	a4, a3, -1
802024b8: b1 47        	li	a5, 12
802024ba: 01 45        	li	a0, 0
802024bc: 63 ed e7 00  	bltu	a5, a4, 0x802024d6 <.LBB6_3>
802024c0: 0e 07        	slli	a4, a4, 3

00000000802024c2 <.LBB6_17>:
802024c2: 97 47 04 00  	auipc	a5, 68
802024c6: 93 87 e7 18  	addi	a5, a5, 398
802024ca: 3e 97        	add	a4, a4, a5
802024cc: 18 63        	ld	a4, 0(a4)
802024ce: 02 87        	jr	a4

00000000802024d0 <.LBB6_2>:
802024d0: 88 65        	ld	a0, 8(a1)
802024d2: 42 05        	slli	a0, a0, 16
802024d4: 65 81        	srli	a0, a0, 25

00000000802024d6 <.LBB6_3>:
802024d6: a2 60        	ld	ra, 8(sp)
802024d8: 02 64        	ld	s0, 0(sp)
802024da: 41 01        	addi	sp, sp, 16
802024dc: 82 80        	ret

00000000802024de <.LBB6_4>:
802024de: 09 45        	li	a0, 2
802024e0: 63 84 a6 02  	beq	a3, a0, 0x80202508 <.LBB6_6+0x6>

00000000802024e4 <.LBB6_18>:
802024e4: 17 45 04 00  	auipc	a0, 68
802024e8: 13 05 45 1d  	addi	a0, a0, 468

00000000802024ec <.LBB6_19>:
802024ec: 17 46 04 00  	auipc	a2, 68
802024f0: 13 06 46 24  	addi	a2, a2, 580
802024f4: 93 05 60 05  	li	a1, 86
802024f8: 97 00 00 00  	auipc	ra, 0
802024fc: e7 80 a0 74  	jalr	1866(ra)
80202500: 00 00        	unimp	

0000000080202502 <.LBB6_6>:
80202502: 11 45        	li	a0, 4
80202504: 63 96 a6 04  	bne	a3, a0, 0x80202550 <.LBB6_20>
80202508: 93 15 96 01  	slli	a1, a2, 25
8020250c: 13 d5 95 01  	srli	a0, a1, 25
80202510: e3 d3 05 fc  	bgez	a1, 0x802024d6 <.LBB6_3>
80202514: fd 55        	li	a1, -1
80202516: 05 a0        	j	0x80202536 <.LBB6_10+0x12>

0000000080202518 <.LBB6_9>:
80202518: 13 15 26 00  	slli	a0, a2, 2
8020251c: fd 55        	li	a1, -1
8020251e: e5 81        	srli	a1, a1, 25
80202520: f5 15        	addi	a1, a1, -3
80202522: 15 a0        	j	0x80202546 <.LBB6_10+0x22>

0000000080202524 <.LBB6_10>:
80202524: 29 45        	li	a0, 10
80202526: 63 94 a6 04  	bne	a3, a0, 0x8020256e <.LBB6_22>
8020252a: 13 15 16 00  	slli	a0, a2, 1
8020252e: 6a 06        	slli	a2, a2, 26
80202530: fd 55        	li	a1, -1
80202532: 63 58 06 00  	bgez	a2, 0x80202542 <.LBB6_10+0x1e>
80202536: 9e 15        	slli	a1, a1, 39
80202538: 4d 8d        	or	a0, a0, a1
8020253a: a2 60        	ld	ra, 8(sp)
8020253c: 02 64        	ld	s0, 0(sp)
8020253e: 41 01        	addi	sp, sp, 16
80202540: 82 80        	ret
80202542: e5 81        	srli	a1, a1, 25
80202544: fd 15        	addi	a1, a1, -1
80202546: 6d 8d        	and	a0, a0, a1
80202548: a2 60        	ld	ra, 8(sp)
8020254a: 02 64        	ld	s0, 0(sp)
8020254c: 41 01        	addi	sp, sp, 16
8020254e: 82 80        	ret

0000000080202550 <.LBB6_20>:
80202550: 17 45 04 00  	auipc	a0, 68
80202554: 13 05 85 1f  	addi	a0, a0, 504

0000000080202558 <.LBB6_21>:
80202558: 17 46 04 00  	auipc	a2, 68
8020255c: 13 06 86 24  	addi	a2, a2, 584
80202560: 93 05 70 05  	li	a1, 87
80202564: 97 00 00 00  	auipc	ra, 0
80202568: e7 80 e0 6d  	jalr	1758(ra)
8020256c: 00 00        	unimp	

000000008020256e <.LBB6_22>:
8020256e: 17 45 04 00  	auipc	a0, 68
80202572: 13 05 a5 24  	addi	a0, a0, 586

0000000080202576 <.LBB6_23>:
80202576: 17 46 04 00  	auipc	a2, 68
8020257a: 13 06 a6 29  	addi	a2, a2, 666
8020257e: 93 05 40 05  	li	a1, 84
80202582: 97 00 00 00  	auipc	ra, 0
80202586: e7 80 00 6c  	jalr	1728(ra)
8020258a: 00 00        	unimp	

Disassembly of section .text._ZN60_$LT$spin..once..Finish$u20$as$u20$core..ops..drop..Drop$GT$4drop17hb46dda8a07855986E:

000000008020258c <_ZN60_$LT$spin..once..Finish$u20$as$u20$core..ops..drop..Drop$GT$4drop17hb46dda8a07855986E>:
8020258c: 41 11        	addi	sp, sp, -16
8020258e: 06 e4        	sd	ra, 8(sp)
80202590: 22 e0        	sd	s0, 0(sp)
80202592: 00 08        	addi	s0, sp, 16
80202594: 83 45 85 00  	lbu	a1, 8(a0)
80202598: 91 c5        	beqz	a1, 0x802025a4 <_ZN60_$LT$spin..once..Finish$u20$as$u20$core..ops..drop..Drop$GT$4drop17hb46dda8a07855986E+0x18>
8020259a: 08 61        	ld	a0, 0(a0)
8020259c: 0f 00 10 03  	fence	rw, w
802025a0: 8d 45        	li	a1, 3
802025a2: 0c e1        	sd	a1, 0(a0)
802025a4: a2 60        	ld	ra, 8(sp)
802025a6: 02 64        	ld	s0, 0(sp)
802025a8: 41 01        	addi	sp, sp, 16
802025aa: 82 80        	ret

Disassembly of section .text._ZN22buddy_system_allocator4Heap4init17h096a9c186af21a8bE:

00000000802025ac <_ZN22buddy_system_allocator4Heap4init17h096a9c186af21a8bE>:
802025ac: 41 11        	addi	sp, sp, -16
802025ae: 06 e4        	sd	ra, 8(sp)
802025b0: 22 e0        	sd	s0, 0(sp)
802025b2: 00 08        	addi	s0, sp, 16
802025b4: 2e 96        	add	a2, a2, a1
802025b6: 9d 05        	addi	a1, a1, 7
802025b8: e1 99        	andi	a1, a1, -8
802025ba: 93 7e 86 ff  	andi	t4, a2, -8
802025be: 63 eb be 12  	bltu	t4, a1, 0x802026f4 <.LBB5_20>
802025c2: 01 47        	li	a4, 0
802025c4: 13 86 85 00  	addi	a2, a1, 8
802025c8: 63 e1 ce 10  	bltu	t4, a2, 0x802026ca <.LBB5_18+0xda>

00000000802025cc <.LBB5_15>:
802025cc: 17 26 00 00  	auipc	a2, 2
802025d0: 13 06 c6 04  	addi	a2, a2, 76
802025d4: 03 38 06 00  	ld	a6, 0(a2)

00000000802025d8 <.LBB5_16>:
802025d8: 17 26 00 00  	auipc	a2, 2
802025dc: 13 06 86 04  	addi	a2, a2, 72
802025e0: 03 3f 06 00  	ld	t5, 0(a2)

00000000802025e4 <.LBB5_17>:
802025e4: 17 26 00 00  	auipc	a2, 2
802025e8: 13 06 46 04  	addi	a2, a2, 68
802025ec: 83 38 06 00  	ld	a7, 0(a2)

00000000802025f0 <.LBB5_18>:
802025f0: 17 26 00 00  	auipc	a2, 2
802025f4: 13 06 06 04  	addi	a2, a2, 64
802025f8: 83 32 06 00  	ld	t0, 0(a2)
802025fc: 13 03 f0 03  	li	t1, 63
80202600: 85 43        	li	t2, 1
80202602: 7d 4e        	li	t3, 31
80202604: 33 86 be 40  	sub	a2, t4, a1
80202608: 31 ca        	beqz	a2, 0x8020265c <.LBB5_18+0x6c>
8020260a: 93 56 16 00  	srli	a3, a2, 1
8020260e: 55 8e        	or	a2, a2, a3
80202610: 93 56 26 00  	srli	a3, a2, 2
80202614: 55 8e        	or	a2, a2, a3
80202616: 93 56 46 00  	srli	a3, a2, 4
8020261a: 55 8e        	or	a2, a2, a3
8020261c: 93 56 86 00  	srli	a3, a2, 8
80202620: 55 8e        	or	a2, a2, a3
80202622: 93 56 06 01  	srli	a3, a2, 16
80202626: 55 8e        	or	a2, a2, a3
80202628: 93 56 06 02  	srli	a3, a2, 32
8020262c: 55 8e        	or	a2, a2, a3
8020262e: 13 46 f6 ff  	not	a2, a2
80202632: 93 56 16 00  	srli	a3, a2, 1
80202636: b3 f6 06 01  	and	a3, a3, a6
8020263a: 15 8e        	sub	a2, a2, a3
8020263c: b3 76 e6 01  	and	a3, a2, t5
80202640: 09 82        	srli	a2, a2, 2
80202642: 33 76 e6 01  	and	a2, a2, t5
80202646: 36 96        	add	a2, a2, a3
80202648: 93 56 46 00  	srli	a3, a2, 4
8020264c: 36 96        	add	a2, a2, a3
8020264e: 33 76 16 01  	and	a2, a2, a7
80202652: 33 06 56 02  	mul	a2, a2, t0
80202656: 93 56 86 03  	srli	a3, a2, 56
8020265a: 19 a0        	j	0x80202660 <.LBB5_18+0x70>
8020265c: 93 06 00 04  	li	a3, 64
80202660: 33 06 b0 40  	neg	a2, a1
80202664: 6d 8e        	and	a2, a2, a1
80202666: b3 06 d3 40  	sub	a3, t1, a3
8020266a: b3 96 d3 00  	sll	a3, t2, a3
8020266e: 63 63 d6 00  	bltu	a2, a3, 0x80202674 <.LBB5_18+0x84>
80202672: 36 86        	mv	a2, a3
80202674: 05 ce        	beqz	a2, 0x802026ac <.LBB5_18+0xbc>
80202676: 93 06 f6 ff  	addi	a3, a2, -1
8020267a: 93 47 f6 ff  	not	a5, a2
8020267e: fd 8e        	and	a3, a3, a5
80202680: 93 d7 16 00  	srli	a5, a3, 1
80202684: b3 f7 07 01  	and	a5, a5, a6
80202688: 9d 8e        	sub	a3, a3, a5
8020268a: b3 f7 e6 01  	and	a5, a3, t5
8020268e: 89 82        	srli	a3, a3, 2
80202690: b3 f6 e6 01  	and	a3, a3, t5
80202694: be 96        	add	a3, a3, a5
80202696: 93 d7 46 00  	srli	a5, a3, 4
8020269a: be 96        	add	a3, a3, a5
8020269c: b3 f6 16 01  	and	a3, a3, a7
802026a0: b3 86 56 02  	mul	a3, a3, t0
802026a4: e1 92        	srli	a3, a3, 56
802026a6: 63 77 de 00  	bgeu	t3, a3, 0x802026b4 <.LBB5_18+0xc4>
802026aa: 0d a8        	j	0x802026dc <.LBB5_19>
802026ac: 93 06 00 04  	li	a3, 64
802026b0: 63 66 de 02  	bltu	t3, a3, 0x802026dc <.LBB5_19>
802026b4: 8e 06        	slli	a3, a3, 3
802026b6: aa 96        	add	a3, a3, a0
802026b8: 9c 62        	ld	a5, 0(a3)
802026ba: 9c e1        	sd	a5, 0(a1)
802026bc: 8c e2        	sd	a1, 0(a3)
802026be: b2 95        	add	a1, a1, a2
802026c0: 93 86 85 00  	addi	a3, a1, 8
802026c4: 32 97        	add	a4, a4, a2
802026c6: e3 ff de f2  	bgeu	t4, a3, 0x80202604 <.LBB5_18+0x14>
802026ca: 83 35 05 11  	ld	a1, 272(a0)
802026ce: ba 95        	add	a1, a1, a4
802026d0: 23 38 b5 10  	sd	a1, 272(a0)
802026d4: a2 60        	ld	ra, 8(sp)
802026d6: 02 64        	ld	s0, 0(sp)
802026d8: 41 01        	addi	sp, sp, 16
802026da: 82 80        	ret

00000000802026dc <.LBB5_19>:
802026dc: 17 46 04 00  	auipc	a2, 68
802026e0: 13 06 c6 1e  	addi	a2, a2, 492
802026e4: 93 05 00 02  	li	a1, 32
802026e8: 36 85        	mv	a0, a3
802026ea: 97 00 00 00  	auipc	ra, 0
802026ee: e7 80 40 58  	jalr	1412(ra)
802026f2: 00 00        	unimp	

00000000802026f4 <.LBB5_20>:
802026f4: 17 45 04 00  	auipc	a0, 68
802026f8: 13 05 45 13  	addi	a0, a0, 308

00000000802026fc <.LBB5_21>:
802026fc: 17 46 04 00  	auipc	a2, 68
80202700: 13 06 46 1b  	addi	a2, a2, 436
80202704: f9 45        	li	a1, 30
80202706: 97 00 00 00  	auipc	ra, 0
8020270a: e7 80 c0 53  	jalr	1340(ra)
8020270e: 00 00        	unimp	

Disassembly of section .text._ZN78_$LT$buddy_system_allocator..LockedHeap$u20$as$u20$core..ops..deref..Deref$GT$5deref17h2474381731d24de7E:

0000000080202710 <_ZN88_$LT$buddy_system_allocator..LockedHeapWithRescue$u20$as$u20$core..ops..deref..Deref$GT$5deref17h1624b06b126ab7f3E>:
80202710: 41 11        	addi	sp, sp, -16
80202712: 06 e4        	sd	ra, 8(sp)
80202714: 22 e0        	sd	s0, 0(sp)
80202716: 00 08        	addi	s0, sp, 16
80202718: a2 60        	ld	ra, 8(sp)
8020271a: 02 64        	ld	s0, 0(sp)
8020271c: 41 01        	addi	sp, sp, 16
8020271e: 82 80        	ret

Disassembly of section .text._ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h1aa85e0efa9af46fE:

0000000080202720 <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h1aa85e0efa9af46fE>:
80202720: 41 11        	addi	sp, sp, -16
80202722: 06 e4        	sd	ra, 8(sp)
80202724: 22 e0        	sd	s0, 0(sp)
80202726: 00 08        	addi	s0, sp, 16
80202728: 08 61        	ld	a0, 0(a0)
8020272a: a2 60        	ld	ra, 8(sp)
8020272c: 02 64        	ld	s0, 0(sp)
8020272e: 41 01        	addi	sp, sp, 16
80202730: 17 03 00 00  	auipc	t1, 0
80202734: 67 00 a3 1f  	jr	506(t1)

Disassembly of section .text._ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h86b16270b9ff9e69E:

0000000080202738 <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h86b16270b9ff9e69E>:
80202738: 41 11        	addi	sp, sp, -16
8020273a: 06 e4        	sd	ra, 8(sp)
8020273c: 22 e0        	sd	s0, 0(sp)
8020273e: 00 08        	addi	s0, sp, 16
80202740: 08 61        	ld	a0, 0(a0)
80202742: a2 60        	ld	ra, 8(sp)
80202744: 02 64        	ld	s0, 0(sp)
80202746: 41 01        	addi	sp, sp, 16
80202748: 17 03 00 00  	auipc	t1, 0
8020274c: 67 00 43 0d  	jr	212(t1)

Disassembly of section .text._ZN4core3ptr59drop_in_place$LT$$RF$riscv..register..scause..Exception$GT$17h8c4d5c89b0bc32b4E:

0000000080202750 <_ZN4core3ptr59drop_in_place$LT$$RF$riscv..register..scause..Exception$GT$17h8c4d5c89b0bc32b4E>:
80202750: 41 11        	addi	sp, sp, -16
80202752: 06 e4        	sd	ra, 8(sp)
80202754: 22 e0        	sd	s0, 0(sp)
80202756: 00 08        	addi	s0, sp, 16
80202758: a2 60        	ld	ra, 8(sp)
8020275a: 02 64        	ld	s0, 0(sp)
8020275c: 41 01        	addi	sp, sp, 16
8020275e: 82 80        	ret

Disassembly of section .text._ZN5riscv8register6scause9Interrupt4from17ha9a0ca98bcff293eE:

0000000080202760 <_ZN5riscv8register6scause9Interrupt4from17ha9a0ca98bcff293eE>:
80202760: 29 46        	li	a2, 10
80202762: a5 45        	li	a1, 9
80202764: 63 60 a6 02  	bltu	a2, a0, 0x80202784 <.LBB3_3+0x14>
80202768: 41 11        	addi	sp, sp, -16
8020276a: 06 e4        	sd	ra, 8(sp)
8020276c: 22 e0        	sd	s0, 0(sp)
8020276e: 00 08        	addi	s0, sp, 16

0000000080202770 <.LBB3_3>:
80202770: 97 45 04 00  	auipc	a1, 68
80202774: 93 85 45 43  	addi	a1, a1, 1076
80202778: 2e 95        	add	a0, a0, a1
8020277a: 83 45 05 00  	lbu	a1, 0(a0)
8020277e: a2 60        	ld	ra, 8(sp)
80202780: 02 64        	ld	s0, 0(sp)
80202782: 41 01        	addi	sp, sp, 16
80202784: 2e 85        	mv	a0, a1
80202786: 82 80        	ret

Disassembly of section .text._ZN5riscv8register6scause9Exception4from17hbf61d6d58c7966ffE:

0000000080202788 <_ZN5riscv8register6scause9Exception4from17hbf61d6d58c7966ffE>:
80202788: 5d 46        	li	a2, 23
8020278a: c1 45        	li	a1, 16
8020278c: 63 60 a6 02  	bltu	a2, a0, 0x802027ac <.LBB4_3+0x14>
80202790: 41 11        	addi	sp, sp, -16
80202792: 06 e4        	sd	ra, 8(sp)
80202794: 22 e0        	sd	s0, 0(sp)
80202796: 00 08        	addi	s0, sp, 16

0000000080202798 <.LBB4_3>:
80202798: 97 45 04 00  	auipc	a1, 68
8020279c: 93 85 75 41  	addi	a1, a1, 1047
802027a0: 2e 95        	add	a0, a0, a1
802027a2: 83 45 05 00  	lbu	a1, 0(a0)
802027a6: a2 60        	ld	ra, 8(sp)
802027a8: 02 64        	ld	s0, 0(sp)
802027aa: 41 01        	addi	sp, sp, 16
802027ac: 2e 85        	mv	a0, a1
802027ae: 82 80        	ret

Disassembly of section .text._ZN5riscv8register6scause6Scause4code17h67514d7fe44e35d2E:

00000000802027b0 <_ZN5riscv8register6scause6Scause4code17h67514d7fe44e35d2E>:
802027b0: 41 11        	addi	sp, sp, -16
802027b2: 06 e4        	sd	ra, 8(sp)
802027b4: 22 e0        	sd	s0, 0(sp)
802027b6: 00 08        	addi	s0, sp, 16
802027b8: 08 61        	ld	a0, 0(a0)
802027ba: 06 05        	slli	a0, a0, 1
802027bc: 05 81        	srli	a0, a0, 1
802027be: a2 60        	ld	ra, 8(sp)
802027c0: 02 64        	ld	s0, 0(sp)
802027c2: 41 01        	addi	sp, sp, 16
802027c4: 82 80        	ret

Disassembly of section .text._ZN66_$LT$riscv..register..scause..Trap$u20$as$u20$core..fmt..Debug$GT$3fmt17hd2a7a3623887e373E:

00000000802027c6 <_ZN66_$LT$riscv..register..scause..Trap$u20$as$u20$core..fmt..Debug$GT$3fmt17hd2a7a3623887e373E>:
802027c6: 01 11        	addi	sp, sp, -32
802027c8: 06 ec        	sd	ra, 24(sp)
802027ca: 22 e8        	sd	s0, 16(sp)
802027cc: 00 10        	addi	s0, sp, 32
802027ce: 2a 86        	mv	a2, a0
802027d0: 83 46 05 00  	lbu	a3, 0(a0)
802027d4: 2e 85        	mv	a0, a1
802027d6: 93 05 16 00  	addi	a1, a2, 1
802027da: 81 ce        	beqz	a3, 0x802027f2 <.LBB6_5+0xa>
802027dc: 23 34 b4 fe  	sd	a1, -24(s0)

00000000802027e0 <.LBB6_4>:
802027e0: 97 45 04 00  	auipc	a1, 68
802027e4: 93 85 85 1d  	addi	a1, a1, 472

00000000802027e8 <.LBB6_5>:
802027e8: 17 47 04 00  	auipc	a4, 68
802027ec: 13 07 07 1e  	addi	a4, a4, 480
802027f0: 19 a8        	j	0x80202806 <.LBB6_7+0x8>
802027f2: 23 34 b4 fe  	sd	a1, -24(s0)

00000000802027f6 <.LBB6_6>:
802027f6: 97 45 04 00  	auipc	a1, 68
802027fa: 93 85 25 1f  	addi	a1, a1, 498

00000000802027fe <.LBB6_7>:
802027fe: 17 47 04 00  	auipc	a4, 68
80202802: 13 07 a7 1f  	addi	a4, a4, 506
80202806: 25 46        	li	a2, 9
80202808: 93 06 84 fe  	addi	a3, s0, -24
8020280c: 97 10 00 00  	auipc	ra, 1
80202810: e7 80 40 16  	jalr	356(ra)
80202814: e2 60        	ld	ra, 24(sp)
80202816: 42 64        	ld	s0, 16(sp)
80202818: 05 61        	addi	sp, sp, 32
8020281a: 82 80        	ret

Disassembly of section .text._ZN71_$LT$riscv..register..scause..Interrupt$u20$as$u20$core..fmt..Debug$GT$3fmt17hacd25cb7125cd354E:

000000008020281c <_ZN71_$LT$riscv..register..scause..Interrupt$u20$as$u20$core..fmt..Debug$GT$3fmt17hacd25cb7125cd354E>:
8020281c: 41 11        	addi	sp, sp, -16
8020281e: 06 e4        	sd	ra, 8(sp)
80202820: 22 e0        	sd	s0, 0(sp)
80202822: 00 08        	addi	s0, sp, 16
80202824: 03 45 05 00  	lbu	a0, 0(a0)
80202828: 0e 05        	slli	a0, a0, 3

000000008020282a <.LBB7_11>:
8020282a: 17 46 04 00  	auipc	a2, 68
8020282e: 13 06 66 0b  	addi	a2, a2, 182
80202832: 32 95        	add	a0, a0, a2
80202834: 10 61        	ld	a2, 0(a0)
80202836: 2e 85        	mv	a0, a1
80202838: 02 86        	jr	a2

000000008020283a <.LBB7_12>:
8020283a: 97 45 04 00  	auipc	a1, 68
8020283e: 93 85 d5 26  	addi	a1, a1, 621
80202842: 21 46        	li	a2, 8
80202844: a2 60        	ld	ra, 8(sp)
80202846: 02 64        	ld	s0, 0(sp)
80202848: 41 01        	addi	sp, sp, 16
8020284a: 17 13 00 00  	auipc	t1, 1
8020284e: 67 00 e3 11  	jr	286(t1)

0000000080202852 <.LBB7_2>:
80202852: 97 45 04 00  	auipc	a1, 68
80202856: 93 85 05 24  	addi	a1, a1, 576
8020285a: 55 46        	li	a2, 21
8020285c: a2 60        	ld	ra, 8(sp)
8020285e: 02 64        	ld	s0, 0(sp)
80202860: 41 01        	addi	sp, sp, 16
80202862: 17 13 00 00  	auipc	t1, 1
80202866: 67 00 63 10  	jr	262(t1)

000000008020286a <.LBB7_3>:
8020286a: 97 45 04 00  	auipc	a1, 68
8020286e: 93 85 a5 21  	addi	a1, a1, 538
80202872: 39 46        	li	a2, 14
80202874: a2 60        	ld	ra, 8(sp)
80202876: 02 64        	ld	s0, 0(sp)
80202878: 41 01        	addi	sp, sp, 16
8020287a: 17 13 00 00  	auipc	t1, 1
8020287e: 67 00 e3 0e  	jr	238(t1)

0000000080202882 <.LBB7_4>:
80202882: 97 45 04 00  	auipc	a1, 68
80202886: 93 85 95 1f  	addi	a1, a1, 505
8020288a: 25 46        	li	a2, 9
8020288c: a2 60        	ld	ra, 8(sp)
8020288e: 02 64        	ld	s0, 0(sp)
80202890: 41 01        	addi	sp, sp, 16
80202892: 17 13 00 00  	auipc	t1, 1
80202896: 67 00 63 0d  	jr	214(t1)

000000008020289a <.LBB7_5>:
8020289a: 97 45 04 00  	auipc	a1, 68
8020289e: 93 85 b5 1c  	addi	a1, a1, 459
802028a2: 59 46        	li	a2, 22
802028a4: a2 60        	ld	ra, 8(sp)
802028a6: 02 64        	ld	s0, 0(sp)
802028a8: 41 01        	addi	sp, sp, 16
802028aa: 17 13 00 00  	auipc	t1, 1
802028ae: 67 00 e3 0b  	jr	190(t1)

00000000802028b2 <.LBB7_6>:
802028b2: 97 45 04 00  	auipc	a1, 68
802028b6: 93 85 45 1a  	addi	a1, a1, 420
802028ba: 3d 46        	li	a2, 15
802028bc: a2 60        	ld	ra, 8(sp)
802028be: 02 64        	ld	s0, 0(sp)
802028c0: 41 01        	addi	sp, sp, 16
802028c2: 17 13 00 00  	auipc	t1, 1
802028c6: 67 00 63 0a  	jr	166(t1)

00000000802028ca <.LBB7_7>:
802028ca: 97 45 04 00  	auipc	a1, 68
802028ce: 93 85 05 18  	addi	a1, a1, 384
802028d2: 31 46        	li	a2, 12
802028d4: a2 60        	ld	ra, 8(sp)
802028d6: 02 64        	ld	s0, 0(sp)
802028d8: 41 01        	addi	sp, sp, 16
802028da: 17 13 00 00  	auipc	t1, 1
802028de: 67 00 e3 08  	jr	142(t1)

00000000802028e2 <.LBB7_8>:
802028e2: 97 45 04 00  	auipc	a1, 68
802028e6: 93 85 f5 14  	addi	a1, a1, 335
802028ea: 65 46        	li	a2, 25
802028ec: a2 60        	ld	ra, 8(sp)
802028ee: 02 64        	ld	s0, 0(sp)
802028f0: 41 01        	addi	sp, sp, 16
802028f2: 17 13 00 00  	auipc	t1, 1
802028f6: 67 00 63 07  	jr	118(t1)

00000000802028fa <.LBB7_9>:
802028fa: 97 45 04 00  	auipc	a1, 68
802028fe: 93 85 55 12  	addi	a1, a1, 293
80202902: 49 46        	li	a2, 18
80202904: a2 60        	ld	ra, 8(sp)
80202906: 02 64        	ld	s0, 0(sp)
80202908: 41 01        	addi	sp, sp, 16
8020290a: 17 13 00 00  	auipc	t1, 1
8020290e: 67 00 e3 05  	jr	94(t1)

0000000080202912 <.LBB7_21>:
80202912: 97 45 04 00  	auipc	a1, 68
80202916: 93 85 65 10  	addi	a1, a1, 262
8020291a: 1d 46        	li	a2, 7
8020291c: a2 60        	ld	ra, 8(sp)
8020291e: 02 64        	ld	s0, 0(sp)
80202920: 41 01        	addi	sp, sp, 16
80202922: 17 13 00 00  	auipc	t1, 1
80202926: 67 00 63 04  	jr	70(t1)

Disassembly of section .text._ZN71_$LT$riscv..register..scause..Exception$u20$as$u20$core..fmt..Debug$GT$3fmt17h5d2c239ebab34529E:

000000008020292a <_ZN71_$LT$riscv..register..scause..Exception$u20$as$u20$core..fmt..Debug$GT$3fmt17h5d2c239ebab34529E>:
8020292a: 41 11        	addi	sp, sp, -16
8020292c: 06 e4        	sd	ra, 8(sp)
8020292e: 22 e0        	sd	s0, 0(sp)
80202930: 00 08        	addi	s0, sp, 16
80202932: 03 45 05 00  	lbu	a0, 0(a0)
80202936: 0e 05        	slli	a0, a0, 3

0000000080202938 <.LBB8_20>:
80202938: 17 46 04 00  	auipc	a2, 68
8020293c: 13 06 86 ff  	addi	a2, a2, -8
80202940: 32 95        	add	a0, a0, a2
80202942: 10 61        	ld	a2, 0(a0)
80202944: 2e 85        	mv	a0, a1
80202946: 02 86        	jr	a2

0000000080202948 <.LBB8_21>:
80202948: 97 45 04 00  	auipc	a1, 68
8020294c: 93 85 75 24  	addi	a1, a1, 583
80202950: 55 46        	li	a2, 21
80202952: a2 60        	ld	ra, 8(sp)
80202954: 02 64        	ld	s0, 0(sp)
80202956: 41 01        	addi	sp, sp, 16
80202958: 17 13 00 00  	auipc	t1, 1
8020295c: 67 00 03 01  	jr	16(t1)

0000000080202960 <.LBB8_22>:
80202960: 97 25 00 00  	auipc	a1, 2
80202964: 93 85 05 6f  	addi	a1, a1, 1776
80202968: 41 46        	li	a2, 16
8020296a: a2 60        	ld	ra, 8(sp)
8020296c: 02 64        	ld	s0, 0(sp)
8020296e: 41 01        	addi	sp, sp, 16
80202970: 17 13 00 00  	auipc	t1, 1
80202974: 67 00 83 ff  	jr	-8(t1)

0000000080202978 <.LBB8_3>:
80202978: 97 45 04 00  	auipc	a1, 68
8020297c: 93 85 55 20  	addi	a1, a1, 517
80202980: dd a8        	j	0x80202a76 <.LBB8_35+0x8>

0000000080202982 <.LBB8_4>:
80202982: 97 45 04 00  	auipc	a1, 68
80202986: 93 85 15 1f  	addi	a1, a1, 497
8020298a: 2d a8        	j	0x802029c4 <.LBB8_7+0x8>

000000008020298c <.LBB8_5>:
8020298c: 97 45 04 00  	auipc	a1, 68
80202990: 93 85 e5 1d  	addi	a1, a1, 478
80202994: 25 46        	li	a2, 9
80202996: a2 60        	ld	ra, 8(sp)
80202998: 02 64        	ld	s0, 0(sp)
8020299a: 41 01        	addi	sp, sp, 16
8020299c: 17 13 00 00  	auipc	t1, 1
802029a0: 67 00 c3 fc  	jr	-52(t1)

00000000802029a4 <.LBB8_6>:
802029a4: 97 45 04 00  	auipc	a1, 68
802029a8: 93 85 75 1b  	addi	a1, a1, 439
802029ac: 3d 46        	li	a2, 15
802029ae: a2 60        	ld	ra, 8(sp)
802029b0: 02 64        	ld	s0, 0(sp)
802029b2: 41 01        	addi	sp, sp, 16
802029b4: 17 13 00 00  	auipc	t1, 1
802029b8: 67 00 43 fb  	jr	-76(t1)

00000000802029bc <.LBB8_7>:
802029bc: 97 45 04 00  	auipc	a1, 68
802029c0: 93 85 55 19  	addi	a1, a1, 405
802029c4: 29 46        	li	a2, 10
802029c6: a2 60        	ld	ra, 8(sp)
802029c8: 02 64        	ld	s0, 0(sp)
802029ca: 41 01        	addi	sp, sp, 16
802029cc: 17 13 00 00  	auipc	t1, 1
802029d0: 67 00 c3 f9  	jr	-100(t1)

00000000802029d4 <.LBB8_9>:
802029d4: 97 45 04 00  	auipc	a1, 68
802029d8: 93 85 25 17  	addi	a1, a1, 370
802029dc: 2d 46        	li	a2, 11
802029de: a2 60        	ld	ra, 8(sp)
802029e0: 02 64        	ld	s0, 0(sp)
802029e2: 41 01        	addi	sp, sp, 16
802029e4: 17 13 00 00  	auipc	t1, 1
802029e8: 67 00 43 f8  	jr	-124(t1)

00000000802029ec <.LBB8_29>:
802029ec: 97 45 04 00  	auipc	a1, 68
802029f0: 93 85 25 14  	addi	a1, a1, 322
802029f4: 61 46        	li	a2, 24
802029f6: a2 60        	ld	ra, 8(sp)
802029f8: 02 64        	ld	s0, 0(sp)
802029fa: 41 01        	addi	sp, sp, 16
802029fc: 17 13 00 00  	auipc	t1, 1
80202a00: 67 00 c3 f6  	jr	-148(t1)

0000000080202a04 <.LBB8_30>:
80202a04: 97 45 04 00  	auipc	a1, 68
80202a08: 93 85 65 11  	addi	a1, a1, 278
80202a0c: 51 46        	li	a2, 20
80202a0e: a2 60        	ld	ra, 8(sp)
80202a10: 02 64        	ld	s0, 0(sp)
80202a12: 41 01        	addi	sp, sp, 16
80202a14: 17 13 00 00  	auipc	t1, 1
80202a18: 67 00 43 f5  	jr	-172(t1)

0000000080202a1c <.LBB8_31>:
80202a1c: 97 45 04 00  	auipc	a1, 68
80202a20: 93 85 15 0f  	addi	a1, a1, 241
80202a24: 35 46        	li	a2, 13
80202a26: a2 60        	ld	ra, 8(sp)
80202a28: 02 64        	ld	s0, 0(sp)
80202a2a: 41 01        	addi	sp, sp, 16
80202a2c: 17 13 00 00  	auipc	t1, 1
80202a30: 67 00 c3 f3  	jr	-196(t1)

0000000080202a34 <.LBB8_32>:
80202a34: 97 45 04 00  	auipc	a1, 68
80202a38: 93 85 b5 0c  	addi	a1, a1, 203
80202a3c: 39 46        	li	a2, 14
80202a3e: a2 60        	ld	ra, 8(sp)
80202a40: 02 64        	ld	s0, 0(sp)
80202a42: 41 01        	addi	sp, sp, 16
80202a44: 17 13 00 00  	auipc	t1, 1
80202a48: 67 00 43 f2  	jr	-220(t1)

0000000080202a4c <.LBB8_33>:
80202a4c: 97 45 04 00  	auipc	a1, 68
80202a50: 93 85 a5 09  	addi	a1, a1, 154
80202a54: 65 46        	li	a2, 25
80202a56: a2 60        	ld	ra, 8(sp)
80202a58: 02 64        	ld	s0, 0(sp)
80202a5a: 41 01        	addi	sp, sp, 16
80202a5c: 17 13 00 00  	auipc	t1, 1
80202a60: 67 00 c3 f0  	jr	-244(t1)

0000000080202a64 <.LBB8_34>:
80202a64: 97 45 04 00  	auipc	a1, 68
80202a68: 93 85 05 07  	addi	a1, a1, 112
80202a6c: 29 a0        	j	0x80202a76 <.LBB8_35+0x8>

0000000080202a6e <.LBB8_35>:
80202a6e: 97 45 04 00  	auipc	a1, 68
80202a72: 93 85 45 05  	addi	a1, a1, 84
80202a76: 49 46        	li	a2, 18
80202a78: a2 60        	ld	ra, 8(sp)
80202a7a: 02 64        	ld	s0, 0(sp)
80202a7c: 41 01        	addi	sp, sp, 16
80202a7e: 17 13 00 00  	auipc	t1, 1
80202a82: 67 00 a3 ee  	jr	-278(t1)

0000000080202a86 <.LBB8_36>:
80202a86: 97 45 04 00  	auipc	a1, 68
80202a8a: 93 85 95 02  	addi	a1, a1, 41
80202a8e: 4d 46        	li	a2, 19
80202a90: a2 60        	ld	ra, 8(sp)
80202a92: 02 64        	ld	s0, 0(sp)
80202a94: 41 01        	addi	sp, sp, 16
80202a96: 17 13 00 00  	auipc	t1, 1
80202a9a: 67 00 23 ed  	jr	-302(t1)

0000000080202a9e <.LBB8_37>:
80202a9e: 97 45 04 00  	auipc	a1, 68
80202aa2: 93 85 a5 f7  	addi	a1, a1, -134
80202aa6: 1d 46        	li	a2, 7
80202aa8: a2 60        	ld	ra, 8(sp)
80202aaa: 02 64        	ld	s0, 0(sp)
80202aac: 41 01        	addi	sp, sp, 16
80202aae: 17 13 00 00  	auipc	t1, 1
80202ab2: 67 00 a3 eb  	jr	-326(t1)

Disassembly of section .text._ZN4core3ptr32drop_in_place$LT$$RF$$RF$str$GT$17haf40bd6c1d91ab3bE:

0000000080202ab6 <_ZN4core3ptr32drop_in_place$LT$$RF$$RF$str$GT$17haf40bd6c1d91ab3bE>:
80202ab6: 41 11        	addi	sp, sp, -16
80202ab8: 06 e4        	sd	ra, 8(sp)
80202aba: 22 e0        	sd	s0, 0(sp)
80202abc: 00 08        	addi	s0, sp, 16
80202abe: a2 60        	ld	ra, 8(sp)
80202ac0: 02 64        	ld	s0, 0(sp)
80202ac2: 41 01        	addi	sp, sp, 16
80202ac4: 82 80        	ret

Disassembly of section .text._ZN43_$LT$log..NopLogger$u20$as$u20$log..Log$GT$7enabled17h1a2bf1c29409faa0E:

0000000080202ac6 <_ZN43_$LT$log..NopLogger$u20$as$u20$log..Log$GT$7enabled17h1a2bf1c29409faa0E>:
80202ac6: 41 11        	addi	sp, sp, -16
80202ac8: 06 e4        	sd	ra, 8(sp)
80202aca: 22 e0        	sd	s0, 0(sp)
80202acc: 00 08        	addi	s0, sp, 16
80202ace: 01 45        	li	a0, 0
80202ad0: a2 60        	ld	ra, 8(sp)
80202ad2: 02 64        	ld	s0, 0(sp)
80202ad4: 41 01        	addi	sp, sp, 16
80202ad6: 82 80        	ret

Disassembly of section .text._ZN43_$LT$log..NopLogger$u20$as$u20$log..Log$GT$3log17haafec08b3a927984E:

0000000080202ad8 <_ZN43_$LT$log..NopLogger$u20$as$u20$log..Log$GT$3log17haafec08b3a927984E>:
80202ad8: 41 11        	addi	sp, sp, -16
80202ada: 06 e4        	sd	ra, 8(sp)
80202adc: 22 e0        	sd	s0, 0(sp)
80202ade: 00 08        	addi	s0, sp, 16
80202ae0: a2 60        	ld	ra, 8(sp)
80202ae2: 02 64        	ld	s0, 0(sp)
80202ae4: 41 01        	addi	sp, sp, 16
80202ae6: 82 80        	ret

Disassembly of section .text._ZN43_$LT$log..NopLogger$u20$as$u20$log..Log$GT$5flush17h246837124c246afbE:

0000000080202ae8 <_ZN43_$LT$log..NopLogger$u20$as$u20$log..Log$GT$5flush17h246837124c246afbE>:
80202ae8: 41 11        	addi	sp, sp, -16
80202aea: 06 e4        	sd	ra, 8(sp)
80202aec: 22 e0        	sd	s0, 0(sp)
80202aee: 00 08        	addi	s0, sp, 16
80202af0: a2 60        	ld	ra, 8(sp)
80202af2: 02 64        	ld	s0, 0(sp)
80202af4: 41 01        	addi	sp, sp, 16
80202af6: 82 80        	ret

Disassembly of section .text._ZN3log17__private_api_log17he4dfcaf7e9ba9ed4E:

0000000080202af8 <_ZN3log17__private_api_log17he4dfcaf7e9ba9ed4E>:
80202af8: 35 71        	addi	sp, sp, -160
80202afa: 06 ed        	sd	ra, 152(sp)
80202afc: 22 e9        	sd	s0, 144(sp)
80202afe: 26 e5        	sd	s1, 136(sp)
80202b00: 00 11        	addi	s0, sp, 160
80202b02: e1 e6        	bnez	a3, 0x80202bca <.LBB24_11>
80202b04: 2a 87        	mv	a4, a0
80202b06: 03 28 06 03  	lw	a6, 48(a2)
80202b0a: 83 38 86 02  	ld	a7, 40(a2)
80202b0e: 83 32 06 02  	ld	t0, 32(a2)
80202b12: 03 33 86 01  	ld	t1, 24(a2)
80202b16: 83 33 06 01  	ld	t2, 16(a2)
80202b1a: 83 3e 86 00  	ld	t4, 8(a2)
80202b1e: 03 3f 06 00  	ld	t5, 0(a2)
80202b22: 0f 00 30 03  	fence	rw, rw

0000000080202b26 <.LBB24_6>:
80202b26: 17 25 00 00  	auipc	a0, 2
80202b2a: 13 05 a5 e3  	addi	a0, a0, -454
80202b2e: 08 61        	ld	a0, 0(a0)
80202b30: 09 46        	li	a2, 2
80202b32: 0f 00 30 02  	fence	r, rw
80202b36: 63 0b c5 00  	beq	a0, a2, 0x80202b4c <.LBB24_9>

0000000080202b3a <.LBB24_7>:
80202b3a: 17 4e 04 00  	auipc	t3, 68
80202b3e: 13 0e 6e 0a  	addi	t3, t3, 166

0000000080202b42 <.LBB24_8>:
80202b42: 17 45 04 00  	auipc	a0, 68
80202b46: 13 05 65 08  	addi	a0, a0, 134
80202b4a: 21 a8        	j	0x80202b62 <.LBB24_10+0xc>

0000000080202b4c <.LBB24_9>:
80202b4c: 17 25 00 00  	auipc	a0, 2
80202b50: 13 05 c5 b4  	addi	a0, a0, -1204
80202b54: 08 61        	ld	a0, 0(a0)

0000000080202b56 <.LBB24_10>:
80202b56: 17 26 00 00  	auipc	a2, 2
80202b5a: 13 06 a6 b4  	addi	a2, a2, -1206
80202b5e: 03 3e 06 00  	ld	t3, 0(a2)
80202b62: 10 63        	ld	a2, 0(a4)
80202b64: 1c 67        	ld	a5, 8(a4)
80202b66: 14 6b        	ld	a3, 16(a4)
80202b68: 83 3f 87 01  	ld	t6, 24(a4)
80202b6c: 04 73        	ld	s1, 32(a4)
80202b6e: 18 77        	ld	a4, 40(a4)
80202b70: 23 30 e4 fb  	sd	t5, -96(s0)
80202b74: 23 34 d4 fb  	sd	t4, -88(s0)
80202b78: 23 38 b4 fa  	sd	a1, -80(s0)
80202b7c: 23 34 c4 f6  	sd	a2, -152(s0)
80202b80: 23 38 f4 f6  	sd	a5, -144(s0)
80202b84: 23 3c d4 f6  	sd	a3, -136(s0)
80202b88: 23 30 f4 f9  	sd	t6, -128(s0)
80202b8c: 23 34 94 f8  	sd	s1, -120(s0)
80202b90: 23 38 e4 f8  	sd	a4, -112(s0)
80202b94: 23 3c 04 fa  	sd	zero, -72(s0)
80202b98: 23 30 74 fc  	sd	t2, -64(s0)
80202b9c: 23 34 64 fc  	sd	t1, -56(s0)
80202ba0: 23 38 04 fc  	sd	zero, -48(s0)
80202ba4: 23 3c 54 fc  	sd	t0, -40(s0)
80202ba8: 23 30 14 ff  	sd	a7, -32(s0)
80202bac: 85 45        	li	a1, 1
80202bae: 23 2c b4 f8  	sw	a1, -104(s0)
80202bb2: 23 2e 04 f9  	sw	a6, -100(s0)
80202bb6: 03 36 8e 02  	ld	a2, 40(t3)
80202bba: 93 05 84 f6  	addi	a1, s0, -152
80202bbe: 02 96        	jalr	a2
80202bc0: ea 60        	ld	ra, 152(sp)
80202bc2: 4a 64        	ld	s0, 144(sp)
80202bc4: aa 64        	ld	s1, 136(sp)
80202bc6: 0d 61        	addi	sp, sp, 160
80202bc8: 82 80        	ret

0000000080202bca <.LBB24_11>:
80202bca: 17 45 04 00  	auipc	a0, 68
80202bce: 13 05 05 0a  	addi	a0, a0, 160

0000000080202bd2 <.LBB24_12>:
80202bd2: 17 46 04 00  	auipc	a2, 68
80202bd6: 13 06 e6 0e  	addi	a2, a2, 238
80202bda: 93 05 50 05  	li	a1, 85
80202bde: 97 00 00 00  	auipc	ra, 0
80202be2: e7 80 40 06  	jalr	100(ra)
80202be6: 00 00        	unimp	

Disassembly of section .text._ZN4core3ops8function6FnOnce9call_once17hfd3303d23173549bE:

0000000080202be8 <_ZN4core3ops8function6FnOnce9call_once17hfd3303d23173549bE>:
80202be8: 08 61        	ld	a0, 0(a0)
80202bea: 01 a0        	j	0x80202bea <_ZN4core3ops8function6FnOnce9call_once17hfd3303d23173549bE+0x2>

Disassembly of section .text._ZN4core3ptr102drop_in_place$LT$$RF$core..iter..adapters..copied..Copied$LT$core..slice..iter..Iter$LT$u8$GT$$GT$$GT$17h53befd6046d0b90eE:

0000000080202bec <_ZN4core3ptr102drop_in_place$LT$$RF$core..iter..adapters..copied..Copied$LT$core..slice..iter..Iter$LT$u8$GT$$GT$$GT$17h53befd6046d0b90eE>:
80202bec: 82 80        	ret

Disassembly of section .text._ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17hf7601e0e4f62b400E:

0000000080202bee <_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17hf7601e0e4f62b400E>:
80202bee: 17 25 00 00  	auipc	a0, 2
80202bf2: 13 05 25 ba  	addi	a0, a0, -1118
80202bf6: 08 61        	ld	a0, 0(a0)
80202bf8: 82 80        	ret

Disassembly of section .text._ZN63_$LT$core..cell..BorrowMutError$u20$as$u20$core..fmt..Debug$GT$3fmt17h85b3e4f3b263bba6E:

0000000080202bfa <_ZN63_$LT$core..cell..BorrowMutError$u20$as$u20$core..fmt..Debug$GT$3fmt17h85b3e4f3b263bba6E>:
80202bfa: 90 65        	ld	a2, 8(a1)
80202bfc: 88 61        	ld	a0, 0(a1)
80202bfe: 1c 6e        	ld	a5, 24(a2)

0000000080202c00 <.LBB112_1>:
80202c00: 97 45 04 00  	auipc	a1, 68
80202c04: 93 85 95 11  	addi	a1, a1, 281
80202c08: 39 46        	li	a2, 14
80202c0a: 82 87        	jr	a5

Disassembly of section .text._ZN4core5panic10panic_info9PanicInfo7message17hcb7a5a3e466be904E:

0000000080202c0c <_ZN4core5panic10panic_info9PanicInfo7message17hcb7a5a3e466be904E>:
80202c0c: 08 69        	ld	a0, 16(a0)
80202c0e: 82 80        	ret

Disassembly of section .text._ZN4core5panic10panic_info9PanicInfo8location17h43d8a14288f989fbE:

0000000080202c10 <_ZN4core5panic10panic_info9PanicInfo8location17h43d8a14288f989fbE>:
80202c10: 08 6d        	ld	a0, 24(a0)
80202c12: 82 80        	ret

Disassembly of section .text.unlikely._ZN4core9panicking9panic_fmt17h09608ae52bd0d3adE:

0000000080202c14 <_ZN4core9panicking9panic_fmt17h09608ae52bd0d3adE>:
80202c14: 79 71        	addi	sp, sp, -48
80202c16: 06 f4        	sd	ra, 40(sp)

0000000080202c18 <.LBB169_1>:
80202c18: 17 46 04 00  	auipc	a2, 68
80202c1c: 13 06 06 0c  	addi	a2, a2, 192
80202c20: 32 e0        	sd	a2, 0(sp)

0000000080202c22 <.LBB169_2>:
80202c22: 17 46 04 00  	auipc	a2, 68
80202c26: 13 06 e6 13  	addi	a2, a2, 318
80202c2a: 32 e4        	sd	a2, 8(sp)
80202c2c: 2a e8        	sd	a0, 16(sp)
80202c2e: 2e ec        	sd	a1, 24(sp)
80202c30: 05 45        	li	a0, 1
80202c32: 23 00 a1 02  	sb	a0, 32(sp)
80202c36: 0a 85        	mv	a0, sp
80202c38: 97 f0 ff ff  	auipc	ra, 1048575
80202c3c: e7 80 60 19  	jalr	406(ra)
80202c40: 00 00        	unimp	

Disassembly of section .text.unlikely._ZN4core9panicking5panic17h968d2b6b541ffadfE:

0000000080202c42 <_ZN4core9panicking5panic17h968d2b6b541ffadfE>:
80202c42: 5d 71        	addi	sp, sp, -80
80202c44: 86 e4        	sd	ra, 72(sp)
80202c46: 2a fc        	sd	a0, 56(sp)
80202c48: ae e0        	sd	a1, 64(sp)
80202c4a: 28 18        	addi	a0, sp, 56
80202c4c: 2a ec        	sd	a0, 24(sp)
80202c4e: 05 45        	li	a0, 1
80202c50: 2a f0        	sd	a0, 32(sp)
80202c52: 02 e4        	sd	zero, 8(sp)

0000000080202c54 <.LBB171_1>:
80202c54: 17 45 04 00  	auipc	a0, 68
80202c58: 13 05 45 08  	addi	a0, a0, 132
80202c5c: 2a f4        	sd	a0, 40(sp)
80202c5e: 02 f8        	sd	zero, 48(sp)
80202c60: 28 00        	addi	a0, sp, 8
80202c62: b2 85        	mv	a1, a2
80202c64: 97 00 00 00  	auipc	ra, 0
80202c68: e7 80 00 fb  	jalr	-80(ra)
80202c6c: 00 00        	unimp	

Disassembly of section .text.unlikely._ZN4core9panicking18panic_bounds_check17h03ed6527cd415bf9E:

0000000080202c6e <_ZN4core9panicking18panic_bounds_check17h03ed6527cd415bf9E>:
80202c6e: 59 71        	addi	sp, sp, -112
80202c70: 86 f4        	sd	ra, 104(sp)
80202c72: 2a e4        	sd	a0, 8(sp)
80202c74: 2e e8        	sd	a1, 16(sp)
80202c76: 08 08        	addi	a0, sp, 16
80202c78: aa e4        	sd	a0, 72(sp)

0000000080202c7a <.LBB174_1>:
80202c7a: 17 15 00 00  	auipc	a0, 1
80202c7e: 13 05 c5 67  	addi	a0, a0, 1660
80202c82: aa e8        	sd	a0, 80(sp)
80202c84: 2c 00        	addi	a1, sp, 8
80202c86: ae ec        	sd	a1, 88(sp)
80202c88: aa f0        	sd	a0, 96(sp)

0000000080202c8a <.LBB174_2>:
80202c8a: 17 45 04 00  	auipc	a0, 68
80202c8e: 13 05 65 0b  	addi	a0, a0, 182
80202c92: 2a f4        	sd	a0, 40(sp)
80202c94: 09 45        	li	a0, 2
80202c96: 2a f8        	sd	a0, 48(sp)
80202c98: 02 ec        	sd	zero, 24(sp)
80202c9a: ac 00        	addi	a1, sp, 72
80202c9c: 2e fc        	sd	a1, 56(sp)
80202c9e: aa e0        	sd	a0, 64(sp)
80202ca0: 28 08        	addi	a0, sp, 24
80202ca2: b2 85        	mv	a1, a2
80202ca4: 97 00 00 00  	auipc	ra, 0
80202ca8: e7 80 00 f7  	jalr	-144(ra)
80202cac: 00 00        	unimp	

Disassembly of section .text.unlikely._ZN4core6result13unwrap_failed17h93c501911315d321E:

0000000080202cae <_ZN4core6result13unwrap_failed17h93c501911315d321E>:
80202cae: 19 71        	addi	sp, sp, -128
80202cb0: 86 fc        	sd	ra, 120(sp)
80202cb2: 2a e4        	sd	a0, 8(sp)
80202cb4: 2e e8        	sd	a1, 16(sp)
80202cb6: 32 ec        	sd	a2, 24(sp)
80202cb8: 36 f0        	sd	a3, 32(sp)
80202cba: 28 00        	addi	a0, sp, 8
80202cbc: aa ec        	sd	a0, 88(sp)

0000000080202cbe <.LBB181_1>:
80202cbe: 17 15 00 00  	auipc	a0, 1
80202cc2: 13 05 c5 73  	addi	a0, a0, 1852
80202cc6: aa f0        	sd	a0, 96(sp)
80202cc8: 28 08        	addi	a0, sp, 24
80202cca: aa f4        	sd	a0, 104(sp)

0000000080202ccc <.LBB181_2>:
80202ccc: 17 15 00 00  	auipc	a0, 1
80202cd0: 13 05 c5 71  	addi	a0, a0, 1820
80202cd4: aa f8        	sd	a0, 112(sp)

0000000080202cd6 <.LBB181_3>:
80202cd6: 17 45 04 00  	auipc	a0, 68
80202cda: 13 05 25 0d  	addi	a0, a0, 210
80202cde: 2a fc        	sd	a0, 56(sp)
80202ce0: 09 45        	li	a0, 2
80202ce2: aa e0        	sd	a0, 64(sp)
80202ce4: 02 f4        	sd	zero, 40(sp)
80202ce6: ac 08        	addi	a1, sp, 88
80202ce8: ae e4        	sd	a1, 72(sp)
80202cea: aa e8        	sd	a0, 80(sp)
80202cec: 28 10        	addi	a0, sp, 40
80202cee: ba 85        	mv	a1, a4
80202cf0: 97 00 00 00  	auipc	ra, 0
80202cf4: e7 80 40 f2  	jalr	-220(ra)
80202cf8: 00 00        	unimp	

Disassembly of section .text._ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h00c12acf7478cdceE:

0000000080202cfa <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h00c12acf7478cdceE>:
80202cfa: 31 71        	addi	sp, sp, -192
80202cfc: 06 fd        	sd	ra, 184(sp)
80202cfe: 22 f9        	sd	s0, 176(sp)
80202d00: 26 f5        	sd	s1, 168(sp)
80202d02: 4a f1        	sd	s2, 160(sp)
80202d04: 4e ed        	sd	s3, 152(sp)
80202d06: 52 e9        	sd	s4, 144(sp)
80202d08: 56 e5        	sd	s5, 136(sp)
80202d0a: 5a e1        	sd	s6, 128(sp)
80202d0c: de fc        	sd	s7, 120(sp)
80202d0e: e2 f8        	sd	s8, 112(sp)
80202d10: e6 f4        	sd	s9, 104(sp)
80202d12: ea f0        	sd	s10, 96(sp)
80202d14: ee ec        	sd	s11, 88(sp)
80202d16: b2 84        	mv	s1, a2
80202d18: 2e 8a        	mv	s4, a1
80202d1a: 81 49        	li	s3, 0
80202d1c: 01 44        	li	s0, 0
80202d1e: 81 4d        	li	s11, 0
80202d20: 2e e8        	sd	a1, 16(sp)
80202d22: 32 ec        	sd	a2, 24(sp)
80202d24: 02 f0        	sd	zero, 32(sp)
80202d26: 32 f4        	sd	a2, 40(sp)
80202d28: 85 4a        	li	s5, 1
80202d2a: 56 f8        	sd	s5, 48(sp)
80202d2c: 29 4b        	li	s6, 10
80202d2e: 83 3b 05 01  	ld	s7, 16(a0)
80202d32: 03 39 05 00  	ld	s2, 0(a0)
80202d36: 08 65        	ld	a0, 8(a0)
80202d38: 2a e4        	sd	a0, 8(sp)
80202d3a: 5a dc        	sw	s6, 56(sp)

0000000080202d3c <.LBB183_26>:
80202d3c: 17 35 04 00  	auipc	a0, 67
80202d40: 13 05 a5 60  	addi	a0, a0, 1546
80202d44: 2a e0        	sd	a0, 0(sp)
80202d46: c1 4c        	li	s9, 16
80202d48: 05 a0        	j	0x80202d68 <.LBB183_26+0x2c>
80202d4a: 33 05 b6 00  	add	a0, a2, a1
80202d4e: 03 45 f5 ff  	lbu	a0, -1(a0)
80202d52: 59 15        	addi	a0, a0, -10
80202d54: 13 35 15 00  	seqz	a0, a0
80202d58: 23 80 ab 00  	sb	a0, 0(s7)
80202d5c: 22 65        	ld	a0, 8(sp)
80202d5e: 14 6d        	ld	a3, 24(a0)
80202d60: 4a 85        	mv	a0, s2
80202d62: 82 96        	jalr	a3
80202d64: ea 89        	mv	s3, s10
80202d66: 79 e1        	bnez	a0, 0x80202e2c <.LBB183_26+0xf0>
80202d68: 13 f5 fd 0f  	andi	a0, s11, 255
80202d6c: 55 ed        	bnez	a0, 0x80202e28 <.LBB183_26+0xec>
80202d6e: 63 fb 84 02  	bgeu	s1, s0, 0x80202da4 <.LBB183_26+0x68>
80202d72: 85 4d        	li	s11, 1
80202d74: 4e 8d        	mv	s10, s3
80202d76: 26 8c        	mv	s8, s1
80202d78: 63 88 99 0a  	beq	s3, s1, 0x80202e28 <.LBB183_26+0xec>
80202d7c: 03 c5 0b 00  	lbu	a0, 0(s7)
80202d80: 01 c9        	beqz	a0, 0x80202d90 <.LBB183_26+0x54>
80202d82: 22 65        	ld	a0, 8(sp)
80202d84: 14 6d        	ld	a3, 24(a0)
80202d86: 11 46        	li	a2, 4
80202d88: 4a 85        	mv	a0, s2
80202d8a: 82 65        	ld	a1, 0(sp)
80202d8c: 82 96        	jalr	a3
80202d8e: 59 ed        	bnez	a0, 0x80202e2c <.LBB183_26+0xf0>
80202d90: 33 06 3c 41  	sub	a2, s8, s3
80202d94: b3 05 3a 01  	add	a1, s4, s3
80202d98: e3 19 3c fb  	bne	s8, s3, 0x80202d4a <.LBB183_26+0xe>
80202d9c: 01 45        	li	a0, 0
80202d9e: 6d bf        	j	0x80202d58 <.LBB183_26+0x1c>
80202da0: e3 e9 84 fc  	bltu	s1, s0, 0x80202d72 <.LBB183_26+0x36>
80202da4: 33 86 84 40  	sub	a2, s1, s0
80202da8: b3 06 8a 00  	add	a3, s4, s0
80202dac: 63 72 96 03  	bgeu	a2, s9, 0x80202dd0 <.LBB183_26+0x94>
80202db0: 81 45        	li	a1, 0
80202db2: 05 ca        	beqz	a2, 0x80202de2 <.LBB183_26+0xa6>
80202db4: 33 85 b6 00  	add	a0, a3, a1
80202db8: 03 45 05 00  	lbu	a0, 0(a0)
80202dbc: 63 07 65 03  	beq	a0, s6, 0x80202dea <.LBB183_26+0xae>
80202dc0: 85 05        	addi	a1, a1, 1
80202dc2: e3 19 b6 fe  	bne	a2, a1, 0x80202db4 <.LBB183_26+0x78>
80202dc6: 01 45        	li	a0, 0
80202dc8: b2 85        	mv	a1, a2
80202dca: 63 03 55 03  	beq	a0, s5, 0x80202df0 <.LBB183_26+0xb4>
80202dce: b9 a0        	j	0x80202e1c <.LBB183_26+0xe0>
80202dd0: 29 45        	li	a0, 10
80202dd2: b6 85        	mv	a1, a3
80202dd4: 97 10 00 00  	auipc	ra, 1
80202dd8: e7 80 c0 c4  	jalr	-948(ra)
80202ddc: 63 0a 55 01  	beq	a0, s5, 0x80202df0 <.LBB183_26+0xb4>
80202de0: 35 a8        	j	0x80202e1c <.LBB183_26+0xe0>
80202de2: 01 45        	li	a0, 0
80202de4: 63 06 55 01  	beq	a0, s5, 0x80202df0 <.LBB183_26+0xb4>
80202de8: 15 a8        	j	0x80202e1c <.LBB183_26+0xe0>
80202dea: 05 45        	li	a0, 1
80202dec: 63 18 55 03  	bne	a0, s5, 0x80202e1c <.LBB183_26+0xe0>
80202df0: 33 05 b4 00  	add	a0, s0, a1
80202df4: 13 04 15 00  	addi	s0, a0, 1
80202df8: 93 35 14 00  	seqz	a1, s0
80202dfc: 33 b6 84 00  	sltu	a2, s1, s0
80202e00: d1 8d        	or	a1, a1, a2
80202e02: d9 fd        	bnez	a1, 0x80202da0 <.LBB183_26+0x64>
80202e04: 52 95        	add	a0, a0, s4
80202e06: 03 45 05 00  	lbu	a0, 0(a0)
80202e0a: e3 1b 65 f9  	bne	a0, s6, 0x80202da0 <.LBB183_26+0x64>
80202e0e: 81 4d        	li	s11, 0
80202e10: 22 8d        	mv	s10, s0
80202e12: 22 8c        	mv	s8, s0
80202e14: 03 c5 0b 00  	lbu	a0, 0(s7)
80202e18: 2d f5        	bnez	a0, 0x80202d82 <.LBB183_26+0x46>
80202e1a: 9d bf        	j	0x80202d90 <.LBB183_26+0x54>
80202e1c: 26 84        	mv	s0, s1
80202e1e: 85 4d        	li	s11, 1
80202e20: 4e 8d        	mv	s10, s3
80202e22: 26 8c        	mv	s8, s1
80202e24: e3 9c 99 f4  	bne	s3, s1, 0x80202d7c <.LBB183_26+0x40>
80202e28: 01 45        	li	a0, 0
80202e2a: 11 a0        	j	0x80202e2e <.LBB183_26+0xf2>
80202e2c: 05 45        	li	a0, 1
80202e2e: ea 70        	ld	ra, 184(sp)
80202e30: 4a 74        	ld	s0, 176(sp)
80202e32: aa 74        	ld	s1, 168(sp)
80202e34: 0a 79        	ld	s2, 160(sp)
80202e36: ea 69        	ld	s3, 152(sp)
80202e38: 4a 6a        	ld	s4, 144(sp)
80202e3a: aa 6a        	ld	s5, 136(sp)
80202e3c: 0a 6b        	ld	s6, 128(sp)
80202e3e: e6 7b        	ld	s7, 120(sp)
80202e40: 46 7c        	ld	s8, 112(sp)
80202e42: a6 7c        	ld	s9, 104(sp)
80202e44: 06 7d        	ld	s10, 96(sp)
80202e46: e6 6d        	ld	s11, 88(sp)
80202e48: 29 61        	addi	sp, sp, 192
80202e4a: 82 80        	ret

Disassembly of section .text._ZN4core3fmt8builders11DebugStruct5field17ha0e83fa7747a7c74E:

0000000080202e4c <_ZN4core3fmt8builders11DebugStruct5field17ha0e83fa7747a7c74E>:
80202e4c: 71 71        	addi	sp, sp, -176
80202e4e: 06 f5        	sd	ra, 168(sp)
80202e50: 22 f1        	sd	s0, 160(sp)
80202e52: 26 ed        	sd	s1, 152(sp)
80202e54: 4a e9        	sd	s2, 144(sp)
80202e56: 4e e5        	sd	s3, 136(sp)
80202e58: 52 e1        	sd	s4, 128(sp)
80202e5a: d6 fc        	sd	s5, 120(sp)
80202e5c: da f8        	sd	s6, 112(sp)
80202e5e: de f4        	sd	s7, 104(sp)
80202e60: 2a 84        	mv	s0, a0
80202e62: 03 45 85 00  	lbu	a0, 8(a0)
80202e66: 85 4b        	li	s7, 1
80202e68: 85 44        	li	s1, 1
80202e6a: 0d c1        	beqz	a0, 0x80202e8c <_ZN4core3fmt8builders11DebugStruct5field17ha0e83fa7747a7c74E+0x40>
80202e6c: 23 04 94 00  	sb	s1, 8(s0)
80202e70: a3 04 74 01  	sb	s7, 9(s0)
80202e74: 22 85        	mv	a0, s0
80202e76: aa 70        	ld	ra, 168(sp)
80202e78: 0a 74        	ld	s0, 160(sp)
80202e7a: ea 64        	ld	s1, 152(sp)
80202e7c: 4a 69        	ld	s2, 144(sp)
80202e7e: aa 69        	ld	s3, 136(sp)
80202e80: 0a 6a        	ld	s4, 128(sp)
80202e82: e6 7a        	ld	s5, 120(sp)
80202e84: 46 7b        	ld	s6, 112(sp)
80202e86: a6 7b        	ld	s7, 104(sp)
80202e88: 4d 61        	addi	sp, sp, 176
80202e8a: 82 80        	ret
80202e8c: ba 89        	mv	s3, a4
80202e8e: 36 89        	mv	s2, a3
80202e90: 32 8a        	mv	s4, a2
80202e92: ae 8a        	mv	s5, a1
80202e94: 03 3b 04 00  	ld	s6, 0(s0)
80202e98: 03 65 0b 03  	lwu	a0, 48(s6)
80202e9c: 83 45 94 00  	lbu	a1, 9(s0)
80202ea0: 13 76 45 00  	andi	a2, a0, 4
80202ea4: 09 ea        	bnez	a2, 0x80202eb6 <.LBB184_18+0xa>
80202ea6: 13 b6 15 00  	seqz	a2, a1
80202eaa: e1 c1        	beqz	a1, 0x80202f6a <.LBB184_23>

0000000080202eac <.LBB184_18>:
80202eac: 97 45 04 00  	auipc	a1, 68
80202eb0: 93 85 15 f5  	addi	a1, a1, -175
80202eb4: 7d a8        	j	0x80202f72 <.LBB184_23+0x8>
80202eb6: 85 e1        	bnez	a1, 0x80202ed6 <.LBB184_19+0x14>
80202eb8: 83 35 8b 00  	ld	a1, 8(s6)
80202ebc: 03 35 0b 00  	ld	a0, 0(s6)
80202ec0: 94 6d        	ld	a3, 24(a1)

0000000080202ec2 <.LBB184_19>:
80202ec2: 97 45 04 00  	auipc	a1, 68
80202ec6: 93 85 65 f3  	addi	a1, a1, -202
80202eca: 0d 46        	li	a2, 3
80202ecc: 82 96        	jalr	a3
80202ece: 85 44        	li	s1, 1
80202ed0: 51 fd        	bnez	a0, 0x80202e6c <_ZN4core3fmt8builders11DebugStruct5field17ha0e83fa7747a7c74E+0x20>
80202ed2: 03 25 0b 03  	lw	a0, 48(s6)
80202ed6: 85 44        	li	s1, 1
80202ed8: a3 03 91 02  	sb	s1, 39(sp)
80202edc: 83 35 0b 00  	ld	a1, 0(s6)
80202ee0: 03 36 8b 00  	ld	a2, 8(s6)
80202ee4: 2e e4        	sd	a1, 8(sp)
80202ee6: 32 e8        	sd	a2, 16(sp)
80202ee8: 93 05 71 02  	addi	a1, sp, 39
80202eec: 2e ec        	sd	a1, 24(sp)
80202eee: 83 25 4b 03  	lw	a1, 52(s6)
80202ef2: 03 06 8b 03  	lb	a2, 56(s6)
80202ef6: 83 36 0b 01  	ld	a3, 16(s6)
80202efa: 03 37 8b 01  	ld	a4, 24(s6)
80202efe: 83 37 0b 02  	ld	a5, 32(s6)
80202f02: 03 38 8b 02  	ld	a6, 40(s6)
80202f06: aa cc        	sw	a0, 88(sp)
80202f08: ae ce        	sw	a1, 92(sp)
80202f0a: 23 00 c1 06  	sb	a2, 96(sp)
80202f0e: 36 fc        	sd	a3, 56(sp)
80202f10: ba e0        	sd	a4, 64(sp)
80202f12: be e4        	sd	a5, 72(sp)
80202f14: c2 e8        	sd	a6, 80(sp)
80202f16: 28 00        	addi	a0, sp, 8
80202f18: 2a f4        	sd	a0, 40(sp)

0000000080202f1a <.LBB184_20>:
80202f1a: 17 45 04 00  	auipc	a0, 68
80202f1e: 13 05 e5 ea  	addi	a0, a0, -338
80202f22: 2a f8        	sd	a0, 48(sp)
80202f24: 28 00        	addi	a0, sp, 8
80202f26: d6 85        	mv	a1, s5
80202f28: 52 86        	mv	a2, s4
80202f2a: 97 00 00 00  	auipc	ra, 0
80202f2e: e7 80 00 dd  	jalr	-560(ra)
80202f32: 0d fd        	bnez	a0, 0x80202e6c <_ZN4core3fmt8builders11DebugStruct5field17ha0e83fa7747a7c74E+0x20>

0000000080202f34 <.LBB184_21>:
80202f34: 97 45 04 00  	auipc	a1, 68
80202f38: 93 85 c5 e6  	addi	a1, a1, -404
80202f3c: 28 00        	addi	a0, sp, 8
80202f3e: 09 46        	li	a2, 2
80202f40: 97 00 00 00  	auipc	ra, 0
80202f44: e7 80 a0 db  	jalr	-582(ra)
80202f48: 15 f1        	bnez	a0, 0x80202e6c <_ZN4core3fmt8builders11DebugStruct5field17ha0e83fa7747a7c74E+0x20>
80202f4a: 03 b6 89 01  	ld	a2, 24(s3)
80202f4e: 2c 10        	addi	a1, sp, 40
80202f50: 4a 85        	mv	a0, s2
80202f52: 02 96        	jalr	a2
80202f54: 01 fd        	bnez	a0, 0x80202e6c <_ZN4core3fmt8builders11DebugStruct5field17ha0e83fa7747a7c74E+0x20>
80202f56: c2 75        	ld	a1, 48(sp)
80202f58: 22 75        	ld	a0, 40(sp)
80202f5a: 94 6d        	ld	a3, 24(a1)

0000000080202f5c <.LBB184_22>:
80202f5c: 97 45 04 00  	auipc	a1, 68
80202f60: 93 85 f5 e9  	addi	a1, a1, -353
80202f64: 09 46        	li	a2, 2
80202f66: 82 96        	jalr	a3
80202f68: b1 a8        	j	0x80202fc4 <.LBB184_24+0x1c>

0000000080202f6a <.LBB184_23>:
80202f6a: 97 45 04 00  	auipc	a1, 68
80202f6e: 93 85 55 e9  	addi	a1, a1, -363
80202f72: 83 36 8b 00  	ld	a3, 8(s6)
80202f76: 03 35 0b 00  	ld	a0, 0(s6)
80202f7a: 94 6e        	ld	a3, 24(a3)
80202f7c: 13 66 26 00  	ori	a2, a2, 2
80202f80: 82 96        	jalr	a3
80202f82: 85 44        	li	s1, 1
80202f84: e3 14 05 ee  	bnez	a0, 0x80202e6c <_ZN4core3fmt8builders11DebugStruct5field17ha0e83fa7747a7c74E+0x20>
80202f88: 83 35 8b 00  	ld	a1, 8(s6)
80202f8c: 03 35 0b 00  	ld	a0, 0(s6)
80202f90: 94 6d        	ld	a3, 24(a1)
80202f92: d6 85        	mv	a1, s5
80202f94: 52 86        	mv	a2, s4
80202f96: 82 96        	jalr	a3
80202f98: 85 44        	li	s1, 1
80202f9a: e3 19 05 ec  	bnez	a0, 0x80202e6c <_ZN4core3fmt8builders11DebugStruct5field17ha0e83fa7747a7c74E+0x20>
80202f9e: 83 35 8b 00  	ld	a1, 8(s6)
80202fa2: 03 35 0b 00  	ld	a0, 0(s6)
80202fa6: 94 6d        	ld	a3, 24(a1)

0000000080202fa8 <.LBB184_24>:
80202fa8: 97 45 04 00  	auipc	a1, 68
80202fac: 93 85 85 df  	addi	a1, a1, -520
80202fb0: 09 46        	li	a2, 2
80202fb2: 82 96        	jalr	a3
80202fb4: 85 44        	li	s1, 1
80202fb6: e3 1b 05 ea  	bnez	a0, 0x80202e6c <_ZN4core3fmt8builders11DebugStruct5field17ha0e83fa7747a7c74E+0x20>
80202fba: 03 b6 89 01  	ld	a2, 24(s3)
80202fbe: 4a 85        	mv	a0, s2
80202fc0: da 85        	mv	a1, s6
80202fc2: 02 96        	jalr	a2
80202fc4: aa 84        	mv	s1, a0
80202fc6: 5d b5        	j	0x80202e6c <_ZN4core3fmt8builders11DebugStruct5field17ha0e83fa7747a7c74E+0x20>

Disassembly of section .text._ZN4core3fmt8builders10DebugTuple5field17h677b7d6bf29f0a1bE:

0000000080202fc8 <_ZN4core3fmt8builders10DebugTuple5field17h677b7d6bf29f0a1bE>:
80202fc8: 35 71        	addi	sp, sp, -160
80202fca: 06 ed        	sd	ra, 152(sp)
80202fcc: 22 e9        	sd	s0, 144(sp)
80202fce: 26 e5        	sd	s1, 136(sp)
80202fd0: 4a e1        	sd	s2, 128(sp)
80202fd2: ce fc        	sd	s3, 120(sp)
80202fd4: d2 f8        	sd	s4, 112(sp)
80202fd6: d6 f4        	sd	s5, 104(sp)
80202fd8: 2a 84        	mv	s0, a0
80202fda: 03 45 05 01  	lbu	a0, 16(a0)
80202fde: 09 c5        	beqz	a0, 0x80202fe8 <_ZN4core3fmt8builders10DebugTuple5field17h677b7d6bf29f0a1bE+0x20>
80202fe0: 83 3a 04 00  	ld	s5, 0(s0)
80202fe4: 85 44        	li	s1, 1
80202fe6: e5 a0        	j	0x802030ce <.LBB187_20+0xe>
80202fe8: b2 89        	mv	s3, a2
80202fea: 2e 89        	mv	s2, a1
80202fec: 03 3a 84 00  	ld	s4, 8(s0)
80202ff0: 03 65 0a 03  	lwu	a0, 48(s4)
80202ff4: 83 3a 04 00  	ld	s5, 0(s0)
80202ff8: 93 75 45 00  	andi	a1, a0, 4
80202ffc: 91 e9        	bnez	a1, 0x80203010 <.LBB187_16+0xa>
80202ffe: 13 b6 1a 00  	seqz	a2, s5
80203002: 63 88 0a 02  	beqz	s5, 0x80203032 <.LBB187_18>

0000000080203006 <.LBB187_16>:
80203006: 97 45 04 00  	auipc	a1, 68
8020300a: 93 85 75 df  	addi	a1, a1, -521
8020300e: 35 a0        	j	0x8020303a <.LBB187_18+0x8>
80203010: 63 98 0a 04  	bnez	s5, 0x80203060 <.LBB187_18+0x2e>
80203014: 83 35 8a 00  	ld	a1, 8(s4)
80203018: 03 35 0a 00  	ld	a0, 0(s4)
8020301c: 94 6d        	ld	a3, 24(a1)

000000008020301e <.LBB187_17>:
8020301e: 97 45 04 00  	auipc	a1, 68
80203022: 93 85 75 de  	addi	a1, a1, -537
80203026: 09 46        	li	a2, 2
80203028: 82 96        	jalr	a3
8020302a: 0d c9        	beqz	a0, 0x8020305c <.LBB187_18+0x2a>
8020302c: 81 4a        	li	s5, 0
8020302e: 85 44        	li	s1, 1
80203030: 79 a8        	j	0x802030ce <.LBB187_20+0xe>

0000000080203032 <.LBB187_18>:
80203032: 97 45 04 00  	auipc	a1, 68
80203036: 93 85 55 dd  	addi	a1, a1, -555
8020303a: 83 36 8a 00  	ld	a3, 8(s4)
8020303e: 03 35 0a 00  	ld	a0, 0(s4)
80203042: 94 6e        	ld	a3, 24(a3)
80203044: 09 47        	li	a4, 2
80203046: 33 06 c7 40  	sub	a2, a4, a2
8020304a: 82 96        	jalr	a3
8020304c: 85 44        	li	s1, 1
8020304e: 41 e1        	bnez	a0, 0x802030ce <.LBB187_20+0xe>
80203050: 03 b6 89 01  	ld	a2, 24(s3)
80203054: 4a 85        	mv	a0, s2
80203056: d2 85        	mv	a1, s4
80203058: 02 96        	jalr	a2
8020305a: 8d a8        	j	0x802030cc <.LBB187_20+0xc>
8020305c: 03 25 0a 03  	lw	a0, 48(s4)
80203060: 85 44        	li	s1, 1
80203062: a3 03 91 02  	sb	s1, 39(sp)
80203066: 83 35 0a 00  	ld	a1, 0(s4)
8020306a: 03 36 8a 00  	ld	a2, 8(s4)
8020306e: 2e e4        	sd	a1, 8(sp)
80203070: 32 e8        	sd	a2, 16(sp)
80203072: 93 05 71 02  	addi	a1, sp, 39
80203076: 2e ec        	sd	a1, 24(sp)
80203078: 83 25 4a 03  	lw	a1, 52(s4)
8020307c: 03 06 8a 03  	lb	a2, 56(s4)
80203080: 83 36 0a 01  	ld	a3, 16(s4)
80203084: 03 37 8a 01  	ld	a4, 24(s4)
80203088: 83 37 0a 02  	ld	a5, 32(s4)
8020308c: 03 38 8a 02  	ld	a6, 40(s4)
80203090: aa cc        	sw	a0, 88(sp)
80203092: ae ce        	sw	a1, 92(sp)
80203094: 23 00 c1 06  	sb	a2, 96(sp)
80203098: 36 fc        	sd	a3, 56(sp)
8020309a: ba e0        	sd	a4, 64(sp)
8020309c: be e4        	sd	a5, 72(sp)
8020309e: c2 e8        	sd	a6, 80(sp)
802030a0: 28 00        	addi	a0, sp, 8
802030a2: 03 b6 89 01  	ld	a2, 24(s3)
802030a6: 2a f4        	sd	a0, 40(sp)

00000000802030a8 <.LBB187_19>:
802030a8: 17 45 04 00  	auipc	a0, 68
802030ac: 13 05 05 d2  	addi	a0, a0, -736
802030b0: 2a f8        	sd	a0, 48(sp)
802030b2: 2c 10        	addi	a1, sp, 40
802030b4: 4a 85        	mv	a0, s2
802030b6: 02 96        	jalr	a2
802030b8: 19 e9        	bnez	a0, 0x802030ce <.LBB187_20+0xe>
802030ba: c2 75        	ld	a1, 48(sp)
802030bc: 22 75        	ld	a0, 40(sp)
802030be: 94 6d        	ld	a3, 24(a1)

00000000802030c0 <.LBB187_20>:
802030c0: 97 45 04 00  	auipc	a1, 68
802030c4: 93 85 b5 d3  	addi	a1, a1, -709
802030c8: 09 46        	li	a2, 2
802030ca: 82 96        	jalr	a3
802030cc: aa 84        	mv	s1, a0
802030ce: 23 08 94 00  	sb	s1, 16(s0)
802030d2: 13 85 1a 00  	addi	a0, s5, 1
802030d6: 08 e0        	sd	a0, 0(s0)
802030d8: 22 85        	mv	a0, s0
802030da: ea 60        	ld	ra, 152(sp)
802030dc: 4a 64        	ld	s0, 144(sp)
802030de: aa 64        	ld	s1, 136(sp)
802030e0: 0a 69        	ld	s2, 128(sp)
802030e2: e6 79        	ld	s3, 120(sp)
802030e4: 46 7a        	ld	s4, 112(sp)
802030e6: a6 7a        	ld	s5, 104(sp)
802030e8: 0d 61        	addi	sp, sp, 160
802030ea: 82 80        	ret

Disassembly of section .text._ZN4core3fmt5Write10write_char17h0935c44e9832f7afE:

00000000802030ec <_ZN4core3fmt5Write10write_char17h0935c44e9832f7afE>:
802030ec: 41 11        	addi	sp, sp, -16
802030ee: 06 e4        	sd	ra, 8(sp)
802030f0: 1b 86 05 00  	sext.w	a2, a1
802030f4: 93 06 00 08  	li	a3, 128
802030f8: 02 c2        	sw	zero, 4(sp)
802030fa: 63 76 d6 00  	bgeu	a2, a3, 0x80203106 <_ZN4core3fmt5Write10write_char17h0935c44e9832f7afE+0x1a>
802030fe: 23 02 b1 00  	sb	a1, 4(sp)
80203102: 05 46        	li	a2, 1
80203104: 51 a8        	j	0x80203198 <_ZN4core3fmt5Write10write_char17h0935c44e9832f7afE+0xac>
80203106: 1b d6 b5 00  	srliw	a2, a1, 11
8020310a: 19 ee        	bnez	a2, 0x80203128 <_ZN4core3fmt5Write10write_char17h0935c44e9832f7afE+0x3c>
8020310c: 13 d6 65 00  	srli	a2, a1, 6
80203110: 13 66 06 0c  	ori	a2, a2, 192
80203114: 23 02 c1 00  	sb	a2, 4(sp)
80203118: 93 f5 f5 03  	andi	a1, a1, 63
8020311c: 93 e5 05 08  	ori	a1, a1, 128
80203120: a3 02 b1 00  	sb	a1, 5(sp)
80203124: 09 46        	li	a2, 2
80203126: 8d a8        	j	0x80203198 <_ZN4core3fmt5Write10write_char17h0935c44e9832f7afE+0xac>
80203128: 1b d6 05 01  	srliw	a2, a1, 16
8020312c: 05 ea        	bnez	a2, 0x8020315c <_ZN4core3fmt5Write10write_char17h0935c44e9832f7afE+0x70>
8020312e: 13 96 05 02  	slli	a2, a1, 32
80203132: 01 92        	srli	a2, a2, 32
80203134: 9b d6 c5 00  	srliw	a3, a1, 12
80203138: 93 e6 06 0e  	ori	a3, a3, 224
8020313c: 23 02 d1 00  	sb	a3, 4(sp)
80203140: 52 16        	slli	a2, a2, 52
80203142: 69 92        	srli	a2, a2, 58
80203144: 13 66 06 08  	ori	a2, a2, 128
80203148: a3 02 c1 00  	sb	a2, 5(sp)
8020314c: 93 f5 f5 03  	andi	a1, a1, 63
80203150: 93 e5 05 08  	ori	a1, a1, 128
80203154: 23 03 b1 00  	sb	a1, 6(sp)
80203158: 0d 46        	li	a2, 3
8020315a: 3d a8        	j	0x80203198 <_ZN4core3fmt5Write10write_char17h0935c44e9832f7afE+0xac>
8020315c: 13 96 05 02  	slli	a2, a1, 32
80203160: 01 92        	srli	a2, a2, 32
80203162: 93 16 b6 02  	slli	a3, a2, 43
80203166: f5 92        	srli	a3, a3, 61
80203168: 93 e6 06 0f  	ori	a3, a3, 240
8020316c: 23 02 d1 00  	sb	a3, 4(sp)
80203170: 93 16 e6 02  	slli	a3, a2, 46
80203174: e9 92        	srli	a3, a3, 58
80203176: 93 e6 06 08  	ori	a3, a3, 128
8020317a: a3 02 d1 00  	sb	a3, 5(sp)
8020317e: 52 16        	slli	a2, a2, 52
80203180: 69 92        	srli	a2, a2, 58
80203182: 13 66 06 08  	ori	a2, a2, 128
80203186: 23 03 c1 00  	sb	a2, 6(sp)
8020318a: 93 f5 f5 03  	andi	a1, a1, 63
8020318e: 93 e5 05 08  	ori	a1, a1, 128
80203192: a3 03 b1 00  	sb	a1, 7(sp)
80203196: 11 46        	li	a2, 4
80203198: 4c 00        	addi	a1, sp, 4
8020319a: 97 00 00 00  	auipc	ra, 0
8020319e: e7 80 00 b6  	jalr	-1184(ra)
802031a2: a2 60        	ld	ra, 8(sp)
802031a4: 41 01        	addi	sp, sp, 16
802031a6: 82 80        	ret

Disassembly of section .text._ZN4core3fmt5Write9write_fmt17h034a4ff4b8bb18e2E:

00000000802031a8 <_ZN4core3fmt5Write9write_fmt17h034a4ff4b8bb18e2E>:
802031a8: 39 71        	addi	sp, sp, -64
802031aa: 06 fc        	sd	ra, 56(sp)
802031ac: 90 75        	ld	a2, 40(a1)
802031ae: 94 71        	ld	a3, 32(a1)
802031b0: 2a e0        	sd	a0, 0(sp)
802031b2: 32 f8        	sd	a2, 48(sp)
802031b4: 36 f4        	sd	a3, 40(sp)
802031b6: 88 6d        	ld	a0, 24(a1)
802031b8: 90 69        	ld	a2, 16(a1)
802031ba: 94 65        	ld	a3, 8(a1)
802031bc: 8c 61        	ld	a1, 0(a1)
802031be: 2a f0        	sd	a0, 32(sp)
802031c0: 32 ec        	sd	a2, 24(sp)
802031c2: 36 e8        	sd	a3, 16(sp)
802031c4: 2e e4        	sd	a1, 8(sp)

00000000802031c6 <.LBB210_1>:
802031c6: 97 45 04 00  	auipc	a1, 68
802031ca: 93 85 25 d7  	addi	a1, a1, -654
802031ce: 0a 85        	mv	a0, sp
802031d0: 30 00        	addi	a2, sp, 8
802031d2: 97 00 00 00  	auipc	ra, 0
802031d6: e7 80 20 14  	jalr	322(ra)
802031da: e2 70        	ld	ra, 56(sp)
802031dc: 21 61        	addi	sp, sp, 64
802031de: 82 80        	ret

Disassembly of section .text._ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17h6fc98956e2bba6c6E:

00000000802031e0 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17h6fc98956e2bba6c6E>:
802031e0: 08 61        	ld	a0, 0(a0)
802031e2: 17 03 00 00  	auipc	t1, 0
802031e6: 67 00 83 b1  	jr	-1256(t1)

Disassembly of section .text._ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hd06c6dea4ceba69fE:

00000000802031ea <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hd06c6dea4ceba69fE>:
802031ea: 41 11        	addi	sp, sp, -16
802031ec: 06 e4        	sd	ra, 8(sp)
802031ee: 08 61        	ld	a0, 0(a0)
802031f0: 1b 86 05 00  	sext.w	a2, a1
802031f4: 93 06 00 08  	li	a3, 128
802031f8: 02 c2        	sw	zero, 4(sp)
802031fa: 63 76 d6 00  	bgeu	a2, a3, 0x80203206 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hd06c6dea4ceba69fE+0x1c>
802031fe: 23 02 b1 00  	sb	a1, 4(sp)
80203202: 05 46        	li	a2, 1
80203204: 51 a8        	j	0x80203298 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hd06c6dea4ceba69fE+0xae>
80203206: 1b d6 b5 00  	srliw	a2, a1, 11
8020320a: 19 ee        	bnez	a2, 0x80203228 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hd06c6dea4ceba69fE+0x3e>
8020320c: 13 d6 65 00  	srli	a2, a1, 6
80203210: 13 66 06 0c  	ori	a2, a2, 192
80203214: 23 02 c1 00  	sb	a2, 4(sp)
80203218: 93 f5 f5 03  	andi	a1, a1, 63
8020321c: 93 e5 05 08  	ori	a1, a1, 128
80203220: a3 02 b1 00  	sb	a1, 5(sp)
80203224: 09 46        	li	a2, 2
80203226: 8d a8        	j	0x80203298 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hd06c6dea4ceba69fE+0xae>
80203228: 1b d6 05 01  	srliw	a2, a1, 16
8020322c: 05 ea        	bnez	a2, 0x8020325c <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hd06c6dea4ceba69fE+0x72>
8020322e: 13 96 05 02  	slli	a2, a1, 32
80203232: 01 92        	srli	a2, a2, 32
80203234: 9b d6 c5 00  	srliw	a3, a1, 12
80203238: 93 e6 06 0e  	ori	a3, a3, 224
8020323c: 23 02 d1 00  	sb	a3, 4(sp)
80203240: 52 16        	slli	a2, a2, 52
80203242: 69 92        	srli	a2, a2, 58
80203244: 13 66 06 08  	ori	a2, a2, 128
80203248: a3 02 c1 00  	sb	a2, 5(sp)
8020324c: 93 f5 f5 03  	andi	a1, a1, 63
80203250: 93 e5 05 08  	ori	a1, a1, 128
80203254: 23 03 b1 00  	sb	a1, 6(sp)
80203258: 0d 46        	li	a2, 3
8020325a: 3d a8        	j	0x80203298 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hd06c6dea4ceba69fE+0xae>
8020325c: 13 96 05 02  	slli	a2, a1, 32
80203260: 01 92        	srli	a2, a2, 32
80203262: 93 16 b6 02  	slli	a3, a2, 43
80203266: f5 92        	srli	a3, a3, 61
80203268: 93 e6 06 0f  	ori	a3, a3, 240
8020326c: 23 02 d1 00  	sb	a3, 4(sp)
80203270: 93 16 e6 02  	slli	a3, a2, 46
80203274: e9 92        	srli	a3, a3, 58
80203276: 93 e6 06 08  	ori	a3, a3, 128
8020327a: a3 02 d1 00  	sb	a3, 5(sp)
8020327e: 52 16        	slli	a2, a2, 52
80203280: 69 92        	srli	a2, a2, 58
80203282: 13 66 06 08  	ori	a2, a2, 128
80203286: 23 03 c1 00  	sb	a2, 6(sp)
8020328a: 93 f5 f5 03  	andi	a1, a1, 63
8020328e: 93 e5 05 08  	ori	a1, a1, 128
80203292: a3 03 b1 00  	sb	a1, 7(sp)
80203296: 11 46        	li	a2, 4
80203298: 4c 00        	addi	a1, sp, 4
8020329a: 97 00 00 00  	auipc	ra, 0
8020329e: e7 80 00 a6  	jalr	-1440(ra)
802032a2: a2 60        	ld	ra, 8(sp)
802032a4: 41 01        	addi	sp, sp, 16
802032a6: 82 80        	ret

Disassembly of section .text._ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_fmt17h06062d83efbc924aE:

00000000802032a8 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_fmt17h06062d83efbc924aE>:
802032a8: 39 71        	addi	sp, sp, -64
802032aa: 06 fc        	sd	ra, 56(sp)
802032ac: 08 61        	ld	a0, 0(a0)
802032ae: 90 75        	ld	a2, 40(a1)
802032b0: 94 71        	ld	a3, 32(a1)
802032b2: 2a e0        	sd	a0, 0(sp)
802032b4: 32 f8        	sd	a2, 48(sp)
802032b6: 36 f4        	sd	a3, 40(sp)
802032b8: 88 6d        	ld	a0, 24(a1)
802032ba: 90 69        	ld	a2, 16(a1)
802032bc: 94 65        	ld	a3, 8(a1)
802032be: 8c 61        	ld	a1, 0(a1)
802032c0: 2a f0        	sd	a0, 32(sp)
802032c2: 32 ec        	sd	a2, 24(sp)
802032c4: 36 e8        	sd	a3, 16(sp)
802032c6: 2e e4        	sd	a1, 8(sp)

00000000802032c8 <.LBB213_1>:
802032c8: 97 45 04 00  	auipc	a1, 68
802032cc: 93 85 05 c7  	addi	a1, a1, -912
802032d0: 0a 85        	mv	a0, sp
802032d2: 30 00        	addi	a2, sp, 8
802032d4: 97 00 00 00  	auipc	ra, 0
802032d8: e7 80 00 04  	jalr	64(ra)
802032dc: e2 70        	ld	ra, 56(sp)
802032de: 21 61        	addi	sp, sp, 64
802032e0: 82 80        	ret

Disassembly of section .text._ZN59_$LT$core..fmt..Arguments$u20$as$u20$core..fmt..Display$GT$3fmt17h14b26a2a8d914ef0E:

00000000802032e2 <_ZN59_$LT$core..fmt..Arguments$u20$as$u20$core..fmt..Display$GT$3fmt17h14b26a2a8d914ef0E>:
802032e2: 39 71        	addi	sp, sp, -64
802032e4: 06 fc        	sd	ra, 56(sp)
802032e6: 10 75        	ld	a2, 40(a0)
802032e8: 18 71        	ld	a4, 32(a0)
802032ea: 1c 6d        	ld	a5, 24(a0)
802032ec: 32 f8        	sd	a2, 48(sp)
802032ee: 94 61        	ld	a3, 0(a1)
802032f0: 3a f4        	sd	a4, 40(sp)
802032f2: 3e f0        	sd	a5, 32(sp)
802032f4: 10 69        	ld	a2, 16(a0)
802032f6: 18 65        	ld	a4, 8(a0)
802032f8: 08 61        	ld	a0, 0(a0)
802032fa: 8c 65        	ld	a1, 8(a1)
802032fc: 32 ec        	sd	a2, 24(sp)
802032fe: 3a e8        	sd	a4, 16(sp)
80203300: 2a e4        	sd	a0, 8(sp)
80203302: 30 00        	addi	a2, sp, 8
80203304: 36 85        	mv	a0, a3
80203306: 97 00 00 00  	auipc	ra, 0
8020330a: e7 80 e0 00  	jalr	14(ra)
8020330e: e2 70        	ld	ra, 56(sp)
80203310: 21 61        	addi	sp, sp, 64
80203312: 82 80        	ret

Disassembly of section .text._ZN4core3fmt5write17h42fcd7b837de3f75E:

0000000080203314 <_ZN4core3fmt5write17h42fcd7b837de3f75E>:
80203314: 19 71        	addi	sp, sp, -128
80203316: 86 fc        	sd	ra, 120(sp)
80203318: a2 f8        	sd	s0, 112(sp)
8020331a: a6 f4        	sd	s1, 104(sp)
8020331c: ca f0        	sd	s2, 96(sp)
8020331e: ce ec        	sd	s3, 88(sp)
80203320: d2 e8        	sd	s4, 80(sp)
80203322: d6 e4        	sd	s5, 72(sp)
80203324: da e0        	sd	s6, 64(sp)
80203326: b2 89        	mv	s3, a2
80203328: 05 46        	li	a2, 1
8020332a: 16 16        	slli	a2, a2, 37
8020332c: 32 f8        	sd	a2, 48(sp)
8020332e: 0d 46        	li	a2, 3
80203330: 23 0c c1 02  	sb	a2, 56(sp)
80203334: 03 b6 09 00  	ld	a2, 0(s3)
80203338: 02 e8        	sd	zero, 16(sp)
8020333a: 02 f0        	sd	zero, 32(sp)
8020333c: 2a e0        	sd	a0, 0(sp)
8020333e: 2e e4        	sd	a1, 8(sp)
80203340: 69 c6        	beqz	a2, 0x8020340a <.LBB218_31+0x9e>
80203342: 03 b5 89 00  	ld	a0, 8(s3)
80203346: 63 0e 05 10  	beqz	a0, 0x80203462 <.LBB218_31+0xf6>
8020334a: 83 b5 09 01  	ld	a1, 16(s3)
8020334e: 93 06 f5 ff  	addi	a3, a0, -1
80203352: 8e 06        	slli	a3, a3, 3
80203354: 8d 82        	srli	a3, a3, 3
80203356: 13 89 16 00  	addi	s2, a3, 1
8020335a: 93 84 85 00  	addi	s1, a1, 8
8020335e: 93 05 80 03  	li	a1, 56
80203362: 33 0a b5 02  	mul	s4, a0, a1
80203366: 13 04 86 01  	addi	s0, a2, 24
8020336a: 85 4a        	li	s5, 1

000000008020336c <.LBB218_31>:
8020336c: 17 0b 00 00  	auipc	s6, 0
80203370: 13 0b cb 87  	addi	s6, s6, -1924
80203374: 90 60        	ld	a2, 0(s1)
80203376: 09 ca        	beqz	a2, 0x80203388 <.LBB218_31+0x1c>
80203378: a2 66        	ld	a3, 8(sp)
8020337a: 02 65        	ld	a0, 0(sp)
8020337c: 83 b5 84 ff  	ld	a1, -8(s1)
80203380: 94 6e        	ld	a3, 24(a3)
80203382: 82 96        	jalr	a3
80203384: 63 11 05 10  	bnez	a0, 0x80203486 <.LBB218_31+0x11a>
80203388: 48 44        	lw	a0, 12(s0)
8020338a: 2a da        	sw	a0, 52(sp)
8020338c: 03 05 04 01  	lb	a0, 16(s0)
80203390: 23 0c a1 02  	sb	a0, 56(sp)
80203394: 0c 44        	lw	a1, 8(s0)
80203396: 03 b5 09 02  	ld	a0, 32(s3)
8020339a: 2e d8        	sw	a1, 48(sp)
8020339c: 83 36 84 ff  	ld	a3, -8(s0)
802033a0: 0c 60        	ld	a1, 0(s0)
802033a2: 89 ce        	beqz	a3, 0x802033bc <.LBB218_31+0x50>
802033a4: 01 46        	li	a2, 0
802033a6: 63 9c 56 01  	bne	a3, s5, 0x802033be <.LBB218_31+0x52>
802033aa: 92 05        	slli	a1, a1, 4
802033ac: aa 95        	add	a1, a1, a0
802033ae: 90 65        	ld	a2, 8(a1)
802033b0: 63 04 66 01  	beq	a2, s6, 0x802033b8 <.LBB218_31+0x4c>
802033b4: 01 46        	li	a2, 0
802033b6: 21 a0        	j	0x802033be <.LBB218_31+0x52>
802033b8: 8c 61        	ld	a1, 0(a1)
802033ba: 8c 61        	ld	a1, 0(a1)
802033bc: 05 46        	li	a2, 1
802033be: 32 e8        	sd	a2, 16(sp)
802033c0: 2e ec        	sd	a1, 24(sp)
802033c2: 83 36 84 fe  	ld	a3, -24(s0)
802033c6: 83 35 04 ff  	ld	a1, -16(s0)
802033ca: 89 ce        	beqz	a3, 0x802033e4 <.LBB218_31+0x78>
802033cc: 01 46        	li	a2, 0
802033ce: 63 9c 56 01  	bne	a3, s5, 0x802033e6 <.LBB218_31+0x7a>
802033d2: 92 05        	slli	a1, a1, 4
802033d4: aa 95        	add	a1, a1, a0
802033d6: 90 65        	ld	a2, 8(a1)
802033d8: 63 04 66 01  	beq	a2, s6, 0x802033e0 <.LBB218_31+0x74>
802033dc: 01 46        	li	a2, 0
802033de: 21 a0        	j	0x802033e6 <.LBB218_31+0x7a>
802033e0: 8c 61        	ld	a1, 0(a1)
802033e2: 8c 61        	ld	a1, 0(a1)
802033e4: 05 46        	li	a2, 1
802033e6: 32 f0        	sd	a2, 32(sp)
802033e8: 2e f4        	sd	a1, 40(sp)
802033ea: 0c 6c        	ld	a1, 24(s0)
802033ec: 92 05        	slli	a1, a1, 4
802033ee: 2e 95        	add	a0, a0, a1
802033f0: 10 65        	ld	a2, 8(a0)
802033f2: 08 61        	ld	a0, 0(a0)
802033f4: 8a 85        	mv	a1, sp
802033f6: 02 96        	jalr	a2
802033f8: 59 e5        	bnez	a0, 0x80203486 <.LBB218_31+0x11a>
802033fa: c1 04        	addi	s1, s1, 16
802033fc: 13 0a 8a fc  	addi	s4, s4, -56
80203400: 13 04 84 03  	addi	s0, s0, 56
80203404: e3 18 0a f6  	bnez	s4, 0x80203374 <.LBB218_31+0x8>
80203408: 81 a8        	j	0x80203458 <.LBB218_31+0xec>
8020340a: 03 b5 89 02  	ld	a0, 40(s3)
8020340e: 31 c9        	beqz	a0, 0x80203462 <.LBB218_31+0xf6>
80203410: 83 b5 09 02  	ld	a1, 32(s3)
80203414: 03 b6 09 01  	ld	a2, 16(s3)
80203418: 93 06 f5 ff  	addi	a3, a0, -1
8020341c: 92 06        	slli	a3, a3, 4
8020341e: 91 82        	srli	a3, a3, 4
80203420: 13 89 16 00  	addi	s2, a3, 1
80203424: 13 04 86 00  	addi	s0, a2, 8
80203428: 13 1a 45 00  	slli	s4, a0, 4
8020342c: 93 84 85 00  	addi	s1, a1, 8
80203430: 10 60        	ld	a2, 0(s0)
80203432: 01 ca        	beqz	a2, 0x80203442 <.LBB218_31+0xd6>
80203434: a2 66        	ld	a3, 8(sp)
80203436: 02 65        	ld	a0, 0(sp)
80203438: 83 35 84 ff  	ld	a1, -8(s0)
8020343c: 94 6e        	ld	a3, 24(a3)
8020343e: 82 96        	jalr	a3
80203440: 39 e1        	bnez	a0, 0x80203486 <.LBB218_31+0x11a>
80203442: 90 60        	ld	a2, 0(s1)
80203444: 03 b5 84 ff  	ld	a0, -8(s1)
80203448: 8a 85        	mv	a1, sp
8020344a: 02 96        	jalr	a2
8020344c: 0d ed        	bnez	a0, 0x80203486 <.LBB218_31+0x11a>
8020344e: 41 04        	addi	s0, s0, 16
80203450: 41 1a        	addi	s4, s4, -16
80203452: c1 04        	addi	s1, s1, 16
80203454: e3 1e 0a fc  	bnez	s4, 0x80203430 <.LBB218_31+0xc4>
80203458: 03 b5 89 01  	ld	a0, 24(s3)
8020345c: 63 68 a9 00  	bltu	s2, a0, 0x8020346c <.LBB218_31+0x100>
80203460: 2d a0        	j	0x8020348a <.LBB218_31+0x11e>
80203462: 01 49        	li	s2, 0
80203464: 03 b5 89 01  	ld	a0, 24(s3)
80203468: 63 71 a9 02  	bgeu	s2, a0, 0x8020348a <.LBB218_31+0x11e>
8020346c: 03 b5 09 01  	ld	a0, 16(s3)
80203470: 93 15 49 00  	slli	a1, s2, 4
80203474: 33 06 b5 00  	add	a2, a0, a1
80203478: a2 66        	ld	a3, 8(sp)
8020347a: 02 65        	ld	a0, 0(sp)
8020347c: 0c 62        	ld	a1, 0(a2)
8020347e: 10 66        	ld	a2, 8(a2)
80203480: 94 6e        	ld	a3, 24(a3)
80203482: 82 96        	jalr	a3
80203484: 19 c1        	beqz	a0, 0x8020348a <.LBB218_31+0x11e>
80203486: 05 45        	li	a0, 1
80203488: 11 a0        	j	0x8020348c <.LBB218_31+0x120>
8020348a: 01 45        	li	a0, 0
8020348c: e6 70        	ld	ra, 120(sp)
8020348e: 46 74        	ld	s0, 112(sp)
80203490: a6 74        	ld	s1, 104(sp)
80203492: 06 79        	ld	s2, 96(sp)
80203494: e6 69        	ld	s3, 88(sp)
80203496: 46 6a        	ld	s4, 80(sp)
80203498: a6 6a        	ld	s5, 72(sp)
8020349a: 06 6b        	ld	s6, 64(sp)
8020349c: 09 61        	addi	sp, sp, 128
8020349e: 82 80        	ret

Disassembly of section .text._ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E:

00000000802034a0 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E>:
802034a0: 59 71        	addi	sp, sp, -112
802034a2: 86 f4        	sd	ra, 104(sp)
802034a4: a2 f0        	sd	s0, 96(sp)
802034a6: a6 ec        	sd	s1, 88(sp)
802034a8: ca e8        	sd	s2, 80(sp)
802034aa: ce e4        	sd	s3, 72(sp)
802034ac: d2 e0        	sd	s4, 64(sp)
802034ae: 56 fc        	sd	s5, 56(sp)
802034b0: 5a f8        	sd	s6, 48(sp)
802034b2: 5e f4        	sd	s7, 40(sp)
802034b4: 62 f0        	sd	s8, 32(sp)
802034b6: 66 ec        	sd	s9, 24(sp)
802034b8: 6a e8        	sd	s10, 16(sp)
802034ba: 6e e4        	sd	s11, 8(sp)
802034bc: be 89        	mv	s3, a5
802034be: 3a 89        	mv	s2, a4
802034c0: 36 8b        	mv	s6, a3
802034c2: 32 8a        	mv	s4, a2
802034c4: 2a 8c        	mv	s8, a0
802034c6: b9 c1        	beqz	a1, 0x8020350c <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x6c>
802034c8: 03 64 0c 03  	lwu	s0, 48(s8)
802034cc: 13 75 14 00  	andi	a0, s0, 1
802034d0: b7 0a 11 00  	lui	s5, 272
802034d4: 19 c1        	beqz	a0, 0x802034da <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x3a>
802034d6: 93 0a b0 02  	li	s5, 43
802034da: b3 0c 35 01  	add	s9, a0, s3
802034de: 13 75 44 00  	andi	a0, s0, 4
802034e2: 15 cd        	beqz	a0, 0x8020351e <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x7e>
802034e4: 13 05 00 02  	li	a0, 32
802034e8: 63 70 ab 04  	bgeu	s6, a0, 0x80203528 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x88>
802034ec: 01 45        	li	a0, 0
802034ee: 63 03 0b 04  	beqz	s6, 0x80203534 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x94>
802034f2: da 85        	mv	a1, s6
802034f4: 52 86        	mv	a2, s4
802034f6: 83 06 06 00  	lb	a3, 0(a2)
802034fa: 05 06        	addi	a2, a2, 1
802034fc: 93 a6 06 fc  	slti	a3, a3, -64
80203500: 93 c6 16 00  	xori	a3, a3, 1
80203504: fd 15        	addi	a1, a1, -1
80203506: 36 95        	add	a0, a0, a3
80203508: fd f5        	bnez	a1, 0x802034f6 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x56>
8020350a: 2d a0        	j	0x80203534 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x94>
8020350c: 03 24 0c 03  	lw	s0, 48(s8)
80203510: 93 8c 19 00  	addi	s9, s3, 1
80203514: 93 0a d0 02  	li	s5, 45
80203518: 13 75 44 00  	andi	a0, s0, 4
8020351c: 61 f5        	bnez	a0, 0x802034e4 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x44>
8020351e: 01 4a        	li	s4, 0
80203520: 03 35 0c 01  	ld	a0, 16(s8)
80203524: 01 ed        	bnez	a0, 0x8020353c <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x9c>
80203526: 99 a0        	j	0x8020356c <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xcc>
80203528: 52 85        	mv	a0, s4
8020352a: da 85        	mv	a1, s6
8020352c: 97 10 00 00  	auipc	ra, 1
80203530: e7 80 80 83  	jalr	-1992(ra)
80203534: aa 9c        	add	s9, s9, a0
80203536: 03 35 0c 01  	ld	a0, 16(s8)
8020353a: 0d c9        	beqz	a0, 0x8020356c <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xcc>
8020353c: 03 3d 8c 01  	ld	s10, 24(s8)
80203540: 63 f6 ac 03  	bgeu	s9, s10, 0x8020356c <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xcc>
80203544: 13 75 84 00  	andi	a0, s0, 8
80203548: 41 e5        	bnez	a0, 0x802035d0 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x130>
8020354a: 83 45 8c 03  	lbu	a1, 56(s8)
8020354e: 0d 46        	li	a2, 3
80203550: 05 45        	li	a0, 1
80203552: 63 83 c5 00  	beq	a1, a2, 0x80203558 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xb8>
80203556: 2e 85        	mv	a0, a1
80203558: 93 75 35 00  	andi	a1, a0, 3
8020355c: 33 05 9d 41  	sub	a0, s10, s9
80203560: e1 c1        	beqz	a1, 0x80203620 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x180>
80203562: 05 46        	li	a2, 1
80203564: 63 91 c5 0c  	bne	a1, a2, 0x80203626 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x186>
80203568: 01 4d        	li	s10, 0
8020356a: d9 a0        	j	0x80203630 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x190>
8020356c: 03 34 0c 00  	ld	s0, 0(s8)
80203570: 83 34 8c 00  	ld	s1, 8(s8)
80203574: 22 85        	mv	a0, s0
80203576: a6 85        	mv	a1, s1
80203578: 56 86        	mv	a2, s5
8020357a: d2 86        	mv	a3, s4
8020357c: 5a 87        	mv	a4, s6
8020357e: 97 00 00 00  	auipc	ra, 0
80203582: e7 80 00 14  	jalr	320(ra)
80203586: 85 4b        	li	s7, 1
80203588: 0d c1        	beqz	a0, 0x802035aa <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x10a>
8020358a: 5e 85        	mv	a0, s7
8020358c: a6 70        	ld	ra, 104(sp)
8020358e: 06 74        	ld	s0, 96(sp)
80203590: e6 64        	ld	s1, 88(sp)
80203592: 46 69        	ld	s2, 80(sp)
80203594: a6 69        	ld	s3, 72(sp)
80203596: 06 6a        	ld	s4, 64(sp)
80203598: e2 7a        	ld	s5, 56(sp)
8020359a: 42 7b        	ld	s6, 48(sp)
8020359c: a2 7b        	ld	s7, 40(sp)
8020359e: 02 7c        	ld	s8, 32(sp)
802035a0: e2 6c        	ld	s9, 24(sp)
802035a2: 42 6d        	ld	s10, 16(sp)
802035a4: a2 6d        	ld	s11, 8(sp)
802035a6: 65 61        	addi	sp, sp, 112
802035a8: 82 80        	ret
802035aa: 9c 6c        	ld	a5, 24(s1)
802035ac: 22 85        	mv	a0, s0
802035ae: ca 85        	mv	a1, s2
802035b0: 4e 86        	mv	a2, s3
802035b2: a6 70        	ld	ra, 104(sp)
802035b4: 06 74        	ld	s0, 96(sp)
802035b6: e6 64        	ld	s1, 88(sp)
802035b8: 46 69        	ld	s2, 80(sp)
802035ba: a6 69        	ld	s3, 72(sp)
802035bc: 06 6a        	ld	s4, 64(sp)
802035be: e2 7a        	ld	s5, 56(sp)
802035c0: 42 7b        	ld	s6, 48(sp)
802035c2: a2 7b        	ld	s7, 40(sp)
802035c4: 02 7c        	ld	s8, 32(sp)
802035c6: e2 6c        	ld	s9, 24(sp)
802035c8: 42 6d        	ld	s10, 16(sp)
802035ca: a2 6d        	ld	s11, 8(sp)
802035cc: 65 61        	addi	sp, sp, 112
802035ce: 82 87        	jr	a5
802035d0: 03 24 4c 03  	lw	s0, 52(s8)
802035d4: 13 05 00 03  	li	a0, 48
802035d8: 83 45 8c 03  	lbu	a1, 56(s8)
802035dc: 2e e0        	sd	a1, 0(sp)
802035de: 83 3d 0c 00  	ld	s11, 0(s8)
802035e2: 83 34 8c 00  	ld	s1, 8(s8)
802035e6: 23 2a ac 02  	sw	a0, 52(s8)
802035ea: 85 4b        	li	s7, 1
802035ec: 23 0c 7c 03  	sb	s7, 56(s8)
802035f0: 6e 85        	mv	a0, s11
802035f2: a6 85        	mv	a1, s1
802035f4: 56 86        	mv	a2, s5
802035f6: d2 86        	mv	a3, s4
802035f8: 5a 87        	mv	a4, s6
802035fa: 97 00 00 00  	auipc	ra, 0
802035fe: e7 80 40 0c  	jalr	196(ra)
80203602: 41 f5        	bnez	a0, 0x8020358a <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xea>
80203604: 22 8a        	mv	s4, s0
80203606: 33 05 9d 41  	sub	a0, s10, s9
8020360a: 13 04 15 00  	addi	s0, a0, 1
8020360e: 7d 14        	addi	s0, s0, -1
80203610: 49 c4        	beqz	s0, 0x8020369a <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x1fa>
80203612: 90 70        	ld	a2, 32(s1)
80203614: 93 05 00 03  	li	a1, 48
80203618: 6e 85        	mv	a0, s11
8020361a: 02 96        	jalr	a2
8020361c: 6d d9        	beqz	a0, 0x8020360e <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x16e>
8020361e: b5 b7        	j	0x8020358a <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xea>
80203620: 2a 8d        	mv	s10, a0
80203622: 2e 85        	mv	a0, a1
80203624: 31 a0        	j	0x80203630 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x190>
80203626: 93 05 15 00  	addi	a1, a0, 1
8020362a: 05 81        	srli	a0, a0, 1
8020362c: 13 dd 15 00  	srli	s10, a1, 1
80203630: 83 3c 0c 00  	ld	s9, 0(s8)
80203634: 83 3d 8c 00  	ld	s11, 8(s8)
80203638: 03 24 4c 03  	lw	s0, 52(s8)
8020363c: 93 04 15 00  	addi	s1, a0, 1
80203640: fd 14        	addi	s1, s1, -1
80203642: 89 c8        	beqz	s1, 0x80203654 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x1b4>
80203644: 03 b6 0d 02  	ld	a2, 32(s11)
80203648: 66 85        	mv	a0, s9
8020364a: a2 85        	mv	a1, s0
8020364c: 02 96        	jalr	a2
8020364e: 6d d9        	beqz	a0, 0x80203640 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x1a0>
80203650: 85 4b        	li	s7, 1
80203652: 25 bf        	j	0x8020358a <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xea>
80203654: 37 05 11 00  	lui	a0, 272
80203658: 85 4b        	li	s7, 1
8020365a: e3 08 a4 f2  	beq	s0, a0, 0x8020358a <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xea>
8020365e: 66 85        	mv	a0, s9
80203660: ee 85        	mv	a1, s11
80203662: 56 86        	mv	a2, s5
80203664: d2 86        	mv	a3, s4
80203666: 5a 87        	mv	a4, s6
80203668: 97 00 00 00  	auipc	ra, 0
8020366c: e7 80 60 05  	jalr	86(ra)
80203670: 09 fd        	bnez	a0, 0x8020358a <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xea>
80203672: 83 b6 8d 01  	ld	a3, 24(s11)
80203676: 66 85        	mv	a0, s9
80203678: ca 85        	mv	a1, s2
8020367a: 4e 86        	mv	a2, s3
8020367c: 82 96        	jalr	a3
8020367e: 11 f5        	bnez	a0, 0x8020358a <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xea>
80203680: 81 44        	li	s1, 0
80203682: 63 0a 9d 02  	beq	s10, s1, 0x802036b6 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x216>
80203686: 03 b6 0d 02  	ld	a2, 32(s11)
8020368a: 85 04        	addi	s1, s1, 1
8020368c: 66 85        	mv	a0, s9
8020368e: a2 85        	mv	a1, s0
80203690: 02 96        	jalr	a2
80203692: 65 d9        	beqz	a0, 0x80203682 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x1e2>
80203694: 13 85 f4 ff  	addi	a0, s1, -1
80203698: 05 a0        	j	0x802036b8 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x218>
8020369a: 94 6c        	ld	a3, 24(s1)
8020369c: 6e 85        	mv	a0, s11
8020369e: ca 85        	mv	a1, s2
802036a0: 4e 86        	mv	a2, s3
802036a2: 82 96        	jalr	a3
802036a4: e3 13 05 ee  	bnez	a0, 0x8020358a <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xea>
802036a8: 81 4b        	li	s7, 0
802036aa: 23 2a 4c 03  	sw	s4, 52(s8)
802036ae: 02 65        	ld	a0, 0(sp)
802036b0: 23 0c ac 02  	sb	a0, 56(s8)
802036b4: d9 bd        	j	0x8020358a <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xea>
802036b6: 6a 85        	mv	a0, s10
802036b8: b3 3b a5 01  	sltu	s7, a0, s10
802036bc: f9 b5        	j	0x8020358a <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xea>

Disassembly of section .text._ZN4core3fmt9Formatter12pad_integral12write_prefix17h94560343c060f655E:

00000000802036be <_ZN4core3fmt9Formatter12pad_integral12write_prefix17h94560343c060f655E>:
802036be: 79 71        	addi	sp, sp, -48
802036c0: 06 f4        	sd	ra, 40(sp)
802036c2: 22 f0        	sd	s0, 32(sp)
802036c4: 26 ec        	sd	s1, 24(sp)
802036c6: 4a e8        	sd	s2, 16(sp)
802036c8: 4e e4        	sd	s3, 8(sp)
802036ca: 9b 07 06 00  	sext.w	a5, a2
802036ce: 37 08 11 00  	lui	a6, 272
802036d2: 3a 89        	mv	s2, a4
802036d4: b6 84        	mv	s1, a3
802036d6: 2e 84        	mv	s0, a1
802036d8: aa 89        	mv	s3, a0
802036da: 63 89 07 01  	beq	a5, a6, 0x802036ec <_ZN4core3fmt9Formatter12pad_integral12write_prefix17h94560343c060f655E+0x2e>
802036de: 14 70        	ld	a3, 32(s0)
802036e0: 4e 85        	mv	a0, s3
802036e2: b2 85        	mv	a1, a2
802036e4: 82 96        	jalr	a3
802036e6: aa 85        	mv	a1, a0
802036e8: 05 45        	li	a0, 1
802036ea: 91 ed        	bnez	a1, 0x80203706 <_ZN4core3fmt9Formatter12pad_integral12write_prefix17h94560343c060f655E+0x48>
802036ec: 81 cc        	beqz	s1, 0x80203704 <_ZN4core3fmt9Formatter12pad_integral12write_prefix17h94560343c060f655E+0x46>
802036ee: 1c 6c        	ld	a5, 24(s0)
802036f0: 4e 85        	mv	a0, s3
802036f2: a6 85        	mv	a1, s1
802036f4: 4a 86        	mv	a2, s2
802036f6: a2 70        	ld	ra, 40(sp)
802036f8: 02 74        	ld	s0, 32(sp)
802036fa: e2 64        	ld	s1, 24(sp)
802036fc: 42 69        	ld	s2, 16(sp)
802036fe: a2 69        	ld	s3, 8(sp)
80203700: 45 61        	addi	sp, sp, 48
80203702: 82 87        	jr	a5
80203704: 01 45        	li	a0, 0
80203706: a2 70        	ld	ra, 40(sp)
80203708: 02 74        	ld	s0, 32(sp)
8020370a: e2 64        	ld	s1, 24(sp)
8020370c: 42 69        	ld	s2, 16(sp)
8020370e: a2 69        	ld	s3, 8(sp)
80203710: 45 61        	addi	sp, sp, 48
80203712: 82 80        	ret

Disassembly of section .text._ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E:

0000000080203714 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E>:
80203714: 5d 71        	addi	sp, sp, -80
80203716: 86 e4        	sd	ra, 72(sp)
80203718: a2 e0        	sd	s0, 64(sp)
8020371a: 26 fc        	sd	s1, 56(sp)
8020371c: 4a f8        	sd	s2, 48(sp)
8020371e: 4e f4        	sd	s3, 40(sp)
80203720: 52 f0        	sd	s4, 32(sp)
80203722: 56 ec        	sd	s5, 24(sp)
80203724: 5a e8        	sd	s6, 16(sp)
80203726: 5e e4        	sd	s7, 8(sp)
80203728: 2a 8a        	mv	s4, a0
8020372a: 83 32 05 01  	ld	t0, 16(a0)
8020372e: 08 71        	ld	a0, 32(a0)
80203730: 93 86 f2 ff  	addi	a3, t0, -1
80203734: b3 36 d0 00  	snez	a3, a3
80203738: 13 07 f5 ff  	addi	a4, a0, -1
8020373c: 33 37 e0 00  	snez	a4, a4
80203740: f9 8e        	and	a3, a3, a4
80203742: b2 89        	mv	s3, a2
80203744: 2e 89        	mv	s2, a1
80203746: 63 9d 06 16  	bnez	a3, 0x802038c0 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x1ac>
8020374a: 85 45        	li	a1, 1
8020374c: 63 18 b5 10  	bne	a0, a1, 0x8020385c <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x148>
80203750: 03 35 8a 02  	ld	a0, 40(s4)
80203754: 81 45        	li	a1, 0
80203756: b3 06 39 01  	add	a3, s2, s3
8020375a: 13 07 15 00  	addi	a4, a0, 1
8020375e: 37 03 11 00  	lui	t1, 272
80203762: 93 08 f0 0d  	li	a7, 223
80203766: 13 08 00 0f  	li	a6, 240
8020376a: 4a 86        	mv	a2, s2
8020376c: 01 a8        	j	0x8020377c <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x68>
8020376e: 13 05 16 00  	addi	a0, a2, 1
80203772: 91 8d        	sub	a1, a1, a2
80203774: aa 95        	add	a1, a1, a0
80203776: 2a 86        	mv	a2, a0
80203778: 63 02 64 0e  	beq	s0, t1, 0x8020385c <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x148>
8020377c: 7d 17        	addi	a4, a4, -1
8020377e: 25 c7        	beqz	a4, 0x802037e6 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0xd2>
80203780: 63 0e d6 0c  	beq	a2, a3, 0x8020385c <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x148>
80203784: 03 05 06 00  	lb	a0, 0(a2)
80203788: 13 74 f5 0f  	andi	s0, a0, 255
8020378c: e3 51 05 fe  	bgez	a0, 0x8020376e <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x5a>
80203790: 03 45 16 00  	lbu	a0, 1(a2)
80203794: 93 77 f4 01  	andi	a5, s0, 31
80203798: 93 74 f5 03  	andi	s1, a0, 63
8020379c: 63 f9 88 02  	bgeu	a7, s0, 0x802037ce <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0xba>
802037a0: 03 45 26 00  	lbu	a0, 2(a2)
802037a4: 9a 04        	slli	s1, s1, 6
802037a6: 13 75 f5 03  	andi	a0, a0, 63
802037aa: c9 8c        	or	s1, s1, a0
802037ac: 63 67 04 03  	bltu	s0, a6, 0x802037da <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0xc6>
802037b0: 03 45 36 00  	lbu	a0, 3(a2)
802037b4: f6 17        	slli	a5, a5, 61
802037b6: ad 93        	srli	a5, a5, 43
802037b8: 9a 04        	slli	s1, s1, 6
802037ba: 13 75 f5 03  	andi	a0, a0, 63
802037be: 45 8d        	or	a0, a0, s1
802037c0: 33 64 f5 00  	or	s0, a0, a5
802037c4: 63 0c 64 08  	beq	s0, t1, 0x8020385c <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x148>
802037c8: 13 05 46 00  	addi	a0, a2, 4
802037cc: 5d b7        	j	0x80203772 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x5e>
802037ce: 13 05 26 00  	addi	a0, a2, 2
802037d2: 9a 07        	slli	a5, a5, 6
802037d4: 33 e4 97 00  	or	s0, a5, s1
802037d8: 69 bf        	j	0x80203772 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x5e>
802037da: 13 05 36 00  	addi	a0, a2, 3
802037de: b2 07        	slli	a5, a5, 12
802037e0: 33 e4 f4 00  	or	s0, s1, a5
802037e4: 79 b7        	j	0x80203772 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x5e>
802037e6: 63 0b d6 06  	beq	a2, a3, 0x8020385c <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x148>
802037ea: 03 05 06 00  	lb	a0, 0(a2)
802037ee: 63 53 05 04  	bgez	a0, 0x80203834 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x120>
802037f2: 13 75 f5 0f  	andi	a0, a0, 255
802037f6: 93 06 00 0e  	li	a3, 224
802037fa: 63 6d d5 02  	bltu	a0, a3, 0x80203834 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x120>
802037fe: 93 06 00 0f  	li	a3, 240
80203802: 63 69 d5 02  	bltu	a0, a3, 0x80203834 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x120>
80203806: 83 46 16 00  	lbu	a3, 1(a2)
8020380a: 03 47 26 00  	lbu	a4, 2(a2)
8020380e: 93 f6 f6 03  	andi	a3, a3, 63
80203812: 13 77 f7 03  	andi	a4, a4, 63
80203816: 03 46 36 00  	lbu	a2, 3(a2)
8020381a: 76 15        	slli	a0, a0, 61
8020381c: 2d 91        	srli	a0, a0, 43
8020381e: b2 06        	slli	a3, a3, 12
80203820: 1a 07        	slli	a4, a4, 6
80203822: d9 8e        	or	a3, a3, a4
80203824: 13 76 f6 03  	andi	a2, a2, 63
80203828: 55 8e        	or	a2, a2, a3
8020382a: 51 8d        	or	a0, a0, a2
8020382c: 37 06 11 00  	lui	a2, 272
80203830: 63 06 c5 02  	beq	a0, a2, 0x8020385c <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x148>
80203834: 85 c1        	beqz	a1, 0x80203854 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x140>
80203836: 63 fd 35 01  	bgeu	a1, s3, 0x80203850 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x13c>
8020383a: 33 05 b9 00  	add	a0, s2, a1
8020383e: 03 05 05 00  	lb	a0, 0(a0)
80203842: 13 06 00 fc  	li	a2, -64
80203846: 63 57 c5 00  	bge	a0, a2, 0x80203854 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x140>
8020384a: 01 45        	li	a0, 0
8020384c: 11 e5        	bnez	a0, 0x80203858 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x144>
8020384e: 39 a0        	j	0x8020385c <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x148>
80203850: e3 9d 35 ff  	bne	a1, s3, 0x8020384a <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x136>
80203854: 4a 85        	mv	a0, s2
80203856: 19 c1        	beqz	a0, 0x8020385c <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x148>
80203858: ae 89        	mv	s3, a1
8020385a: 2a 89        	mv	s2, a0
8020385c: 63 82 02 06  	beqz	t0, 0x802038c0 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x1ac>
80203860: 03 34 8a 01  	ld	s0, 24(s4)
80203864: 13 05 00 02  	li	a0, 32
80203868: 63 f4 a9 04  	bgeu	s3, a0, 0x802038b0 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x19c>
8020386c: 01 45        	li	a0, 0
8020386e: 63 8e 09 00  	beqz	s3, 0x8020388a <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x176>
80203872: ce 85        	mv	a1, s3
80203874: 4a 86        	mv	a2, s2
80203876: 83 06 06 00  	lb	a3, 0(a2)
8020387a: 05 06        	addi	a2, a2, 1
8020387c: 93 a6 06 fc  	slti	a3, a3, -64
80203880: 93 c6 16 00  	xori	a3, a3, 1
80203884: fd 15        	addi	a1, a1, -1
80203886: 36 95        	add	a0, a0, a3
80203888: fd f5        	bnez	a1, 0x80203876 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x162>
8020388a: 63 7b 85 02  	bgeu	a0, s0, 0x802038c0 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x1ac>
8020388e: 83 45 8a 03  	lbu	a1, 56(s4)
80203892: 8d 46        	li	a3, 3
80203894: 01 46        	li	a2, 0
80203896: 63 83 d5 00  	beq	a1, a3, 0x8020389c <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x188>
8020389a: 2e 86        	mv	a2, a1
8020389c: 93 75 36 00  	andi	a1, a2, 3
802038a0: 33 05 a4 40  	sub	a0, s0, a0
802038a4: a1 c1        	beqz	a1, 0x802038e4 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x1d0>
802038a6: 05 46        	li	a2, 1
802038a8: 63 91 c5 04  	bne	a1, a2, 0x802038ea <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x1d6>
802038ac: 81 4a        	li	s5, 0
802038ae: 99 a0        	j	0x802038f4 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x1e0>
802038b0: 4a 85        	mv	a0, s2
802038b2: ce 85        	mv	a1, s3
802038b4: 97 00 00 00  	auipc	ra, 0
802038b8: e7 80 00 4b  	jalr	1200(ra)
802038bc: e3 69 85 fc  	bltu	a0, s0, 0x8020388e <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x17a>
802038c0: 83 35 8a 00  	ld	a1, 8(s4)
802038c4: 03 35 0a 00  	ld	a0, 0(s4)
802038c8: 9c 6d        	ld	a5, 24(a1)
802038ca: ca 85        	mv	a1, s2
802038cc: 4e 86        	mv	a2, s3
802038ce: a6 60        	ld	ra, 72(sp)
802038d0: 06 64        	ld	s0, 64(sp)
802038d2: e2 74        	ld	s1, 56(sp)
802038d4: 42 79        	ld	s2, 48(sp)
802038d6: a2 79        	ld	s3, 40(sp)
802038d8: 02 7a        	ld	s4, 32(sp)
802038da: e2 6a        	ld	s5, 24(sp)
802038dc: 42 6b        	ld	s6, 16(sp)
802038de: a2 6b        	ld	s7, 8(sp)
802038e0: 61 61        	addi	sp, sp, 80
802038e2: 82 87        	jr	a5
802038e4: aa 8a        	mv	s5, a0
802038e6: 2e 85        	mv	a0, a1
802038e8: 31 a0        	j	0x802038f4 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x1e0>
802038ea: 93 05 15 00  	addi	a1, a0, 1
802038ee: 05 81        	srli	a0, a0, 1
802038f0: 93 da 15 00  	srli	s5, a1, 1
802038f4: 03 3b 0a 00  	ld	s6, 0(s4)
802038f8: 83 3b 8a 00  	ld	s7, 8(s4)
802038fc: 83 24 4a 03  	lw	s1, 52(s4)
80203900: 13 04 15 00  	addi	s0, a0, 1
80203904: 7d 14        	addi	s0, s0, -1
80203906: 09 c8        	beqz	s0, 0x80203918 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x204>
80203908: 03 b6 0b 02  	ld	a2, 32(s7)
8020390c: 5a 85        	mv	a0, s6
8020390e: a6 85        	mv	a1, s1
80203910: 02 96        	jalr	a2
80203912: 6d d9        	beqz	a0, 0x80203904 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x1f0>
80203914: 05 4a        	li	s4, 1
80203916: 2d a8        	j	0x80203950 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x23c>
80203918: 37 05 11 00  	lui	a0, 272
8020391c: 05 4a        	li	s4, 1
8020391e: 63 89 a4 02  	beq	s1, a0, 0x80203950 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x23c>
80203922: 83 b6 8b 01  	ld	a3, 24(s7)
80203926: 5a 85        	mv	a0, s6
80203928: ca 85        	mv	a1, s2
8020392a: 4e 86        	mv	a2, s3
8020392c: 82 96        	jalr	a3
8020392e: 0d e1        	bnez	a0, 0x80203950 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x23c>
80203930: 01 44        	li	s0, 0
80203932: 63 8c 8a 00  	beq	s5, s0, 0x8020394a <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x236>
80203936: 03 b6 0b 02  	ld	a2, 32(s7)
8020393a: 05 04        	addi	s0, s0, 1
8020393c: 5a 85        	mv	a0, s6
8020393e: a6 85        	mv	a1, s1
80203940: 02 96        	jalr	a2
80203942: 65 d9        	beqz	a0, 0x80203932 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x21e>
80203944: 13 05 f4 ff  	addi	a0, s0, -1
80203948: 11 a0        	j	0x8020394c <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x238>
8020394a: 56 85        	mv	a0, s5
8020394c: 33 3a 55 01  	sltu	s4, a0, s5
80203950: 52 85        	mv	a0, s4
80203952: a6 60        	ld	ra, 72(sp)
80203954: 06 64        	ld	s0, 64(sp)
80203956: e2 74        	ld	s1, 56(sp)
80203958: 42 79        	ld	s2, 48(sp)
8020395a: a2 79        	ld	s3, 40(sp)
8020395c: 02 7a        	ld	s4, 32(sp)
8020395e: e2 6a        	ld	s5, 24(sp)
80203960: 42 6b        	ld	s6, 16(sp)
80203962: a2 6b        	ld	s7, 8(sp)
80203964: 61 61        	addi	sp, sp, 80
80203966: 82 80        	ret

Disassembly of section .text._ZN4core3fmt9Formatter9write_str17h6b023101b7091b7bE:

0000000080203968 <_ZN57_$LT$core..fmt..Formatter$u20$as$u20$core..fmt..Write$GT$9write_str17h9ea88953b3da9726E>:
80203968: 14 65        	ld	a3, 8(a0)
8020396a: 08 61        	ld	a0, 0(a0)
8020396c: 9c 6e        	ld	a5, 24(a3)
8020396e: 82 87        	jr	a5

Disassembly of section .text._ZN4core3fmt9Formatter25debug_tuple_field1_finish17h0bb87442736b9178E:

0000000080203970 <_ZN4core3fmt9Formatter25debug_tuple_field1_finish17h0bb87442736b9178E>:
80203970: 39 71        	addi	sp, sp, -64
80203972: 06 fc        	sd	ra, 56(sp)
80203974: 22 f8        	sd	s0, 48(sp)
80203976: 26 f4        	sd	s1, 40(sp)
80203978: 4a f0        	sd	s2, 32(sp)
8020397a: 4e ec        	sd	s3, 24(sp)
8020397c: 2a 84        	mv	s0, a0
8020397e: 1c 65        	ld	a5, 8(a0)
80203980: 08 61        	ld	a0, 0(a0)
80203982: 9c 6f        	ld	a5, 24(a5)
80203984: 3a 89        	mv	s2, a4
80203986: b6 89        	mv	s3, a3
80203988: b2 84        	mv	s1, a2
8020398a: 82 97        	jalr	a5
8020398c: 93 b5 14 00  	seqz	a1, s1
80203990: 22 e4        	sd	s0, 8(sp)
80203992: 23 08 a1 00  	sb	a0, 16(sp)
80203996: 02 e0        	sd	zero, 0(sp)
80203998: a3 08 b1 00  	sb	a1, 17(sp)
8020399c: 0a 85        	mv	a0, sp
8020399e: ce 85        	mv	a1, s3
802039a0: 4a 86        	mv	a2, s2
802039a2: 97 f0 ff ff  	auipc	ra, 1048575
802039a6: e7 80 60 62  	jalr	1574(ra)
802039aa: 02 65        	ld	a0, 0(sp)
802039ac: 83 45 01 01  	lbu	a1, 16(sp)
802039b0: 39 c5        	beqz	a0, 0x802039fe <.LBB245_9+0x10>
802039b2: 05 44        	li	s0, 1
802039b4: a1 e5        	bnez	a1, 0x802039fc <.LBB245_9+0xe>
802039b6: 83 45 11 01  	lbu	a1, 17(sp)
802039ba: 7d 15        	addi	a0, a0, -1
802039bc: 13 35 15 00  	seqz	a0, a0
802039c0: a2 64        	ld	s1, 8(sp)
802039c2: b3 35 b0 00  	snez	a1, a1
802039c6: 6d 8d        	and	a0, a0, a1
802039c8: 05 c1        	beqz	a0, 0x802039e8 <.LBB245_8+0x10>
802039ca: 03 c5 04 03  	lbu	a0, 48(s1)
802039ce: 11 89        	andi	a0, a0, 4
802039d0: 01 ed        	bnez	a0, 0x802039e8 <.LBB245_8+0x10>
802039d2: 8c 64        	ld	a1, 8(s1)
802039d4: 88 60        	ld	a0, 0(s1)
802039d6: 94 6d        	ld	a3, 24(a1)

00000000802039d8 <.LBB245_8>:
802039d8: 97 35 04 00  	auipc	a1, 67
802039dc: 93 85 05 43  	addi	a1, a1, 1072
802039e0: 05 46        	li	a2, 1
802039e2: 05 44        	li	s0, 1
802039e4: 82 96        	jalr	a3
802039e6: 19 e9        	bnez	a0, 0x802039fc <.LBB245_9+0xe>
802039e8: 8c 64        	ld	a1, 8(s1)
802039ea: 88 60        	ld	a0, 0(s1)
802039ec: 94 6d        	ld	a3, 24(a1)

00000000802039ee <.LBB245_9>:
802039ee: 97 35 04 00  	auipc	a1, 67
802039f2: 93 85 a5 2e  	addi	a1, a1, 746
802039f6: 05 46        	li	a2, 1
802039f8: 82 96        	jalr	a3
802039fa: 2a 84        	mv	s0, a0
802039fc: a2 85        	mv	a1, s0
802039fe: 33 35 b0 00  	snez	a0, a1
80203a02: e2 70        	ld	ra, 56(sp)
80203a04: 42 74        	ld	s0, 48(sp)
80203a06: a2 74        	ld	s1, 40(sp)
80203a08: 02 79        	ld	s2, 32(sp)
80203a0a: e2 69        	ld	s3, 24(sp)
80203a0c: 21 61        	addi	sp, sp, 64
80203a0e: 82 80        	ret

Disassembly of section .text._ZN42_$LT$str$u20$as$u20$core..fmt..Display$GT$3fmt17h8884fddb1f24a834E:

0000000080203a10 <_ZN42_$LT$str$u20$as$u20$core..fmt..Display$GT$3fmt17h8884fddb1f24a834E>:
80203a10: ae 86        	mv	a3, a1
80203a12: aa 85        	mv	a1, a0
80203a14: 32 85        	mv	a0, a2
80203a16: 36 86        	mv	a2, a3
80203a18: 17 03 00 00  	auipc	t1, 0
80203a1c: 67 00 c3 cf  	jr	-772(t1)

Disassembly of section .text._ZN4core5slice6memchr14memchr_aligned17hb7cb49aaa6ca698aE:

0000000080203a20 <_ZN4core5slice6memchr14memchr_aligned17hb7cb49aaa6ca698aE>:
80203a20: 41 11        	addi	sp, sp, -16
80203a22: 06 e4        	sd	ra, 8(sp)
80203a24: 93 86 75 00  	addi	a3, a1, 7
80203a28: e1 9a        	andi	a3, a3, -8
80203a2a: 13 78 f5 0f  	andi	a6, a0, 255
80203a2e: 63 87 b6 02  	beq	a3, a1, 0x80203a5c <_ZN4core5slice6memchr14memchr_aligned17hb7cb49aaa6ca698aE+0x3c>
80203a32: 33 85 b6 40  	sub	a0, a3, a1
80203a36: 63 63 c5 00  	bltu	a0, a2, 0x80203a3c <_ZN4core5slice6memchr14memchr_aligned17hb7cb49aaa6ca698aE+0x1c>
80203a3a: 32 85        	mv	a0, a2
80203a3c: 05 c1        	beqz	a0, 0x80203a5c <_ZN4core5slice6memchr14memchr_aligned17hb7cb49aaa6ca698aE+0x3c>
80203a3e: 81 46        	li	a3, 0
80203a40: 33 87 d5 00  	add	a4, a1, a3
80203a44: 03 47 07 00  	lbu	a4, 0(a4)
80203a48: 63 0c 07 09  	beq	a4, a6, 0x80203ae0 <.LBB266_24+0x6a>
80203a4c: 85 06        	addi	a3, a3, 1
80203a4e: e3 19 d5 fe  	bne	a0, a3, 0x80203a40 <_ZN4core5slice6memchr14memchr_aligned17hb7cb49aaa6ca698aE+0x20>
80203a52: 93 08 06 ff  	addi	a7, a2, -16
80203a56: 63 f6 a8 00  	bgeu	a7, a0, 0x80203a62 <.LBB266_22>
80203a5a: 95 a0        	j	0x80203abe <.LBB266_24+0x48>
80203a5c: 01 45        	li	a0, 0
80203a5e: 93 08 06 ff  	addi	a7, a2, -16

0000000080203a62 <.LBB266_22>:
80203a62: 97 16 00 00  	auipc	a3, 1
80203a66: 93 86 66 dc  	addi	a3, a3, -570
80203a6a: 83 b2 06 00  	ld	t0, 0(a3)

0000000080203a6e <.LBB266_23>:
80203a6e: 97 16 00 00  	auipc	a3, 1
80203a72: 93 86 26 dc  	addi	a3, a3, -574

0000000080203a76 <.LBB266_24>:
80203a76: 17 17 00 00  	auipc	a4, 1
80203a7a: 13 07 27 dc  	addi	a4, a4, -574
80203a7e: 1c 63        	ld	a5, 0(a4)
80203a80: 03 b3 06 00  	ld	t1, 0(a3)
80203a84: b3 03 f8 02  	mul	t2, a6, a5
80203a88: b3 87 a5 00  	add	a5, a1, a0
80203a8c: 98 63        	ld	a4, 0(a5)
80203a8e: 33 47 77 00  	xor	a4, a4, t2
80203a92: 93 46 f7 ff  	not	a3, a4
80203a96: 16 97        	add	a4, a4, t0
80203a98: b3 f6 66 00  	and	a3, a3, t1
80203a9c: f9 8e        	and	a3, a3, a4
80203a9e: 91 ee        	bnez	a3, 0x80203aba <.LBB266_24+0x44>
80203aa0: 94 67        	ld	a3, 8(a5)
80203aa2: b3 c6 76 00  	xor	a3, a3, t2
80203aa6: 13 c7 f6 ff  	not	a4, a3
80203aaa: 96 96        	add	a3, a3, t0
80203aac: 33 77 67 00  	and	a4, a4, t1
80203ab0: f9 8e        	and	a3, a3, a4
80203ab2: 81 e6        	bnez	a3, 0x80203aba <.LBB266_24+0x44>
80203ab4: 41 05        	addi	a0, a0, 16
80203ab6: e3 f9 a8 fc  	bgeu	a7, a0, 0x80203a88 <.LBB266_24+0x12>
80203aba: 63 69 a6 02  	bltu	a2, a0, 0x80203aec <.LBB266_25>
80203abe: 63 0b c5 00  	beq	a0, a2, 0x80203ad4 <.LBB266_24+0x5e>
80203ac2: b3 86 a5 00  	add	a3, a1, a0
80203ac6: 83 c6 06 00  	lbu	a3, 0(a3)
80203aca: 63 88 06 01  	beq	a3, a6, 0x80203ada <.LBB266_24+0x64>
80203ace: 05 05        	addi	a0, a0, 1
80203ad0: e3 19 a6 fe  	bne	a2, a0, 0x80203ac2 <.LBB266_24+0x4c>
80203ad4: 81 45        	li	a1, 0
80203ad6: b2 86        	mv	a3, a2
80203ad8: 29 a0        	j	0x80203ae2 <.LBB266_24+0x6c>
80203ada: 85 45        	li	a1, 1
80203adc: aa 86        	mv	a3, a0
80203ade: 11 a0        	j	0x80203ae2 <.LBB266_24+0x6c>
80203ae0: 85 45        	li	a1, 1
80203ae2: 2e 85        	mv	a0, a1
80203ae4: b6 85        	mv	a1, a3
80203ae6: a2 60        	ld	ra, 8(sp)
80203ae8: 41 01        	addi	sp, sp, 16
80203aea: 82 80        	ret

0000000080203aec <.LBB266_25>:
80203aec: 97 36 04 00  	auipc	a3, 67
80203af0: 93 86 c6 47  	addi	a3, a3, 1148
80203af4: b2 85        	mv	a1, a2
80203af6: 36 86        	mv	a2, a3
80203af8: 97 00 00 00  	auipc	ra, 0
80203afc: e7 80 a0 00  	jalr	10(ra)
80203b00: 00 00        	unimp	

Disassembly of section .text.unlikely._ZN4core5slice5index26slice_start_index_len_fail17hdcd879eec8619ea3E:

0000000080203b02 <_ZN4core5slice5index26slice_start_index_len_fail17hdcd879eec8619ea3E>:
80203b02: 41 11        	addi	sp, sp, -16
80203b04: 06 e4        	sd	ra, 8(sp)
80203b06: 97 00 00 00  	auipc	ra, 0
80203b0a: e7 80 a0 00  	jalr	10(ra)
80203b0e: 00 00        	unimp	

Disassembly of section .text._ZN4core5slice5index29slice_start_index_len_fail_rt17h7ca29b4725b4aa4bE:

0000000080203b10 <_ZN4core5slice5index29slice_start_index_len_fail_rt17h7ca29b4725b4aa4bE>:
80203b10: 59 71        	addi	sp, sp, -112
80203b12: 86 f4        	sd	ra, 104(sp)
80203b14: 2a e4        	sd	a0, 8(sp)
80203b16: 2e e8        	sd	a1, 16(sp)
80203b18: 28 00        	addi	a0, sp, 8
80203b1a: aa e4        	sd	a0, 72(sp)

0000000080203b1c <.LBB276_1>:
80203b1c: 17 05 00 00  	auipc	a0, 0
80203b20: 13 05 a5 7d  	addi	a0, a0, 2010
80203b24: aa e8        	sd	a0, 80(sp)
80203b26: 0c 08        	addi	a1, sp, 16
80203b28: ae ec        	sd	a1, 88(sp)
80203b2a: aa f0        	sd	a0, 96(sp)

0000000080203b2c <.LBB276_2>:
80203b2c: 17 35 04 00  	auipc	a0, 67
80203b30: 13 05 c5 48  	addi	a0, a0, 1164
80203b34: 2a f4        	sd	a0, 40(sp)
80203b36: 09 45        	li	a0, 2
80203b38: 2a f8        	sd	a0, 48(sp)
80203b3a: 02 ec        	sd	zero, 24(sp)
80203b3c: ac 00        	addi	a1, sp, 72
80203b3e: 2e fc        	sd	a1, 56(sp)
80203b40: aa e0        	sd	a0, 64(sp)
80203b42: 28 08        	addi	a0, sp, 24
80203b44: b2 85        	mv	a1, a2
80203b46: 97 f0 ff ff  	auipc	ra, 1048575
80203b4a: e7 80 e0 0c  	jalr	206(ra)
80203b4e: 00 00        	unimp	

Disassembly of section .text._ZN4core3str8converts9from_utf817h41c2ca4493b63f8bE:

0000000080203b50 <_ZN4core3str8converts9from_utf817h41c2ca4493b63f8bE>:
80203b50: 5d 71        	addi	sp, sp, -80
80203b52: a2 e4        	sd	s0, 72(sp)
80203b54: a6 e0        	sd	s1, 64(sp)
80203b56: 4a fc        	sd	s2, 56(sp)
80203b58: 4e f8        	sd	s3, 48(sp)
80203b5a: 52 f4        	sd	s4, 40(sp)
80203b5c: 56 f0        	sd	s5, 32(sp)
80203b5e: 5a ec        	sd	s6, 24(sp)
80203b60: 5e e8        	sd	s7, 16(sp)
80203b62: 62 e4        	sd	s8, 8(sp)
80203b64: 66 e0        	sd	s9, 0(sp)
80203b66: 93 06 16 ff  	addi	a3, a2, -15
80203b6a: 81 4c        	li	s9, 0
80203b6c: 63 63 d6 00  	bltu	a2, a3, 0x80203b72 <_ZN4core3str8converts9from_utf817h41c2ca4493b63f8bE+0x22>
80203b70: b6 8c        	mv	s9, a3
80203b72: 63 0a 06 1a  	beqz	a2, 0x80203d26 <.LBB288_50+0x19a>
80203b76: 81 46        	li	a3, 0
80203b78: 13 87 75 00  	addi	a4, a1, 7
80203b7c: 61 9b        	andi	a4, a4, -8
80203b7e: 33 08 b7 40  	sub	a6, a4, a1

0000000080203b82 <.LBB288_49>:
80203b82: 17 17 00 00  	auipc	a4, 1
80203b86: 13 07 67 cd  	addi	a4, a4, -810
80203b8a: 1c 63        	ld	a5, 0(a4)

0000000080203b8c <.LBB288_50>:
80203b8c: 97 38 04 00  	auipc	a7, 67
80203b90: 93 88 c8 44  	addi	a7, a7, 1100
80203b94: 91 42        	li	t0, 4
80203b96: 13 03 00 0f  	li	t1, 240
80203b9a: 93 03 00 03  	li	t2, 48
80203b9e: 13 0e f0 fb  	li	t3, -65
80203ba2: 93 0e 40 0f  	li	t4, 244
80203ba6: 13 0f f0 f8  	li	t5, -113
80203baa: 8d 4f        	li	t6, 3
80203bac: 93 0a 00 0e  	li	s5, 224
80203bb0: 13 09 00 fa  	li	s2, -96
80203bb4: 13 0a d0 0e  	li	s4, 237
80203bb8: b1 49        	li	s3, 12
80203bba: 09 4b        	li	s6, 2
80203bbc: 85 4b        	li	s7, 1
80203bbe: 21 a0        	j	0x80203bc6 <.LBB288_50+0x3a>
80203bc0: 85 06        	addi	a3, a3, 1
80203bc2: 63 f2 c6 16  	bgeu	a3, a2, 0x80203d26 <.LBB288_50+0x19a>
80203bc6: 33 87 d5 00  	add	a4, a1, a3
80203bca: 03 44 07 00  	lbu	s0, 0(a4)
80203bce: 13 17 84 03  	slli	a4, s0, 56
80203bd2: 93 54 87 43  	srai	s1, a4, 56
80203bd6: 63 c6 04 04  	bltz	s1, 0x80203c22 <.LBB288_50+0x96>
80203bda: 13 07 18 00  	addi	a4, a6, 1
80203bde: 33 37 e0 00  	snez	a4, a4
80203be2: 3b 04 d8 40  	subw	s0, a6, a3
80203be6: 1d 88        	andi	s0, s0, 7
80203be8: 13 34 14 00  	seqz	s0, s0
80203bec: 61 8f        	and	a4, a4, s0
80203bee: 69 db        	beqz	a4, 0x80203bc0 <.LBB288_50+0x34>
80203bf0: 63 fd 96 01  	bgeu	a3, s9, 0x80203c0a <.LBB288_50+0x7e>
80203bf4: 33 87 d5 00  	add	a4, a1, a3
80203bf8: 00 63        	ld	s0, 0(a4)
80203bfa: 7d 8c        	and	s0, s0, a5
80203bfc: 19 e4        	bnez	s0, 0x80203c0a <.LBB288_50+0x7e>
80203bfe: 18 67        	ld	a4, 8(a4)
80203c00: 7d 8f        	and	a4, a4, a5
80203c02: 01 e7        	bnez	a4, 0x80203c0a <.LBB288_50+0x7e>
80203c04: c1 06        	addi	a3, a3, 16
80203c06: e3 e7 96 ff  	bltu	a3, s9, 0x80203bf4 <.LBB288_50+0x68>
80203c0a: 63 fc c6 10  	bgeu	a3, a2, 0x80203d22 <.LBB288_50+0x196>
80203c0e: 33 87 d5 00  	add	a4, a1, a3
80203c12: 03 07 07 00  	lb	a4, 0(a4)
80203c16: 63 46 07 10  	bltz	a4, 0x80203d22 <.LBB288_50+0x196>
80203c1a: 85 06        	addi	a3, a3, 1
80203c1c: e3 19 d6 fe  	bne	a2, a3, 0x80203c0e <.LBB288_50+0x82>
80203c20: 19 a2        	j	0x80203d26 <.LBB288_50+0x19a>
80203c22: 33 87 88 00  	add	a4, a7, s0
80203c26: 03 47 07 00  	lbu	a4, 0(a4)
80203c2a: 63 02 57 02  	beq	a4, t0, 0x80203c4e <.LBB288_50+0xc2>
80203c2e: 63 0e f7 03  	beq	a4, t6, 0x80203c6a <.LBB288_50+0xde>
80203c32: 63 1d 67 11  	bne	a4, s6, 0x80203d4c <.LBB288_50+0x1c0>
80203c36: 13 84 16 00  	addi	s0, a3, 1
80203c3a: 63 76 c4 10  	bgeu	s0, a2, 0x80203d46 <.LBB288_50+0x1ba>
80203c3e: 33 87 85 00  	add	a4, a1, s0
80203c42: 03 07 07 00  	lb	a4, 0(a4)
80203c46: 85 44        	li	s1, 1
80203c48: 63 5b ee 0c  	bge	t3, a4, 0x80203d1e <.LBB288_50+0x192>
80203c4c: 29 a2        	j	0x80203d56 <.LBB288_50+0x1ca>
80203c4e: 13 87 16 00  	addi	a4, a3, 1
80203c52: 63 7c c7 0e  	bgeu	a4, a2, 0x80203d4a <.LBB288_50+0x1be>
80203c56: 2e 97        	add	a4, a4, a1
80203c58: 03 0c 07 00  	lb	s8, 0(a4)
80203c5c: 63 05 64 02  	beq	s0, t1, 0x80203c86 <.LBB288_50+0xfa>
80203c60: 63 1a d4 03  	bne	s0, t4, 0x80203c94 <.LBB288_50+0x108>
80203c64: 63 55 8f 05  	bge	t5, s8, 0x80203cae <.LBB288_50+0x122>
80203c68: d5 a0        	j	0x80203d4c <.LBB288_50+0x1c0>
80203c6a: 13 87 16 00  	addi	a4, a3, 1
80203c6e: 63 7e c7 0c  	bgeu	a4, a2, 0x80203d4a <.LBB288_50+0x1be>
80203c72: 2e 97        	add	a4, a4, a1
80203c74: 03 0c 07 00  	lb	s8, 0(a4)
80203c78: 63 0f 54 05  	beq	s0, s5, 0x80203cd6 <.LBB288_50+0x14a>
80203c7c: 63 12 44 07  	bne	s0, s4, 0x80203ce0 <.LBB288_50+0x154>
80203c80: 63 45 2c 09  	blt	s8, s2, 0x80203d0a <.LBB288_50+0x17e>
80203c84: e1 a0        	j	0x80203d4c <.LBB288_50+0x1c0>
80203c86: 1b 07 0c 07  	addiw	a4, s8, 112
80203c8a: 13 77 f7 0f  	andi	a4, a4, 255
80203c8e: 63 60 77 02  	bltu	a4, t2, 0x80203cae <.LBB288_50+0x122>
80203c92: 6d a8        	j	0x80203d4c <.LBB288_50+0x1c0>
80203c94: 1b 87 f4 00  	addiw	a4, s1, 15
80203c98: 13 77 f7 0f  	andi	a4, a4, 255
80203c9c: 13 37 37 00  	sltiu	a4, a4, 3
80203ca0: 13 24 0c 00  	slti	s0, s8, 0
80203ca4: 61 8f        	and	a4, a4, s0
80203ca6: 13 34 0c fc  	sltiu	s0, s8, -64
80203caa: 61 8f        	and	a4, a4, s0
80203cac: 45 c3        	beqz	a4, 0x80203d4c <.LBB288_50+0x1c0>
80203cae: 13 87 26 00  	addi	a4, a3, 2
80203cb2: 63 7a c7 08  	bgeu	a4, a2, 0x80203d46 <.LBB288_50+0x1ba>
80203cb6: 2e 97        	add	a4, a4, a1
80203cb8: 03 07 07 00  	lb	a4, 0(a4)
80203cbc: 63 4a ee 08  	blt	t3, a4, 0x80203d50 <.LBB288_50+0x1c4>
80203cc0: 13 84 36 00  	addi	s0, a3, 3
80203cc4: 63 71 c4 08  	bgeu	s0, a2, 0x80203d46 <.LBB288_50+0x1ba>
80203cc8: 33 87 85 00  	add	a4, a1, s0
80203ccc: 03 07 07 00  	lb	a4, 0(a4)
80203cd0: 63 57 ee 04  	bge	t3, a4, 0x80203d1e <.LBB288_50+0x192>
80203cd4: 41 a0        	j	0x80203d54 <.LBB288_50+0x1c8>
80203cd6: 13 77 0c fe  	andi	a4, s8, -32
80203cda: 63 08 27 03  	beq	a4, s2, 0x80203d0a <.LBB288_50+0x17e>
80203cde: bd a0        	j	0x80203d4c <.LBB288_50+0x1c0>
80203ce0: 1b 87 f4 01  	addiw	a4, s1, 31
80203ce4: 13 77 f7 0f  	andi	a4, a4, 255
80203ce8: 63 75 37 01  	bgeu	a4, s3, 0x80203cf2 <.LBB288_50+0x166>
80203cec: 63 5f 8e 01  	bge	t3, s8, 0x80203d0a <.LBB288_50+0x17e>
80203cf0: b1 a8        	j	0x80203d4c <.LBB288_50+0x1c0>
80203cf2: 13 f7 e4 ff  	andi	a4, s1, -2
80203cf6: 49 07        	addi	a4, a4, 18
80203cf8: 13 37 17 00  	seqz	a4, a4
80203cfc: 13 24 0c 00  	slti	s0, s8, 0
80203d00: 61 8f        	and	a4, a4, s0
80203d02: 13 34 0c fc  	sltiu	s0, s8, -64
80203d06: 61 8f        	and	a4, a4, s0
80203d08: 31 c3        	beqz	a4, 0x80203d4c <.LBB288_50+0x1c0>
80203d0a: 13 84 26 00  	addi	s0, a3, 2
80203d0e: 63 7c c4 02  	bgeu	s0, a2, 0x80203d46 <.LBB288_50+0x1ba>
80203d12: 33 87 85 00  	add	a4, a1, s0
80203d16: 03 07 07 00  	lb	a4, 0(a4)
80203d1a: 63 4b ee 02  	blt	t3, a4, 0x80203d50 <.LBB288_50+0x1c4>
80203d1e: 93 06 14 00  	addi	a3, s0, 1
80203d22: e3 e2 c6 ea  	bltu	a3, a2, 0x80203bc6 <.LBB288_50+0x3a>
80203d26: 81 46        	li	a3, 0
80203d28: 0c e5        	sd	a1, 8(a0)
80203d2a: 10 e9        	sd	a2, 16(a0)
80203d2c: 14 e1        	sd	a3, 0(a0)
80203d2e: 26 64        	ld	s0, 72(sp)
80203d30: 86 64        	ld	s1, 64(sp)
80203d32: 62 79        	ld	s2, 56(sp)
80203d34: c2 79        	ld	s3, 48(sp)
80203d36: 22 7a        	ld	s4, 40(sp)
80203d38: 82 7a        	ld	s5, 32(sp)
80203d3a: 62 6b        	ld	s6, 24(sp)
80203d3c: c2 6b        	ld	s7, 16(sp)
80203d3e: 22 6c        	ld	s8, 8(sp)
80203d40: 82 6c        	ld	s9, 0(sp)
80203d42: 61 61        	addi	sp, sp, 80
80203d44: 82 80        	ret
80203d46: 81 4b        	li	s7, 0
80203d48: 39 a0        	j	0x80203d56 <.LBB288_50+0x1ca>
80203d4a: 81 4b        	li	s7, 0
80203d4c: 85 44        	li	s1, 1
80203d4e: 21 a0        	j	0x80203d56 <.LBB288_50+0x1ca>
80203d50: 89 44        	li	s1, 2
80203d52: 11 a0        	j	0x80203d56 <.LBB288_50+0x1ca>
80203d54: 8d 44        	li	s1, 3
80203d56: 14 e5        	sd	a3, 8(a0)
80203d58: 23 08 75 01  	sb	s7, 16(a0)
80203d5c: a3 08 95 00  	sb	s1, 17(a0)
80203d60: 85 46        	li	a3, 1
80203d62: e9 b7        	j	0x80203d2c <.LBB288_50+0x1a0>

Disassembly of section .text._ZN4core3str5count14do_count_chars17h75bffc8ce7e643c7E:

0000000080203d64 <_ZN4core3str5count14do_count_chars17h75bffc8ce7e643c7E>:
80203d64: 2a 86        	mv	a2, a0
80203d66: 1d 05        	addi	a0, a0, 7
80203d68: 13 77 85 ff  	andi	a4, a0, -8
80203d6c: b3 08 c7 40  	sub	a7, a4, a2
80203d70: 63 ec 15 01  	bltu	a1, a7, 0x80203d88 <_ZN4core3str5count14do_count_chars17h75bffc8ce7e643c7E+0x24>
80203d74: 33 88 15 41  	sub	a6, a1, a7
80203d78: 13 35 88 00  	sltiu	a0, a6, 8
80203d7c: 93 b7 98 00  	sltiu	a5, a7, 9
80203d80: 93 c7 17 00  	xori	a5, a5, 1
80203d84: 5d 8d        	or	a0, a0, a5
80203d86: 11 cd        	beqz	a0, 0x80203da2 <_ZN4core3str5count14do_count_chars17h75bffc8ce7e643c7E+0x3e>
80203d88: 01 45        	li	a0, 0
80203d8a: 99 c9        	beqz	a1, 0x80203da0 <_ZN4core3str5count14do_count_chars17h75bffc8ce7e643c7E+0x3c>
80203d8c: 83 06 06 00  	lb	a3, 0(a2)
80203d90: 05 06        	addi	a2, a2, 1
80203d92: 93 a6 06 fc  	slti	a3, a3, -64
80203d96: 93 c6 16 00  	xori	a3, a3, 1
80203d9a: fd 15        	addi	a1, a1, -1
80203d9c: 36 95        	add	a0, a0, a3
80203d9e: fd f5        	bnez	a1, 0x80203d8c <_ZN4core3str5count14do_count_chars17h75bffc8ce7e643c7E+0x28>
80203da0: 82 80        	ret
80203da2: 93 75 78 00  	andi	a1, a6, 7
80203da6: 81 47        	li	a5, 0
80203da8: 63 0f c7 00  	beq	a4, a2, 0x80203dc6 <_ZN4core3str5count14do_count_chars17h75bffc8ce7e643c7E+0x62>
80203dac: 33 07 e6 40  	sub	a4, a2, a4
80203db0: 32 85        	mv	a0, a2
80203db2: 83 06 05 00  	lb	a3, 0(a0)
80203db6: 05 05        	addi	a0, a0, 1
80203db8: 93 a6 06 fc  	slti	a3, a3, -64
80203dbc: 93 c6 16 00  	xori	a3, a3, 1
80203dc0: 05 07        	addi	a4, a4, 1
80203dc2: b6 97        	add	a5, a5, a3
80203dc4: 7d f7        	bnez	a4, 0x80203db2 <_ZN4core3str5count14do_count_chars17h75bffc8ce7e643c7E+0x4e>
80203dc6: b3 02 16 01  	add	t0, a2, a7
80203dca: 01 46        	li	a2, 0
80203dcc: 99 cd        	beqz	a1, 0x80203dea <_ZN4core3str5count14do_count_chars17h75bffc8ce7e643c7E+0x86>
80203dce: 13 75 88 ff  	andi	a0, a6, -8
80203dd2: b3 86 a2 00  	add	a3, t0, a0
80203dd6: 03 85 06 00  	lb	a0, 0(a3)
80203dda: 85 06        	addi	a3, a3, 1
80203ddc: 13 25 05 fc  	slti	a0, a0, -64
80203de0: 13 45 15 00  	xori	a0, a0, 1
80203de4: fd 15        	addi	a1, a1, -1
80203de6: 2a 96        	add	a2, a2, a0
80203de8: fd f5        	bnez	a1, 0x80203dd6 <_ZN4core3str5count14do_count_chars17h75bffc8ce7e643c7E+0x72>
80203dea: 13 57 38 00  	srli	a4, a6, 3

0000000080203dee <.LBB290_27>:
80203dee: 17 15 00 00  	auipc	a0, 1
80203df2: 13 05 a5 a7  	addi	a0, a0, -1414
80203df6: 03 3f 05 00  	ld	t5, 0(a0)

0000000080203dfa <.LBB290_28>:
80203dfa: 17 15 00 00  	auipc	a0, 1
80203dfe: 13 05 65 a7  	addi	a0, a0, -1418
80203e02: 83 38 05 00  	ld	a7, 0(a0)
80203e06: 37 15 00 10  	lui	a0, 65537
80203e0a: 12 05        	slli	a0, a0, 4
80203e0c: 05 05        	addi	a0, a0, 1
80203e0e: 42 05        	slli	a0, a0, 16
80203e10: 13 08 15 00  	addi	a6, a0, 1
80203e14: 33 05 f6 00  	add	a0, a2, a5
80203e18: 25 a0        	j	0x80203e40 <.LBB290_28+0x46>
80203e1a: 13 16 3e 00  	slli	a2, t3, 3
80203e1e: b3 02 c3 00  	add	t0, t1, a2
80203e22: 33 87 c3 41  	sub	a4, t2, t3
80203e26: 13 76 3e 00  	andi	a2, t3, 3
80203e2a: b3 f6 15 01  	and	a3, a1, a7
80203e2e: a1 81        	srli	a1, a1, 8
80203e30: b3 f5 15 01  	and	a1, a1, a7
80203e34: b6 95        	add	a1, a1, a3
80203e36: b3 85 05 03  	mul	a1, a1, a6
80203e3a: c1 91        	srli	a1, a1, 48
80203e3c: 2e 95        	add	a0, a0, a1
80203e3e: 41 e2        	bnez	a2, 0x80203ebe <.LBB290_28+0xc4>
80203e40: 25 d3        	beqz	a4, 0x80203da0 <_ZN4core3str5count14do_count_chars17h75bffc8ce7e643c7E+0x3c>
80203e42: ba 83        	mv	t2, a4
80203e44: 16 83        	mv	t1, t0
80203e46: 93 05 00 0c  	li	a1, 192
80203e4a: 3a 8e        	mv	t3, a4
80203e4c: 63 64 b7 00  	bltu	a4, a1, 0x80203e54 <.LBB290_28+0x5a>
80203e50: 13 0e 00 0c  	li	t3, 192
80203e54: 93 75 ce 0f  	andi	a1, t3, 252
80203e58: 13 96 35 00  	slli	a2, a1, 3
80203e5c: b3 0e c3 00  	add	t4, t1, a2
80203e60: cd dd        	beqz	a1, 0x80203e1a <.LBB290_28+0x20>
80203e62: 81 45        	li	a1, 0
80203e64: 1a 86        	mv	a2, t1
80203e66: 55 da        	beqz	a2, 0x80203e1a <.LBB290_28+0x20>
80203e68: 18 62        	ld	a4, 0(a2)
80203e6a: 93 47 f7 ff  	not	a5, a4
80203e6e: 9d 83        	srli	a5, a5, 7
80203e70: 19 83        	srli	a4, a4, 6
80203e72: 14 66        	ld	a3, 8(a2)
80203e74: 5d 8f        	or	a4, a4, a5
80203e76: 33 77 e7 01  	and	a4, a4, t5
80203e7a: ba 95        	add	a1, a1, a4
80203e7c: 13 c7 f6 ff  	not	a4, a3
80203e80: 1d 83        	srli	a4, a4, 7
80203e82: 99 82        	srli	a3, a3, 6
80203e84: 1c 6a        	ld	a5, 16(a2)
80203e86: d9 8e        	or	a3, a3, a4
80203e88: b3 f6 e6 01  	and	a3, a3, t5
80203e8c: b6 95        	add	a1, a1, a3
80203e8e: 93 c6 f7 ff  	not	a3, a5
80203e92: 9d 82        	srli	a3, a3, 7
80203e94: 13 d7 67 00  	srli	a4, a5, 6
80203e98: 1c 6e        	ld	a5, 24(a2)
80203e9a: d9 8e        	or	a3, a3, a4
80203e9c: b3 f6 e6 01  	and	a3, a3, t5
80203ea0: b6 95        	add	a1, a1, a3
80203ea2: 93 c6 f7 ff  	not	a3, a5
80203ea6: 9d 82        	srli	a3, a3, 7
80203ea8: 13 d7 67 00  	srli	a4, a5, 6
80203eac: d9 8e        	or	a3, a3, a4
80203eae: b3 f6 e6 01  	and	a3, a3, t5
80203eb2: 13 06 06 02  	addi	a2, a2, 32
80203eb6: b6 95        	add	a1, a1, a3
80203eb8: e3 17 d6 fb  	bne	a2, t4, 0x80203e66 <.LBB290_28+0x6c>
80203ebc: b9 bf        	j	0x80203e1a <.LBB290_28+0x20>
80203ebe: 63 0a 03 02  	beqz	t1, 0x80203ef2 <.LBB290_28+0xf8>
80203ec2: 93 05 00 0c  	li	a1, 192
80203ec6: 63 e4 b3 00  	bltu	t2, a1, 0x80203ece <.LBB290_28+0xd4>
80203eca: 93 03 00 0c  	li	t2, 192
80203ece: 81 45        	li	a1, 0
80203ed0: 13 f6 33 00  	andi	a2, t2, 3
80203ed4: 0e 06        	slli	a2, a2, 3
80203ed6: 83 b6 0e 00  	ld	a3, 0(t4)
80203eda: a1 0e        	addi	t4, t4, 8
80203edc: 13 c7 f6 ff  	not	a4, a3
80203ee0: 1d 83        	srli	a4, a4, 7
80203ee2: 99 82        	srli	a3, a3, 6
80203ee4: d9 8e        	or	a3, a3, a4
80203ee6: b3 f6 e6 01  	and	a3, a3, t5
80203eea: 61 16        	addi	a2, a2, -8
80203eec: b6 95        	add	a1, a1, a3
80203eee: 65 f6        	bnez	a2, 0x80203ed6 <.LBB290_28+0xdc>
80203ef0: 11 a0        	j	0x80203ef4 <.LBB290_28+0xfa>
80203ef2: 81 45        	li	a1, 0
80203ef4: 33 f6 15 01  	and	a2, a1, a7
80203ef8: a1 81        	srli	a1, a1, 8
80203efa: b3 f5 15 01  	and	a1, a1, a7
80203efe: b2 95        	add	a1, a1, a2
80203f00: b3 85 05 03  	mul	a1, a1, a6
80203f04: c1 91        	srli	a1, a1, 48
80203f06: 2e 95        	add	a0, a0, a1
80203f08: 82 80        	ret

Disassembly of section .text._ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$i64$GT$3fmt17hdf8f6c6faa92793eE:

0000000080203f0a <_ZN4core3fmt3num55_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$usize$GT$3fmt17h6e7d2eee31f3cd74E>:
80203f0a: 75 71        	addi	sp, sp, -144
80203f0c: 06 e5        	sd	ra, 136(sp)
80203f0e: 2e 88        	mv	a6, a1
80203f10: 81 45        	li	a1, 0
80203f12: 18 61        	ld	a4, 0(a0)
80203f14: 93 08 81 00  	addi	a7, sp, 8
80203f18: a9 42        	li	t0, 10
80203f1a: 3d 43        	li	t1, 15
80203f1c: 19 a8        	j	0x80203f32 <_ZN4core3fmt3num55_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$usize$GT$3fmt17h6e7d2eee31f3cd74E+0x28>
80203f1e: b3 86 b8 00  	add	a3, a7, a1
80203f22: 13 57 45 00  	srli	a4, a0, 4
80203f26: 3d 9e        	addw	a2, a2, a5
80203f28: a3 8f c6 06  	sb	a2, 127(a3)
80203f2c: fd 15        	addi	a1, a1, -1
80203f2e: 63 7c a3 00  	bgeu	t1, a0, 0x80203f46 <_ZN4core3fmt3num55_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$usize$GT$3fmt17h6e7d2eee31f3cd74E+0x3c>
80203f32: 3a 85        	mv	a0, a4
80203f34: 93 77 f7 00  	andi	a5, a4, 15
80203f38: 13 06 00 03  	li	a2, 48
80203f3c: e3 e1 57 fe  	bltu	a5, t0, 0x80203f1e <_ZN4core3fmt3num55_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$usize$GT$3fmt17h6e7d2eee31f3cd74E+0x14>
80203f40: 13 06 70 05  	li	a2, 87
80203f44: e9 bf        	j	0x80203f1e <_ZN4core3fmt3num55_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$usize$GT$3fmt17h6e7d2eee31f3cd74E+0x14>
80203f46: 13 85 05 08  	addi	a0, a1, 128
80203f4a: 13 06 10 08  	li	a2, 129
80203f4e: 63 76 c5 02  	bgeu	a0, a2, 0x80203f7a <.LBB555_8>
80203f52: 28 00        	addi	a0, sp, 8
80203f54: 2e 95        	add	a0, a0, a1
80203f56: 13 07 05 08  	addi	a4, a0, 128
80203f5a: b3 07 b0 40  	neg	a5, a1

0000000080203f5e <.LBB555_7>:
80203f5e: 17 36 04 00  	auipc	a2, 67
80203f62: 13 06 a6 f0  	addi	a2, a2, -246
80203f66: 85 45        	li	a1, 1
80203f68: 89 46        	li	a3, 2
80203f6a: 42 85        	mv	a0, a6
80203f6c: 97 f0 ff ff  	auipc	ra, 1048575
80203f70: e7 80 40 53  	jalr	1332(ra)
80203f74: aa 60        	ld	ra, 136(sp)
80203f76: 49 61        	addi	sp, sp, 144
80203f78: 82 80        	ret

0000000080203f7a <.LBB555_8>:
80203f7a: 17 36 04 00  	auipc	a2, 67
80203f7e: 13 06 66 ed  	addi	a2, a2, -298
80203f82: 93 05 00 08  	li	a1, 128
80203f86: 97 00 00 00  	auipc	ra, 0
80203f8a: e7 80 c0 b7  	jalr	-1156(ra)
80203f8e: 00 00        	unimp	

Disassembly of section .text._ZN4core3fmt3num49_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u8$GT$3fmt17hf059cf4dae679fc3E:

0000000080203f90 <_ZN4core3fmt3num49_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u8$GT$3fmt17hf059cf4dae679fc3E>:
80203f90: 75 71        	addi	sp, sp, -144
80203f92: 06 e5        	sd	ra, 136(sp)
80203f94: 2e 88        	mv	a6, a1
80203f96: 83 e5 05 03  	lwu	a1, 48(a1)
80203f9a: 13 f6 05 01  	andi	a2, a1, 16
80203f9e: 11 ee        	bnez	a2, 0x80203fba <_ZN4core3fmt3num49_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u8$GT$3fmt17hf059cf4dae679fc3E+0x2a>
80203fa0: 93 f5 05 02  	andi	a1, a1, 32
80203fa4: b1 e5        	bnez	a1, 0x80203ff0 <_ZN4core3fmt3num49_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u8$GT$3fmt17hf059cf4dae679fc3E+0x60>
80203fa6: 13 75 f5 0f  	andi	a0, a0, 255
80203faa: 85 45        	li	a1, 1
80203fac: 42 86        	mv	a2, a6
80203fae: aa 60        	ld	ra, 136(sp)
80203fb0: 49 61        	addi	sp, sp, 144
80203fb2: 17 03 00 00  	auipc	t1, 0
80203fb6: 67 00 c3 19  	jr	412(t1)
80203fba: 81 45        	li	a1, 0
80203fbc: 93 08 81 00  	addi	a7, sp, 8
80203fc0: a9 42        	li	t0, 10
80203fc2: 3d 43        	li	t1, 15
80203fc4: 29 a8        	j	0x80203fde <_ZN4core3fmt3num49_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u8$GT$3fmt17hf059cf4dae679fc3E+0x4e>
80203fc6: b3 86 b8 00  	add	a3, a7, a1
80203fca: 13 77 f5 0f  	andi	a4, a0, 255
80203fce: 13 55 47 00  	srli	a0, a4, 4
80203fd2: 3d 9e        	addw	a2, a2, a5
80203fd4: a3 8f c6 06  	sb	a2, 127(a3)
80203fd8: fd 15        	addi	a1, a1, -1
80203fda: 63 76 e3 04  	bgeu	t1, a4, 0x80204026 <_ZN4core3fmt3num49_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u8$GT$3fmt17hf059cf4dae679fc3E+0x96>
80203fde: 93 77 f5 00  	andi	a5, a0, 15
80203fe2: 13 06 00 03  	li	a2, 48
80203fe6: e3 e0 57 fe  	bltu	a5, t0, 0x80203fc6 <_ZN4core3fmt3num49_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u8$GT$3fmt17hf059cf4dae679fc3E+0x36>
80203fea: 13 06 70 05  	li	a2, 87
80203fee: e1 bf        	j	0x80203fc6 <_ZN4core3fmt3num49_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u8$GT$3fmt17hf059cf4dae679fc3E+0x36>
80203ff0: 81 45        	li	a1, 0
80203ff2: 93 08 81 00  	addi	a7, sp, 8
80203ff6: a9 42        	li	t0, 10
80203ff8: 3d 43        	li	t1, 15
80203ffa: 29 a8        	j	0x80204014 <_ZN4core3fmt3num49_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u8$GT$3fmt17hf059cf4dae679fc3E+0x84>
80203ffc: b3 86 b8 00  	add	a3, a7, a1
80204000: 13 77 f5 0f  	andi	a4, a0, 255
80204004: 13 55 47 00  	srli	a0, a4, 4
80204008: 3d 9e        	addw	a2, a2, a5
8020400a: a3 8f c6 06  	sb	a2, 127(a3)
8020400e: fd 15        	addi	a1, a1, -1
80204010: 63 7b e3 00  	bgeu	t1, a4, 0x80204026 <_ZN4core3fmt3num49_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u8$GT$3fmt17hf059cf4dae679fc3E+0x96>
80204014: 93 77 f5 00  	andi	a5, a0, 15
80204018: 13 06 00 03  	li	a2, 48
8020401c: e3 e0 57 fe  	bltu	a5, t0, 0x80203ffc <_ZN4core3fmt3num49_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u8$GT$3fmt17hf059cf4dae679fc3E+0x6c>
80204020: 13 06 70 03  	li	a2, 55
80204024: e1 bf        	j	0x80203ffc <_ZN4core3fmt3num49_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u8$GT$3fmt17hf059cf4dae679fc3E+0x6c>
80204026: 13 85 05 08  	addi	a0, a1, 128
8020402a: 13 06 10 08  	li	a2, 129
8020402e: 63 76 c5 02  	bgeu	a0, a2, 0x8020405a <.LBB565_15>
80204032: 28 00        	addi	a0, sp, 8
80204034: 2e 95        	add	a0, a0, a1
80204036: 13 07 05 08  	addi	a4, a0, 128
8020403a: b3 07 b0 40  	neg	a5, a1

000000008020403e <.LBB565_14>:
8020403e: 17 36 04 00  	auipc	a2, 67
80204042: 13 06 a6 e2  	addi	a2, a2, -470
80204046: 85 45        	li	a1, 1
80204048: 89 46        	li	a3, 2
8020404a: 42 85        	mv	a0, a6
8020404c: 97 f0 ff ff  	auipc	ra, 1048575
80204050: e7 80 40 45  	jalr	1108(ra)
80204054: aa 60        	ld	ra, 136(sp)
80204056: 49 61        	addi	sp, sp, 144
80204058: 82 80        	ret

000000008020405a <.LBB565_15>:
8020405a: 17 36 04 00  	auipc	a2, 67
8020405e: 13 06 66 df  	addi	a2, a2, -522
80204062: 93 05 00 08  	li	a1, 128
80204066: 97 00 00 00  	auipc	ra, 0
8020406a: e7 80 c0 a9  	jalr	-1380(ra)
8020406e: 00 00        	unimp	

Disassembly of section .text._ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17h7d8d90efa1f76e4dE:

0000000080204070 <_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17h7d8d90efa1f76e4dE>:
80204070: 75 71        	addi	sp, sp, -144
80204072: 06 e5        	sd	ra, 136(sp)
80204074: 2e 88        	mv	a6, a1
80204076: 83 e5 05 03  	lwu	a1, 48(a1)
8020407a: 13 f6 05 01  	andi	a2, a1, 16
8020407e: 09 ee        	bnez	a2, 0x80204098 <_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17h7d8d90efa1f76e4dE+0x28>
80204080: 93 f5 05 02  	andi	a1, a1, 32
80204084: a9 e5        	bnez	a1, 0x802040ce <_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17h7d8d90efa1f76e4dE+0x5e>
80204086: 08 61        	ld	a0, 0(a0)
80204088: 85 45        	li	a1, 1
8020408a: 42 86        	mv	a2, a6
8020408c: aa 60        	ld	ra, 136(sp)
8020408e: 49 61        	addi	sp, sp, 144
80204090: 17 03 00 00  	auipc	t1, 0
80204094: 67 00 e3 0b  	jr	190(t1)
80204098: 81 45        	li	a1, 0
8020409a: 18 61        	ld	a4, 0(a0)
8020409c: 93 08 81 00  	addi	a7, sp, 8
802040a0: a9 42        	li	t0, 10
802040a2: 3d 43        	li	t1, 15
802040a4: 19 a8        	j	0x802040ba <_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17h7d8d90efa1f76e4dE+0x4a>
802040a6: b3 86 b8 00  	add	a3, a7, a1
802040aa: 13 57 45 00  	srli	a4, a0, 4
802040ae: 3d 9e        	addw	a2, a2, a5
802040b0: a3 8f c6 06  	sb	a2, 127(a3)
802040b4: fd 15        	addi	a1, a1, -1
802040b6: 63 77 a3 04  	bgeu	t1, a0, 0x80204104 <_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17h7d8d90efa1f76e4dE+0x94>
802040ba: 3a 85        	mv	a0, a4
802040bc: 93 77 f7 00  	andi	a5, a4, 15
802040c0: 13 06 00 03  	li	a2, 48
802040c4: e3 e1 57 fe  	bltu	a5, t0, 0x802040a6 <_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17h7d8d90efa1f76e4dE+0x36>
802040c8: 13 06 70 05  	li	a2, 87
802040cc: e9 bf        	j	0x802040a6 <_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17h7d8d90efa1f76e4dE+0x36>
802040ce: 81 45        	li	a1, 0
802040d0: 18 61        	ld	a4, 0(a0)
802040d2: 93 08 81 00  	addi	a7, sp, 8
802040d6: a9 42        	li	t0, 10
802040d8: 3d 43        	li	t1, 15
802040da: 19 a8        	j	0x802040f0 <_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17h7d8d90efa1f76e4dE+0x80>
802040dc: b3 86 b8 00  	add	a3, a7, a1
802040e0: 13 57 45 00  	srli	a4, a0, 4
802040e4: 3d 9e        	addw	a2, a2, a5
802040e6: a3 8f c6 06  	sb	a2, 127(a3)
802040ea: fd 15        	addi	a1, a1, -1
802040ec: 63 7c a3 00  	bgeu	t1, a0, 0x80204104 <_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17h7d8d90efa1f76e4dE+0x94>
802040f0: 3a 85        	mv	a0, a4
802040f2: 93 77 f7 00  	andi	a5, a4, 15
802040f6: 13 06 00 03  	li	a2, 48
802040fa: e3 e1 57 fe  	bltu	a5, t0, 0x802040dc <_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17h7d8d90efa1f76e4dE+0x6c>
802040fe: 13 06 70 03  	li	a2, 55
80204102: e9 bf        	j	0x802040dc <_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17h7d8d90efa1f76e4dE+0x6c>
80204104: 13 85 05 08  	addi	a0, a1, 128
80204108: 13 06 10 08  	li	a2, 129
8020410c: 63 76 c5 02  	bgeu	a0, a2, 0x80204138 <.LBB569_15>
80204110: 28 00        	addi	a0, sp, 8
80204112: 2e 95        	add	a0, a0, a1
80204114: 13 07 05 08  	addi	a4, a0, 128
80204118: b3 07 b0 40  	neg	a5, a1

000000008020411c <.LBB569_14>:
8020411c: 17 36 04 00  	auipc	a2, 67
80204120: 13 06 c6 d4  	addi	a2, a2, -692
80204124: 85 45        	li	a1, 1
80204126: 89 46        	li	a3, 2
80204128: 42 85        	mv	a0, a6
8020412a: 97 f0 ff ff  	auipc	ra, 1048575
8020412e: e7 80 60 37  	jalr	886(ra)
80204132: aa 60        	ld	ra, 136(sp)
80204134: 49 61        	addi	sp, sp, 144
80204136: 82 80        	ret

0000000080204138 <.LBB569_15>:
80204138: 17 36 04 00  	auipc	a2, 67
8020413c: 13 06 86 d1  	addi	a2, a2, -744
80204140: 93 05 00 08  	li	a1, 128
80204144: 97 00 00 00  	auipc	ra, 0
80204148: e7 80 e0 9b  	jalr	-1602(ra)
8020414c: 00 00        	unimp	

Disassembly of section .text._ZN4core3fmt3num3imp7fmt_u6417h2bebad4dea13b624E:

000000008020414e <_ZN4core3fmt3num3imp7fmt_u6417h2bebad4dea13b624E>:
8020414e: 39 71        	addi	sp, sp, -64
80204150: 06 fc        	sd	ra, 56(sp)
80204152: 22 f8        	sd	s0, 48(sp)
80204154: 26 f4        	sd	s1, 40(sp)
80204156: 32 88        	mv	a6, a2
80204158: 93 56 45 00  	srli	a3, a0, 4
8020415c: 13 07 70 02  	li	a4, 39
80204160: 93 07 10 27  	li	a5, 625

0000000080204164 <.LBB570_10>:
80204164: 97 3e 04 00  	auipc	t4, 67
80204168: 93 8e 6e d0  	addi	t4, t4, -762
8020416c: 63 f3 f6 02  	bgeu	a3, a5, 0x80204192 <.LBB570_10+0x2e>
80204170: 93 06 30 06  	li	a3, 99
80204174: 63 e9 a6 0a  	bltu	a3, a0, 0x80204226 <.LBB570_11+0x92>
80204178: 29 46        	li	a2, 10
8020417a: 63 77 c5 0e  	bgeu	a0, a2, 0x80204268 <.LBB570_11+0xd4>
8020417e: 93 06 f7 ff  	addi	a3, a4, -1
80204182: 13 06 11 00  	addi	a2, sp, 1
80204186: 36 96        	add	a2, a2, a3
80204188: 1b 05 05 03  	addiw	a0, a0, 48
8020418c: 23 00 a6 00  	sb	a0, 0(a2)
80204190: dd a8        	j	0x80204286 <.LBB570_11+0xf2>
80204192: 01 47        	li	a4, 0

0000000080204194 <.LBB570_11>:
80204194: 97 06 00 00  	auipc	a3, 0
80204198: 93 86 46 74  	addi	a3, a3, 1860
8020419c: 83 b8 06 00  	ld	a7, 0(a3)
802041a0: 89 66        	lui	a3, 2
802041a2: 9b 83 06 71  	addiw	t2, a3, 1808
802041a6: 85 66        	lui	a3, 1
802041a8: 1b 8e b6 47  	addiw	t3, a3, 1147
802041ac: 93 02 40 06  	li	t0, 100
802041b0: 13 03 11 00  	addi	t1, sp, 1
802041b4: b7 e6 f5 05  	lui	a3, 24414
802041b8: 1b 8f f6 0f  	addiw	t5, a3, 255
802041bc: aa 87        	mv	a5, a0
802041be: 33 35 15 03  	mulhu	a0, a0, a7
802041c2: 2d 81        	srli	a0, a0, 11
802041c4: 3b 06 75 02  	mulw	a2, a0, t2
802041c8: 3b 86 c7 40  	subw	a2, a5, a2
802041cc: 93 16 06 03  	slli	a3, a2, 48
802041d0: c9 92        	srli	a3, a3, 50
802041d2: b3 86 c6 03  	mul	a3, a3, t3
802041d6: 93 df 16 01  	srli	t6, a3, 17
802041da: c1 82        	srli	a3, a3, 16
802041dc: 13 f4 e6 7f  	andi	s0, a3, 2046
802041e0: bb 86 5f 02  	mulw	a3, t6, t0
802041e4: 15 9e        	subw	a2, a2, a3
802041e6: 46 16        	slli	a2, a2, 49
802041e8: 41 92        	srli	a2, a2, 48
802041ea: b3 86 8e 00  	add	a3, t4, s0
802041ee: 33 04 e3 00  	add	s0, t1, a4
802041f2: 83 cf 06 00  	lbu	t6, 0(a3)
802041f6: 83 86 16 00  	lb	a3, 1(a3)
802041fa: 76 96        	add	a2, a2, t4
802041fc: 83 04 16 00  	lb	s1, 1(a2)
80204200: 03 46 06 00  	lbu	a2, 0(a2)
80204204: 23 02 d4 02  	sb	a3, 36(s0)
80204208: a3 01 f4 03  	sb	t6, 35(s0)
8020420c: 23 03 94 02  	sb	s1, 38(s0)
80204210: a3 02 c4 02  	sb	a2, 37(s0)
80204214: 71 17        	addi	a4, a4, -4
80204216: e3 63 ff fa  	bltu	t5, a5, 0x802041bc <.LBB570_11+0x28>
8020421a: 13 07 77 02  	addi	a4, a4, 39
8020421e: 93 06 30 06  	li	a3, 99
80204222: e3 fb a6 f4  	bgeu	a3, a0, 0x80204178 <.LBB570_10+0x14>
80204226: 13 16 05 03  	slli	a2, a0, 48
8020422a: 49 92        	srli	a2, a2, 50
8020422c: 85 66        	lui	a3, 1
8020422e: 9b 86 b6 47  	addiw	a3, a3, 1147
80204232: 33 06 d6 02  	mul	a2, a2, a3
80204236: 45 82        	srli	a2, a2, 17
80204238: 93 06 40 06  	li	a3, 100
8020423c: bb 06 d6 02  	mulw	a3, a2, a3
80204240: 15 9d        	subw	a0, a0, a3
80204242: 46 15        	slli	a0, a0, 49
80204244: 41 91        	srli	a0, a0, 48
80204246: 79 17        	addi	a4, a4, -2
80204248: 76 95        	add	a0, a0, t4
8020424a: 83 06 15 00  	lb	a3, 1(a0)
8020424e: 03 45 05 00  	lbu	a0, 0(a0)
80204252: 93 07 11 00  	addi	a5, sp, 1
80204256: ba 97        	add	a5, a5, a4
80204258: a3 80 d7 00  	sb	a3, 1(a5)
8020425c: 23 80 a7 00  	sb	a0, 0(a5)
80204260: 32 85        	mv	a0, a2
80204262: 29 46        	li	a2, 10
80204264: e3 6d c5 f0  	bltu	a0, a2, 0x8020417e <.LBB570_10+0x1a>
80204268: 06 05        	slli	a0, a0, 1
8020426a: 93 06 e7 ff  	addi	a3, a4, -2
8020426e: 76 95        	add	a0, a0, t4
80204270: 03 06 15 00  	lb	a2, 1(a0)
80204274: 03 45 05 00  	lbu	a0, 0(a0)
80204278: 13 07 11 00  	addi	a4, sp, 1
8020427c: 36 97        	add	a4, a4, a3
8020427e: a3 00 c7 00  	sb	a2, 1(a4)
80204282: 23 00 a7 00  	sb	a0, 0(a4)
80204286: 13 05 11 00  	addi	a0, sp, 1
8020428a: 33 07 d5 00  	add	a4, a0, a3
8020428e: 13 05 70 02  	li	a0, 39
80204292: b3 07 d5 40  	sub	a5, a0, a3

0000000080204296 <.LBB570_12>:
80204296: 17 36 04 00  	auipc	a2, 67
8020429a: 13 06 26 a4  	addi	a2, a2, -1470
8020429e: 42 85        	mv	a0, a6
802042a0: 81 46        	li	a3, 0
802042a2: 97 f0 ff ff  	auipc	ra, 1048575
802042a6: e7 80 e0 1f  	jalr	510(ra)
802042aa: e2 70        	ld	ra, 56(sp)
802042ac: 42 74        	ld	s0, 48(sp)
802042ae: a2 74        	ld	s1, 40(sp)
802042b0: 21 61        	addi	sp, sp, 64
802042b2: 82 80        	ret

Disassembly of section .text._ZN4core3fmt3num3imp51_$LT$impl$u20$core..fmt..Display$u20$for$u20$u8$GT$3fmt17h93332490606bba67E:

00000000802042b4 <_ZN4core3fmt3num3imp51_$LT$impl$u20$core..fmt..Display$u20$for$u20$u8$GT$3fmt17h93332490606bba67E>:
802042b4: 03 45 05 00  	lbu	a0, 0(a0)
802042b8: 2e 86        	mv	a2, a1
802042ba: 85 45        	li	a1, 1
802042bc: 17 03 00 00  	auipc	t1, 0
802042c0: 67 00 23 e9  	jr	-366(t1)

Disassembly of section .text._ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$i32$GT$3fmt17hf957be9b21bfb453E:

00000000802042c4 <_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$i32$GT$3fmt17hf957be9b21bfb453E>:
802042c4: 03 65 05 00  	lwu	a0, 0(a0)
802042c8: 2e 86        	mv	a2, a1
802042ca: 9b 06 05 00  	sext.w	a3, a0
802042ce: 93 a5 06 00  	slti	a1, a3, 0
802042d2: 93 c5 15 00  	xori	a1, a1, 1
802042d6: 63 d4 06 00  	bgez	a3, 0x802042de <_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$i32$GT$3fmt17hf957be9b21bfb453E+0x1a>
802042da: 33 05 d0 40  	neg	a0, a3
802042de: 17 03 00 00  	auipc	t1, 0
802042e2: 67 00 03 e7  	jr	-400(t1)

Disassembly of section .text._ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h518678af98a1949fE:

00000000802042e6 <_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h518678af98a1949fE>:
802042e6: 03 65 05 00  	lwu	a0, 0(a0)
802042ea: 2e 86        	mv	a2, a1
802042ec: 85 45        	li	a1, 1
802042ee: 17 03 00 00  	auipc	t1, 0
802042f2: 67 00 03 e6  	jr	-416(t1)

Disassembly of section .text._ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u64$GT$3fmt17h77ff5d762b7f8e58E:

00000000802042f6 <_ZN4core3fmt3num3imp54_$LT$impl$u20$core..fmt..Display$u20$for$u20$usize$GT$3fmt17hadb5d59c0aa64a0cE>:
802042f6: 08 61        	ld	a0, 0(a0)
802042f8: 2e 86        	mv	a2, a1
802042fa: 85 45        	li	a1, 1
802042fc: 17 03 00 00  	auipc	t1, 0
80204300: 67 00 23 e5  	jr	-430(t1)

Disassembly of section .text._ZN53_$LT$core..fmt..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h036960996838d966E:

0000000080204304 <_ZN53_$LT$core..fmt..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h036960996838d966E>:
80204304: 90 65        	ld	a2, 8(a1)
80204306: 88 61        	ld	a0, 0(a1)
80204308: 1c 6e        	ld	a5, 24(a2)

000000008020430a <.LBB602_1>:
8020430a: 97 35 04 00  	auipc	a1, 67
8020430e: 93 85 e5 dc  	addi	a1, a1, -562
80204312: 15 46        	li	a2, 5
80204314: 82 87        	jr	a5

Disassembly of section .text._ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h080b833ce0f5925fE:

0000000080204316 <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h080b833ce0f5925fE>:
80204316: 08 61        	ld	a0, 0(a0)
80204318: 03 05 05 00  	lb	a0, 0(a0)
8020431c: 17 03 00 00  	auipc	t1, 0
80204320: 67 00 43 c7  	jr	-908(t1)

Disassembly of section .text._ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h2dd2fbac7a8df1f0E:

0000000080204324 <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h2dd2fbac7a8df1f0E>:
80204324: 39 71        	addi	sp, sp, -64
80204326: 06 fc        	sd	ra, 56(sp)
80204328: 22 f8        	sd	s0, 48(sp)
8020432a: 26 f4        	sd	s1, 40(sp)
8020432c: 08 61        	ld	a0, 0(a0)
8020432e: 03 46 05 00  	lbu	a2, 0(a0)
80204332: 2e 84        	mv	s0, a1
80204334: 49 ce        	beqz	a2, 0x802043ce <.LBB621_13+0x1e>
80204336: 0c 64        	ld	a1, 8(s0)
80204338: 05 05        	addi	a0, a0, 1
8020433a: 2a e4        	sd	a0, 8(sp)
8020433c: 08 60        	ld	a0, 0(s0)
8020433e: 94 6d        	ld	a3, 24(a1)

0000000080204340 <.LBB621_10>:
80204340: 97 25 04 00  	auipc	a1, 66
80204344: 93 85 a5 00  	addi	a1, a1, 10
80204348: 11 46        	li	a2, 4
8020434a: 82 96        	jalr	a3
8020434c: 22 ec        	sd	s0, 24(sp)
8020434e: 23 00 a1 02  	sb	a0, 32(sp)
80204352: 02 e8        	sd	zero, 16(sp)
80204354: a3 00 01 02  	sb	zero, 33(sp)

0000000080204358 <.LBB621_11>:
80204358: 17 36 04 00  	auipc	a2, 67
8020435c: 13 06 86 ab  	addi	a2, a2, -1352
80204360: 08 08        	addi	a0, sp, 16
80204362: 2c 00        	addi	a1, sp, 8
80204364: 97 f0 ff ff  	auipc	ra, 1048575
80204368: e7 80 40 c6  	jalr	-924(ra)
8020436c: 42 65        	ld	a0, 16(sp)
8020436e: 83 45 01 02  	lbu	a1, 32(sp)
80204372: 39 c5        	beqz	a0, 0x802043c0 <.LBB621_13+0x10>
80204374: 05 44        	li	s0, 1
80204376: a1 e5        	bnez	a1, 0x802043be <.LBB621_13+0xe>
80204378: 83 45 11 02  	lbu	a1, 33(sp)
8020437c: 7d 15        	addi	a0, a0, -1
8020437e: 13 35 15 00  	seqz	a0, a0
80204382: e2 64        	ld	s1, 24(sp)
80204384: b3 35 b0 00  	snez	a1, a1
80204388: 6d 8d        	and	a0, a0, a1
8020438a: 05 c1        	beqz	a0, 0x802043aa <.LBB621_12+0x10>
8020438c: 03 c5 04 03  	lbu	a0, 48(s1)
80204390: 11 89        	andi	a0, a0, 4
80204392: 01 ed        	bnez	a0, 0x802043aa <.LBB621_12+0x10>
80204394: 8c 64        	ld	a1, 8(s1)
80204396: 88 60        	ld	a0, 0(s1)
80204398: 94 6d        	ld	a3, 24(a1)

000000008020439a <.LBB621_12>:
8020439a: 97 35 04 00  	auipc	a1, 67
8020439e: 93 85 e5 a6  	addi	a1, a1, -1426
802043a2: 05 46        	li	a2, 1
802043a4: 05 44        	li	s0, 1
802043a6: 82 96        	jalr	a3
802043a8: 19 e9        	bnez	a0, 0x802043be <.LBB621_13+0xe>
802043aa: 8c 64        	ld	a1, 8(s1)
802043ac: 88 60        	ld	a0, 0(s1)
802043ae: 94 6d        	ld	a3, 24(a1)

00000000802043b0 <.LBB621_13>:
802043b0: 97 35 04 00  	auipc	a1, 67
802043b4: 93 85 85 92  	addi	a1, a1, -1752
802043b8: 05 46        	li	a2, 1
802043ba: 82 96        	jalr	a3
802043bc: 2a 84        	mv	s0, a0
802043be: a2 85        	mv	a1, s0
802043c0: 33 35 b0 00  	snez	a0, a1
802043c4: e2 70        	ld	ra, 56(sp)
802043c6: 42 74        	ld	s0, 48(sp)
802043c8: a2 74        	ld	s1, 40(sp)
802043ca: 21 61        	addi	sp, sp, 64
802043cc: 82 80        	ret
802043ce: 0c 64        	ld	a1, 8(s0)
802043d0: 08 60        	ld	a0, 0(s0)
802043d2: 9c 6d        	ld	a5, 24(a1)

00000000802043d4 <.LBB621_14>:
802043d4: 97 25 04 00  	auipc	a1, 66
802043d8: 93 85 e5 f7  	addi	a1, a1, -130
802043dc: 11 46        	li	a2, 4
802043de: e2 70        	ld	ra, 56(sp)
802043e0: 42 74        	ld	s0, 48(sp)
802043e2: a2 74        	ld	s1, 40(sp)
802043e4: 21 61        	addi	sp, sp, 64
802043e6: 82 87        	jr	a5

Disassembly of section .text._ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hcb8bce5ca6b6d1baE:

00000000802043e8 <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hcb8bce5ca6b6d1baE>:
802043e8: 10 65        	ld	a2, 8(a0)
802043ea: 08 61        	ld	a0, 0(a0)
802043ec: 1c 6e        	ld	a5, 24(a2)
802043ee: 82 87        	jr	a5

Disassembly of section .text._ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hce9151d49674d170E:

00000000802043f0 <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hce9151d49674d170E>:
802043f0: 08 61        	ld	a0, 0(a0)
802043f2: 17 03 00 00  	auipc	t1, 0
802043f6: 67 00 e3 c7  	jr	-898(t1)

Disassembly of section .text._ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hcf3c30afa59af89fE:

00000000802043fa <_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hcf3c30afa59af89fE>:
802043fa: 14 61        	ld	a3, 0(a0)
802043fc: 10 65        	ld	a2, 8(a0)
802043fe: 2e 85        	mv	a0, a1
80204400: b6 85        	mv	a1, a3
80204402: 17 f3 ff ff  	auipc	t1, 1048575
80204406: 67 00 23 31  	jr	786(t1)

Disassembly of section .text._ZN64_$LT$core..str..error..Utf8Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h1dbc314162ce6afeE:

000000008020440a <_ZN64_$LT$core..str..error..Utf8Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h1dbc314162ce6afeE>:
8020440a: 79 71        	addi	sp, sp, -48
8020440c: 06 f4        	sd	ra, 40(sp)
8020440e: 22 f0        	sd	s0, 32(sp)
80204410: 2e 84        	mv	s0, a1
80204412: 2a e0        	sd	a0, 0(sp)
80204414: 8c 65        	ld	a1, 8(a1)
80204416: 21 05        	addi	a0, a0, 8
80204418: 2a e4        	sd	a0, 8(sp)
8020441a: 08 60        	ld	a0, 0(s0)
8020441c: 94 6d        	ld	a3, 24(a1)

000000008020441e <.LBB699_8>:
8020441e: 97 35 04 00  	auipc	a1, 67
80204422: 93 85 f5 cb  	addi	a1, a1, -833
80204426: 25 46        	li	a2, 9
80204428: 82 96        	jalr	a3
8020442a: 22 e8        	sd	s0, 16(sp)
8020442c: 23 0c a1 00  	sb	a0, 24(sp)
80204430: a3 0c 01 00  	sb	zero, 25(sp)

0000000080204434 <.LBB699_9>:
80204434: 97 35 04 00  	auipc	a1, 67
80204438: 93 85 25 cb  	addi	a1, a1, -846

000000008020443c <.LBB699_10>:
8020443c: 17 37 04 00  	auipc	a4, 67
80204440: 13 07 47 94  	addi	a4, a4, -1724
80204444: 08 08        	addi	a0, sp, 16
80204446: 2d 46        	li	a2, 11
80204448: 8a 86        	mv	a3, sp
8020444a: 97 f0 ff ff  	auipc	ra, 1048575
8020444e: e7 80 20 a0  	jalr	-1534(ra)

0000000080204452 <.LBB699_11>:
80204452: 97 35 04 00  	auipc	a1, 67
80204456: 93 85 f5 c9  	addi	a1, a1, -865

000000008020445a <.LBB699_12>:
8020445a: 17 37 04 00  	auipc	a4, 67
8020445e: 13 07 67 ca  	addi	a4, a4, -858
80204462: 08 08        	addi	a0, sp, 16
80204464: 25 46        	li	a2, 9
80204466: 34 00        	addi	a3, sp, 8
80204468: 97 f0 ff ff  	auipc	ra, 1048575
8020446c: e7 80 40 9e  	jalr	-1564(ra)
80204470: 03 45 91 01  	lbu	a0, 25(sp)
80204474: 83 45 81 01  	lbu	a1, 24(sp)
80204478: 1d c9        	beqz	a0, 0x802044ae <.LBB699_14+0xe>
8020447a: 05 45        	li	a0, 1
8020447c: 85 e9        	bnez	a1, 0x802044ac <.LBB699_14+0xc>
8020447e: 42 65        	ld	a0, 16(sp)
80204480: 83 45 05 03  	lbu	a1, 48(a0)
80204484: 91 89        	andi	a1, a1, 4
80204486: 91 e9        	bnez	a1, 0x8020449a <.LBB699_13+0xc>
80204488: 0c 65        	ld	a1, 8(a0)
8020448a: 08 61        	ld	a0, 0(a0)
8020448c: 94 6d        	ld	a3, 24(a1)

000000008020448e <.LBB699_13>:
8020448e: 97 35 04 00  	auipc	a1, 67
80204492: 93 85 55 97  	addi	a1, a1, -1675
80204496: 09 46        	li	a2, 2
80204498: 09 a8        	j	0x802044aa <.LBB699_14+0xa>
8020449a: 0c 65        	ld	a1, 8(a0)
8020449c: 08 61        	ld	a0, 0(a0)
8020449e: 94 6d        	ld	a3, 24(a1)

00000000802044a0 <.LBB699_14>:
802044a0: 97 35 04 00  	auipc	a1, 67
802044a4: 93 85 25 96  	addi	a1, a1, -1694
802044a8: 05 46        	li	a2, 1
802044aa: 82 96        	jalr	a3
802044ac: aa 85        	mv	a1, a0
802044ae: 33 35 b0 00  	snez	a0, a1
802044b2: a2 70        	ld	ra, 40(sp)
802044b4: 02 74        	ld	s0, 32(sp)
802044b6: 45 61        	addi	sp, sp, 48
802044b8: 82 80        	ret

Disassembly of section .text.memset:

00000000802044ba <memset>:
802044ba: 17 03 00 00  	auipc	t1, 0
802044be: 67 00 63 0b  	jr	182(t1)

Disassembly of section .text._ZN17compiler_builtins3mem6memcpy17h1cdac96a74bbfcebE:

00000000802044c2 <_ZN17compiler_builtins3mem6memcpy17h1cdac96a74bbfcebE>:
802044c2: bd 46        	li	a3, 15
802044c4: 63 fa c6 06  	bgeu	a3, a2, 0x80204538 <_ZN17compiler_builtins3mem6memcpy17h1cdac96a74bbfcebE+0x76>
802044c8: bb 06 a0 40  	negw	a3, a0
802044cc: 13 f8 76 00  	andi	a6, a3, 7
802044d0: b3 03 05 01  	add	t2, a0, a6
802044d4: 63 0c 08 00  	beqz	a6, 0x802044ec <_ZN17compiler_builtins3mem6memcpy17h1cdac96a74bbfcebE+0x2a>
802044d8: aa 87        	mv	a5, a0
802044da: ae 86        	mv	a3, a1
802044dc: 03 87 06 00  	lb	a4, 0(a3)
802044e0: 23 80 e7 00  	sb	a4, 0(a5)
802044e4: 85 07        	addi	a5, a5, 1
802044e6: 85 06        	addi	a3, a3, 1
802044e8: e3 ea 77 fe  	bltu	a5, t2, 0x802044dc <_ZN17compiler_builtins3mem6memcpy17h1cdac96a74bbfcebE+0x1a>
802044ec: b3 88 05 01  	add	a7, a1, a6
802044f0: 33 08 06 41  	sub	a6, a2, a6
802044f4: 93 72 88 ff  	andi	t0, a6, -8
802044f8: 93 f5 78 00  	andi	a1, a7, 7
802044fc: b3 86 53 00  	add	a3, t2, t0
80204500: 9d cd        	beqz	a1, 0x8020453e <_ZN17compiler_builtins3mem6memcpy17h1cdac96a74bbfcebE+0x7c>
80204502: 63 58 50 04  	blez	t0, 0x80204552 <_ZN17compiler_builtins3mem6memcpy17h1cdac96a74bbfcebE+0x90>
80204506: 13 93 35 00  	slli	t1, a1, 3
8020450a: 13 f7 88 ff  	andi	a4, a7, -8
8020450e: 10 63        	ld	a2, 0(a4)
80204510: bb 05 60 40  	negw	a1, t1
80204514: 13 fe 85 03  	andi	t3, a1, 56
80204518: 93 07 87 00  	addi	a5, a4, 8
8020451c: 98 63        	ld	a4, 0(a5)
8020451e: 33 56 66 00  	srl	a2, a2, t1
80204522: b3 15 c7 01  	sll	a1, a4, t3
80204526: d1 8d        	or	a1, a1, a2
80204528: 23 b0 b3 00  	sd	a1, 0(t2)
8020452c: a1 03        	addi	t2, t2, 8
8020452e: a1 07        	addi	a5, a5, 8
80204530: 3a 86        	mv	a2, a4
80204532: e3 e5 d3 fe  	bltu	t2, a3, 0x8020451c <_ZN17compiler_builtins3mem6memcpy17h1cdac96a74bbfcebE+0x5a>
80204536: 31 a8        	j	0x80204552 <_ZN17compiler_builtins3mem6memcpy17h1cdac96a74bbfcebE+0x90>
80204538: aa 86        	mv	a3, a0
8020453a: 0d e2        	bnez	a2, 0x8020455c <_ZN17compiler_builtins3mem6memcpy17h1cdac96a74bbfcebE+0x9a>
8020453c: 0d a8        	j	0x8020456e <_ZN17compiler_builtins3mem6memcpy17h1cdac96a74bbfcebE+0xac>
8020453e: 63 5a 50 00  	blez	t0, 0x80204552 <_ZN17compiler_builtins3mem6memcpy17h1cdac96a74bbfcebE+0x90>
80204542: c6 85        	mv	a1, a7
80204544: 90 61        	ld	a2, 0(a1)
80204546: 23 b0 c3 00  	sd	a2, 0(t2)
8020454a: a1 03        	addi	t2, t2, 8
8020454c: a1 05        	addi	a1, a1, 8
8020454e: e3 eb d3 fe  	bltu	t2, a3, 0x80204544 <_ZN17compiler_builtins3mem6memcpy17h1cdac96a74bbfcebE+0x82>
80204552: b3 85 58 00  	add	a1, a7, t0
80204556: 13 76 78 00  	andi	a2, a6, 7
8020455a: 11 ca        	beqz	a2, 0x8020456e <_ZN17compiler_builtins3mem6memcpy17h1cdac96a74bbfcebE+0xac>
8020455c: 36 96        	add	a2, a2, a3
8020455e: 03 87 05 00  	lb	a4, 0(a1)
80204562: 23 80 e6 00  	sb	a4, 0(a3)
80204566: 85 06        	addi	a3, a3, 1
80204568: 85 05        	addi	a1, a1, 1
8020456a: e3 ea c6 fe  	bltu	a3, a2, 0x8020455e <_ZN17compiler_builtins3mem6memcpy17h1cdac96a74bbfcebE+0x9c>
8020456e: 82 80        	ret

Disassembly of section .text._ZN17compiler_builtins3mem6memset17h145cb91cb23ad912E:

0000000080204570 <_ZN17compiler_builtins3mem6memset17h145cb91cb23ad912E>:
80204570: bd 46        	li	a3, 15
80204572: 63 fa c6 04  	bgeu	a3, a2, 0x802045c6 <_ZN17compiler_builtins3mem6memset17h145cb91cb23ad912E+0x56>
80204576: bb 06 a0 40  	negw	a3, a0
8020457a: 9d 8a        	andi	a3, a3, 7
8020457c: 33 07 d5 00  	add	a4, a0, a3
80204580: 99 c6        	beqz	a3, 0x8020458e <_ZN17compiler_builtins3mem6memset17h145cb91cb23ad912E+0x1e>
80204582: aa 87        	mv	a5, a0
80204584: 23 80 b7 00  	sb	a1, 0(a5)
80204588: 85 07        	addi	a5, a5, 1
8020458a: e3 ed e7 fe  	bltu	a5, a4, 0x80204584 <_ZN17compiler_builtins3mem6memset17h145cb91cb23ad912E+0x14>
8020458e: b3 08 d6 40  	sub	a7, a2, a3
80204592: 93 f7 88 ff  	andi	a5, a7, -8
80204596: b3 06 f7 00  	add	a3, a4, a5
8020459a: 63 52 f0 02  	blez	a5, 0x802045be <_ZN17compiler_builtins3mem6memset17h145cb91cb23ad912E+0x4e>
8020459e: 13 98 85 03  	slli	a6, a1, 56
802045a2: b7 17 10 10  	lui	a5, 65793
802045a6: 92 07        	slli	a5, a5, 4
802045a8: 93 87 07 10  	addi	a5, a5, 256
802045ac: b3 37 f8 02  	mulhu	a5, a6, a5
802045b0: 13 96 07 02  	slli	a2, a5, 32
802045b4: d1 8f        	or	a5, a5, a2
802045b6: 1c e3        	sd	a5, 0(a4)
802045b8: 21 07        	addi	a4, a4, 8
802045ba: e3 6e d7 fe  	bltu	a4, a3, 0x802045b6 <_ZN17compiler_builtins3mem6memset17h145cb91cb23ad912E+0x46>
802045be: 13 f6 78 00  	andi	a2, a7, 7
802045c2: 01 e6        	bnez	a2, 0x802045ca <_ZN17compiler_builtins3mem6memset17h145cb91cb23ad912E+0x5a>
802045c4: 09 a8        	j	0x802045d6 <_ZN17compiler_builtins3mem6memset17h145cb91cb23ad912E+0x66>
802045c6: aa 86        	mv	a3, a0
802045c8: 19 c6        	beqz	a2, 0x802045d6 <_ZN17compiler_builtins3mem6memset17h145cb91cb23ad912E+0x66>
802045ca: 36 96        	add	a2, a2, a3
802045cc: 23 80 b6 00  	sb	a1, 0(a3)
802045d0: 85 06        	addi	a3, a3, 1
802045d2: e3 ed c6 fe  	bltu	a3, a2, 0x802045cc <_ZN17compiler_builtins3mem6memset17h145cb91cb23ad912E+0x5c>
802045d6: 82 80        	ret

Disassembly of section .text.memcpy:

00000000802045d8 <memcpy>:
802045d8: 17 03 00 00  	auipc	t1, 0
802045dc: 67 00 a3 ee  	jr	-278(t1)
