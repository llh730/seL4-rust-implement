
target/riscv64gc-unknown-none-elf/release/sel4:	file format elf64-littleriscv

Disassembly of section .text:

0000000080200000 <stext>:
80200000: 17 71 21 00  	auipc	sp, 535
80200004: 13 01 81 12  	addi	sp, sp, 296
80200008: 97 10 00 00  	auipc	ra, 1
8020000c: e7 80 80 ff  	jalr	-8(ra)
		...

0000000080201000 <rust_main>:
80201000: 19 71        	addi	sp, sp, -128
80201002: 86 fc        	sd	ra, 120(sp)
80201004: a2 f8        	sd	s0, 112(sp)
80201006: a6 f4        	sd	s1, 104(sp)
80201008: ca f0        	sd	s2, 96(sp)
8020100a: ce ec        	sd	s3, 88(sp)
8020100c: d2 e8        	sd	s4, 80(sp)
8020100e: 00 01        	addi	s0, sp, 128

0000000080201010 <.LBB3_1>:
80201010: 17 25 00 00  	auipc	a0, 2
80201014: 13 05 05 b0  	addi	a0, a0, -1280
80201018: 23 38 a4 f8  	sd	a0, -112(s0)
8020101c: 05 45        	li	a0, 1
8020101e: 23 3c a4 f8  	sd	a0, -104(s0)
80201022: 23 30 04 f8  	sd	zero, -128(s0)

0000000080201026 <.LBB3_2>:
80201026: 17 25 00 00  	auipc	a0, 2
8020102a: 13 05 25 aa  	addi	a0, a0, -1374
8020102e: 23 30 a4 fa  	sd	a0, -96(s0)
80201032: 23 34 04 fa  	sd	zero, -88(s0)
80201036: 13 05 04 f8  	addi	a0, s0, -128
8020103a: 97 00 00 00  	auipc	ra, 0
8020103e: e7 80 00 57  	jalr	1392(ra)
80201042: 97 00 00 00  	auipc	ra, 0
80201046: e7 80 20 1f  	jalr	498(ra)
8020104a: 97 00 00 00  	auipc	ra, 0
8020104e: e7 80 00 15  	jalr	336(ra)
80201052: 97 00 00 00  	auipc	ra, 0
80201056: e7 80 a0 2f  	jalr	762(ra)
8020105a: aa 84        	mv	s1, a0
8020105c: 13 09 05 ff  	addi	s2, a0, -16

0000000080201060 <.LBB3_3>:
80201060: 97 25 00 00  	auipc	a1, 2
80201064: 93 85 85 b0  	addi	a1, a1, -1272
80201068: 97 00 00 00  	auipc	ra, 0
8020106c: e7 80 20 2a  	jalr	674(ra)
80201070: aa 89        	mv	s3, a0
80201072: 2e 8a        	mv	s4, a1

0000000080201074 <.LBB3_4>:
80201074: 97 25 00 00  	auipc	a1, 2
80201078: 93 85 c5 b0  	addi	a1, a1, -1268
8020107c: 26 85        	mv	a0, s1
8020107e: 97 00 00 00  	auipc	ra, 0
80201082: e7 80 c0 28  	jalr	652(ra)
80201086: ae 84        	mv	s1, a1
80201088: 21 05        	addi	a0, a0, 8
8020108a: 23 38 34 fb  	sd	s3, -80(s0)

000000008020108e <.LBB3_5>:
8020108e: 97 15 00 00  	auipc	a1, 1
80201092: 93 85 45 65  	addi	a1, a1, 1620
80201096: 23 3c b4 fa  	sd	a1, -72(s0)
8020109a: 23 30 a4 fc  	sd	a0, -64(s0)
8020109e: 23 34 b4 fc  	sd	a1, -56(s0)

00000000802010a2 <.LBB3_6>:
802010a2: 17 25 00 00  	auipc	a0, 2
802010a6: 13 05 65 a8  	addi	a0, a0, -1402
802010aa: 23 38 a4 f8  	sd	a0, -112(s0)
802010ae: 0d 45        	li	a0, 3
802010b0: 23 3c a4 f8  	sd	a0, -104(s0)
802010b4: 23 30 04 f8  	sd	zero, -128(s0)
802010b8: 13 05 04 fb  	addi	a0, s0, -80
802010bc: 23 30 a4 fa  	sd	a0, -96(s0)
802010c0: 09 45        	li	a0, 2
802010c2: 23 34 a4 fa  	sd	a0, -88(s0)
802010c6: 13 05 04 f8  	addi	a0, s0, -128
802010ca: 97 00 00 00  	auipc	ra, 0
802010ce: e7 80 00 4e  	jalr	1248(ra)
802010d2: 88 60        	ld	a0, 0(s1)
802010d4: 05 05        	addi	a0, a0, 1
802010d6: 88 e0        	sd	a0, 0(s1)
802010d8: 03 35 0a 00  	ld	a0, 0(s4)
802010dc: 05 05        	addi	a0, a0, 1
802010de: 23 30 aa 00  	sd	a0, 0(s4)
802010e2: 4a 85        	mv	a0, s2
802010e4: 97 00 00 00  	auipc	ra, 0
802010e8: e7 80 20 1e  	jalr	482(ra)
802010ec: 97 00 00 00  	auipc	ra, 0
802010f0: e7 80 40 02  	jalr	36(ra)
802010f4: 00 00        	unimp	

Disassembly of section .text._ZN4sel43sbi15console_putchar17hbfeff6a159c8e95bE:

00000000802010f6 <_ZN4sel43sbi15console_putchar17hbfeff6a159c8e95bE>:
802010f6: 41 11        	addi	sp, sp, -16
802010f8: 06 e4        	sd	ra, 8(sp)
802010fa: 22 e0        	sd	s0, 0(sp)
802010fc: 00 08        	addi	s0, sp, 16
802010fe: 85 48        	li	a7, 1
80201100: 81 45        	li	a1, 0
80201102: 01 46        	li	a2, 0
80201104: 73 00 00 00  	ecall	
80201108: a2 60        	ld	ra, 8(sp)
8020110a: 02 64        	ld	s0, 0(sp)
8020110c: 41 01        	addi	sp, sp, 16
8020110e: 82 80        	ret

Disassembly of section .text._ZN4sel43sbi8shutdown17h66331878ed4ddfbbE:

0000000080201110 <_ZN4sel43sbi8shutdown17h66331878ed4ddfbbE>:
80201110: 39 71        	addi	sp, sp, -64
80201112: 06 fc        	sd	ra, 56(sp)
80201114: 22 f8        	sd	s0, 48(sp)
80201116: 80 00        	addi	s0, sp, 64
80201118: a1 48        	li	a7, 8
8020111a: 01 45        	li	a0, 0
8020111c: 81 45        	li	a1, 0
8020111e: 01 46        	li	a2, 0
80201120: 73 00 00 00  	ecall	

0000000080201124 <.LBB7_1>:
80201124: 17 25 00 00  	auipc	a0, 2
80201128: 13 05 c5 96  	addi	a0, a0, -1684
8020112c: 23 38 a4 fc  	sd	a0, -48(s0)
80201130: 05 45        	li	a0, 1
80201132: 23 3c a4 fc  	sd	a0, -40(s0)
80201136: 23 30 04 fc  	sd	zero, -64(s0)

000000008020113a <.LBB7_2>:
8020113a: 17 25 00 00  	auipc	a0, 2
8020113e: 13 05 e5 93  	addi	a0, a0, -1730
80201142: 23 30 a4 fe  	sd	a0, -32(s0)
80201146: 23 34 04 fe  	sd	zero, -24(s0)

000000008020114a <.LBB7_3>:
8020114a: 97 25 00 00  	auipc	a1, 2
8020114e: 93 85 65 96  	addi	a1, a1, -1690
80201152: 13 05 04 fc  	addi	a0, s0, -64
80201156: 97 10 00 00  	auipc	ra, 1
8020115a: e7 80 40 ae  	jalr	-1308(ra)
8020115e: 00 00        	unimp	

Disassembly of section .text._ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hc83fb63968e07dbeE:

0000000080201160 <_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hc83fb63968e07dbeE>:
80201160: 41 11        	addi	sp, sp, -16
80201162: 06 e4        	sd	ra, 8(sp)
80201164: 22 e0        	sd	s0, 0(sp)
80201166: 00 08        	addi	s0, sp, 16
80201168: 08 61        	ld	a0, 0(a0)
8020116a: a2 60        	ld	ra, 8(sp)
8020116c: 02 64        	ld	s0, 0(sp)
8020116e: 41 01        	addi	sp, sp, 16
80201170: 17 13 00 00  	auipc	t1, 1
80201174: 67 00 03 bb  	jr	-1104(t1)

Disassembly of section .text._ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17he9e9b4aa0ef791bdE:

0000000080201178 <_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17he9e9b4aa0ef791bdE>:
80201178: 41 11        	addi	sp, sp, -16
8020117a: 06 e4        	sd	ra, 8(sp)
8020117c: 22 e0        	sd	s0, 0(sp)
8020117e: 00 08        	addi	s0, sp, 16
80201180: 10 61        	ld	a2, 0(a0)
80201182: 14 65        	ld	a3, 8(a0)
80201184: 2e 87        	mv	a4, a1
80201186: 32 85        	mv	a0, a2
80201188: b6 85        	mv	a1, a3
8020118a: 3a 86        	mv	a2, a4
8020118c: a2 60        	ld	ra, 8(sp)
8020118e: 02 64        	ld	s0, 0(sp)
80201190: 41 01        	addi	sp, sp, 16
80201192: 17 13 00 00  	auipc	t1, 1
80201196: 67 00 43 21  	jr	532(t1)

Disassembly of section .text._ZN4sel46kernel6vspace7pt_init17haa10305f5fea8ca7E:

000000008020119a <_ZN4sel46kernel6vspace7pt_init17haa10305f5fea8ca7E>:
8020119a: 41 11        	addi	sp, sp, -16
8020119c: 06 e4        	sd	ra, 8(sp)
8020119e: 22 e0        	sd	s0, 0(sp)
802011a0: 00 08        	addi	s0, sp, 16

00000000802011a2 <.LBB2_5>:
802011a2: 17 48 00 00  	auipc	a6, 4
802011a6: 13 08 e8 e5  	addi	a6, a6, -418
802011aa: 93 08 f8 7f  	addi	a7, a6, 2047
802011ae: 13 86 18 00  	addi	a2, a7, 1
802011b2: 93 06 f0 0e  	li	a3, 239
802011b6: 13 05 f0 ef  	li	a0, -257
802011ba: 13 17 e5 01  	slli	a4, a0, 30
802011be: b7 07 00 40  	lui	a5, 262144
802011c2: 37 05 00 10  	lui	a0, 65536
802011c6: f5 55        	li	a1, -3
802011c8: fa 05        	slli	a1, a1, 30
802011ca: 14 e2        	sd	a3, 0(a2)
802011cc: 3e 97        	add	a4, a4, a5
802011ce: 21 06        	addi	a2, a2, 8
802011d0: aa 96        	add	a3, a3, a0
802011d2: e3 6c b7 fe  	bltu	a4, a1, 0x802011ca <.LBB2_5+0x28>

00000000802011d6 <.LBB2_6>:
802011d6: 17 56 00 00  	auipc	a2, 5
802011da: 13 06 a6 e2  	addi	a2, a2, -470
802011de: 13 55 26 00  	srli	a0, a2, 2
802011e2: b7 05 f0 ff  	lui	a1, 1048320
802011e6: a9 81        	srli	a1, a1, 10
802011e8: 6d 8d        	and	a0, a0, a1
802011ea: 13 65 15 02  	ori	a0, a0, 33
802011ee: a3 b8 a8 00  	sd	a0, 17(a7)
802011f2: a3 b8 a8 7e  	sd	a0, 2033(a7)
802011f6: 23 38 a8 00  	sd	a0, 16(a6)
802011fa: 93 05 00 20  	li	a1, 512
802011fe: 37 05 00 20  	lui	a0, 131072
80201202: 1b 05 f5 0e  	addiw	a0, a0, 239
80201206: b7 06 08 00  	lui	a3, 128
8020120a: 08 e2        	sd	a0, 0(a2)
8020120c: 36 95        	add	a0, a0, a3
8020120e: fd 15        	addi	a1, a1, -1
80201210: 21 06        	addi	a2, a2, 8
80201212: e5 fd        	bnez	a1, 0x8020120a <.LBB2_6+0x34>
80201214: 13 15 88 00  	slli	a0, a6, 8
80201218: 51 81        	srli	a0, a0, 20
8020121a: fd 55        	li	a1, -1
8020121c: fe 15        	slli	a1, a1, 63
8020121e: 4d 8d        	or	a0, a0, a1
80201220: 73 10 05 18  	csrw	satp, a0
80201224: 73 00 00 12  	sfence.vma
80201228: 73 00 00 12  	sfence.vma
8020122c: a2 60        	ld	ra, 8(sp)
8020122e: 02 64        	ld	s0, 0(sp)
80201230: 41 01        	addi	sp, sp, 16
80201232: 82 80        	ret

Disassembly of section .text._ZN4sel410heap_alloc9init_heap17h3294eb883f2849c6E:

0000000080201234 <_ZN4sel410heap_alloc9init_heap17h3294eb883f2849c6E>:
80201234: 01 11        	addi	sp, sp, -32
80201236: 06 ec        	sd	ra, 24(sp)
80201238: 22 e8        	sd	s0, 16(sp)
8020123a: 26 e4        	sd	s1, 8(sp)
8020123c: 4a e0        	sd	s2, 0(sp)
8020123e: 00 10        	addi	s0, sp, 32

0000000080201240 <.LBB0_3>:
80201240: 17 65 20 00  	auipc	a0, 518
80201244: 13 05 05 dc  	addi	a0, a0, -576
80201248: 97 10 00 00  	auipc	ra, 1
8020124c: e7 80 80 96  	jalr	-1688(ra)
80201250: aa 84        	mv	s1, a0
80201252: 05 45        	li	a0, 1
80201254: 2f b9 a4 00  	amoadd.d	s2, a0, (s1)
80201258: 88 64        	ld	a0, 8(s1)
8020125a: 0f 00 30 02  	fence	r, rw
8020125e: 63 09 25 01  	beq	a0, s2, 0x80201270 <.LBB0_3+0x30>
80201262: 0f 00 00 01  	fence	w, 0
80201266: 88 64        	ld	a0, 8(s1)
80201268: 0f 00 30 02  	fence	r, rw
8020126c: e3 1b 25 ff  	bne	a0, s2, 0x80201262 <.LBB0_3+0x22>
80201270: 13 85 04 01  	addi	a0, s1, 16

0000000080201274 <.LBB0_4>:
80201274: 97 65 00 00  	auipc	a1, 6
80201278: 93 85 c5 d8  	addi	a1, a1, -628
8020127c: 37 06 20 00  	lui	a2, 512
80201280: 97 00 00 00  	auipc	ra, 0
80201284: e7 80 e0 60  	jalr	1550(ra)
80201288: 13 05 19 00  	addi	a0, s2, 1
8020128c: 0f 00 10 03  	fence	rw, w
80201290: 88 e4        	sd	a0, 8(s1)
80201292: e2 60        	ld	ra, 24(sp)
80201294: 42 64        	ld	s0, 16(sp)
80201296: a2 64        	ld	s1, 8(sp)
80201298: 02 69        	ld	s2, 0(sp)
8020129a: 05 61        	addi	sp, sp, 32
8020129c: 82 80        	ret

Disassembly of section .text.__rg_dealloc:

000000008020129e <__rg_dealloc>:
8020129e: 41 11        	addi	sp, sp, -16
802012a0: 06 e4        	sd	ra, 8(sp)
802012a2: 22 e0        	sd	s0, 0(sp)
802012a4: 00 08        	addi	s0, sp, 16

00000000802012a6 <.LBB2_1>:
802012a6: 97 66 20 00  	auipc	a3, 518
802012aa: 93 86 a6 d5  	addi	a3, a3, -678
802012ae: 32 87        	mv	a4, a2
802012b0: 2e 86        	mv	a2, a1
802012b2: aa 85        	mv	a1, a0
802012b4: 36 85        	mv	a0, a3
802012b6: ba 86        	mv	a3, a4
802012b8: a2 60        	ld	ra, 8(sp)
802012ba: 02 64        	ld	s0, 0(sp)
802012bc: 41 01        	addi	sp, sp, 16
802012be: 17 13 00 00  	auipc	t1, 1
802012c2: 67 00 23 90  	jr	-1790(t1)

Disassembly of section .text._ZN4core3ptr108drop_in_place$LT$alloc..rc..Rc$LT$core..cell..RefCell$LT$sel4..kernel..object..structures..cap_t$GT$$GT$$GT$17h4cc5840b5d36c113E:

00000000802012c6 <_ZN4core3ptr108drop_in_place$LT$alloc..rc..Rc$LT$core..cell..RefCell$LT$sel4..kernel..object..structures..cap_t$GT$$GT$$GT$17h4cc5840b5d36c113E>:
802012c6: 41 11        	addi	sp, sp, -16
802012c8: 06 e4        	sd	ra, 8(sp)
802012ca: 22 e0        	sd	s0, 0(sp)
802012cc: 00 08        	addi	s0, sp, 16
802012ce: 0c 61        	ld	a1, 0(a0)
802012d0: fd 15        	addi	a1, a1, -1
802012d2: 0c e1        	sd	a1, 0(a0)
802012d4: 89 e5        	bnez	a1, 0x802012de <_ZN4core3ptr108drop_in_place$LT$alloc..rc..Rc$LT$core..cell..RefCell$LT$sel4..kernel..object..structures..cap_t$GT$$GT$$GT$17h4cc5840b5d36c113E+0x18>
802012d6: 0c 65        	ld	a1, 8(a0)
802012d8: fd 15        	addi	a1, a1, -1
802012da: 0c e5        	sd	a1, 8(a0)
802012dc: 89 c5        	beqz	a1, 0x802012e6 <_ZN4core3ptr108drop_in_place$LT$alloc..rc..Rc$LT$core..cell..RefCell$LT$sel4..kernel..object..structures..cap_t$GT$$GT$$GT$17h4cc5840b5d36c113E+0x20>
802012de: a2 60        	ld	ra, 8(sp)
802012e0: 02 64        	ld	s0, 0(sp)
802012e2: 41 01        	addi	sp, sp, 16
802012e4: 82 80        	ret
802012e6: 93 05 80 02  	li	a1, 40
802012ea: 21 46        	li	a2, 8
802012ec: a2 60        	ld	ra, 8(sp)
802012ee: 02 64        	ld	s0, 0(sp)
802012f0: 41 01        	addi	sp, sp, 16
802012f2: 17 03 00 00  	auipc	t1, 0
802012f6: 67 00 43 59  	jr	1428(t1)

Disassembly of section .text._ZN4core3ptr47drop_in_place$LT$core..cell..BorrowMutError$GT$17h1c74932dfe841b87E:

00000000802012fa <_ZN4core3ptr47drop_in_place$LT$core..cell..BorrowMutError$GT$17h1c74932dfe841b87E>:
802012fa: 41 11        	addi	sp, sp, -16
802012fc: 06 e4        	sd	ra, 8(sp)
802012fe: 22 e0        	sd	s0, 0(sp)
80201300: 00 08        	addi	s0, sp, 16
80201302: a2 60        	ld	ra, 8(sp)
80201304: 02 64        	ld	s0, 0(sp)
80201306: 41 01        	addi	sp, sp, 16
80201308: 82 80        	ret

Disassembly of section .text._ZN4core4cell16RefCell$LT$T$GT$10borrow_mut17h78e1eaf2616083f2E:

000000008020130a <_ZN4core4cell16RefCell$LT$T$GT$10borrow_mut17h78e1eaf2616083f2E>:
8020130a: 01 11        	addi	sp, sp, -32
8020130c: 06 ec        	sd	ra, 24(sp)
8020130e: 22 e8        	sd	s0, 16(sp)
80201310: 00 10        	addi	s0, sp, 32
80201312: 2a 86        	mv	a2, a0
80201314: 08 61        	ld	a0, 0(a0)
80201316: 11 e9        	bnez	a0, 0x8020132a <_ZN4core4cell16RefCell$LT$T$GT$10borrow_mut17h78e1eaf2616083f2E+0x20>
80201318: fd 55        	li	a1, -1
8020131a: 13 05 86 00  	addi	a0, a2, 8
8020131e: 0c e2        	sd	a1, 0(a2)
80201320: b2 85        	mv	a1, a2
80201322: e2 60        	ld	ra, 24(sp)
80201324: 42 64        	ld	s0, 16(sp)
80201326: 05 61        	addi	sp, sp, 32
80201328: 82 80        	ret
8020132a: 2e 87        	mv	a4, a1

000000008020132c <.LBB2_3>:
8020132c: 17 15 00 00  	auipc	a0, 1
80201330: 13 05 c5 79  	addi	a0, a0, 1948

0000000080201334 <.LBB2_4>:
80201334: 97 16 00 00  	auipc	a3, 1
80201338: 93 86 46 7a  	addi	a3, a3, 1956
8020133c: c1 45        	li	a1, 16
8020133e: 13 06 84 fe  	addi	a2, s0, -24
80201342: 97 10 00 00  	auipc	ra, 1
80201346: e7 80 20 99  	jalr	-1646(ra)
8020134a: 00 00        	unimp	

Disassembly of section .text._ZN4sel43get17hee4607b94a8d2d76E:

000000008020134c <_ZN4sel43get17hee4607b94a8d2d76E>:
8020134c: 41 11        	addi	sp, sp, -16
8020134e: 06 e4        	sd	ra, 8(sp)
80201350: 22 e0        	sd	s0, 0(sp)
80201352: 00 08        	addi	s0, sp, 16
80201354: 00 00        	unimp	

Disassembly of section .text._ZN4core3ptr37drop_in_place$LT$core..fmt..Error$GT$17h8a07bd9b64186cfeE.llvm.627776411115031865:

0000000080201356 <_ZN4core3ptr54drop_in_place$LT$$RF$mut$u20$sel4..console..Stdout$GT$17he26c29928d3f96b5E.llvm.627776411115031865>:
80201356: 41 11        	addi	sp, sp, -16
80201358: 06 e4        	sd	ra, 8(sp)
8020135a: 22 e0        	sd	s0, 0(sp)
8020135c: 00 08        	addi	s0, sp, 16
8020135e: a2 60        	ld	ra, 8(sp)
80201360: 02 64        	ld	s0, 0(sp)
80201362: 41 01        	addi	sp, sp, 16
80201364: 82 80        	ret

Disassembly of section .text._ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.627776411115031865:

0000000080201366 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.627776411115031865>:
80201366: 39 71        	addi	sp, sp, -64
80201368: 06 fc        	sd	ra, 56(sp)
8020136a: 22 f8        	sd	s0, 48(sp)
8020136c: 26 f4        	sd	s1, 40(sp)
8020136e: 4a f0        	sd	s2, 32(sp)
80201370: 4e ec        	sd	s3, 24(sp)
80201372: 52 e8        	sd	s4, 16(sp)
80201374: 56 e4        	sd	s5, 8(sp)
80201376: 80 00        	addi	s0, sp, 64
80201378: 1b 85 05 00  	sext.w	a0, a1
8020137c: 13 06 00 08  	li	a2, 128
80201380: 23 22 04 fc  	sw	zero, -60(s0)
80201384: 63 76 c5 00  	bgeu	a0, a2, 0x80201390 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.627776411115031865+0x2a>
80201388: 23 02 b4 fc  	sb	a1, -60(s0)
8020138c: 05 45        	li	a0, 1
8020138e: 51 a8        	j	0x80201422 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.627776411115031865+0xbc>
80201390: 1b d5 b5 00  	srliw	a0, a1, 11
80201394: 19 ed        	bnez	a0, 0x802013b2 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.627776411115031865+0x4c>
80201396: 13 d5 65 00  	srli	a0, a1, 6
8020139a: 13 65 05 0c  	ori	a0, a0, 192
8020139e: 23 02 a4 fc  	sb	a0, -60(s0)
802013a2: 13 f5 f5 03  	andi	a0, a1, 63
802013a6: 13 65 05 08  	ori	a0, a0, 128
802013aa: a3 02 a4 fc  	sb	a0, -59(s0)
802013ae: 09 45        	li	a0, 2
802013b0: 8d a8        	j	0x80201422 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.627776411115031865+0xbc>
802013b2: 1b d5 05 01  	srliw	a0, a1, 16
802013b6: 05 e9        	bnez	a0, 0x802013e6 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.627776411115031865+0x80>
802013b8: 13 95 05 02  	slli	a0, a1, 32
802013bc: 01 91        	srli	a0, a0, 32
802013be: 1b d6 c5 00  	srliw	a2, a1, 12
802013c2: 13 66 06 0e  	ori	a2, a2, 224
802013c6: 23 02 c4 fc  	sb	a2, -60(s0)
802013ca: 52 15        	slli	a0, a0, 52
802013cc: 69 91        	srli	a0, a0, 58
802013ce: 13 65 05 08  	ori	a0, a0, 128
802013d2: a3 02 a4 fc  	sb	a0, -59(s0)
802013d6: 13 f5 f5 03  	andi	a0, a1, 63
802013da: 13 65 05 08  	ori	a0, a0, 128
802013de: 23 03 a4 fc  	sb	a0, -58(s0)
802013e2: 0d 45        	li	a0, 3
802013e4: 3d a8        	j	0x80201422 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.627776411115031865+0xbc>
802013e6: 13 95 05 02  	slli	a0, a1, 32
802013ea: 01 91        	srli	a0, a0, 32
802013ec: 13 16 b5 02  	slli	a2, a0, 43
802013f0: 75 92        	srli	a2, a2, 61
802013f2: 13 66 06 0f  	ori	a2, a2, 240
802013f6: 23 02 c4 fc  	sb	a2, -60(s0)
802013fa: 13 16 e5 02  	slli	a2, a0, 46
802013fe: 69 92        	srli	a2, a2, 58
80201400: 13 66 06 08  	ori	a2, a2, 128
80201404: a3 02 c4 fc  	sb	a2, -59(s0)
80201408: 52 15        	slli	a0, a0, 52
8020140a: 69 91        	srli	a0, a0, 58
8020140c: 13 65 05 08  	ori	a0, a0, 128
80201410: 23 03 a4 fc  	sb	a0, -58(s0)
80201414: 13 f5 f5 03  	andi	a0, a1, 63
80201418: 13 65 05 08  	ori	a0, a0, 128
8020141c: a3 03 a4 fc  	sb	a0, -57(s0)
80201420: 11 45        	li	a0, 4
80201422: 93 04 44 fc  	addi	s1, s0, -60
80201426: 33 89 a4 00  	add	s2, s1, a0
8020142a: 93 09 f0 0d  	li	s3, 223
8020142e: 13 0a 00 0f  	li	s4, 240
80201432: b7 0a 11 00  	lui	s5, 272
80201436: 01 a8        	j	0x80201446 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.627776411115031865+0xe0>
80201438: 85 04        	addi	s1, s1, 1
8020143a: 97 00 00 00  	auipc	ra, 0
8020143e: e7 80 c0 cb  	jalr	-836(ra)
80201442: 63 8f 24 05  	beq	s1, s2, 0x802014a0 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.627776411115031865+0x13a>
80201446: 83 85 04 00  	lb	a1, 0(s1)
8020144a: 13 f5 f5 0f  	andi	a0, a1, 255
8020144e: e3 d5 05 fe  	bgez	a1, 0x80201438 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.627776411115031865+0xd2>
80201452: 03 c6 14 00  	lbu	a2, 1(s1)
80201456: 93 75 f5 01  	andi	a1, a0, 31
8020145a: 13 76 f6 03  	andi	a2, a2, 63
8020145e: 63 f7 a9 02  	bgeu	s3, a0, 0x8020148c <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.627776411115031865+0x126>
80201462: 83 c6 24 00  	lbu	a3, 2(s1)
80201466: 1a 06        	slli	a2, a2, 6
80201468: 93 f6 f6 03  	andi	a3, a3, 63
8020146c: 55 8e        	or	a2, a2, a3
8020146e: 63 64 45 03  	bltu	a0, s4, 0x80201496 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.627776411115031865+0x130>
80201472: 03 c5 34 00  	lbu	a0, 3(s1)
80201476: f6 15        	slli	a1, a1, 61
80201478: ad 91        	srli	a1, a1, 43
8020147a: 1a 06        	slli	a2, a2, 6
8020147c: 13 75 f5 03  	andi	a0, a0, 63
80201480: 51 8d        	or	a0, a0, a2
80201482: 4d 8d        	or	a0, a0, a1
80201484: 63 0e 55 01  	beq	a0, s5, 0x802014a0 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.627776411115031865+0x13a>
80201488: 91 04        	addi	s1, s1, 4
8020148a: 45 bf        	j	0x8020143a <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.627776411115031865+0xd4>
8020148c: 89 04        	addi	s1, s1, 2
8020148e: 13 95 65 00  	slli	a0, a1, 6
80201492: 51 8d        	or	a0, a0, a2
80201494: 5d b7        	j	0x8020143a <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.627776411115031865+0xd4>
80201496: 8d 04        	addi	s1, s1, 3
80201498: 13 95 c5 00  	slli	a0, a1, 12
8020149c: 51 8d        	or	a0, a0, a2
8020149e: 71 bf        	j	0x8020143a <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.627776411115031865+0xd4>
802014a0: 01 45        	li	a0, 0
802014a2: e2 70        	ld	ra, 56(sp)
802014a4: 42 74        	ld	s0, 48(sp)
802014a6: a2 74        	ld	s1, 40(sp)
802014a8: 02 79        	ld	s2, 32(sp)
802014aa: e2 69        	ld	s3, 24(sp)
802014ac: 42 6a        	ld	s4, 16(sp)
802014ae: a2 6a        	ld	s5, 8(sp)
802014b0: 21 61        	addi	sp, sp, 64
802014b2: 82 80        	ret

Disassembly of section .text._ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_fmt17hea6da6f03dcdd814E.llvm.627776411115031865:

00000000802014b4 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_fmt17hea6da6f03dcdd814E.llvm.627776411115031865>:
802014b4: 5d 71        	addi	sp, sp, -80
802014b6: 86 e4        	sd	ra, 72(sp)
802014b8: a2 e0        	sd	s0, 64(sp)
802014ba: 80 08        	addi	s0, sp, 80
802014bc: 08 61        	ld	a0, 0(a0)
802014be: 90 75        	ld	a2, 40(a1)
802014c0: 94 71        	ld	a3, 32(a1)
802014c2: 23 3c a4 fa  	sd	a0, -72(s0)
802014c6: 23 34 c4 fe  	sd	a2, -24(s0)
802014ca: 23 30 d4 fe  	sd	a3, -32(s0)
802014ce: 88 6d        	ld	a0, 24(a1)
802014d0: 90 69        	ld	a2, 16(a1)
802014d2: 94 65        	ld	a3, 8(a1)
802014d4: 8c 61        	ld	a1, 0(a1)
802014d6: 23 3c a4 fc  	sd	a0, -40(s0)
802014da: 23 38 c4 fc  	sd	a2, -48(s0)
802014de: 23 34 d4 fc  	sd	a3, -56(s0)
802014e2: 23 30 b4 fc  	sd	a1, -64(s0)

00000000802014e6 <.LBB2_1>:
802014e6: 97 15 00 00  	auipc	a1, 1
802014ea: 93 85 25 6b  	addi	a1, a1, 1714
802014ee: 13 05 84 fb  	addi	a0, s0, -72
802014f2: 13 06 04 fc  	addi	a2, s0, -64
802014f6: 97 10 00 00  	auipc	ra, 1
802014fa: e7 80 c0 85  	jalr	-1956(ra)
802014fe: a6 60        	ld	ra, 72(sp)
80201500: 06 64        	ld	s0, 64(sp)
80201502: 61 61        	addi	sp, sp, 80
80201504: 82 80        	ret

Disassembly of section .text._ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hff577ac6e379d064E.llvm.627776411115031865:

0000000080201506 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hff577ac6e379d064E.llvm.627776411115031865>:
80201506: 39 71        	addi	sp, sp, -64
80201508: 06 fc        	sd	ra, 56(sp)
8020150a: 22 f8        	sd	s0, 48(sp)
8020150c: 26 f4        	sd	s1, 40(sp)
8020150e: 4a f0        	sd	s2, 32(sp)
80201510: 4e ec        	sd	s3, 24(sp)
80201512: 52 e8        	sd	s4, 16(sp)
80201514: 56 e4        	sd	s5, 8(sp)
80201516: 80 00        	addi	s0, sp, 64
80201518: 3d ce        	beqz	a2, 0x80201596 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hff577ac6e379d064E.llvm.627776411115031865+0x90>
8020151a: ae 84        	mv	s1, a1
8020151c: 33 89 c5 00  	add	s2, a1, a2
80201520: 93 09 f0 0d  	li	s3, 223
80201524: 13 0a 00 0f  	li	s4, 240
80201528: b7 0a 11 00  	lui	s5, 272
8020152c: 01 a8        	j	0x8020153c <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hff577ac6e379d064E.llvm.627776411115031865+0x36>
8020152e: 85 04        	addi	s1, s1, 1
80201530: 97 00 00 00  	auipc	ra, 0
80201534: e7 80 60 bc  	jalr	-1082(ra)
80201538: 63 8f 24 05  	beq	s1, s2, 0x80201596 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hff577ac6e379d064E.llvm.627776411115031865+0x90>
8020153c: 83 85 04 00  	lb	a1, 0(s1)
80201540: 13 f5 f5 0f  	andi	a0, a1, 255
80201544: e3 d5 05 fe  	bgez	a1, 0x8020152e <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hff577ac6e379d064E.llvm.627776411115031865+0x28>
80201548: 03 c6 14 00  	lbu	a2, 1(s1)
8020154c: 93 75 f5 01  	andi	a1, a0, 31
80201550: 13 76 f6 03  	andi	a2, a2, 63
80201554: 63 f7 a9 02  	bgeu	s3, a0, 0x80201582 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hff577ac6e379d064E.llvm.627776411115031865+0x7c>
80201558: 83 c6 24 00  	lbu	a3, 2(s1)
8020155c: 1a 06        	slli	a2, a2, 6
8020155e: 93 f6 f6 03  	andi	a3, a3, 63
80201562: 55 8e        	or	a2, a2, a3
80201564: 63 64 45 03  	bltu	a0, s4, 0x8020158c <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hff577ac6e379d064E.llvm.627776411115031865+0x86>
80201568: 03 c5 34 00  	lbu	a0, 3(s1)
8020156c: f6 15        	slli	a1, a1, 61
8020156e: ad 91        	srli	a1, a1, 43
80201570: 1a 06        	slli	a2, a2, 6
80201572: 13 75 f5 03  	andi	a0, a0, 63
80201576: 51 8d        	or	a0, a0, a2
80201578: 4d 8d        	or	a0, a0, a1
8020157a: 63 0e 55 01  	beq	a0, s5, 0x80201596 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hff577ac6e379d064E.llvm.627776411115031865+0x90>
8020157e: 91 04        	addi	s1, s1, 4
80201580: 45 bf        	j	0x80201530 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hff577ac6e379d064E.llvm.627776411115031865+0x2a>
80201582: 89 04        	addi	s1, s1, 2
80201584: 13 95 65 00  	slli	a0, a1, 6
80201588: 51 8d        	or	a0, a0, a2
8020158a: 5d b7        	j	0x80201530 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hff577ac6e379d064E.llvm.627776411115031865+0x2a>
8020158c: 8d 04        	addi	s1, s1, 3
8020158e: 13 95 c5 00  	slli	a0, a1, 12
80201592: 51 8d        	or	a0, a0, a2
80201594: 71 bf        	j	0x80201530 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hff577ac6e379d064E.llvm.627776411115031865+0x2a>
80201596: 01 45        	li	a0, 0
80201598: e2 70        	ld	ra, 56(sp)
8020159a: 42 74        	ld	s0, 48(sp)
8020159c: a2 74        	ld	s1, 40(sp)
8020159e: 02 79        	ld	s2, 32(sp)
802015a0: e2 69        	ld	s3, 24(sp)
802015a2: 42 6a        	ld	s4, 16(sp)
802015a4: a2 6a        	ld	s5, 8(sp)
802015a6: 21 61        	addi	sp, sp, 64
802015a8: 82 80        	ret

Disassembly of section .text._ZN4sel47console5print17hac8e0d72989ef035E:

00000000802015aa <_ZN4sel47console5print17hac8e0d72989ef035E>:
802015aa: 5d 71        	addi	sp, sp, -80
802015ac: 86 e4        	sd	ra, 72(sp)
802015ae: a2 e0        	sd	s0, 64(sp)
802015b0: 80 08        	addi	s0, sp, 80
802015b2: 0c 75        	ld	a1, 40(a0)
802015b4: 10 71        	ld	a2, 32(a0)
802015b6: 93 06 84 fe  	addi	a3, s0, -24
802015ba: 23 38 d4 fa  	sd	a3, -80(s0)
802015be: 23 30 b4 fe  	sd	a1, -32(s0)
802015c2: 23 3c c4 fc  	sd	a2, -40(s0)
802015c6: 0c 6d        	ld	a1, 24(a0)
802015c8: 10 69        	ld	a2, 16(a0)
802015ca: 14 65        	ld	a3, 8(a0)
802015cc: 08 61        	ld	a0, 0(a0)
802015ce: 23 38 b4 fc  	sd	a1, -48(s0)
802015d2: 23 34 c4 fc  	sd	a2, -56(s0)
802015d6: 23 30 d4 fc  	sd	a3, -64(s0)
802015da: 23 3c a4 fa  	sd	a0, -72(s0)

00000000802015de <.LBB4_3>:
802015de: 97 15 00 00  	auipc	a1, 1
802015e2: 93 85 a5 5b  	addi	a1, a1, 1466
802015e6: 13 05 04 fb  	addi	a0, s0, -80
802015ea: 13 06 84 fb  	addi	a2, s0, -72
802015ee: 97 00 00 00  	auipc	ra, 0
802015f2: e7 80 40 76  	jalr	1892(ra)
802015f6: 09 e5        	bnez	a0, 0x80201600 <.LBB4_4>
802015f8: a6 60        	ld	ra, 72(sp)
802015fa: 06 64        	ld	s0, 64(sp)
802015fc: 61 61        	addi	sp, sp, 80
802015fe: 82 80        	ret

0000000080201600 <.LBB4_4>:
80201600: 17 15 00 00  	auipc	a0, 1
80201604: 13 05 85 5c  	addi	a0, a0, 1480

0000000080201608 <.LBB4_5>:
80201608: 97 16 00 00  	auipc	a3, 1
8020160c: 93 86 06 5f  	addi	a3, a3, 1520

0000000080201610 <.LBB4_6>:
80201610: 17 17 00 00  	auipc	a4, 1
80201614: 13 07 87 61  	addi	a4, a4, 1560
80201618: 93 05 b0 02  	li	a1, 43
8020161c: 13 06 84 fe  	addi	a2, s0, -24
80201620: 97 00 00 00  	auipc	ra, 0
80201624: e7 80 40 6b  	jalr	1716(ra)
80201628: 00 00        	unimp	

Disassembly of section .text.rust_begin_unwind:

000000008020162a <rust_begin_unwind>:
8020162a: 6d 71        	addi	sp, sp, -272
8020162c: 06 e6        	sd	ra, 264(sp)
8020162e: 22 e2        	sd	s0, 256(sp)
80201630: a6 fd        	sd	s1, 248(sp)
80201632: 00 0a        	addi	s0, sp, 272
80201634: aa 84        	mv	s1, a0
80201636: 97 00 00 00  	auipc	ra, 0
8020163a: e7 80 00 60  	jalr	1536(ra)
8020163e: 15 e5        	bnez	a0, 0x8020166a <.LBB0_10+0x16>
80201640: 26 85        	mv	a0, s1
80201642: 97 00 00 00  	auipc	ra, 0
80201646: e7 80 00 5f  	jalr	1520(ra)
8020164a: 31 ed        	bnez	a0, 0x802016a6 <.LBB0_12+0x16>

000000008020164c <.LBB0_9>:
8020164c: 17 15 00 00  	auipc	a0, 1
80201650: 13 05 45 69  	addi	a0, a0, 1684

0000000080201654 <.LBB0_10>:
80201654: 17 16 00 00  	auipc	a2, 1
80201658: 13 06 c6 6c  	addi	a2, a2, 1740
8020165c: 93 05 b0 02  	li	a1, 43
80201660: 97 00 00 00  	auipc	ra, 0
80201664: e7 80 80 60  	jalr	1544(ra)
80201668: 00 00        	unimp	
8020166a: 0c 61        	ld	a1, 0(a0)
8020166c: 10 65        	ld	a2, 8(a0)
8020166e: 23 30 b4 f2  	sd	a1, -224(s0)
80201672: 23 34 c4 f2  	sd	a2, -216(s0)
80201676: 08 49        	lw	a0, 16(a0)
80201678: 23 2a a4 f2  	sw	a0, -204(s0)
8020167c: 26 85        	mv	a0, s1
8020167e: 97 00 00 00  	auipc	ra, 0
80201682: e7 80 40 5b  	jalr	1460(ra)
80201686: 7d e5        	bnez	a0, 0x80201774 <.LBB0_18+0x24>

0000000080201688 <.LBB0_11>:
80201688: 17 15 00 00  	auipc	a0, 1
8020168c: 13 05 85 65  	addi	a0, a0, 1624

0000000080201690 <.LBB0_12>:
80201690: 17 16 00 00  	auipc	a2, 1
80201694: 13 06 06 70  	addi	a2, a2, 1792
80201698: 93 05 b0 02  	li	a1, 43
8020169c: 97 00 00 00  	auipc	ra, 0
802016a0: e7 80 c0 5c  	jalr	1484(ra)
802016a4: 00 00        	unimp	
802016a6: 23 34 a4 fa  	sd	a0, -88(s0)
802016aa: 13 05 84 fa  	addi	a0, s0, -88
802016ae: 23 38 a4 ee  	sd	a0, -272(s0)

00000000802016b2 <.LBB0_13>:
802016b2: 17 05 00 00  	auipc	a0, 0
802016b6: 13 05 e5 aa  	addi	a0, a0, -1362
802016ba: 23 3c a4 ee  	sd	a0, -264(s0)

00000000802016be <.LBB0_14>:
802016be: 17 15 00 00  	auipc	a0, 1
802016c2: 13 05 25 60  	addi	a0, a0, 1538
802016c6: 23 38 a4 f4  	sd	a0, -176(s0)
802016ca: 09 45        	li	a0, 2
802016cc: 23 3c a4 f4  	sd	a0, -168(s0)
802016d0: 23 30 04 f4  	sd	zero, -192(s0)
802016d4: 13 05 04 ef  	addi	a0, s0, -272
802016d8: 23 30 a4 f6  	sd	a0, -160(s0)
802016dc: 05 45        	li	a0, 1
802016de: 23 34 a4 f6  	sd	a0, -152(s0)
802016e2: 7d 45        	li	a0, 31
802016e4: 23 0a a4 f2  	sb	a0, -204(s0)
802016e8: 13 05 10 03  	li	a0, 49
802016ec: 23 0c a4 f2  	sb	a0, -200(s0)
802016f0: 13 05 44 f3  	addi	a0, s0, -204
802016f4: 23 38 a4 f6  	sd	a0, -144(s0)

00000000802016f8 <.LBB0_15>:
802016f8: 17 15 00 00  	auipc	a0, 1
802016fc: 13 05 a5 fc  	addi	a0, a0, -54
80201700: 23 3c a4 f6  	sd	a0, -136(s0)
80201704: 93 05 84 f3  	addi	a1, s0, -200
80201708: 23 30 b4 f8  	sd	a1, -128(s0)
8020170c: 23 34 a4 f8  	sd	a0, -120(s0)
80201710: 13 05 04 f4  	addi	a0, s0, -192
80201714: 23 38 a4 f8  	sd	a0, -112(s0)

0000000080201718 <.LBB0_16>:
80201718: 17 05 00 00  	auipc	a0, 0
8020171c: 13 05 85 60  	addi	a0, a0, 1544
80201720: 23 3c a4 f8  	sd	a0, -104(s0)
80201724: 13 05 04 fe  	addi	a0, s0, -32
80201728: 23 30 a4 f2  	sd	a0, -224(s0)
8020172c: 23 38 04 fa  	sd	zero, -80(s0)

0000000080201730 <.LBB0_17>:
80201730: 17 15 00 00  	auipc	a0, 1
80201734: 13 05 05 52  	addi	a0, a0, 1312
80201738: 23 30 a4 fc  	sd	a0, -64(s0)
8020173c: 11 45        	li	a0, 4
8020173e: 23 34 a4 fc  	sd	a0, -56(s0)
80201742: 13 05 04 f7  	addi	a0, s0, -144
80201746: 23 38 a4 fc  	sd	a0, -48(s0)
8020174a: 0d 45        	li	a0, 3
8020174c: 23 3c a4 fc  	sd	a0, -40(s0)

0000000080201750 <.LBB0_18>:
80201750: 97 15 00 00  	auipc	a1, 1
80201754: 93 85 85 44  	addi	a1, a1, 1096
80201758: 13 05 04 f2  	addi	a0, s0, -224
8020175c: 13 06 04 fb  	addi	a2, s0, -80
80201760: 97 00 00 00  	auipc	ra, 0
80201764: e7 80 20 5f  	jalr	1522(ra)
80201768: 75 e9        	bnez	a0, 0x8020185c <.LBB0_27>
8020176a: 97 00 00 00  	auipc	ra, 0
8020176e: e7 80 60 9a  	jalr	-1626(ra)
80201772: 00 00        	unimp	
80201774: 23 3c a4 f2  	sd	a0, -200(s0)
80201778: 13 05 04 f2  	addi	a0, s0, -224
8020177c: 23 30 a4 f4  	sd	a0, -192(s0)

0000000080201780 <.LBB0_19>:
80201780: 17 05 00 00  	auipc	a0, 0
80201784: 13 05 85 9f  	addi	a0, a0, -1544
80201788: 23 34 a4 f4  	sd	a0, -184(s0)
8020178c: 13 05 44 f3  	addi	a0, s0, -204
80201790: 23 38 a4 f4  	sd	a0, -176(s0)

0000000080201794 <.LBB0_20>:
80201794: 17 15 00 00  	auipc	a0, 1
80201798: 13 05 e5 f3  	addi	a0, a0, -194
8020179c: 23 3c a4 f4  	sd	a0, -168(s0)
802017a0: 13 05 84 f3  	addi	a0, s0, -200
802017a4: 23 30 a4 f6  	sd	a0, -160(s0)

00000000802017a8 <.LBB0_21>:
802017a8: 17 05 00 00  	auipc	a0, 0
802017ac: 13 05 85 9b  	addi	a0, a0, -1608
802017b0: 23 34 a4 f6  	sd	a0, -152(s0)

00000000802017b4 <.LBB0_22>:
802017b4: 17 15 00 00  	auipc	a0, 1
802017b8: 13 05 c5 59  	addi	a0, a0, 1436
802017bc: 23 30 a4 f0  	sd	a0, -256(s0)
802017c0: 11 45        	li	a0, 4
802017c2: 23 34 a4 f0  	sd	a0, -248(s0)
802017c6: 23 38 04 ee  	sd	zero, -272(s0)
802017ca: 93 05 04 f4  	addi	a1, s0, -192
802017ce: 23 38 b4 f0  	sd	a1, -240(s0)
802017d2: 8d 45        	li	a1, 3
802017d4: 23 3c b4 f0  	sd	a1, -232(s0)
802017d8: 7d 46        	li	a2, 31
802017da: 23 03 c4 fa  	sb	a2, -90(s0)
802017de: 13 06 10 03  	li	a2, 49
802017e2: a3 03 c4 fa  	sb	a2, -89(s0)
802017e6: 13 06 64 fa  	addi	a2, s0, -90
802017ea: 23 38 c4 f6  	sd	a2, -144(s0)

00000000802017ee <.LBB0_23>:
802017ee: 17 16 00 00  	auipc	a2, 1
802017f2: 13 06 46 ed  	addi	a2, a2, -300
802017f6: 23 3c c4 f6  	sd	a2, -136(s0)
802017fa: 93 06 74 fa  	addi	a3, s0, -89
802017fe: 23 30 d4 f8  	sd	a3, -128(s0)
80201802: 23 34 c4 f8  	sd	a2, -120(s0)
80201806: 13 06 04 ef  	addi	a2, s0, -272
8020180a: 23 38 c4 f8  	sd	a2, -112(s0)

000000008020180e <.LBB0_24>:
8020180e: 17 06 00 00  	auipc	a2, 0
80201812: 13 06 26 51  	addi	a2, a2, 1298
80201816: 23 3c c4 f8  	sd	a2, -104(s0)
8020181a: 13 06 04 fe  	addi	a2, s0, -32
8020181e: 23 34 c4 fa  	sd	a2, -88(s0)
80201822: 23 38 04 fa  	sd	zero, -80(s0)

0000000080201826 <.LBB0_25>:
80201826: 17 16 00 00  	auipc	a2, 1
8020182a: 13 06 a6 42  	addi	a2, a2, 1066
8020182e: 23 30 c4 fc  	sd	a2, -64(s0)
80201832: 23 34 a4 fc  	sd	a0, -56(s0)
80201836: 13 05 04 f7  	addi	a0, s0, -144
8020183a: 23 38 a4 fc  	sd	a0, -48(s0)
8020183e: 23 3c b4 fc  	sd	a1, -40(s0)

0000000080201842 <.LBB0_26>:
80201842: 97 15 00 00  	auipc	a1, 1
80201846: 93 85 65 35  	addi	a1, a1, 854
8020184a: 13 05 84 fa  	addi	a0, s0, -88
8020184e: 13 06 04 fb  	addi	a2, s0, -80
80201852: 97 00 00 00  	auipc	ra, 0
80201856: e7 80 00 50  	jalr	1280(ra)
8020185a: 01 d9        	beqz	a0, 0x8020176a <.LBB0_18+0x1a>

000000008020185c <.LBB0_27>:
8020185c: 17 15 00 00  	auipc	a0, 1
80201860: 13 05 c5 36  	addi	a0, a0, 876

0000000080201864 <.LBB0_28>:
80201864: 97 16 00 00  	auipc	a3, 1
80201868: 93 86 46 39  	addi	a3, a3, 916

000000008020186c <.LBB0_29>:
8020186c: 17 17 00 00  	auipc	a4, 1
80201870: 13 07 47 42  	addi	a4, a4, 1060
80201874: 93 05 b0 02  	li	a1, 43
80201878: 13 06 04 fe  	addi	a2, s0, -32
8020187c: 97 00 00 00  	auipc	ra, 0
80201880: e7 80 80 45  	jalr	1112(ra)
80201884: 00 00        	unimp	

Disassembly of section .text.__rust_dealloc:

0000000080201886 <__rust_dealloc>:
80201886: 17 03 00 00  	auipc	t1, 0
8020188a: 67 00 83 a1  	jr	-1512(t1)

Disassembly of section .text._ZN22buddy_system_allocator4Heap4init17h096a9c186af21a8bE:

000000008020188e <_ZN22buddy_system_allocator4Heap4init17h096a9c186af21a8bE>:
8020188e: 41 11        	addi	sp, sp, -16
80201890: 06 e4        	sd	ra, 8(sp)
80201892: 22 e0        	sd	s0, 0(sp)
80201894: 00 08        	addi	s0, sp, 16
80201896: 2e 96        	add	a2, a2, a1
80201898: 9d 05        	addi	a1, a1, 7
8020189a: e1 99        	andi	a1, a1, -8
8020189c: 93 7e 86 ff  	andi	t4, a2, -8
802018a0: 63 eb be 12  	bltu	t4, a1, 0x802019d6 <.LBB5_20>
802018a4: 01 47        	li	a4, 0
802018a6: 13 86 85 00  	addi	a2, a1, 8
802018aa: 63 e1 ce 10  	bltu	t4, a2, 0x802019ac <.LBB5_18+0xda>

00000000802018ae <.LBB5_15>:
802018ae: 17 16 00 00  	auipc	a2, 1
802018b2: 13 06 26 e9  	addi	a2, a2, -366
802018b6: 03 38 06 00  	ld	a6, 0(a2)

00000000802018ba <.LBB5_16>:
802018ba: 17 16 00 00  	auipc	a2, 1
802018be: 13 06 e6 e8  	addi	a2, a2, -370
802018c2: 03 3f 06 00  	ld	t5, 0(a2)

00000000802018c6 <.LBB5_17>:
802018c6: 17 16 00 00  	auipc	a2, 1
802018ca: 13 06 a6 e8  	addi	a2, a2, -374
802018ce: 83 38 06 00  	ld	a7, 0(a2)

00000000802018d2 <.LBB5_18>:
802018d2: 17 16 00 00  	auipc	a2, 1
802018d6: 13 06 66 e8  	addi	a2, a2, -378
802018da: 83 32 06 00  	ld	t0, 0(a2)
802018de: 13 03 f0 03  	li	t1, 63
802018e2: 85 43        	li	t2, 1
802018e4: 7d 4e        	li	t3, 31
802018e6: 33 86 be 40  	sub	a2, t4, a1
802018ea: 31 ca        	beqz	a2, 0x8020193e <.LBB5_18+0x6c>
802018ec: 93 56 16 00  	srli	a3, a2, 1
802018f0: 55 8e        	or	a2, a2, a3
802018f2: 93 56 26 00  	srli	a3, a2, 2
802018f6: 55 8e        	or	a2, a2, a3
802018f8: 93 56 46 00  	srli	a3, a2, 4
802018fc: 55 8e        	or	a2, a2, a3
802018fe: 93 56 86 00  	srli	a3, a2, 8
80201902: 55 8e        	or	a2, a2, a3
80201904: 93 56 06 01  	srli	a3, a2, 16
80201908: 55 8e        	or	a2, a2, a3
8020190a: 93 56 06 02  	srli	a3, a2, 32
8020190e: 55 8e        	or	a2, a2, a3
80201910: 13 46 f6 ff  	not	a2, a2
80201914: 93 56 16 00  	srli	a3, a2, 1
80201918: b3 f6 06 01  	and	a3, a3, a6
8020191c: 15 8e        	sub	a2, a2, a3
8020191e: b3 76 e6 01  	and	a3, a2, t5
80201922: 09 82        	srli	a2, a2, 2
80201924: 33 76 e6 01  	and	a2, a2, t5
80201928: 36 96        	add	a2, a2, a3
8020192a: 93 56 46 00  	srli	a3, a2, 4
8020192e: 36 96        	add	a2, a2, a3
80201930: 33 76 16 01  	and	a2, a2, a7
80201934: 33 06 56 02  	mul	a2, a2, t0
80201938: 93 56 86 03  	srli	a3, a2, 56
8020193c: 19 a0        	j	0x80201942 <.LBB5_18+0x70>
8020193e: 93 06 00 04  	li	a3, 64
80201942: 33 06 b0 40  	neg	a2, a1
80201946: 6d 8e        	and	a2, a2, a1
80201948: b3 06 d3 40  	sub	a3, t1, a3
8020194c: b3 96 d3 00  	sll	a3, t2, a3
80201950: 63 63 d6 00  	bltu	a2, a3, 0x80201956 <.LBB5_18+0x84>
80201954: 36 86        	mv	a2, a3
80201956: 05 ce        	beqz	a2, 0x8020198e <.LBB5_18+0xbc>
80201958: 93 06 f6 ff  	addi	a3, a2, -1
8020195c: 93 47 f6 ff  	not	a5, a2
80201960: fd 8e        	and	a3, a3, a5
80201962: 93 d7 16 00  	srli	a5, a3, 1
80201966: b3 f7 07 01  	and	a5, a5, a6
8020196a: 9d 8e        	sub	a3, a3, a5
8020196c: b3 f7 e6 01  	and	a5, a3, t5
80201970: 89 82        	srli	a3, a3, 2
80201972: b3 f6 e6 01  	and	a3, a3, t5
80201976: be 96        	add	a3, a3, a5
80201978: 93 d7 46 00  	srli	a5, a3, 4
8020197c: be 96        	add	a3, a3, a5
8020197e: b3 f6 16 01  	and	a3, a3, a7
80201982: b3 86 56 02  	mul	a3, a3, t0
80201986: e1 92        	srli	a3, a3, 56
80201988: 63 77 de 00  	bgeu	t3, a3, 0x80201996 <.LBB5_18+0xc4>
8020198c: 0d a8        	j	0x802019be <.LBB5_19>
8020198e: 93 06 00 04  	li	a3, 64
80201992: 63 66 de 02  	bltu	t3, a3, 0x802019be <.LBB5_19>
80201996: 8e 06        	slli	a3, a3, 3
80201998: aa 96        	add	a3, a3, a0
8020199a: 9c 62        	ld	a5, 0(a3)
8020199c: 9c e1        	sd	a5, 0(a1)
8020199e: 8c e2        	sd	a1, 0(a3)
802019a0: b2 95        	add	a1, a1, a2
802019a2: 93 86 85 00  	addi	a3, a1, 8
802019a6: 32 97        	add	a4, a4, a2
802019a8: e3 ff de f2  	bgeu	t4, a3, 0x802018e6 <.LBB5_18+0x14>
802019ac: 83 35 05 11  	ld	a1, 272(a0)
802019b0: ba 95        	add	a1, a1, a4
802019b2: 23 38 b5 10  	sd	a1, 272(a0)
802019b6: a2 60        	ld	ra, 8(sp)
802019b8: 02 64        	ld	s0, 0(sp)
802019ba: 41 01        	addi	sp, sp, 16
802019bc: 82 80        	ret

00000000802019be <.LBB5_19>:
802019be: 17 16 00 00  	auipc	a2, 1
802019c2: 13 06 a6 48  	addi	a2, a2, 1162
802019c6: 93 05 00 02  	li	a1, 32
802019ca: 36 85        	mv	a0, a3
802019cc: 97 00 00 00  	auipc	ra, 0
802019d0: e7 80 80 2c  	jalr	712(ra)
802019d4: 00 00        	unimp	

00000000802019d6 <.LBB5_20>:
802019d6: 17 15 00 00  	auipc	a0, 1
802019da: 13 05 25 3d  	addi	a0, a0, 978

00000000802019de <.LBB5_21>:
802019de: 17 16 00 00  	auipc	a2, 1
802019e2: 13 06 26 45  	addi	a2, a2, 1106
802019e6: f9 45        	li	a1, 30
802019e8: 97 00 00 00  	auipc	ra, 0
802019ec: e7 80 00 28  	jalr	640(ra)
802019f0: 00 00        	unimp	

Disassembly of section .text._ZN22buddy_system_allocator4Heap7dealloc17h5c5bb6edc7877f64E:

00000000802019f2 <_ZN22buddy_system_allocator4Heap7dealloc17h5c5bb6edc7877f64E>:
802019f2: 41 11        	addi	sp, sp, -16
802019f4: 06 e4        	sd	ra, 8(sp)
802019f6: 22 e0        	sd	s0, 0(sp)
802019f8: 00 08        	addi	s0, sp, 16
802019fa: 05 47        	li	a4, 1
802019fc: 89 47        	li	a5, 2

00000000802019fe <.LBB7_22>:
802019fe: 17 13 00 00  	auipc	t1, 1
80201a02: 13 03 23 d8  	addi	t1, t1, -638

0000000080201a06 <.LBB7_23>:
80201a06: 97 12 00 00  	auipc	t0, 1
80201a0a: 93 82 22 d8  	addi	t0, t0, -638

0000000080201a0e <.LBB7_24>:
80201a0e: 97 18 00 00  	auipc	a7, 1
80201a12: 93 88 28 d8  	addi	a7, a7, -638

0000000080201a16 <.LBB7_25>:
80201a16: 17 18 00 00  	auipc	a6, 1
80201a1a: 13 08 28 d8  	addi	a6, a6, -638
80201a1e: 63 7d f6 0c  	bgeu	a2, a5, 0x80201af8 <.LBB7_25+0xe2>
80201a22: 63 72 d7 14  	bgeu	a4, a3, 0x80201b66 <.LBB7_25+0x150>
80201a26: 21 47        	li	a4, 8
80201a28: 63 73 d7 14  	bgeu	a4, a3, 0x80201b6e <.LBB7_25+0x158>
80201a2c: 63 84 06 14  	beqz	a3, 0x80201b74 <.LBB7_25+0x15e>
80201a30: 93 83 f6 ff  	addi	t2, a3, -1
80201a34: 93 c7 f6 ff  	not	a5, a3
80201a38: 03 33 03 00  	ld	t1, 0(t1)
80201a3c: b3 f3 77 00  	and	t2, a5, t2
80201a40: 03 b7 02 00  	ld	a4, 0(t0)
80201a44: 93 d7 13 00  	srli	a5, t2, 1
80201a48: b3 f7 67 00  	and	a5, a5, t1
80201a4c: b3 87 f3 40  	sub	a5, t2, a5
80201a50: b3 f2 e7 00  	and	t0, a5, a4
80201a54: 89 83        	srli	a5, a5, 2
80201a56: 7d 8f        	and	a4, a4, a5
80201a58: 16 97        	add	a4, a4, t0
80201a5a: 83 b8 08 00  	ld	a7, 0(a7)
80201a5e: 03 38 08 00  	ld	a6, 0(a6)
80201a62: 93 57 47 00  	srli	a5, a4, 4
80201a66: 3e 97        	add	a4, a4, a5
80201a68: 33 77 17 01  	and	a4, a4, a7
80201a6c: 33 07 07 03  	mul	a4, a4, a6
80201a70: 13 53 87 03  	srli	t1, a4, 56
80201a74: 7d 48        	li	a6, 31
80201a76: 63 64 68 10  	bltu	a6, t1, 0x80201b7e <.LBB7_26>
80201a7a: 13 17 33 00  	slli	a4, t1, 3
80201a7e: 2a 97        	add	a4, a4, a0
80201a80: 1c 63        	ld	a5, 0(a4)
80201a82: 9c e1        	sd	a5, 0(a1)
80201a84: 0c e3        	sd	a1, 0(a4)
80201a86: 85 48        	li	a7, 1
80201a88: ae 82        	mv	t0, a1
80201a8a: 33 97 68 00  	sll	a4, a7, t1
80201a8e: 93 17 33 00  	slli	a5, t1, 3
80201a92: b3 03 f5 00  	add	t2, a0, a5
80201a96: 33 4e 57 00  	xor	t3, a4, t0
80201a9a: 1e 87        	mv	a4, t2
80201a9c: 9d cd        	beqz	a1, 0x80201ada <.LBB7_25+0xc4>
80201a9e: ae 87        	mv	a5, a1
80201aa0: ba 8e        	mv	t4, a4
80201aa2: 8c 61        	ld	a1, 0(a1)
80201aa4: 3e 87        	mv	a4, a5
80201aa6: e3 1b fe fe  	bne	t3, a5, 0x80201a9c <.LBB7_25+0x86>
80201aaa: 23 b0 be 00  	sd	a1, 0(t4)
80201aae: 83 b5 03 00  	ld	a1, 0(t2)
80201ab2: 81 c5        	beqz	a1, 0x80201aba <.LBB7_25+0xa4>
80201ab4: 8c 61        	ld	a1, 0(a1)
80201ab6: 23 b0 b3 00  	sd	a1, 0(t2)
80201aba: 63 0e 03 0d  	beq	t1, a6, 0x80201b96 <.LBB7_27>
80201abe: 63 e3 c2 01  	bltu	t0, t3, 0x80201ac4 <.LBB7_25+0xae>
80201ac2: f2 82        	mv	t0, t3
80201ac4: 05 03        	addi	t1, t1, 1
80201ac6: 93 15 33 00  	slli	a1, t1, 3
80201aca: aa 95        	add	a1, a1, a0
80201acc: 98 61        	ld	a4, 0(a1)
80201ace: 23 b0 e2 00  	sd	a4, 0(t0)
80201ad2: 23 b0 55 00  	sd	t0, 0(a1)
80201ad6: 96 85        	mv	a1, t0
80201ad8: 4d bf        	j	0x80201a8a <.LBB7_25+0x74>
80201ada: 83 35 05 10  	ld	a1, 256(a0)
80201ade: 03 37 85 10  	ld	a4, 264(a0)
80201ae2: 91 8d        	sub	a1, a1, a2
80201ae4: 23 30 b5 10  	sd	a1, 256(a0)
80201ae8: b3 05 d7 40  	sub	a1, a4, a3
80201aec: 23 34 b5 10  	sd	a1, 264(a0)
80201af0: a2 60        	ld	ra, 8(sp)
80201af2: 02 64        	ld	s0, 0(sp)
80201af4: 41 01        	addi	sp, sp, 16
80201af6: 82 80        	ret
80201af8: 13 07 f6 ff  	addi	a4, a2, -1
80201afc: 93 57 17 00  	srli	a5, a4, 1
80201b00: 5d 8f        	or	a4, a4, a5
80201b02: 93 57 27 00  	srli	a5, a4, 2
80201b06: 5d 8f        	or	a4, a4, a5
80201b08: 93 57 47 00  	srli	a5, a4, 4
80201b0c: 5d 8f        	or	a4, a4, a5
80201b0e: 93 57 87 00  	srli	a5, a4, 8
80201b12: 5d 8f        	or	a4, a4, a5
80201b14: 93 57 07 01  	srli	a5, a4, 16
80201b18: 5d 8f        	or	a4, a4, a5
80201b1a: 93 57 07 02  	srli	a5, a4, 32
80201b1e: 5d 8f        	or	a4, a4, a5
80201b20: 83 33 03 00  	ld	t2, 0(t1)
80201b24: 13 4e f7 ff  	not	t3, a4
80201b28: 83 b7 02 00  	ld	a5, 0(t0)
80201b2c: 13 57 1e 00  	srli	a4, t3, 1
80201b30: 33 77 77 00  	and	a4, a4, t2
80201b34: 33 07 ee 40  	sub	a4, t3, a4
80201b38: b3 73 f7 00  	and	t2, a4, a5
80201b3c: 09 83        	srli	a4, a4, 2
80201b3e: 7d 8f        	and	a4, a4, a5
80201b40: 1e 97        	add	a4, a4, t2
80201b42: 83 b3 08 00  	ld	t2, 0(a7)
80201b46: 03 3e 08 00  	ld	t3, 0(a6)
80201b4a: 93 57 47 00  	srli	a5, a4, 4
80201b4e: 3e 97        	add	a4, a4, a5
80201b50: 33 77 77 00  	and	a4, a4, t2
80201b54: 33 07 c7 03  	mul	a4, a4, t3
80201b58: 61 93        	srli	a4, a4, 56
80201b5a: fd 57        	li	a5, -1
80201b5c: 33 d7 e7 00  	srl	a4, a5, a4
80201b60: 05 07        	addi	a4, a4, 1
80201b62: e3 62 d7 ec  	bltu	a4, a3, 0x80201a26 <.LBB7_25+0x10>
80201b66: ba 86        	mv	a3, a4
80201b68: 21 47        	li	a4, 8
80201b6a: e3 61 d7 ec  	bltu	a4, a3, 0x80201a2c <.LBB7_25+0x16>
80201b6e: a1 46        	li	a3, 8
80201b70: e3 90 06 ec  	bnez	a3, 0x80201a30 <.LBB7_25+0x1a>
80201b74: 13 03 00 04  	li	t1, 64
80201b78: 7d 48        	li	a6, 31
80201b7a: e3 70 68 f0  	bgeu	a6, t1, 0x80201a7a <.LBB7_25+0x64>

0000000080201b7e <.LBB7_26>:
80201b7e: 17 16 00 00  	auipc	a2, 1
80201b82: 13 06 26 2e  	addi	a2, a2, 738
80201b86: 93 05 00 02  	li	a1, 32
80201b8a: 1a 85        	mv	a0, t1
80201b8c: 97 00 00 00  	auipc	ra, 0
80201b90: e7 80 80 10  	jalr	264(ra)
80201b94: 00 00        	unimp	

0000000080201b96 <.LBB7_27>:
80201b96: 17 16 00 00  	auipc	a2, 1
80201b9a: 13 06 26 2e  	addi	a2, a2, 738
80201b9e: 13 05 00 02  	li	a0, 32
80201ba2: 93 05 00 02  	li	a1, 32
80201ba6: 97 00 00 00  	auipc	ra, 0
80201baa: e7 80 e0 0e  	jalr	238(ra)
80201bae: 00 00        	unimp	

Disassembly of section .text._ZN78_$LT$buddy_system_allocator..LockedHeap$u20$as$u20$core..ops..deref..Deref$GT$5deref17h2474381731d24de7E:

0000000080201bb0 <_ZN88_$LT$buddy_system_allocator..LockedHeapWithRescue$u20$as$u20$core..ops..deref..Deref$GT$5deref17h1624b06b126ab7f3E>:
80201bb0: 41 11        	addi	sp, sp, -16
80201bb2: 06 e4        	sd	ra, 8(sp)
80201bb4: 22 e0        	sd	s0, 0(sp)
80201bb6: 00 08        	addi	s0, sp, 16
80201bb8: a2 60        	ld	ra, 8(sp)
80201bba: 02 64        	ld	s0, 0(sp)
80201bbc: 41 01        	addi	sp, sp, 16
80201bbe: 82 80        	ret

Disassembly of section .text._ZN87_$LT$buddy_system_allocator..LockedHeap$u20$as$u20$core..alloc..global..GlobalAlloc$GT$7dealloc17ha5c23284bbaeea22E:

0000000080201bc0 <_ZN97_$LT$buddy_system_allocator..LockedHeapWithRescue$u20$as$u20$core..alloc..global..GlobalAlloc$GT$7dealloc17h1ad76109b91b7e86E>:
80201bc0: 01 11        	addi	sp, sp, -32
80201bc2: 06 ec        	sd	ra, 24(sp)
80201bc4: 22 e8        	sd	s0, 16(sp)
80201bc6: 26 e4        	sd	s1, 8(sp)
80201bc8: 4a e0        	sd	s2, 0(sp)
80201bca: 00 10        	addi	s0, sp, 32
80201bcc: aa 84        	mv	s1, a0
80201bce: 05 45        	li	a0, 1
80201bd0: 2f b9 a4 00  	amoadd.d	s2, a0, (s1)
80201bd4: 88 64        	ld	a0, 8(s1)
80201bd6: 0f 00 30 02  	fence	r, rw
80201bda: 63 09 25 01  	beq	a0, s2, 0x80201bec <_ZN97_$LT$buddy_system_allocator..LockedHeapWithRescue$u20$as$u20$core..alloc..global..GlobalAlloc$GT$7dealloc17h1ad76109b91b7e86E+0x2c>
80201bde: 0f 00 00 01  	fence	w, 0
80201be2: 88 64        	ld	a0, 8(s1)
80201be4: 0f 00 30 02  	fence	r, rw
80201be8: e3 1b 25 ff  	bne	a0, s2, 0x80201bde <_ZN97_$LT$buddy_system_allocator..LockedHeapWithRescue$u20$as$u20$core..alloc..global..GlobalAlloc$GT$7dealloc17h1ad76109b91b7e86E+0x1e>
80201bec: 13 85 04 01  	addi	a0, s1, 16
80201bf0: 97 00 00 00  	auipc	ra, 0
80201bf4: e7 80 20 e0  	jalr	-510(ra)
80201bf8: 13 05 19 00  	addi	a0, s2, 1
80201bfc: 0f 00 10 03  	fence	rw, w
80201c00: 88 e4        	sd	a0, 8(s1)
80201c02: e2 60        	ld	ra, 24(sp)
80201c04: 42 64        	ld	s0, 16(sp)
80201c06: a2 64        	ld	s1, 8(sp)
80201c08: 02 69        	ld	s2, 0(sp)
80201c0a: 05 61        	addi	sp, sp, 32
80201c0c: 82 80        	ret

Disassembly of section .text._ZN4core3ops8function6FnOnce9call_once17hfd3303d23173549bE:

0000000080201c0e <_ZN4core3ops8function6FnOnce9call_once17hfd3303d23173549bE>:
80201c0e: 08 61        	ld	a0, 0(a0)
80201c10: 01 a0        	j	0x80201c10 <_ZN4core3ops8function6FnOnce9call_once17hfd3303d23173549bE+0x2>

Disassembly of section .text._ZN4core3ptr102drop_in_place$LT$$RF$core..iter..adapters..copied..Copied$LT$core..slice..iter..Iter$LT$u8$GT$$GT$$GT$17h53befd6046d0b90eE:

0000000080201c12 <_ZN4core3ptr102drop_in_place$LT$$RF$core..iter..adapters..copied..Copied$LT$core..slice..iter..Iter$LT$u8$GT$$GT$$GT$17h53befd6046d0b90eE>:
80201c12: 82 80        	ret

Disassembly of section .text._ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17hf7601e0e4f62b400E:

0000000080201c14 <_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17hf7601e0e4f62b400E>:
80201c14: 17 15 00 00  	auipc	a0, 1
80201c18: 13 05 45 c9  	addi	a0, a0, -876
80201c1c: 08 61        	ld	a0, 0(a0)
80201c1e: 82 80        	ret

Disassembly of section .text._ZN63_$LT$core..cell..BorrowMutError$u20$as$u20$core..fmt..Debug$GT$3fmt17h85b3e4f3b263bba6E:

0000000080201c20 <_ZN63_$LT$core..cell..BorrowMutError$u20$as$u20$core..fmt..Debug$GT$3fmt17h85b3e4f3b263bba6E>:
80201c20: 90 65        	ld	a2, 8(a1)
80201c22: 88 61        	ld	a0, 0(a1)
80201c24: 1c 6e        	ld	a5, 24(a2)

0000000080201c26 <.LBB112_1>:
80201c26: 97 15 00 00  	auipc	a1, 1
80201c2a: 93 85 a5 28  	addi	a1, a1, 650
80201c2e: 39 46        	li	a2, 14
80201c30: 82 87        	jr	a5

Disassembly of section .text._ZN4core5panic10panic_info9PanicInfo7message17hcb7a5a3e466be904E:

0000000080201c32 <_ZN4core5panic10panic_info9PanicInfo7message17hcb7a5a3e466be904E>:
80201c32: 08 69        	ld	a0, 16(a0)
80201c34: 82 80        	ret

Disassembly of section .text._ZN4core5panic10panic_info9PanicInfo8location17h43d8a14288f989fbE:

0000000080201c36 <_ZN4core5panic10panic_info9PanicInfo8location17h43d8a14288f989fbE>:
80201c36: 08 6d        	ld	a0, 24(a0)
80201c38: 82 80        	ret

Disassembly of section .text.unlikely._ZN4core9panicking9panic_fmt17h09608ae52bd0d3adE:

0000000080201c3a <_ZN4core9panicking9panic_fmt17h09608ae52bd0d3adE>:
80201c3a: 79 71        	addi	sp, sp, -48
80201c3c: 06 f4        	sd	ra, 40(sp)

0000000080201c3e <.LBB169_1>:
80201c3e: 17 16 00 00  	auipc	a2, 1
80201c42: 13 06 26 25  	addi	a2, a2, 594
80201c46: 32 e0        	sd	a2, 0(sp)

0000000080201c48 <.LBB169_2>:
80201c48: 17 16 00 00  	auipc	a2, 1
80201c4c: 13 06 86 2a  	addi	a2, a2, 680
80201c50: 32 e4        	sd	a2, 8(sp)
80201c52: 2a e8        	sd	a0, 16(sp)
80201c54: 2e ec        	sd	a1, 24(sp)
80201c56: 05 45        	li	a0, 1
80201c58: 23 00 a1 02  	sb	a0, 32(sp)
80201c5c: 0a 85        	mv	a0, sp
80201c5e: 97 00 00 00  	auipc	ra, 0
80201c62: e7 80 c0 9c  	jalr	-1588(ra)
80201c66: 00 00        	unimp	

Disassembly of section .text.unlikely._ZN4core9panicking5panic17h968d2b6b541ffadfE:

0000000080201c68 <_ZN4core9panicking5panic17h968d2b6b541ffadfE>:
80201c68: 5d 71        	addi	sp, sp, -80
80201c6a: 86 e4        	sd	ra, 72(sp)
80201c6c: 2a fc        	sd	a0, 56(sp)
80201c6e: ae e0        	sd	a1, 64(sp)
80201c70: 28 18        	addi	a0, sp, 56
80201c72: 2a ec        	sd	a0, 24(sp)
80201c74: 05 45        	li	a0, 1
80201c76: 2a f0        	sd	a0, 32(sp)
80201c78: 02 e4        	sd	zero, 8(sp)

0000000080201c7a <.LBB171_1>:
80201c7a: 17 15 00 00  	auipc	a0, 1
80201c7e: 13 05 65 21  	addi	a0, a0, 534
80201c82: 2a f4        	sd	a0, 40(sp)
80201c84: 02 f8        	sd	zero, 48(sp)
80201c86: 28 00        	addi	a0, sp, 8
80201c88: b2 85        	mv	a1, a2
80201c8a: 97 00 00 00  	auipc	ra, 0
80201c8e: e7 80 00 fb  	jalr	-80(ra)
80201c92: 00 00        	unimp	

Disassembly of section .text.unlikely._ZN4core9panicking18panic_bounds_check17h03ed6527cd415bf9E:

0000000080201c94 <_ZN4core9panicking18panic_bounds_check17h03ed6527cd415bf9E>:
80201c94: 59 71        	addi	sp, sp, -112
80201c96: 86 f4        	sd	ra, 104(sp)
80201c98: 2a e4        	sd	a0, 8(sp)
80201c9a: 2e e8        	sd	a1, 16(sp)
80201c9c: 08 08        	addi	a0, sp, 16
80201c9e: aa e4        	sd	a0, 72(sp)

0000000080201ca0 <.LBB174_1>:
80201ca0: 17 15 00 00  	auipc	a0, 1
80201ca4: 13 05 25 a4  	addi	a0, a0, -1470
80201ca8: aa e8        	sd	a0, 80(sp)
80201caa: 2c 00        	addi	a1, sp, 8
80201cac: ae ec        	sd	a1, 88(sp)
80201cae: aa f0        	sd	a0, 96(sp)

0000000080201cb0 <.LBB174_2>:
80201cb0: 17 15 00 00  	auipc	a0, 1
80201cb4: 13 05 05 22  	addi	a0, a0, 544
80201cb8: 2a f4        	sd	a0, 40(sp)
80201cba: 09 45        	li	a0, 2
80201cbc: 2a f8        	sd	a0, 48(sp)
80201cbe: 02 ec        	sd	zero, 24(sp)
80201cc0: ac 00        	addi	a1, sp, 72
80201cc2: 2e fc        	sd	a1, 56(sp)
80201cc4: aa e0        	sd	a0, 64(sp)
80201cc6: 28 08        	addi	a0, sp, 24
80201cc8: b2 85        	mv	a1, a2
80201cca: 97 00 00 00  	auipc	ra, 0
80201cce: e7 80 00 f7  	jalr	-144(ra)
80201cd2: 00 00        	unimp	

Disassembly of section .text.unlikely._ZN4core6result13unwrap_failed17h93c501911315d321E:

0000000080201cd4 <_ZN4core6result13unwrap_failed17h93c501911315d321E>:
80201cd4: 19 71        	addi	sp, sp, -128
80201cd6: 86 fc        	sd	ra, 120(sp)
80201cd8: 2a e4        	sd	a0, 8(sp)
80201cda: 2e e8        	sd	a1, 16(sp)
80201cdc: 32 ec        	sd	a2, 24(sp)
80201cde: 36 f0        	sd	a3, 32(sp)
80201ce0: 28 00        	addi	a0, sp, 8
80201ce2: aa ec        	sd	a0, 88(sp)

0000000080201ce4 <.LBB181_1>:
80201ce4: 17 15 00 00  	auipc	a0, 1
80201ce8: 13 05 65 a2  	addi	a0, a0, -1498
80201cec: aa f0        	sd	a0, 96(sp)
80201cee: 28 08        	addi	a0, sp, 24
80201cf0: aa f4        	sd	a0, 104(sp)

0000000080201cf2 <.LBB181_2>:
80201cf2: 17 15 00 00  	auipc	a0, 1
80201cf6: 13 05 05 a1  	addi	a0, a0, -1520
80201cfa: aa f8        	sd	a0, 112(sp)

0000000080201cfc <.LBB181_3>:
80201cfc: 17 15 00 00  	auipc	a0, 1
80201d00: 13 05 c5 21  	addi	a0, a0, 540
80201d04: 2a fc        	sd	a0, 56(sp)
80201d06: 09 45        	li	a0, 2
80201d08: aa e0        	sd	a0, 64(sp)
80201d0a: 02 f4        	sd	zero, 40(sp)
80201d0c: ac 08        	addi	a1, sp, 88
80201d0e: ae e4        	sd	a1, 72(sp)
80201d10: aa e8        	sd	a0, 80(sp)
80201d12: 28 10        	addi	a0, sp, 40
80201d14: ba 85        	mv	a1, a4
80201d16: 97 00 00 00  	auipc	ra, 0
80201d1a: e7 80 40 f2  	jalr	-220(ra)
80201d1e: 00 00        	unimp	

Disassembly of section .text._ZN59_$LT$core..fmt..Arguments$u20$as$u20$core..fmt..Display$GT$3fmt17h14b26a2a8d914ef0E:

0000000080201d20 <_ZN59_$LT$core..fmt..Arguments$u20$as$u20$core..fmt..Display$GT$3fmt17h14b26a2a8d914ef0E>:
80201d20: 39 71        	addi	sp, sp, -64
80201d22: 06 fc        	sd	ra, 56(sp)
80201d24: 10 75        	ld	a2, 40(a0)
80201d26: 18 71        	ld	a4, 32(a0)
80201d28: 1c 6d        	ld	a5, 24(a0)
80201d2a: 32 f8        	sd	a2, 48(sp)
80201d2c: 94 61        	ld	a3, 0(a1)
80201d2e: 3a f4        	sd	a4, 40(sp)
80201d30: 3e f0        	sd	a5, 32(sp)
80201d32: 10 69        	ld	a2, 16(a0)
80201d34: 18 65        	ld	a4, 8(a0)
80201d36: 08 61        	ld	a0, 0(a0)
80201d38: 8c 65        	ld	a1, 8(a1)
80201d3a: 32 ec        	sd	a2, 24(sp)
80201d3c: 3a e8        	sd	a4, 16(sp)
80201d3e: 2a e4        	sd	a0, 8(sp)
80201d40: 30 00        	addi	a2, sp, 8
80201d42: 36 85        	mv	a0, a3
80201d44: 97 00 00 00  	auipc	ra, 0
80201d48: e7 80 e0 00  	jalr	14(ra)
80201d4c: e2 70        	ld	ra, 56(sp)
80201d4e: 21 61        	addi	sp, sp, 64
80201d50: 82 80        	ret

Disassembly of section .text._ZN4core3fmt5write17h42fcd7b837de3f75E:

0000000080201d52 <_ZN4core3fmt5write17h42fcd7b837de3f75E>:
80201d52: 19 71        	addi	sp, sp, -128
80201d54: 86 fc        	sd	ra, 120(sp)
80201d56: a2 f8        	sd	s0, 112(sp)
80201d58: a6 f4        	sd	s1, 104(sp)
80201d5a: ca f0        	sd	s2, 96(sp)
80201d5c: ce ec        	sd	s3, 88(sp)
80201d5e: d2 e8        	sd	s4, 80(sp)
80201d60: d6 e4        	sd	s5, 72(sp)
80201d62: da e0        	sd	s6, 64(sp)
80201d64: b2 89        	mv	s3, a2
80201d66: 05 46        	li	a2, 1
80201d68: 16 16        	slli	a2, a2, 37
80201d6a: 32 f8        	sd	a2, 48(sp)
80201d6c: 0d 46        	li	a2, 3
80201d6e: 23 0c c1 02  	sb	a2, 56(sp)
80201d72: 03 b6 09 00  	ld	a2, 0(s3)
80201d76: 02 e8        	sd	zero, 16(sp)
80201d78: 02 f0        	sd	zero, 32(sp)
80201d7a: 2a e0        	sd	a0, 0(sp)
80201d7c: 2e e4        	sd	a1, 8(sp)
80201d7e: 69 c6        	beqz	a2, 0x80201e48 <.LBB218_31+0x9e>
80201d80: 03 b5 89 00  	ld	a0, 8(s3)
80201d84: 63 0e 05 10  	beqz	a0, 0x80201ea0 <.LBB218_31+0xf6>
80201d88: 83 b5 09 01  	ld	a1, 16(s3)
80201d8c: 93 06 f5 ff  	addi	a3, a0, -1
80201d90: 8e 06        	slli	a3, a3, 3
80201d92: 8d 82        	srli	a3, a3, 3
80201d94: 13 89 16 00  	addi	s2, a3, 1
80201d98: 93 84 85 00  	addi	s1, a1, 8
80201d9c: 93 05 80 03  	li	a1, 56
80201da0: 33 0a b5 02  	mul	s4, a0, a1
80201da4: 13 04 86 01  	addi	s0, a2, 24
80201da8: 85 4a        	li	s5, 1

0000000080201daa <.LBB218_31>:
80201daa: 17 0b 00 00  	auipc	s6, 0
80201dae: 13 0b 4b e6  	addi	s6, s6, -412
80201db2: 90 60        	ld	a2, 0(s1)
80201db4: 09 ca        	beqz	a2, 0x80201dc6 <.LBB218_31+0x1c>
80201db6: a2 66        	ld	a3, 8(sp)
80201db8: 02 65        	ld	a0, 0(sp)
80201dba: 83 b5 84 ff  	ld	a1, -8(s1)
80201dbe: 94 6e        	ld	a3, 24(a3)
80201dc0: 82 96        	jalr	a3
80201dc2: 63 11 05 10  	bnez	a0, 0x80201ec4 <.LBB218_31+0x11a>
80201dc6: 48 44        	lw	a0, 12(s0)
80201dc8: 2a da        	sw	a0, 52(sp)
80201dca: 03 05 04 01  	lb	a0, 16(s0)
80201dce: 23 0c a1 02  	sb	a0, 56(sp)
80201dd2: 0c 44        	lw	a1, 8(s0)
80201dd4: 03 b5 09 02  	ld	a0, 32(s3)
80201dd8: 2e d8        	sw	a1, 48(sp)
80201dda: 83 36 84 ff  	ld	a3, -8(s0)
80201dde: 0c 60        	ld	a1, 0(s0)
80201de0: 89 ce        	beqz	a3, 0x80201dfa <.LBB218_31+0x50>
80201de2: 01 46        	li	a2, 0
80201de4: 63 9c 56 01  	bne	a3, s5, 0x80201dfc <.LBB218_31+0x52>
80201de8: 92 05        	slli	a1, a1, 4
80201dea: aa 95        	add	a1, a1, a0
80201dec: 90 65        	ld	a2, 8(a1)
80201dee: 63 04 66 01  	beq	a2, s6, 0x80201df6 <.LBB218_31+0x4c>
80201df2: 01 46        	li	a2, 0
80201df4: 21 a0        	j	0x80201dfc <.LBB218_31+0x52>
80201df6: 8c 61        	ld	a1, 0(a1)
80201df8: 8c 61        	ld	a1, 0(a1)
80201dfa: 05 46        	li	a2, 1
80201dfc: 32 e8        	sd	a2, 16(sp)
80201dfe: 2e ec        	sd	a1, 24(sp)
80201e00: 83 36 84 fe  	ld	a3, -24(s0)
80201e04: 83 35 04 ff  	ld	a1, -16(s0)
80201e08: 89 ce        	beqz	a3, 0x80201e22 <.LBB218_31+0x78>
80201e0a: 01 46        	li	a2, 0
80201e0c: 63 9c 56 01  	bne	a3, s5, 0x80201e24 <.LBB218_31+0x7a>
80201e10: 92 05        	slli	a1, a1, 4
80201e12: aa 95        	add	a1, a1, a0
80201e14: 90 65        	ld	a2, 8(a1)
80201e16: 63 04 66 01  	beq	a2, s6, 0x80201e1e <.LBB218_31+0x74>
80201e1a: 01 46        	li	a2, 0
80201e1c: 21 a0        	j	0x80201e24 <.LBB218_31+0x7a>
80201e1e: 8c 61        	ld	a1, 0(a1)
80201e20: 8c 61        	ld	a1, 0(a1)
80201e22: 05 46        	li	a2, 1
80201e24: 32 f0        	sd	a2, 32(sp)
80201e26: 2e f4        	sd	a1, 40(sp)
80201e28: 0c 6c        	ld	a1, 24(s0)
80201e2a: 92 05        	slli	a1, a1, 4
80201e2c: 2e 95        	add	a0, a0, a1
80201e2e: 10 65        	ld	a2, 8(a0)
80201e30: 08 61        	ld	a0, 0(a0)
80201e32: 8a 85        	mv	a1, sp
80201e34: 02 96        	jalr	a2
80201e36: 59 e5        	bnez	a0, 0x80201ec4 <.LBB218_31+0x11a>
80201e38: c1 04        	addi	s1, s1, 16
80201e3a: 13 0a 8a fc  	addi	s4, s4, -56
80201e3e: 13 04 84 03  	addi	s0, s0, 56
80201e42: e3 18 0a f6  	bnez	s4, 0x80201db2 <.LBB218_31+0x8>
80201e46: 81 a8        	j	0x80201e96 <.LBB218_31+0xec>
80201e48: 03 b5 89 02  	ld	a0, 40(s3)
80201e4c: 31 c9        	beqz	a0, 0x80201ea0 <.LBB218_31+0xf6>
80201e4e: 83 b5 09 02  	ld	a1, 32(s3)
80201e52: 03 b6 09 01  	ld	a2, 16(s3)
80201e56: 93 06 f5 ff  	addi	a3, a0, -1
80201e5a: 92 06        	slli	a3, a3, 4
80201e5c: 91 82        	srli	a3, a3, 4
80201e5e: 13 89 16 00  	addi	s2, a3, 1
80201e62: 13 04 86 00  	addi	s0, a2, 8
80201e66: 13 1a 45 00  	slli	s4, a0, 4
80201e6a: 93 84 85 00  	addi	s1, a1, 8
80201e6e: 10 60        	ld	a2, 0(s0)
80201e70: 01 ca        	beqz	a2, 0x80201e80 <.LBB218_31+0xd6>
80201e72: a2 66        	ld	a3, 8(sp)
80201e74: 02 65        	ld	a0, 0(sp)
80201e76: 83 35 84 ff  	ld	a1, -8(s0)
80201e7a: 94 6e        	ld	a3, 24(a3)
80201e7c: 82 96        	jalr	a3
80201e7e: 39 e1        	bnez	a0, 0x80201ec4 <.LBB218_31+0x11a>
80201e80: 90 60        	ld	a2, 0(s1)
80201e82: 03 b5 84 ff  	ld	a0, -8(s1)
80201e86: 8a 85        	mv	a1, sp
80201e88: 02 96        	jalr	a2
80201e8a: 0d ed        	bnez	a0, 0x80201ec4 <.LBB218_31+0x11a>
80201e8c: 41 04        	addi	s0, s0, 16
80201e8e: 41 1a        	addi	s4, s4, -16
80201e90: c1 04        	addi	s1, s1, 16
80201e92: e3 1e 0a fc  	bnez	s4, 0x80201e6e <.LBB218_31+0xc4>
80201e96: 03 b5 89 01  	ld	a0, 24(s3)
80201e9a: 63 68 a9 00  	bltu	s2, a0, 0x80201eaa <.LBB218_31+0x100>
80201e9e: 2d a0        	j	0x80201ec8 <.LBB218_31+0x11e>
80201ea0: 01 49        	li	s2, 0
80201ea2: 03 b5 89 01  	ld	a0, 24(s3)
80201ea6: 63 71 a9 02  	bgeu	s2, a0, 0x80201ec8 <.LBB218_31+0x11e>
80201eaa: 03 b5 09 01  	ld	a0, 16(s3)
80201eae: 93 15 49 00  	slli	a1, s2, 4
80201eb2: 33 06 b5 00  	add	a2, a0, a1
80201eb6: a2 66        	ld	a3, 8(sp)
80201eb8: 02 65        	ld	a0, 0(sp)
80201eba: 0c 62        	ld	a1, 0(a2)
80201ebc: 10 66        	ld	a2, 8(a2)
80201ebe: 94 6e        	ld	a3, 24(a3)
80201ec0: 82 96        	jalr	a3
80201ec2: 19 c1        	beqz	a0, 0x80201ec8 <.LBB218_31+0x11e>
80201ec4: 05 45        	li	a0, 1
80201ec6: 11 a0        	j	0x80201eca <.LBB218_31+0x120>
80201ec8: 01 45        	li	a0, 0
80201eca: e6 70        	ld	ra, 120(sp)
80201ecc: 46 74        	ld	s0, 112(sp)
80201ece: a6 74        	ld	s1, 104(sp)
80201ed0: 06 79        	ld	s2, 96(sp)
80201ed2: e6 69        	ld	s3, 88(sp)
80201ed4: 46 6a        	ld	s4, 80(sp)
80201ed6: a6 6a        	ld	s5, 72(sp)
80201ed8: 06 6b        	ld	s6, 64(sp)
80201eda: 09 61        	addi	sp, sp, 128
80201edc: 82 80        	ret

Disassembly of section .text._ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E:

0000000080201ede <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E>:
80201ede: 59 71        	addi	sp, sp, -112
80201ee0: 86 f4        	sd	ra, 104(sp)
80201ee2: a2 f0        	sd	s0, 96(sp)
80201ee4: a6 ec        	sd	s1, 88(sp)
80201ee6: ca e8        	sd	s2, 80(sp)
80201ee8: ce e4        	sd	s3, 72(sp)
80201eea: d2 e0        	sd	s4, 64(sp)
80201eec: 56 fc        	sd	s5, 56(sp)
80201eee: 5a f8        	sd	s6, 48(sp)
80201ef0: 5e f4        	sd	s7, 40(sp)
80201ef2: 62 f0        	sd	s8, 32(sp)
80201ef4: 66 ec        	sd	s9, 24(sp)
80201ef6: 6a e8        	sd	s10, 16(sp)
80201ef8: 6e e4        	sd	s11, 8(sp)
80201efa: be 89        	mv	s3, a5
80201efc: 3a 89        	mv	s2, a4
80201efe: 36 8b        	mv	s6, a3
80201f00: 32 8a        	mv	s4, a2
80201f02: 2a 8c        	mv	s8, a0
80201f04: b9 c1        	beqz	a1, 0x80201f4a <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x6c>
80201f06: 03 64 0c 03  	lwu	s0, 48(s8)
80201f0a: 13 75 14 00  	andi	a0, s0, 1
80201f0e: b7 0a 11 00  	lui	s5, 272
80201f12: 19 c1        	beqz	a0, 0x80201f18 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x3a>
80201f14: 93 0a b0 02  	li	s5, 43
80201f18: b3 0c 35 01  	add	s9, a0, s3
80201f1c: 13 75 44 00  	andi	a0, s0, 4
80201f20: 15 cd        	beqz	a0, 0x80201f5c <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x7e>
80201f22: 13 05 00 02  	li	a0, 32
80201f26: 63 70 ab 04  	bgeu	s6, a0, 0x80201f66 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x88>
80201f2a: 01 45        	li	a0, 0
80201f2c: 63 03 0b 04  	beqz	s6, 0x80201f72 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x94>
80201f30: da 85        	mv	a1, s6
80201f32: 52 86        	mv	a2, s4
80201f34: 83 06 06 00  	lb	a3, 0(a2)
80201f38: 05 06        	addi	a2, a2, 1
80201f3a: 93 a6 06 fc  	slti	a3, a3, -64
80201f3e: 93 c6 16 00  	xori	a3, a3, 1
80201f42: fd 15        	addi	a1, a1, -1
80201f44: 36 95        	add	a0, a0, a3
80201f46: fd f5        	bnez	a1, 0x80201f34 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x56>
80201f48: 2d a0        	j	0x80201f72 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x94>
80201f4a: 03 24 0c 03  	lw	s0, 48(s8)
80201f4e: 93 8c 19 00  	addi	s9, s3, 1
80201f52: 93 0a d0 02  	li	s5, 45
80201f56: 13 75 44 00  	andi	a0, s0, 4
80201f5a: 61 f5        	bnez	a0, 0x80201f22 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x44>
80201f5c: 01 4a        	li	s4, 0
80201f5e: 03 35 0c 01  	ld	a0, 16(s8)
80201f62: 01 ed        	bnez	a0, 0x80201f7a <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x9c>
80201f64: 99 a0        	j	0x80201faa <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xcc>
80201f66: 52 85        	mv	a0, s4
80201f68: da 85        	mv	a1, s6
80201f6a: 97 00 00 00  	auipc	ra, 0
80201f6e: e7 80 c0 44  	jalr	1100(ra)
80201f72: aa 9c        	add	s9, s9, a0
80201f74: 03 35 0c 01  	ld	a0, 16(s8)
80201f78: 0d c9        	beqz	a0, 0x80201faa <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xcc>
80201f7a: 03 3d 8c 01  	ld	s10, 24(s8)
80201f7e: 63 f6 ac 03  	bgeu	s9, s10, 0x80201faa <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xcc>
80201f82: 13 75 84 00  	andi	a0, s0, 8
80201f86: 41 e5        	bnez	a0, 0x8020200e <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x130>
80201f88: 83 45 8c 03  	lbu	a1, 56(s8)
80201f8c: 0d 46        	li	a2, 3
80201f8e: 05 45        	li	a0, 1
80201f90: 63 83 c5 00  	beq	a1, a2, 0x80201f96 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xb8>
80201f94: 2e 85        	mv	a0, a1
80201f96: 93 75 35 00  	andi	a1, a0, 3
80201f9a: 33 05 9d 41  	sub	a0, s10, s9
80201f9e: e1 c1        	beqz	a1, 0x8020205e <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x180>
80201fa0: 05 46        	li	a2, 1
80201fa2: 63 91 c5 0c  	bne	a1, a2, 0x80202064 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x186>
80201fa6: 01 4d        	li	s10, 0
80201fa8: d9 a0        	j	0x8020206e <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x190>
80201faa: 03 34 0c 00  	ld	s0, 0(s8)
80201fae: 83 34 8c 00  	ld	s1, 8(s8)
80201fb2: 22 85        	mv	a0, s0
80201fb4: a6 85        	mv	a1, s1
80201fb6: 56 86        	mv	a2, s5
80201fb8: d2 86        	mv	a3, s4
80201fba: 5a 87        	mv	a4, s6
80201fbc: 97 00 00 00  	auipc	ra, 0
80201fc0: e7 80 00 14  	jalr	320(ra)
80201fc4: 85 4b        	li	s7, 1
80201fc6: 0d c1        	beqz	a0, 0x80201fe8 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x10a>
80201fc8: 5e 85        	mv	a0, s7
80201fca: a6 70        	ld	ra, 104(sp)
80201fcc: 06 74        	ld	s0, 96(sp)
80201fce: e6 64        	ld	s1, 88(sp)
80201fd0: 46 69        	ld	s2, 80(sp)
80201fd2: a6 69        	ld	s3, 72(sp)
80201fd4: 06 6a        	ld	s4, 64(sp)
80201fd6: e2 7a        	ld	s5, 56(sp)
80201fd8: 42 7b        	ld	s6, 48(sp)
80201fda: a2 7b        	ld	s7, 40(sp)
80201fdc: 02 7c        	ld	s8, 32(sp)
80201fde: e2 6c        	ld	s9, 24(sp)
80201fe0: 42 6d        	ld	s10, 16(sp)
80201fe2: a2 6d        	ld	s11, 8(sp)
80201fe4: 65 61        	addi	sp, sp, 112
80201fe6: 82 80        	ret
80201fe8: 9c 6c        	ld	a5, 24(s1)
80201fea: 22 85        	mv	a0, s0
80201fec: ca 85        	mv	a1, s2
80201fee: 4e 86        	mv	a2, s3
80201ff0: a6 70        	ld	ra, 104(sp)
80201ff2: 06 74        	ld	s0, 96(sp)
80201ff4: e6 64        	ld	s1, 88(sp)
80201ff6: 46 69        	ld	s2, 80(sp)
80201ff8: a6 69        	ld	s3, 72(sp)
80201ffa: 06 6a        	ld	s4, 64(sp)
80201ffc: e2 7a        	ld	s5, 56(sp)
80201ffe: 42 7b        	ld	s6, 48(sp)
80202000: a2 7b        	ld	s7, 40(sp)
80202002: 02 7c        	ld	s8, 32(sp)
80202004: e2 6c        	ld	s9, 24(sp)
80202006: 42 6d        	ld	s10, 16(sp)
80202008: a2 6d        	ld	s11, 8(sp)
8020200a: 65 61        	addi	sp, sp, 112
8020200c: 82 87        	jr	a5
8020200e: 03 24 4c 03  	lw	s0, 52(s8)
80202012: 13 05 00 03  	li	a0, 48
80202016: 83 45 8c 03  	lbu	a1, 56(s8)
8020201a: 2e e0        	sd	a1, 0(sp)
8020201c: 83 3d 0c 00  	ld	s11, 0(s8)
80202020: 83 34 8c 00  	ld	s1, 8(s8)
80202024: 23 2a ac 02  	sw	a0, 52(s8)
80202028: 85 4b        	li	s7, 1
8020202a: 23 0c 7c 03  	sb	s7, 56(s8)
8020202e: 6e 85        	mv	a0, s11
80202030: a6 85        	mv	a1, s1
80202032: 56 86        	mv	a2, s5
80202034: d2 86        	mv	a3, s4
80202036: 5a 87        	mv	a4, s6
80202038: 97 00 00 00  	auipc	ra, 0
8020203c: e7 80 40 0c  	jalr	196(ra)
80202040: 41 f5        	bnez	a0, 0x80201fc8 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xea>
80202042: 22 8a        	mv	s4, s0
80202044: 33 05 9d 41  	sub	a0, s10, s9
80202048: 13 04 15 00  	addi	s0, a0, 1
8020204c: 7d 14        	addi	s0, s0, -1
8020204e: 49 c4        	beqz	s0, 0x802020d8 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x1fa>
80202050: 90 70        	ld	a2, 32(s1)
80202052: 93 05 00 03  	li	a1, 48
80202056: 6e 85        	mv	a0, s11
80202058: 02 96        	jalr	a2
8020205a: 6d d9        	beqz	a0, 0x8020204c <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x16e>
8020205c: b5 b7        	j	0x80201fc8 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xea>
8020205e: 2a 8d        	mv	s10, a0
80202060: 2e 85        	mv	a0, a1
80202062: 31 a0        	j	0x8020206e <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x190>
80202064: 93 05 15 00  	addi	a1, a0, 1
80202068: 05 81        	srli	a0, a0, 1
8020206a: 13 dd 15 00  	srli	s10, a1, 1
8020206e: 83 3c 0c 00  	ld	s9, 0(s8)
80202072: 83 3d 8c 00  	ld	s11, 8(s8)
80202076: 03 24 4c 03  	lw	s0, 52(s8)
8020207a: 93 04 15 00  	addi	s1, a0, 1
8020207e: fd 14        	addi	s1, s1, -1
80202080: 89 c8        	beqz	s1, 0x80202092 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x1b4>
80202082: 03 b6 0d 02  	ld	a2, 32(s11)
80202086: 66 85        	mv	a0, s9
80202088: a2 85        	mv	a1, s0
8020208a: 02 96        	jalr	a2
8020208c: 6d d9        	beqz	a0, 0x8020207e <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x1a0>
8020208e: 85 4b        	li	s7, 1
80202090: 25 bf        	j	0x80201fc8 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xea>
80202092: 37 05 11 00  	lui	a0, 272
80202096: 85 4b        	li	s7, 1
80202098: e3 08 a4 f2  	beq	s0, a0, 0x80201fc8 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xea>
8020209c: 66 85        	mv	a0, s9
8020209e: ee 85        	mv	a1, s11
802020a0: 56 86        	mv	a2, s5
802020a2: d2 86        	mv	a3, s4
802020a4: 5a 87        	mv	a4, s6
802020a6: 97 00 00 00  	auipc	ra, 0
802020aa: e7 80 60 05  	jalr	86(ra)
802020ae: 09 fd        	bnez	a0, 0x80201fc8 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xea>
802020b0: 83 b6 8d 01  	ld	a3, 24(s11)
802020b4: 66 85        	mv	a0, s9
802020b6: ca 85        	mv	a1, s2
802020b8: 4e 86        	mv	a2, s3
802020ba: 82 96        	jalr	a3
802020bc: 11 f5        	bnez	a0, 0x80201fc8 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xea>
802020be: 81 44        	li	s1, 0
802020c0: 63 0a 9d 02  	beq	s10, s1, 0x802020f4 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x216>
802020c4: 03 b6 0d 02  	ld	a2, 32(s11)
802020c8: 85 04        	addi	s1, s1, 1
802020ca: 66 85        	mv	a0, s9
802020cc: a2 85        	mv	a1, s0
802020ce: 02 96        	jalr	a2
802020d0: 65 d9        	beqz	a0, 0x802020c0 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x1e2>
802020d2: 13 85 f4 ff  	addi	a0, s1, -1
802020d6: 05 a0        	j	0x802020f6 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x218>
802020d8: 94 6c        	ld	a3, 24(s1)
802020da: 6e 85        	mv	a0, s11
802020dc: ca 85        	mv	a1, s2
802020de: 4e 86        	mv	a2, s3
802020e0: 82 96        	jalr	a3
802020e2: e3 13 05 ee  	bnez	a0, 0x80201fc8 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xea>
802020e6: 81 4b        	li	s7, 0
802020e8: 23 2a 4c 03  	sw	s4, 52(s8)
802020ec: 02 65        	ld	a0, 0(sp)
802020ee: 23 0c ac 02  	sb	a0, 56(s8)
802020f2: d9 bd        	j	0x80201fc8 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xea>
802020f4: 6a 85        	mv	a0, s10
802020f6: b3 3b a5 01  	sltu	s7, a0, s10
802020fa: f9 b5        	j	0x80201fc8 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xea>

Disassembly of section .text._ZN4core3fmt9Formatter12pad_integral12write_prefix17h94560343c060f655E:

00000000802020fc <_ZN4core3fmt9Formatter12pad_integral12write_prefix17h94560343c060f655E>:
802020fc: 79 71        	addi	sp, sp, -48
802020fe: 06 f4        	sd	ra, 40(sp)
80202100: 22 f0        	sd	s0, 32(sp)
80202102: 26 ec        	sd	s1, 24(sp)
80202104: 4a e8        	sd	s2, 16(sp)
80202106: 4e e4        	sd	s3, 8(sp)
80202108: 9b 07 06 00  	sext.w	a5, a2
8020210c: 37 08 11 00  	lui	a6, 272
80202110: 3a 89        	mv	s2, a4
80202112: b6 84        	mv	s1, a3
80202114: 2e 84        	mv	s0, a1
80202116: aa 89        	mv	s3, a0
80202118: 63 89 07 01  	beq	a5, a6, 0x8020212a <_ZN4core3fmt9Formatter12pad_integral12write_prefix17h94560343c060f655E+0x2e>
8020211c: 14 70        	ld	a3, 32(s0)
8020211e: 4e 85        	mv	a0, s3
80202120: b2 85        	mv	a1, a2
80202122: 82 96        	jalr	a3
80202124: aa 85        	mv	a1, a0
80202126: 05 45        	li	a0, 1
80202128: 91 ed        	bnez	a1, 0x80202144 <_ZN4core3fmt9Formatter12pad_integral12write_prefix17h94560343c060f655E+0x48>
8020212a: 81 cc        	beqz	s1, 0x80202142 <_ZN4core3fmt9Formatter12pad_integral12write_prefix17h94560343c060f655E+0x46>
8020212c: 1c 6c        	ld	a5, 24(s0)
8020212e: 4e 85        	mv	a0, s3
80202130: a6 85        	mv	a1, s1
80202132: 4a 86        	mv	a2, s2
80202134: a2 70        	ld	ra, 40(sp)
80202136: 02 74        	ld	s0, 32(sp)
80202138: e2 64        	ld	s1, 24(sp)
8020213a: 42 69        	ld	s2, 16(sp)
8020213c: a2 69        	ld	s3, 8(sp)
8020213e: 45 61        	addi	sp, sp, 48
80202140: 82 87        	jr	a5
80202142: 01 45        	li	a0, 0
80202144: a2 70        	ld	ra, 40(sp)
80202146: 02 74        	ld	s0, 32(sp)
80202148: e2 64        	ld	s1, 24(sp)
8020214a: 42 69        	ld	s2, 16(sp)
8020214c: a2 69        	ld	s3, 8(sp)
8020214e: 45 61        	addi	sp, sp, 48
80202150: 82 80        	ret

Disassembly of section .text._ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E:

0000000080202152 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E>:
80202152: 5d 71        	addi	sp, sp, -80
80202154: 86 e4        	sd	ra, 72(sp)
80202156: a2 e0        	sd	s0, 64(sp)
80202158: 26 fc        	sd	s1, 56(sp)
8020215a: 4a f8        	sd	s2, 48(sp)
8020215c: 4e f4        	sd	s3, 40(sp)
8020215e: 52 f0        	sd	s4, 32(sp)
80202160: 56 ec        	sd	s5, 24(sp)
80202162: 5a e8        	sd	s6, 16(sp)
80202164: 5e e4        	sd	s7, 8(sp)
80202166: 2a 8a        	mv	s4, a0
80202168: 83 32 05 01  	ld	t0, 16(a0)
8020216c: 08 71        	ld	a0, 32(a0)
8020216e: 93 86 f2 ff  	addi	a3, t0, -1
80202172: b3 36 d0 00  	snez	a3, a3
80202176: 13 07 f5 ff  	addi	a4, a0, -1
8020217a: 33 37 e0 00  	snez	a4, a4
8020217e: f9 8e        	and	a3, a3, a4
80202180: b2 89        	mv	s3, a2
80202182: 2e 89        	mv	s2, a1
80202184: 63 9d 06 16  	bnez	a3, 0x802022fe <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x1ac>
80202188: 85 45        	li	a1, 1
8020218a: 63 18 b5 10  	bne	a0, a1, 0x8020229a <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x148>
8020218e: 03 35 8a 02  	ld	a0, 40(s4)
80202192: 81 45        	li	a1, 0
80202194: b3 06 39 01  	add	a3, s2, s3
80202198: 13 07 15 00  	addi	a4, a0, 1
8020219c: 37 03 11 00  	lui	t1, 272
802021a0: 93 08 f0 0d  	li	a7, 223
802021a4: 13 08 00 0f  	li	a6, 240
802021a8: 4a 86        	mv	a2, s2
802021aa: 01 a8        	j	0x802021ba <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x68>
802021ac: 13 05 16 00  	addi	a0, a2, 1
802021b0: 91 8d        	sub	a1, a1, a2
802021b2: aa 95        	add	a1, a1, a0
802021b4: 2a 86        	mv	a2, a0
802021b6: 63 02 64 0e  	beq	s0, t1, 0x8020229a <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x148>
802021ba: 7d 17        	addi	a4, a4, -1
802021bc: 25 c7        	beqz	a4, 0x80202224 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0xd2>
802021be: 63 0e d6 0c  	beq	a2, a3, 0x8020229a <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x148>
802021c2: 03 05 06 00  	lb	a0, 0(a2)
802021c6: 13 74 f5 0f  	andi	s0, a0, 255
802021ca: e3 51 05 fe  	bgez	a0, 0x802021ac <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x5a>
802021ce: 03 45 16 00  	lbu	a0, 1(a2)
802021d2: 93 77 f4 01  	andi	a5, s0, 31
802021d6: 93 74 f5 03  	andi	s1, a0, 63
802021da: 63 f9 88 02  	bgeu	a7, s0, 0x8020220c <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0xba>
802021de: 03 45 26 00  	lbu	a0, 2(a2)
802021e2: 9a 04        	slli	s1, s1, 6
802021e4: 13 75 f5 03  	andi	a0, a0, 63
802021e8: c9 8c        	or	s1, s1, a0
802021ea: 63 67 04 03  	bltu	s0, a6, 0x80202218 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0xc6>
802021ee: 03 45 36 00  	lbu	a0, 3(a2)
802021f2: f6 17        	slli	a5, a5, 61
802021f4: ad 93        	srli	a5, a5, 43
802021f6: 9a 04        	slli	s1, s1, 6
802021f8: 13 75 f5 03  	andi	a0, a0, 63
802021fc: 45 8d        	or	a0, a0, s1
802021fe: 33 64 f5 00  	or	s0, a0, a5
80202202: 63 0c 64 08  	beq	s0, t1, 0x8020229a <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x148>
80202206: 13 05 46 00  	addi	a0, a2, 4
8020220a: 5d b7        	j	0x802021b0 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x5e>
8020220c: 13 05 26 00  	addi	a0, a2, 2
80202210: 9a 07        	slli	a5, a5, 6
80202212: 33 e4 97 00  	or	s0, a5, s1
80202216: 69 bf        	j	0x802021b0 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x5e>
80202218: 13 05 36 00  	addi	a0, a2, 3
8020221c: b2 07        	slli	a5, a5, 12
8020221e: 33 e4 f4 00  	or	s0, s1, a5
80202222: 79 b7        	j	0x802021b0 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x5e>
80202224: 63 0b d6 06  	beq	a2, a3, 0x8020229a <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x148>
80202228: 03 05 06 00  	lb	a0, 0(a2)
8020222c: 63 53 05 04  	bgez	a0, 0x80202272 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x120>
80202230: 13 75 f5 0f  	andi	a0, a0, 255
80202234: 93 06 00 0e  	li	a3, 224
80202238: 63 6d d5 02  	bltu	a0, a3, 0x80202272 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x120>
8020223c: 93 06 00 0f  	li	a3, 240
80202240: 63 69 d5 02  	bltu	a0, a3, 0x80202272 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x120>
80202244: 83 46 16 00  	lbu	a3, 1(a2)
80202248: 03 47 26 00  	lbu	a4, 2(a2)
8020224c: 93 f6 f6 03  	andi	a3, a3, 63
80202250: 13 77 f7 03  	andi	a4, a4, 63
80202254: 03 46 36 00  	lbu	a2, 3(a2)
80202258: 76 15        	slli	a0, a0, 61
8020225a: 2d 91        	srli	a0, a0, 43
8020225c: b2 06        	slli	a3, a3, 12
8020225e: 1a 07        	slli	a4, a4, 6
80202260: d9 8e        	or	a3, a3, a4
80202262: 13 76 f6 03  	andi	a2, a2, 63
80202266: 55 8e        	or	a2, a2, a3
80202268: 51 8d        	or	a0, a0, a2
8020226a: 37 06 11 00  	lui	a2, 272
8020226e: 63 06 c5 02  	beq	a0, a2, 0x8020229a <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x148>
80202272: 85 c1        	beqz	a1, 0x80202292 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x140>
80202274: 63 fd 35 01  	bgeu	a1, s3, 0x8020228e <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x13c>
80202278: 33 05 b9 00  	add	a0, s2, a1
8020227c: 03 05 05 00  	lb	a0, 0(a0)
80202280: 13 06 00 fc  	li	a2, -64
80202284: 63 57 c5 00  	bge	a0, a2, 0x80202292 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x140>
80202288: 01 45        	li	a0, 0
8020228a: 11 e5        	bnez	a0, 0x80202296 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x144>
8020228c: 39 a0        	j	0x8020229a <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x148>
8020228e: e3 9d 35 ff  	bne	a1, s3, 0x80202288 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x136>
80202292: 4a 85        	mv	a0, s2
80202294: 19 c1        	beqz	a0, 0x8020229a <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x148>
80202296: ae 89        	mv	s3, a1
80202298: 2a 89        	mv	s2, a0
8020229a: 63 82 02 06  	beqz	t0, 0x802022fe <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x1ac>
8020229e: 03 34 8a 01  	ld	s0, 24(s4)
802022a2: 13 05 00 02  	li	a0, 32
802022a6: 63 f4 a9 04  	bgeu	s3, a0, 0x802022ee <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x19c>
802022aa: 01 45        	li	a0, 0
802022ac: 63 8e 09 00  	beqz	s3, 0x802022c8 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x176>
802022b0: ce 85        	mv	a1, s3
802022b2: 4a 86        	mv	a2, s2
802022b4: 83 06 06 00  	lb	a3, 0(a2)
802022b8: 05 06        	addi	a2, a2, 1
802022ba: 93 a6 06 fc  	slti	a3, a3, -64
802022be: 93 c6 16 00  	xori	a3, a3, 1
802022c2: fd 15        	addi	a1, a1, -1
802022c4: 36 95        	add	a0, a0, a3
802022c6: fd f5        	bnez	a1, 0x802022b4 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x162>
802022c8: 63 7b 85 02  	bgeu	a0, s0, 0x802022fe <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x1ac>
802022cc: 83 45 8a 03  	lbu	a1, 56(s4)
802022d0: 8d 46        	li	a3, 3
802022d2: 01 46        	li	a2, 0
802022d4: 63 83 d5 00  	beq	a1, a3, 0x802022da <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x188>
802022d8: 2e 86        	mv	a2, a1
802022da: 93 75 36 00  	andi	a1, a2, 3
802022de: 33 05 a4 40  	sub	a0, s0, a0
802022e2: a1 c1        	beqz	a1, 0x80202322 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x1d0>
802022e4: 05 46        	li	a2, 1
802022e6: 63 91 c5 04  	bne	a1, a2, 0x80202328 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x1d6>
802022ea: 81 4a        	li	s5, 0
802022ec: 99 a0        	j	0x80202332 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x1e0>
802022ee: 4a 85        	mv	a0, s2
802022f0: ce 85        	mv	a1, s3
802022f2: 97 00 00 00  	auipc	ra, 0
802022f6: e7 80 40 0c  	jalr	196(ra)
802022fa: e3 69 85 fc  	bltu	a0, s0, 0x802022cc <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x17a>
802022fe: 83 35 8a 00  	ld	a1, 8(s4)
80202302: 03 35 0a 00  	ld	a0, 0(s4)
80202306: 9c 6d        	ld	a5, 24(a1)
80202308: ca 85        	mv	a1, s2
8020230a: 4e 86        	mv	a2, s3
8020230c: a6 60        	ld	ra, 72(sp)
8020230e: 06 64        	ld	s0, 64(sp)
80202310: e2 74        	ld	s1, 56(sp)
80202312: 42 79        	ld	s2, 48(sp)
80202314: a2 79        	ld	s3, 40(sp)
80202316: 02 7a        	ld	s4, 32(sp)
80202318: e2 6a        	ld	s5, 24(sp)
8020231a: 42 6b        	ld	s6, 16(sp)
8020231c: a2 6b        	ld	s7, 8(sp)
8020231e: 61 61        	addi	sp, sp, 80
80202320: 82 87        	jr	a5
80202322: aa 8a        	mv	s5, a0
80202324: 2e 85        	mv	a0, a1
80202326: 31 a0        	j	0x80202332 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x1e0>
80202328: 93 05 15 00  	addi	a1, a0, 1
8020232c: 05 81        	srli	a0, a0, 1
8020232e: 93 da 15 00  	srli	s5, a1, 1
80202332: 03 3b 0a 00  	ld	s6, 0(s4)
80202336: 83 3b 8a 00  	ld	s7, 8(s4)
8020233a: 83 24 4a 03  	lw	s1, 52(s4)
8020233e: 13 04 15 00  	addi	s0, a0, 1
80202342: 7d 14        	addi	s0, s0, -1
80202344: 09 c8        	beqz	s0, 0x80202356 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x204>
80202346: 03 b6 0b 02  	ld	a2, 32(s7)
8020234a: 5a 85        	mv	a0, s6
8020234c: a6 85        	mv	a1, s1
8020234e: 02 96        	jalr	a2
80202350: 6d d9        	beqz	a0, 0x80202342 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x1f0>
80202352: 05 4a        	li	s4, 1
80202354: 2d a8        	j	0x8020238e <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x23c>
80202356: 37 05 11 00  	lui	a0, 272
8020235a: 05 4a        	li	s4, 1
8020235c: 63 89 a4 02  	beq	s1, a0, 0x8020238e <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x23c>
80202360: 83 b6 8b 01  	ld	a3, 24(s7)
80202364: 5a 85        	mv	a0, s6
80202366: ca 85        	mv	a1, s2
80202368: 4e 86        	mv	a2, s3
8020236a: 82 96        	jalr	a3
8020236c: 0d e1        	bnez	a0, 0x8020238e <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x23c>
8020236e: 01 44        	li	s0, 0
80202370: 63 8c 8a 00  	beq	s5, s0, 0x80202388 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x236>
80202374: 03 b6 0b 02  	ld	a2, 32(s7)
80202378: 05 04        	addi	s0, s0, 1
8020237a: 5a 85        	mv	a0, s6
8020237c: a6 85        	mv	a1, s1
8020237e: 02 96        	jalr	a2
80202380: 65 d9        	beqz	a0, 0x80202370 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x21e>
80202382: 13 05 f4 ff  	addi	a0, s0, -1
80202386: 11 a0        	j	0x8020238a <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x238>
80202388: 56 85        	mv	a0, s5
8020238a: 33 3a 55 01  	sltu	s4, a0, s5
8020238e: 52 85        	mv	a0, s4
80202390: a6 60        	ld	ra, 72(sp)
80202392: 06 64        	ld	s0, 64(sp)
80202394: e2 74        	ld	s1, 56(sp)
80202396: 42 79        	ld	s2, 48(sp)
80202398: a2 79        	ld	s3, 40(sp)
8020239a: 02 7a        	ld	s4, 32(sp)
8020239c: e2 6a        	ld	s5, 24(sp)
8020239e: 42 6b        	ld	s6, 16(sp)
802023a0: a2 6b        	ld	s7, 8(sp)
802023a2: 61 61        	addi	sp, sp, 80
802023a4: 82 80        	ret

Disassembly of section .text._ZN42_$LT$str$u20$as$u20$core..fmt..Display$GT$3fmt17h8884fddb1f24a834E:

00000000802023a6 <_ZN42_$LT$str$u20$as$u20$core..fmt..Display$GT$3fmt17h8884fddb1f24a834E>:
802023a6: ae 86        	mv	a3, a1
802023a8: aa 85        	mv	a1, a0
802023aa: 32 85        	mv	a0, a2
802023ac: 36 86        	mv	a2, a3
802023ae: 17 03 00 00  	auipc	t1, 0
802023b2: 67 00 43 da  	jr	-604(t1)

Disassembly of section .text._ZN4core3str5count14do_count_chars17h75bffc8ce7e643c7E:

00000000802023b6 <_ZN4core3str5count14do_count_chars17h75bffc8ce7e643c7E>:
802023b6: 2a 86        	mv	a2, a0
802023b8: 1d 05        	addi	a0, a0, 7
802023ba: 13 77 85 ff  	andi	a4, a0, -8
802023be: b3 08 c7 40  	sub	a7, a4, a2
802023c2: 63 ec 15 01  	bltu	a1, a7, 0x802023da <_ZN4core3str5count14do_count_chars17h75bffc8ce7e643c7E+0x24>
802023c6: 33 88 15 41  	sub	a6, a1, a7
802023ca: 13 35 88 00  	sltiu	a0, a6, 8
802023ce: 93 b7 98 00  	sltiu	a5, a7, 9
802023d2: 93 c7 17 00  	xori	a5, a5, 1
802023d6: 5d 8d        	or	a0, a0, a5
802023d8: 11 cd        	beqz	a0, 0x802023f4 <_ZN4core3str5count14do_count_chars17h75bffc8ce7e643c7E+0x3e>
802023da: 01 45        	li	a0, 0
802023dc: 99 c9        	beqz	a1, 0x802023f2 <_ZN4core3str5count14do_count_chars17h75bffc8ce7e643c7E+0x3c>
802023de: 83 06 06 00  	lb	a3, 0(a2)
802023e2: 05 06        	addi	a2, a2, 1
802023e4: 93 a6 06 fc  	slti	a3, a3, -64
802023e8: 93 c6 16 00  	xori	a3, a3, 1
802023ec: fd 15        	addi	a1, a1, -1
802023ee: 36 95        	add	a0, a0, a3
802023f0: fd f5        	bnez	a1, 0x802023de <_ZN4core3str5count14do_count_chars17h75bffc8ce7e643c7E+0x28>
802023f2: 82 80        	ret
802023f4: 93 75 78 00  	andi	a1, a6, 7
802023f8: 81 47        	li	a5, 0
802023fa: 63 0f c7 00  	beq	a4, a2, 0x80202418 <_ZN4core3str5count14do_count_chars17h75bffc8ce7e643c7E+0x62>
802023fe: 33 07 e6 40  	sub	a4, a2, a4
80202402: 32 85        	mv	a0, a2
80202404: 83 06 05 00  	lb	a3, 0(a0)
80202408: 05 05        	addi	a0, a0, 1
8020240a: 93 a6 06 fc  	slti	a3, a3, -64
8020240e: 93 c6 16 00  	xori	a3, a3, 1
80202412: 05 07        	addi	a4, a4, 1
80202414: b6 97        	add	a5, a5, a3
80202416: 7d f7        	bnez	a4, 0x80202404 <_ZN4core3str5count14do_count_chars17h75bffc8ce7e643c7E+0x4e>
80202418: b3 02 16 01  	add	t0, a2, a7
8020241c: 01 46        	li	a2, 0
8020241e: 99 cd        	beqz	a1, 0x8020243c <_ZN4core3str5count14do_count_chars17h75bffc8ce7e643c7E+0x86>
80202420: 13 75 88 ff  	andi	a0, a6, -8
80202424: b3 86 a2 00  	add	a3, t0, a0
80202428: 03 85 06 00  	lb	a0, 0(a3)
8020242c: 85 06        	addi	a3, a3, 1
8020242e: 13 25 05 fc  	slti	a0, a0, -64
80202432: 13 45 15 00  	xori	a0, a0, 1
80202436: fd 15        	addi	a1, a1, -1
80202438: 2a 96        	add	a2, a2, a0
8020243a: fd f5        	bnez	a1, 0x80202428 <_ZN4core3str5count14do_count_chars17h75bffc8ce7e643c7E+0x72>
8020243c: 13 57 38 00  	srli	a4, a6, 3

0000000080202440 <.LBB290_27>:
80202440: 17 05 00 00  	auipc	a0, 0
80202444: 13 05 05 54  	addi	a0, a0, 1344
80202448: 03 3f 05 00  	ld	t5, 0(a0)

000000008020244c <.LBB290_28>:
8020244c: 17 05 00 00  	auipc	a0, 0
80202450: 13 05 c5 53  	addi	a0, a0, 1340
80202454: 83 38 05 00  	ld	a7, 0(a0)
80202458: 37 15 00 10  	lui	a0, 65537
8020245c: 12 05        	slli	a0, a0, 4
8020245e: 05 05        	addi	a0, a0, 1
80202460: 42 05        	slli	a0, a0, 16
80202462: 13 08 15 00  	addi	a6, a0, 1
80202466: 33 05 f6 00  	add	a0, a2, a5
8020246a: 25 a0        	j	0x80202492 <.LBB290_28+0x46>
8020246c: 13 16 3e 00  	slli	a2, t3, 3
80202470: b3 02 c3 00  	add	t0, t1, a2
80202474: 33 87 c3 41  	sub	a4, t2, t3
80202478: 13 76 3e 00  	andi	a2, t3, 3
8020247c: b3 f6 15 01  	and	a3, a1, a7
80202480: a1 81        	srli	a1, a1, 8
80202482: b3 f5 15 01  	and	a1, a1, a7
80202486: b6 95        	add	a1, a1, a3
80202488: b3 85 05 03  	mul	a1, a1, a6
8020248c: c1 91        	srli	a1, a1, 48
8020248e: 2e 95        	add	a0, a0, a1
80202490: 41 e2        	bnez	a2, 0x80202510 <.LBB290_28+0xc4>
80202492: 25 d3        	beqz	a4, 0x802023f2 <_ZN4core3str5count14do_count_chars17h75bffc8ce7e643c7E+0x3c>
80202494: ba 83        	mv	t2, a4
80202496: 16 83        	mv	t1, t0
80202498: 93 05 00 0c  	li	a1, 192
8020249c: 3a 8e        	mv	t3, a4
8020249e: 63 64 b7 00  	bltu	a4, a1, 0x802024a6 <.LBB290_28+0x5a>
802024a2: 13 0e 00 0c  	li	t3, 192
802024a6: 93 75 ce 0f  	andi	a1, t3, 252
802024aa: 13 96 35 00  	slli	a2, a1, 3
802024ae: b3 0e c3 00  	add	t4, t1, a2
802024b2: cd dd        	beqz	a1, 0x8020246c <.LBB290_28+0x20>
802024b4: 81 45        	li	a1, 0
802024b6: 1a 86        	mv	a2, t1
802024b8: 55 da        	beqz	a2, 0x8020246c <.LBB290_28+0x20>
802024ba: 18 62        	ld	a4, 0(a2)
802024bc: 93 47 f7 ff  	not	a5, a4
802024c0: 9d 83        	srli	a5, a5, 7
802024c2: 19 83        	srli	a4, a4, 6
802024c4: 14 66        	ld	a3, 8(a2)
802024c6: 5d 8f        	or	a4, a4, a5
802024c8: 33 77 e7 01  	and	a4, a4, t5
802024cc: ba 95        	add	a1, a1, a4
802024ce: 13 c7 f6 ff  	not	a4, a3
802024d2: 1d 83        	srli	a4, a4, 7
802024d4: 99 82        	srli	a3, a3, 6
802024d6: 1c 6a        	ld	a5, 16(a2)
802024d8: d9 8e        	or	a3, a3, a4
802024da: b3 f6 e6 01  	and	a3, a3, t5
802024de: b6 95        	add	a1, a1, a3
802024e0: 93 c6 f7 ff  	not	a3, a5
802024e4: 9d 82        	srli	a3, a3, 7
802024e6: 13 d7 67 00  	srli	a4, a5, 6
802024ea: 1c 6e        	ld	a5, 24(a2)
802024ec: d9 8e        	or	a3, a3, a4
802024ee: b3 f6 e6 01  	and	a3, a3, t5
802024f2: b6 95        	add	a1, a1, a3
802024f4: 93 c6 f7 ff  	not	a3, a5
802024f8: 9d 82        	srli	a3, a3, 7
802024fa: 13 d7 67 00  	srli	a4, a5, 6
802024fe: d9 8e        	or	a3, a3, a4
80202500: b3 f6 e6 01  	and	a3, a3, t5
80202504: 13 06 06 02  	addi	a2, a2, 32
80202508: b6 95        	add	a1, a1, a3
8020250a: e3 17 d6 fb  	bne	a2, t4, 0x802024b8 <.LBB290_28+0x6c>
8020250e: b9 bf        	j	0x8020246c <.LBB290_28+0x20>
80202510: 63 0a 03 02  	beqz	t1, 0x80202544 <.LBB290_28+0xf8>
80202514: 93 05 00 0c  	li	a1, 192
80202518: 63 e4 b3 00  	bltu	t2, a1, 0x80202520 <.LBB290_28+0xd4>
8020251c: 93 03 00 0c  	li	t2, 192
80202520: 81 45        	li	a1, 0
80202522: 13 f6 33 00  	andi	a2, t2, 3
80202526: 0e 06        	slli	a2, a2, 3
80202528: 83 b6 0e 00  	ld	a3, 0(t4)
8020252c: a1 0e        	addi	t4, t4, 8
8020252e: 13 c7 f6 ff  	not	a4, a3
80202532: 1d 83        	srli	a4, a4, 7
80202534: 99 82        	srli	a3, a3, 6
80202536: d9 8e        	or	a3, a3, a4
80202538: b3 f6 e6 01  	and	a3, a3, t5
8020253c: 61 16        	addi	a2, a2, -8
8020253e: b6 95        	add	a1, a1, a3
80202540: 65 f6        	bnez	a2, 0x80202528 <.LBB290_28+0xdc>
80202542: 11 a0        	j	0x80202546 <.LBB290_28+0xfa>
80202544: 81 45        	li	a1, 0
80202546: 33 f6 15 01  	and	a2, a1, a7
8020254a: a1 81        	srli	a1, a1, 8
8020254c: b3 f5 15 01  	and	a1, a1, a7
80202550: b2 95        	add	a1, a1, a2
80202552: b3 85 05 03  	mul	a1, a1, a6
80202556: c1 91        	srli	a1, a1, 48
80202558: 2e 95        	add	a0, a0, a1
8020255a: 82 80        	ret

Disassembly of section .text._ZN4core3fmt3num3imp7fmt_u6417h2bebad4dea13b624E:

000000008020255c <_ZN4core3fmt3num3imp7fmt_u6417h2bebad4dea13b624E>:
8020255c: 39 71        	addi	sp, sp, -64
8020255e: 06 fc        	sd	ra, 56(sp)
80202560: 22 f8        	sd	s0, 48(sp)
80202562: 26 f4        	sd	s1, 40(sp)
80202564: 32 88        	mv	a6, a2
80202566: 93 56 45 00  	srli	a3, a0, 4
8020256a: 13 07 70 02  	li	a4, 39
8020256e: 93 07 10 27  	li	a5, 625

0000000080202572 <.LBB570_10>:
80202572: 97 1e 00 00  	auipc	t4, 1
80202576: 93 8e 6e 9c  	addi	t4, t4, -1594
8020257a: 63 f3 f6 02  	bgeu	a3, a5, 0x802025a0 <.LBB570_10+0x2e>
8020257e: 93 06 30 06  	li	a3, 99
80202582: 63 e9 a6 0a  	bltu	a3, a0, 0x80202634 <.LBB570_11+0x92>
80202586: 29 46        	li	a2, 10
80202588: 63 77 c5 0e  	bgeu	a0, a2, 0x80202676 <.LBB570_11+0xd4>
8020258c: 93 06 f7 ff  	addi	a3, a4, -1
80202590: 13 06 11 00  	addi	a2, sp, 1
80202594: 36 96        	add	a2, a2, a3
80202596: 1b 05 05 03  	addiw	a0, a0, 48
8020259a: 23 00 a6 00  	sb	a0, 0(a2)
8020259e: dd a8        	j	0x80202694 <.LBB570_11+0xf2>
802025a0: 01 47        	li	a4, 0

00000000802025a2 <.LBB570_11>:
802025a2: 97 06 00 00  	auipc	a3, 0
802025a6: 93 86 e6 44  	addi	a3, a3, 1102
802025aa: 83 b8 06 00  	ld	a7, 0(a3)
802025ae: 89 66        	lui	a3, 2
802025b0: 9b 83 06 71  	addiw	t2, a3, 1808
802025b4: 85 66        	lui	a3, 1
802025b6: 1b 8e b6 47  	addiw	t3, a3, 1147
802025ba: 93 02 40 06  	li	t0, 100
802025be: 13 03 11 00  	addi	t1, sp, 1
802025c2: b7 e6 f5 05  	lui	a3, 24414
802025c6: 1b 8f f6 0f  	addiw	t5, a3, 255
802025ca: aa 87        	mv	a5, a0
802025cc: 33 35 15 03  	mulhu	a0, a0, a7
802025d0: 2d 81        	srli	a0, a0, 11
802025d2: 3b 06 75 02  	mulw	a2, a0, t2
802025d6: 3b 86 c7 40  	subw	a2, a5, a2
802025da: 93 16 06 03  	slli	a3, a2, 48
802025de: c9 92        	srli	a3, a3, 50
802025e0: b3 86 c6 03  	mul	a3, a3, t3
802025e4: 93 df 16 01  	srli	t6, a3, 17
802025e8: c1 82        	srli	a3, a3, 16
802025ea: 13 f4 e6 7f  	andi	s0, a3, 2046
802025ee: bb 86 5f 02  	mulw	a3, t6, t0
802025f2: 15 9e        	subw	a2, a2, a3
802025f4: 46 16        	slli	a2, a2, 49
802025f6: 41 92        	srli	a2, a2, 48
802025f8: b3 86 8e 00  	add	a3, t4, s0
802025fc: 33 04 e3 00  	add	s0, t1, a4
80202600: 83 cf 06 00  	lbu	t6, 0(a3)
80202604: 83 86 16 00  	lb	a3, 1(a3)
80202608: 76 96        	add	a2, a2, t4
8020260a: 83 04 16 00  	lb	s1, 1(a2)
8020260e: 03 46 06 00  	lbu	a2, 0(a2)
80202612: 23 02 d4 02  	sb	a3, 36(s0)
80202616: a3 01 f4 03  	sb	t6, 35(s0)
8020261a: 23 03 94 02  	sb	s1, 38(s0)
8020261e: a3 02 c4 02  	sb	a2, 37(s0)
80202622: 71 17        	addi	a4, a4, -4
80202624: e3 63 ff fa  	bltu	t5, a5, 0x802025ca <.LBB570_11+0x28>
80202628: 13 07 77 02  	addi	a4, a4, 39
8020262c: 93 06 30 06  	li	a3, 99
80202630: e3 fb a6 f4  	bgeu	a3, a0, 0x80202586 <.LBB570_10+0x14>
80202634: 13 16 05 03  	slli	a2, a0, 48
80202638: 49 92        	srli	a2, a2, 50
8020263a: 85 66        	lui	a3, 1
8020263c: 9b 86 b6 47  	addiw	a3, a3, 1147
80202640: 33 06 d6 02  	mul	a2, a2, a3
80202644: 45 82        	srli	a2, a2, 17
80202646: 93 06 40 06  	li	a3, 100
8020264a: bb 06 d6 02  	mulw	a3, a2, a3
8020264e: 15 9d        	subw	a0, a0, a3
80202650: 46 15        	slli	a0, a0, 49
80202652: 41 91        	srli	a0, a0, 48
80202654: 79 17        	addi	a4, a4, -2
80202656: 76 95        	add	a0, a0, t4
80202658: 83 06 15 00  	lb	a3, 1(a0)
8020265c: 03 45 05 00  	lbu	a0, 0(a0)
80202660: 93 07 11 00  	addi	a5, sp, 1
80202664: ba 97        	add	a5, a5, a4
80202666: a3 80 d7 00  	sb	a3, 1(a5)
8020266a: 23 80 a7 00  	sb	a0, 0(a5)
8020266e: 32 85        	mv	a0, a2
80202670: 29 46        	li	a2, 10
80202672: e3 6d c5 f0  	bltu	a0, a2, 0x8020258c <.LBB570_10+0x1a>
80202676: 06 05        	slli	a0, a0, 1
80202678: 93 06 e7 ff  	addi	a3, a4, -2
8020267c: 76 95        	add	a0, a0, t4
8020267e: 03 06 15 00  	lb	a2, 1(a0)
80202682: 03 45 05 00  	lbu	a0, 0(a0)
80202686: 13 07 11 00  	addi	a4, sp, 1
8020268a: 36 97        	add	a4, a4, a3
8020268c: a3 00 c7 00  	sb	a2, 1(a4)
80202690: 23 00 a7 00  	sb	a0, 0(a4)
80202694: 13 05 11 00  	addi	a0, sp, 1
80202698: 33 07 d5 00  	add	a4, a0, a3
8020269c: 13 05 70 02  	li	a0, 39
802026a0: b3 07 d5 40  	sub	a5, a0, a3

00000000802026a4 <.LBB570_12>:
802026a4: 17 06 00 00  	auipc	a2, 0
802026a8: 13 06 c6 7e  	addi	a2, a2, 2028
802026ac: 42 85        	mv	a0, a6
802026ae: 81 46        	li	a3, 0
802026b0: 97 00 00 00  	auipc	ra, 0
802026b4: e7 80 e0 82  	jalr	-2002(ra)
802026b8: e2 70        	ld	ra, 56(sp)
802026ba: 42 74        	ld	s0, 48(sp)
802026bc: a2 74        	ld	s1, 40(sp)
802026be: 21 61        	addi	sp, sp, 64
802026c0: 82 80        	ret

Disassembly of section .text._ZN4core3fmt3num3imp51_$LT$impl$u20$core..fmt..Display$u20$for$u20$u8$GT$3fmt17h93332490606bba67E:

00000000802026c2 <_ZN4core3fmt3num3imp51_$LT$impl$u20$core..fmt..Display$u20$for$u20$u8$GT$3fmt17h93332490606bba67E>:
802026c2: 03 45 05 00  	lbu	a0, 0(a0)
802026c6: 2e 86        	mv	a2, a1
802026c8: 85 45        	li	a1, 1
802026ca: 17 03 00 00  	auipc	t1, 0
802026ce: 67 00 23 e9  	jr	-366(t1)

Disassembly of section .text._ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h518678af98a1949fE:

00000000802026d2 <_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h518678af98a1949fE>:
802026d2: 03 65 05 00  	lwu	a0, 0(a0)
802026d6: 2e 86        	mv	a2, a1
802026d8: 85 45        	li	a1, 1
802026da: 17 03 00 00  	auipc	t1, 0
802026de: 67 00 23 e8  	jr	-382(t1)

Disassembly of section .text._ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u64$GT$3fmt17h77ff5d762b7f8e58E:

00000000802026e2 <_ZN4core3fmt3num3imp54_$LT$impl$u20$core..fmt..Display$u20$for$u20$usize$GT$3fmt17hadb5d59c0aa64a0cE>:
802026e2: 08 61        	ld	a0, 0(a0)
802026e4: 2e 86        	mv	a2, a1
802026e6: 85 45        	li	a1, 1
802026e8: 17 03 00 00  	auipc	t1, 0
802026ec: 67 00 43 e7  	jr	-396(t1)

Disassembly of section .text._ZN53_$LT$core..fmt..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h036960996838d966E:

00000000802026f0 <_ZN53_$LT$core..fmt..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h036960996838d966E>:
802026f0: 90 65        	ld	a2, 8(a1)
802026f2: 88 61        	ld	a0, 0(a1)
802026f4: 1c 6e        	ld	a5, 24(a2)

00000000802026f6 <.LBB602_1>:
802026f6: 97 15 00 00  	auipc	a1, 1
802026fa: 93 85 a5 90  	addi	a1, a1, -1782
802026fe: 15 46        	li	a2, 5
80202700: 82 87        	jr	a5

Disassembly of section .text._ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hcb8bce5ca6b6d1baE:

0000000080202702 <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hcb8bce5ca6b6d1baE>:
80202702: 10 65        	ld	a2, 8(a0)
80202704: 08 61        	ld	a0, 0(a0)
80202706: 1c 6e        	ld	a5, 24(a2)
80202708: 82 87        	jr	a5

Disassembly of section .text._ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hcf3c30afa59af89fE:

000000008020270a <_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hcf3c30afa59af89fE>:
8020270a: 14 61        	ld	a3, 0(a0)
8020270c: 10 65        	ld	a2, 8(a0)
8020270e: 2e 85        	mv	a0, a1
80202710: b6 85        	mv	a1, a3
80202712: 17 03 00 00  	auipc	t1, 0
80202716: 67 00 03 a4  	jr	-1472(t1)
