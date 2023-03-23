
target/riscv64gc-unknown-none-elf/release/sel4:	file format elf64-littleriscv

Disassembly of section .text:

0000000080200000 <stext>:
80200000: 17 41 01 00  	auipc	sp, 20
80200004: 13 01 01 00  	mv	sp, sp
80200008: 97 10 00 00  	auipc	ra, 1
8020000c: e7 80 80 ff  	jalr	-8(ra)
		...

0000000080201000 <rust_main>:
80201000: 39 71        	addi	sp, sp, -64
80201002: 06 fc        	sd	ra, 56(sp)
80201004: 22 f8        	sd	s0, 48(sp)
80201006: 80 00        	addi	s0, sp, 64

0000000080201008 <.LBB4_1>:
80201008: 17 15 00 00  	auipc	a0, 1
8020100c: 13 05 85 71  	addi	a0, a0, 1816
80201010: 23 38 a4 fc  	sd	a0, -48(s0)
80201014: 05 45        	li	a0, 1
80201016: 23 3c a4 fc  	sd	a0, -40(s0)
8020101a: 23 30 04 fc  	sd	zero, -64(s0)

000000008020101e <.LBB4_2>:
8020101e: 17 15 00 00  	auipc	a0, 1
80201022: 13 05 a5 6e  	addi	a0, a0, 1770
80201026: 23 30 a4 fe  	sd	a0, -32(s0)
8020102a: 23 34 04 fe  	sd	zero, -24(s0)
8020102e: 13 05 04 fc  	addi	a0, s0, -64
80201032: 97 00 00 00  	auipc	ra, 0
80201036: e7 80 00 3e  	jalr	992(ra)
8020103a: 97 00 00 00  	auipc	ra, 0
8020103e: e7 80 e0 13  	jalr	318(ra)
80201042: 97 00 00 00  	auipc	ra, 0
80201046: e7 80 c0 09  	jalr	156(ra)
8020104a: 97 00 00 00  	auipc	ra, 0
8020104e: e7 80 a0 00  	jalr	10(ra)
80201052: 00 00        	unimp	

Disassembly of section .text._ZN4sel43sbi8shutdown17h66331878ed4ddfbbE:

0000000080201054 <_ZN4sel43sbi8shutdown17h66331878ed4ddfbbE>:
80201054: 39 71        	addi	sp, sp, -64
80201056: 06 fc        	sd	ra, 56(sp)
80201058: 22 f8        	sd	s0, 48(sp)
8020105a: 80 00        	addi	s0, sp, 64
8020105c: a1 48        	li	a7, 8
8020105e: 01 45        	li	a0, 0
80201060: 81 45        	li	a1, 0
80201062: 01 46        	li	a2, 0
80201064: 73 00 00 00  	ecall	

0000000080201068 <.LBB2_1>:
80201068: 17 15 00 00  	auipc	a0, 1
8020106c: 13 05 85 66  	addi	a0, a0, 1640
80201070: 23 38 a4 fc  	sd	a0, -48(s0)
80201074: 05 45        	li	a0, 1
80201076: 23 3c a4 fc  	sd	a0, -40(s0)
8020107a: 23 30 04 fc  	sd	zero, -64(s0)

000000008020107e <.LBB2_2>:
8020107e: 17 15 00 00  	auipc	a0, 1
80201082: 13 05 a5 63  	addi	a0, a0, 1594
80201086: 23 30 a4 fe  	sd	a0, -32(s0)
8020108a: 23 34 04 fe  	sd	zero, -24(s0)

000000008020108e <.LBB2_3>:
8020108e: 97 15 00 00  	auipc	a1, 1
80201092: 93 85 25 66  	addi	a1, a1, 1634
80201096: 13 05 04 fc  	addi	a0, s0, -64
8020109a: 97 00 00 00  	auipc	ra, 0
8020109e: e7 80 20 7e  	jalr	2018(ra)
802010a2: 00 00        	unimp	

Disassembly of section .text._ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hc83fb63968e07dbeE:

00000000802010a4 <_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hc83fb63968e07dbeE>:
802010a4: 41 11        	addi	sp, sp, -16
802010a6: 06 e4        	sd	ra, 8(sp)
802010a8: 22 e0        	sd	s0, 0(sp)
802010aa: 00 08        	addi	s0, sp, 16
802010ac: 08 61        	ld	a0, 0(a0)
802010ae: a2 60        	ld	ra, 8(sp)
802010b0: 02 64        	ld	s0, 0(sp)
802010b2: 41 01        	addi	sp, sp, 16
802010b4: 17 13 00 00  	auipc	t1, 1
802010b8: 67 00 e3 8a  	jr	-1874(t1)

Disassembly of section .text._ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17he9e9b4aa0ef791bdE:

00000000802010bc <_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17he9e9b4aa0ef791bdE>:
802010bc: 41 11        	addi	sp, sp, -16
802010be: 06 e4        	sd	ra, 8(sp)
802010c0: 22 e0        	sd	s0, 0(sp)
802010c2: 00 08        	addi	s0, sp, 16
802010c4: 10 61        	ld	a2, 0(a0)
802010c6: 14 65        	ld	a3, 8(a0)
802010c8: 2e 87        	mv	a4, a1
802010ca: 32 85        	mv	a0, a2
802010cc: b6 85        	mv	a1, a3
802010ce: 3a 86        	mv	a2, a4
802010d0: a2 60        	ld	ra, 8(sp)
802010d2: 02 64        	ld	s0, 0(sp)
802010d4: 41 01        	addi	sp, sp, 16
802010d6: 17 13 00 00  	auipc	t1, 1
802010da: 67 00 23 f1  	jr	-238(t1)

Disassembly of section .text._ZN4sel46kernel6vspace7pt_init17haa10305f5fea8ca7E:

00000000802010de <_ZN4sel46kernel6vspace7pt_init17haa10305f5fea8ca7E>:
802010de: 41 11        	addi	sp, sp, -16
802010e0: 06 e4        	sd	ra, 8(sp)
802010e2: 22 e0        	sd	s0, 0(sp)
802010e4: 00 08        	addi	s0, sp, 16

00000000802010e6 <.LBB2_5>:
802010e6: 17 38 01 00  	auipc	a6, 19
802010ea: 13 08 a8 f1  	addi	a6, a6, -230
802010ee: 93 08 f8 7f  	addi	a7, a6, 2047
802010f2: 13 86 18 00  	addi	a2, a7, 1
802010f6: 93 06 f0 0e  	li	a3, 239
802010fa: 13 05 f0 ef  	li	a0, -257
802010fe: 13 17 e5 01  	slli	a4, a0, 30
80201102: b7 07 00 40  	lui	a5, 262144
80201106: 37 05 00 10  	lui	a0, 65536
8020110a: f5 55        	li	a1, -3
8020110c: fa 05        	slli	a1, a1, 30
8020110e: 14 e2        	sd	a3, 0(a2)
80201110: 3e 97        	add	a4, a4, a5
80201112: 21 06        	addi	a2, a2, 8
80201114: aa 96        	add	a3, a3, a0
80201116: e3 6c b7 fe  	bltu	a4, a1, 0x8020110e <.LBB2_5+0x28>

000000008020111a <.LBB2_6>:
8020111a: 17 46 01 00  	auipc	a2, 20
8020111e: 13 06 66 ee  	addi	a2, a2, -282
80201122: 13 55 26 00  	srli	a0, a2, 2
80201126: b7 05 f0 ff  	lui	a1, 1048320
8020112a: a9 81        	srli	a1, a1, 10
8020112c: 6d 8d        	and	a0, a0, a1
8020112e: 13 65 15 02  	ori	a0, a0, 33
80201132: a3 b8 a8 00  	sd	a0, 17(a7)
80201136: a3 b8 a8 7e  	sd	a0, 2033(a7)
8020113a: 23 38 a8 00  	sd	a0, 16(a6)
8020113e: 93 05 00 20  	li	a1, 512
80201142: 37 05 00 20  	lui	a0, 131072
80201146: 1b 05 f5 0e  	addiw	a0, a0, 239
8020114a: b7 06 08 00  	lui	a3, 128
8020114e: 08 e2        	sd	a0, 0(a2)
80201150: 36 95        	add	a0, a0, a3
80201152: fd 15        	addi	a1, a1, -1
80201154: 21 06        	addi	a2, a2, 8
80201156: e5 fd        	bnez	a1, 0x8020114e <.LBB2_6+0x34>
80201158: 13 15 88 00  	slli	a0, a6, 8
8020115c: 51 81        	srli	a0, a0, 20
8020115e: fd 55        	li	a1, -1
80201160: fe 15        	slli	a1, a1, 63
80201162: 4d 8d        	or	a0, a0, a1
80201164: 73 10 05 18  	csrw	satp, a0
80201168: 73 00 00 12  	sfence.vma
8020116c: 73 00 00 12  	sfence.vma
80201170: a2 60        	ld	ra, 8(sp)
80201172: 02 64        	ld	s0, 0(sp)
80201174: 41 01        	addi	sp, sp, 16
80201176: 82 80        	ret

Disassembly of section .text._ZN4sel410heap_alloc9init_heap17h3294eb883f2849c6E:

0000000080201178 <_ZN4sel410heap_alloc9init_heap17h3294eb883f2849c6E>:
80201178: 01 11        	addi	sp, sp, -32
8020117a: 06 ec        	sd	ra, 24(sp)
8020117c: 22 e8        	sd	s0, 16(sp)
8020117e: 26 e4        	sd	s1, 8(sp)
80201180: 4a e0        	sd	s2, 0(sp)
80201182: 00 10        	addi	s0, sp, 32

0000000080201184 <.LBB0_3>:
80201184: 17 55 21 00  	auipc	a0, 533
80201188: 13 05 c5 e7  	addi	a0, a0, -388
8020118c: 97 00 00 00  	auipc	ra, 0
80201190: e7 80 60 6c  	jalr	1734(ra)
80201194: aa 84        	mv	s1, a0
80201196: 05 45        	li	a0, 1
80201198: 2f b9 a4 00  	amoadd.d	s2, a0, (s1)
8020119c: 88 64        	ld	a0, 8(s1)
8020119e: 0f 00 30 02  	fence	r, rw
802011a2: 63 09 25 01  	beq	a0, s2, 0x802011b4 <.LBB0_3+0x30>
802011a6: 0f 00 00 01  	fence	w, 0
802011aa: 88 64        	ld	a0, 8(s1)
802011ac: 0f 00 30 02  	fence	r, rw
802011b0: e3 1b 25 ff  	bne	a0, s2, 0x802011a6 <.LBB0_3+0x22>
802011b4: 13 85 04 01  	addi	a0, s1, 16

00000000802011b8 <.LBB0_4>:
802011b8: 97 55 01 00  	auipc	a1, 21
802011bc: 93 85 85 e4  	addi	a1, a1, -440
802011c0: 37 06 20 00  	lui	a2, 512
802011c4: 97 00 00 00  	auipc	ra, 0
802011c8: e7 80 a0 52  	jalr	1322(ra)
802011cc: 13 05 19 00  	addi	a0, s2, 1
802011d0: 0f 00 10 03  	fence	rw, w
802011d4: 88 e4        	sd	a0, 8(s1)
802011d6: e2 60        	ld	ra, 24(sp)
802011d8: 42 64        	ld	s0, 16(sp)
802011da: a2 64        	ld	s1, 8(sp)
802011dc: 02 69        	ld	s2, 0(sp)
802011de: 05 61        	addi	sp, sp, 32
802011e0: 82 80        	ret

Disassembly of section .text._ZN4core3ptr37drop_in_place$LT$core..fmt..Error$GT$17h8a07bd9b64186cfeE.llvm.17772250532125793796:

00000000802011e2 <_ZN4core3ptr54drop_in_place$LT$$RF$mut$u20$sel4..console..Stdout$GT$17he26c29928d3f96b5E.llvm.17772250532125793796>:
802011e2: 41 11        	addi	sp, sp, -16
802011e4: 06 e4        	sd	ra, 8(sp)
802011e6: 22 e0        	sd	s0, 0(sp)
802011e8: 00 08        	addi	s0, sp, 16
802011ea: a2 60        	ld	ra, 8(sp)
802011ec: 02 64        	ld	s0, 0(sp)
802011ee: 41 01        	addi	sp, sp, 16
802011f0: 82 80        	ret

Disassembly of section .text._ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.17772250532125793796:

00000000802011f2 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.17772250532125793796>:
802011f2: 01 11        	addi	sp, sp, -32
802011f4: 06 ec        	sd	ra, 24(sp)
802011f6: 22 e8        	sd	s0, 16(sp)
802011f8: 00 10        	addi	s0, sp, 32
802011fa: 1b 85 05 00  	sext.w	a0, a1
802011fe: 13 06 00 08  	li	a2, 128
80201202: 23 26 04 fe  	sw	zero, -20(s0)
80201206: 63 76 c5 00  	bgeu	a0, a2, 0x80201212 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.17772250532125793796+0x20>
8020120a: 23 06 b4 fe  	sb	a1, -20(s0)
8020120e: 05 45        	li	a0, 1
80201210: 51 a8        	j	0x802012a4 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.17772250532125793796+0xb2>
80201212: 1b d5 b5 00  	srliw	a0, a1, 11
80201216: 19 ed        	bnez	a0, 0x80201234 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.17772250532125793796+0x42>
80201218: 13 d5 65 00  	srli	a0, a1, 6
8020121c: 13 65 05 0c  	ori	a0, a0, 192
80201220: 23 06 a4 fe  	sb	a0, -20(s0)
80201224: 13 f5 f5 03  	andi	a0, a1, 63
80201228: 13 65 05 08  	ori	a0, a0, 128
8020122c: a3 06 a4 fe  	sb	a0, -19(s0)
80201230: 09 45        	li	a0, 2
80201232: 8d a8        	j	0x802012a4 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.17772250532125793796+0xb2>
80201234: 1b d5 05 01  	srliw	a0, a1, 16
80201238: 05 e9        	bnez	a0, 0x80201268 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.17772250532125793796+0x76>
8020123a: 13 95 05 02  	slli	a0, a1, 32
8020123e: 01 91        	srli	a0, a0, 32
80201240: 1b d6 c5 00  	srliw	a2, a1, 12
80201244: 13 66 06 0e  	ori	a2, a2, 224
80201248: 23 06 c4 fe  	sb	a2, -20(s0)
8020124c: 52 15        	slli	a0, a0, 52
8020124e: 69 91        	srli	a0, a0, 58
80201250: 13 65 05 08  	ori	a0, a0, 128
80201254: a3 06 a4 fe  	sb	a0, -19(s0)
80201258: 13 f5 f5 03  	andi	a0, a1, 63
8020125c: 13 65 05 08  	ori	a0, a0, 128
80201260: 23 07 a4 fe  	sb	a0, -18(s0)
80201264: 0d 45        	li	a0, 3
80201266: 3d a8        	j	0x802012a4 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.17772250532125793796+0xb2>
80201268: 13 95 05 02  	slli	a0, a1, 32
8020126c: 01 91        	srli	a0, a0, 32
8020126e: 13 16 b5 02  	slli	a2, a0, 43
80201272: 75 92        	srli	a2, a2, 61
80201274: 13 66 06 0f  	ori	a2, a2, 240
80201278: 23 06 c4 fe  	sb	a2, -20(s0)
8020127c: 13 16 e5 02  	slli	a2, a0, 46
80201280: 69 92        	srli	a2, a2, 58
80201282: 13 66 06 08  	ori	a2, a2, 128
80201286: a3 06 c4 fe  	sb	a2, -19(s0)
8020128a: 52 15        	slli	a0, a0, 52
8020128c: 69 91        	srli	a0, a0, 58
8020128e: 13 65 05 08  	ori	a0, a0, 128
80201292: 23 07 a4 fe  	sb	a0, -18(s0)
80201296: 13 f5 f5 03  	andi	a0, a1, 63
8020129a: 13 65 05 08  	ori	a0, a0, 128
8020129e: a3 07 a4 fe  	sb	a0, -17(s0)
802012a2: 11 45        	li	a0, 4
802012a4: 93 06 c4 fe  	addi	a3, s0, -20
802012a8: 33 87 a6 00  	add	a4, a3, a0
802012ac: 13 03 f0 0d  	li	t1, 223
802012b0: 13 08 00 0f  	li	a6, 240
802012b4: b7 02 11 00  	lui	t0, 272
802012b8: 85 48        	li	a7, 1
802012ba: 01 a8        	j	0x802012ca <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.17772250532125793796+0xd8>
802012bc: 85 06        	addi	a3, a3, 1
802012be: 81 45        	li	a1, 0
802012c0: 01 46        	li	a2, 0
802012c2: 73 00 00 00  	ecall	
802012c6: 63 8f e6 04  	beq	a3, a4, 0x80201324 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.17772250532125793796+0x132>
802012ca: 83 85 06 00  	lb	a1, 0(a3)
802012ce: 13 f5 f5 0f  	andi	a0, a1, 255
802012d2: e3 d5 05 fe  	bgez	a1, 0x802012bc <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.17772250532125793796+0xca>
802012d6: 03 c6 16 00  	lbu	a2, 1(a3)
802012da: 93 75 f5 01  	andi	a1, a0, 31
802012de: 13 76 f6 03  	andi	a2, a2, 63
802012e2: 63 77 a3 02  	bgeu	t1, a0, 0x80201310 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.17772250532125793796+0x11e>
802012e6: 83 c7 26 00  	lbu	a5, 2(a3)
802012ea: 1a 06        	slli	a2, a2, 6
802012ec: 93 f7 f7 03  	andi	a5, a5, 63
802012f0: 5d 8e        	or	a2, a2, a5
802012f2: 63 64 05 03  	bltu	a0, a6, 0x8020131a <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.17772250532125793796+0x128>
802012f6: 03 c5 36 00  	lbu	a0, 3(a3)
802012fa: f6 15        	slli	a1, a1, 61
802012fc: ad 91        	srli	a1, a1, 43
802012fe: 1a 06        	slli	a2, a2, 6
80201300: 13 75 f5 03  	andi	a0, a0, 63
80201304: 51 8d        	or	a0, a0, a2
80201306: 4d 8d        	or	a0, a0, a1
80201308: 63 0e 55 00  	beq	a0, t0, 0x80201324 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.17772250532125793796+0x132>
8020130c: 91 06        	addi	a3, a3, 4
8020130e: 45 bf        	j	0x802012be <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.17772250532125793796+0xcc>
80201310: 89 06        	addi	a3, a3, 2
80201312: 13 95 65 00  	slli	a0, a1, 6
80201316: 51 8d        	or	a0, a0, a2
80201318: 5d b7        	j	0x802012be <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.17772250532125793796+0xcc>
8020131a: 8d 06        	addi	a3, a3, 3
8020131c: 13 95 c5 00  	slli	a0, a1, 12
80201320: 51 8d        	or	a0, a0, a2
80201322: 71 bf        	j	0x802012be <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hf0d505868795947eE.llvm.17772250532125793796+0xcc>
80201324: 01 45        	li	a0, 0
80201326: e2 60        	ld	ra, 24(sp)
80201328: 42 64        	ld	s0, 16(sp)
8020132a: 05 61        	addi	sp, sp, 32
8020132c: 82 80        	ret

Disassembly of section .text._ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_fmt17hea6da6f03dcdd814E.llvm.17772250532125793796:

000000008020132e <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_fmt17hea6da6f03dcdd814E.llvm.17772250532125793796>:
8020132e: 5d 71        	addi	sp, sp, -80
80201330: 86 e4        	sd	ra, 72(sp)
80201332: a2 e0        	sd	s0, 64(sp)
80201334: 80 08        	addi	s0, sp, 80
80201336: 08 61        	ld	a0, 0(a0)
80201338: 90 75        	ld	a2, 40(a1)
8020133a: 94 71        	ld	a3, 32(a1)
8020133c: 23 3c a4 fa  	sd	a0, -72(s0)
80201340: 23 34 c4 fe  	sd	a2, -24(s0)
80201344: 23 30 d4 fe  	sd	a3, -32(s0)
80201348: 88 6d        	ld	a0, 24(a1)
8020134a: 90 69        	ld	a2, 16(a1)
8020134c: 94 65        	ld	a3, 8(a1)
8020134e: 8c 61        	ld	a1, 0(a1)
80201350: 23 3c a4 fc  	sd	a0, -40(s0)
80201354: 23 38 c4 fc  	sd	a2, -48(s0)
80201358: 23 34 d4 fc  	sd	a3, -56(s0)
8020135c: 23 30 b4 fc  	sd	a1, -64(s0)

0000000080201360 <.LBB2_1>:
80201360: 97 15 00 00  	auipc	a1, 1
80201364: 93 85 05 3d  	addi	a1, a1, 976
80201368: 13 05 84 fb  	addi	a0, s0, -72
8020136c: 13 06 04 fc  	addi	a2, s0, -64
80201370: 97 00 00 00  	auipc	ra, 0
80201374: e7 80 40 62  	jalr	1572(ra)
80201378: a6 60        	ld	ra, 72(sp)
8020137a: 06 64        	ld	s0, 64(sp)
8020137c: 61 61        	addi	sp, sp, 80
8020137e: 82 80        	ret

Disassembly of section .text._ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hff577ac6e379d064E.llvm.17772250532125793796:

0000000080201380 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hff577ac6e379d064E.llvm.17772250532125793796>:
80201380: 41 11        	addi	sp, sp, -16
80201382: 06 e4        	sd	ra, 8(sp)
80201384: 22 e0        	sd	s0, 0(sp)
80201386: 00 08        	addi	s0, sp, 16
80201388: 41 c2        	beqz	a2, 0x80201408 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hff577ac6e379d064E.llvm.17772250532125793796+0x88>
8020138a: ae 86        	mv	a3, a1
8020138c: 33 87 c5 00  	add	a4, a1, a2
80201390: 13 03 f0 0d  	li	t1, 223
80201394: 13 08 00 0f  	li	a6, 240
80201398: b7 02 11 00  	lui	t0, 272
8020139c: 85 48        	li	a7, 1
8020139e: 01 a8        	j	0x802013ae <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hff577ac6e379d064E.llvm.17772250532125793796+0x2e>
802013a0: 85 06        	addi	a3, a3, 1
802013a2: 81 45        	li	a1, 0
802013a4: 01 46        	li	a2, 0
802013a6: 73 00 00 00  	ecall	
802013aa: 63 8f e6 04  	beq	a3, a4, 0x80201408 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hff577ac6e379d064E.llvm.17772250532125793796+0x88>
802013ae: 83 85 06 00  	lb	a1, 0(a3)
802013b2: 13 f5 f5 0f  	andi	a0, a1, 255
802013b6: e3 d5 05 fe  	bgez	a1, 0x802013a0 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hff577ac6e379d064E.llvm.17772250532125793796+0x20>
802013ba: 03 c6 16 00  	lbu	a2, 1(a3)
802013be: 93 75 f5 01  	andi	a1, a0, 31
802013c2: 13 76 f6 03  	andi	a2, a2, 63
802013c6: 63 77 a3 02  	bgeu	t1, a0, 0x802013f4 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hff577ac6e379d064E.llvm.17772250532125793796+0x74>
802013ca: 83 c7 26 00  	lbu	a5, 2(a3)
802013ce: 1a 06        	slli	a2, a2, 6
802013d0: 93 f7 f7 03  	andi	a5, a5, 63
802013d4: 5d 8e        	or	a2, a2, a5
802013d6: 63 64 05 03  	bltu	a0, a6, 0x802013fe <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hff577ac6e379d064E.llvm.17772250532125793796+0x7e>
802013da: 03 c5 36 00  	lbu	a0, 3(a3)
802013de: f6 15        	slli	a1, a1, 61
802013e0: ad 91        	srli	a1, a1, 43
802013e2: 1a 06        	slli	a2, a2, 6
802013e4: 13 75 f5 03  	andi	a0, a0, 63
802013e8: 51 8d        	or	a0, a0, a2
802013ea: 4d 8d        	or	a0, a0, a1
802013ec: 63 0e 55 00  	beq	a0, t0, 0x80201408 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hff577ac6e379d064E.llvm.17772250532125793796+0x88>
802013f0: 91 06        	addi	a3, a3, 4
802013f2: 45 bf        	j	0x802013a2 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hff577ac6e379d064E.llvm.17772250532125793796+0x22>
802013f4: 89 06        	addi	a3, a3, 2
802013f6: 13 95 65 00  	slli	a0, a1, 6
802013fa: 51 8d        	or	a0, a0, a2
802013fc: 5d b7        	j	0x802013a2 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hff577ac6e379d064E.llvm.17772250532125793796+0x22>
802013fe: 8d 06        	addi	a3, a3, 3
80201400: 13 95 c5 00  	slli	a0, a1, 12
80201404: 51 8d        	or	a0, a0, a2
80201406: 71 bf        	j	0x802013a2 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hff577ac6e379d064E.llvm.17772250532125793796+0x22>
80201408: 01 45        	li	a0, 0
8020140a: a2 60        	ld	ra, 8(sp)
8020140c: 02 64        	ld	s0, 0(sp)
8020140e: 41 01        	addi	sp, sp, 16
80201410: 82 80        	ret

Disassembly of section .text._ZN4sel47console5print17hac8e0d72989ef035E:

0000000080201412 <_ZN4sel47console5print17hac8e0d72989ef035E>:
80201412: 5d 71        	addi	sp, sp, -80
80201414: 86 e4        	sd	ra, 72(sp)
80201416: a2 e0        	sd	s0, 64(sp)
80201418: 80 08        	addi	s0, sp, 80
8020141a: 0c 75        	ld	a1, 40(a0)
8020141c: 10 71        	ld	a2, 32(a0)
8020141e: 93 06 84 fe  	addi	a3, s0, -24
80201422: 23 38 d4 fa  	sd	a3, -80(s0)
80201426: 23 30 b4 fe  	sd	a1, -32(s0)
8020142a: 23 3c c4 fc  	sd	a2, -40(s0)
8020142e: 0c 6d        	ld	a1, 24(a0)
80201430: 10 69        	ld	a2, 16(a0)
80201432: 14 65        	ld	a3, 8(a0)
80201434: 08 61        	ld	a0, 0(a0)
80201436: 23 38 b4 fc  	sd	a1, -48(s0)
8020143a: 23 34 c4 fc  	sd	a2, -56(s0)
8020143e: 23 30 d4 fc  	sd	a3, -64(s0)
80201442: 23 3c a4 fa  	sd	a0, -72(s0)

0000000080201446 <.LBB4_3>:
80201446: 97 15 00 00  	auipc	a1, 1
8020144a: 93 85 a5 2e  	addi	a1, a1, 746
8020144e: 13 05 04 fb  	addi	a0, s0, -80
80201452: 13 06 84 fb  	addi	a2, s0, -72
80201456: 97 00 00 00  	auipc	ra, 0
8020145a: e7 80 e0 53  	jalr	1342(ra)
8020145e: 09 e5        	bnez	a0, 0x80201468 <.LBB4_4>
80201460: a6 60        	ld	ra, 72(sp)
80201462: 06 64        	ld	s0, 64(sp)
80201464: 61 61        	addi	sp, sp, 80
80201466: 82 80        	ret

0000000080201468 <.LBB4_4>:
80201468: 17 15 00 00  	auipc	a0, 1
8020146c: 13 05 85 2f  	addi	a0, a0, 760

0000000080201470 <.LBB4_5>:
80201470: 97 16 00 00  	auipc	a3, 1
80201474: 93 86 06 32  	addi	a3, a3, 800

0000000080201478 <.LBB4_6>:
80201478: 17 17 00 00  	auipc	a4, 1
8020147c: 13 07 87 34  	addi	a4, a4, 840
80201480: 93 05 b0 02  	li	a1, 43
80201484: 13 06 84 fe  	addi	a2, s0, -24
80201488: 97 00 00 00  	auipc	ra, 0
8020148c: e7 80 e0 48  	jalr	1166(ra)
80201490: 00 00        	unimp	

Disassembly of section .text.rust_begin_unwind:

0000000080201492 <rust_begin_unwind>:
80201492: 6d 71        	addi	sp, sp, -272
80201494: 06 e6        	sd	ra, 264(sp)
80201496: 22 e2        	sd	s0, 256(sp)
80201498: a6 fd        	sd	s1, 248(sp)
8020149a: 00 0a        	addi	s0, sp, 272
8020149c: aa 84        	mv	s1, a0
8020149e: 97 00 00 00  	auipc	ra, 0
802014a2: e7 80 a0 3d  	jalr	986(ra)
802014a6: 15 e5        	bnez	a0, 0x802014d2 <.LBB0_10+0x16>
802014a8: 26 85        	mv	a0, s1
802014aa: 97 00 00 00  	auipc	ra, 0
802014ae: e7 80 a0 3c  	jalr	970(ra)
802014b2: 31 ed        	bnez	a0, 0x8020150e <.LBB0_12+0x16>

00000000802014b4 <.LBB0_9>:
802014b4: 17 15 00 00  	auipc	a0, 1
802014b8: 13 05 45 3c  	addi	a0, a0, 964

00000000802014bc <.LBB0_10>:
802014bc: 17 16 00 00  	auipc	a2, 1
802014c0: 13 06 c6 3f  	addi	a2, a2, 1020
802014c4: 93 05 b0 02  	li	a1, 43
802014c8: 97 00 00 00  	auipc	ra, 0
802014cc: e7 80 20 3e  	jalr	994(ra)
802014d0: 00 00        	unimp	
802014d2: 0c 61        	ld	a1, 0(a0)
802014d4: 10 65        	ld	a2, 8(a0)
802014d6: 23 30 b4 f2  	sd	a1, -224(s0)
802014da: 23 34 c4 f2  	sd	a2, -216(s0)
802014de: 08 49        	lw	a0, 16(a0)
802014e0: 23 2a a4 f2  	sw	a0, -204(s0)
802014e4: 26 85        	mv	a0, s1
802014e6: 97 00 00 00  	auipc	ra, 0
802014ea: e7 80 e0 38  	jalr	910(ra)
802014ee: 7d e5        	bnez	a0, 0x802015dc <.LBB0_18+0x24>

00000000802014f0 <.LBB0_11>:
802014f0: 17 15 00 00  	auipc	a0, 1
802014f4: 13 05 85 38  	addi	a0, a0, 904

00000000802014f8 <.LBB0_12>:
802014f8: 17 16 00 00  	auipc	a2, 1
802014fc: 13 06 06 43  	addi	a2, a2, 1072
80201500: 93 05 b0 02  	li	a1, 43
80201504: 97 00 00 00  	auipc	ra, 0
80201508: e7 80 60 3a  	jalr	934(ra)
8020150c: 00 00        	unimp	
8020150e: 23 34 a4 fa  	sd	a0, -88(s0)
80201512: 13 05 84 fa  	addi	a0, s0, -88
80201516: 23 38 a4 ee  	sd	a0, -272(s0)

000000008020151a <.LBB0_13>:
8020151a: 17 05 00 00  	auipc	a0, 0
8020151e: 13 05 a5 b8  	addi	a0, a0, -1142
80201522: 23 3c a4 ee  	sd	a0, -264(s0)

0000000080201526 <.LBB0_14>:
80201526: 17 15 00 00  	auipc	a0, 1
8020152a: 13 05 25 33  	addi	a0, a0, 818
8020152e: 23 38 a4 f4  	sd	a0, -176(s0)
80201532: 09 45        	li	a0, 2
80201534: 23 3c a4 f4  	sd	a0, -168(s0)
80201538: 23 30 04 f4  	sd	zero, -192(s0)
8020153c: 13 05 04 ef  	addi	a0, s0, -272
80201540: 23 30 a4 f6  	sd	a0, -160(s0)
80201544: 05 45        	li	a0, 1
80201546: 23 34 a4 f6  	sd	a0, -152(s0)
8020154a: 7d 45        	li	a0, 31
8020154c: 23 0a a4 f2  	sb	a0, -204(s0)
80201550: 13 05 10 03  	li	a0, 49
80201554: 23 0c a4 f2  	sb	a0, -200(s0)
80201558: 13 05 44 f3  	addi	a0, s0, -204
8020155c: 23 38 a4 f6  	sd	a0, -144(s0)

0000000080201560 <.LBB0_15>:
80201560: 17 15 00 00  	auipc	a0, 1
80201564: 13 05 45 da  	addi	a0, a0, -604
80201568: 23 3c a4 f6  	sd	a0, -136(s0)
8020156c: 93 05 84 f3  	addi	a1, s0, -200
80201570: 23 30 b4 f8  	sd	a1, -128(s0)
80201574: 23 34 a4 f8  	sd	a0, -120(s0)
80201578: 13 05 04 f4  	addi	a0, s0, -192
8020157c: 23 38 a4 f8  	sd	a0, -112(s0)

0000000080201580 <.LBB0_16>:
80201580: 17 05 00 00  	auipc	a0, 0
80201584: 13 05 25 3e  	addi	a0, a0, 994
80201588: 23 3c a4 f8  	sd	a0, -104(s0)
8020158c: 13 05 04 fe  	addi	a0, s0, -32
80201590: 23 30 a4 f2  	sd	a0, -224(s0)
80201594: 23 38 04 fa  	sd	zero, -80(s0)

0000000080201598 <.LBB0_17>:
80201598: 17 15 00 00  	auipc	a0, 1
8020159c: 13 05 05 25  	addi	a0, a0, 592
802015a0: 23 30 a4 fc  	sd	a0, -64(s0)
802015a4: 11 45        	li	a0, 4
802015a6: 23 34 a4 fc  	sd	a0, -56(s0)
802015aa: 13 05 04 f7  	addi	a0, s0, -144
802015ae: 23 38 a4 fc  	sd	a0, -48(s0)
802015b2: 0d 45        	li	a0, 3
802015b4: 23 3c a4 fc  	sd	a0, -40(s0)

00000000802015b8 <.LBB0_18>:
802015b8: 97 15 00 00  	auipc	a1, 1
802015bc: 93 85 85 17  	addi	a1, a1, 376
802015c0: 13 05 04 f2  	addi	a0, s0, -224
802015c4: 13 06 04 fb  	addi	a2, s0, -80
802015c8: 97 00 00 00  	auipc	ra, 0
802015cc: e7 80 c0 3c  	jalr	972(ra)
802015d0: 75 e9        	bnez	a0, 0x802016c4 <.LBB0_27>
802015d2: 97 00 00 00  	auipc	ra, 0
802015d6: e7 80 20 a8  	jalr	-1406(ra)
802015da: 00 00        	unimp	
802015dc: 23 3c a4 f2  	sd	a0, -200(s0)
802015e0: 13 05 04 f2  	addi	a0, s0, -224
802015e4: 23 30 a4 f4  	sd	a0, -192(s0)

00000000802015e8 <.LBB0_19>:
802015e8: 17 05 00 00  	auipc	a0, 0
802015ec: 13 05 45 ad  	addi	a0, a0, -1324
802015f0: 23 34 a4 f4  	sd	a0, -184(s0)
802015f4: 13 05 44 f3  	addi	a0, s0, -204
802015f8: 23 38 a4 f4  	sd	a0, -176(s0)

00000000802015fc <.LBB0_20>:
802015fc: 17 15 00 00  	auipc	a0, 1
80201600: 13 05 85 d1  	addi	a0, a0, -744
80201604: 23 3c a4 f4  	sd	a0, -168(s0)
80201608: 13 05 84 f3  	addi	a0, s0, -200
8020160c: 23 30 a4 f6  	sd	a0, -160(s0)

0000000080201610 <.LBB0_21>:
80201610: 17 05 00 00  	auipc	a0, 0
80201614: 13 05 45 a9  	addi	a0, a0, -1388
80201618: 23 34 a4 f6  	sd	a0, -152(s0)

000000008020161c <.LBB0_22>:
8020161c: 17 15 00 00  	auipc	a0, 1
80201620: 13 05 c5 2c  	addi	a0, a0, 716
80201624: 23 30 a4 f0  	sd	a0, -256(s0)
80201628: 11 45        	li	a0, 4
8020162a: 23 34 a4 f0  	sd	a0, -248(s0)
8020162e: 23 38 04 ee  	sd	zero, -272(s0)
80201632: 93 05 04 f4  	addi	a1, s0, -192
80201636: 23 38 b4 f0  	sd	a1, -240(s0)
8020163a: 8d 45        	li	a1, 3
8020163c: 23 3c b4 f0  	sd	a1, -232(s0)
80201640: 7d 46        	li	a2, 31
80201642: 23 03 c4 fa  	sb	a2, -90(s0)
80201646: 13 06 10 03  	li	a2, 49
8020164a: a3 03 c4 fa  	sb	a2, -89(s0)
8020164e: 13 06 64 fa  	addi	a2, s0, -90
80201652: 23 38 c4 f6  	sd	a2, -144(s0)

0000000080201656 <.LBB0_23>:
80201656: 17 16 00 00  	auipc	a2, 1
8020165a: 13 06 e6 ca  	addi	a2, a2, -850
8020165e: 23 3c c4 f6  	sd	a2, -136(s0)
80201662: 93 06 74 fa  	addi	a3, s0, -89
80201666: 23 30 d4 f8  	sd	a3, -128(s0)
8020166a: 23 34 c4 f8  	sd	a2, -120(s0)
8020166e: 13 06 04 ef  	addi	a2, s0, -272
80201672: 23 38 c4 f8  	sd	a2, -112(s0)

0000000080201676 <.LBB0_24>:
80201676: 17 06 00 00  	auipc	a2, 0
8020167a: 13 06 c6 2e  	addi	a2, a2, 748
8020167e: 23 3c c4 f8  	sd	a2, -104(s0)
80201682: 13 06 04 fe  	addi	a2, s0, -32
80201686: 23 34 c4 fa  	sd	a2, -88(s0)
8020168a: 23 38 04 fa  	sd	zero, -80(s0)

000000008020168e <.LBB0_25>:
8020168e: 17 16 00 00  	auipc	a2, 1
80201692: 13 06 a6 15  	addi	a2, a2, 346
80201696: 23 30 c4 fc  	sd	a2, -64(s0)
8020169a: 23 34 a4 fc  	sd	a0, -56(s0)
8020169e: 13 05 04 f7  	addi	a0, s0, -144
802016a2: 23 38 a4 fc  	sd	a0, -48(s0)
802016a6: 23 3c b4 fc  	sd	a1, -40(s0)

00000000802016aa <.LBB0_26>:
802016aa: 97 15 00 00  	auipc	a1, 1
802016ae: 93 85 65 08  	addi	a1, a1, 134
802016b2: 13 05 84 fa  	addi	a0, s0, -88
802016b6: 13 06 04 fb  	addi	a2, s0, -80
802016ba: 97 00 00 00  	auipc	ra, 0
802016be: e7 80 a0 2d  	jalr	730(ra)
802016c2: 01 d9        	beqz	a0, 0x802015d2 <.LBB0_18+0x1a>

00000000802016c4 <.LBB0_27>:
802016c4: 17 15 00 00  	auipc	a0, 1
802016c8: 13 05 c5 09  	addi	a0, a0, 156

00000000802016cc <.LBB0_28>:
802016cc: 97 16 00 00  	auipc	a3, 1
802016d0: 93 86 46 0c  	addi	a3, a3, 196

00000000802016d4 <.LBB0_29>:
802016d4: 17 17 00 00  	auipc	a4, 1
802016d8: 13 07 47 15  	addi	a4, a4, 340
802016dc: 93 05 b0 02  	li	a1, 43
802016e0: 13 06 04 fe  	addi	a2, s0, -32
802016e4: 97 00 00 00  	auipc	ra, 0
802016e8: e7 80 20 23  	jalr	562(ra)
802016ec: 00 00        	unimp	

Disassembly of section .text._ZN22buddy_system_allocator4Heap4init17h096a9c186af21a8bE:

00000000802016ee <_ZN22buddy_system_allocator4Heap4init17h096a9c186af21a8bE>:
802016ee: 41 11        	addi	sp, sp, -16
802016f0: 06 e4        	sd	ra, 8(sp)
802016f2: 22 e0        	sd	s0, 0(sp)
802016f4: 00 08        	addi	s0, sp, 16
802016f6: 2e 96        	add	a2, a2, a1
802016f8: 9d 05        	addi	a1, a1, 7
802016fa: e1 99        	andi	a1, a1, -8
802016fc: 93 7e 86 ff  	andi	t4, a2, -8
80201700: 63 eb be 12  	bltu	t4, a1, 0x80201836 <.LBB5_20>
80201704: 01 47        	li	a4, 0
80201706: 13 86 85 00  	addi	a2, a1, 8
8020170a: 63 e1 ce 10  	bltu	t4, a2, 0x8020180c <.LBB5_18+0xda>

000000008020170e <.LBB5_15>:
8020170e: 17 16 00 00  	auipc	a2, 1
80201712: 13 06 26 c7  	addi	a2, a2, -910
80201716: 03 38 06 00  	ld	a6, 0(a2)

000000008020171a <.LBB5_16>:
8020171a: 17 16 00 00  	auipc	a2, 1
8020171e: 13 06 e6 c6  	addi	a2, a2, -914
80201722: 03 3f 06 00  	ld	t5, 0(a2)

0000000080201726 <.LBB5_17>:
80201726: 17 16 00 00  	auipc	a2, 1
8020172a: 13 06 a6 c6  	addi	a2, a2, -918
8020172e: 83 38 06 00  	ld	a7, 0(a2)

0000000080201732 <.LBB5_18>:
80201732: 17 16 00 00  	auipc	a2, 1
80201736: 13 06 66 c6  	addi	a2, a2, -922
8020173a: 83 32 06 00  	ld	t0, 0(a2)
8020173e: 13 03 f0 03  	li	t1, 63
80201742: 85 43        	li	t2, 1
80201744: 7d 4e        	li	t3, 31
80201746: 33 86 be 40  	sub	a2, t4, a1
8020174a: 31 ca        	beqz	a2, 0x8020179e <.LBB5_18+0x6c>
8020174c: 93 56 16 00  	srli	a3, a2, 1
80201750: 55 8e        	or	a2, a2, a3
80201752: 93 56 26 00  	srli	a3, a2, 2
80201756: 55 8e        	or	a2, a2, a3
80201758: 93 56 46 00  	srli	a3, a2, 4
8020175c: 55 8e        	or	a2, a2, a3
8020175e: 93 56 86 00  	srli	a3, a2, 8
80201762: 55 8e        	or	a2, a2, a3
80201764: 93 56 06 01  	srli	a3, a2, 16
80201768: 55 8e        	or	a2, a2, a3
8020176a: 93 56 06 02  	srli	a3, a2, 32
8020176e: 55 8e        	or	a2, a2, a3
80201770: 13 46 f6 ff  	not	a2, a2
80201774: 93 56 16 00  	srli	a3, a2, 1
80201778: b3 f6 06 01  	and	a3, a3, a6
8020177c: 15 8e        	sub	a2, a2, a3
8020177e: b3 76 e6 01  	and	a3, a2, t5
80201782: 09 82        	srli	a2, a2, 2
80201784: 33 76 e6 01  	and	a2, a2, t5
80201788: 36 96        	add	a2, a2, a3
8020178a: 93 56 46 00  	srli	a3, a2, 4
8020178e: 36 96        	add	a2, a2, a3
80201790: 33 76 16 01  	and	a2, a2, a7
80201794: 33 06 56 02  	mul	a2, a2, t0
80201798: 93 56 86 03  	srli	a3, a2, 56
8020179c: 19 a0        	j	0x802017a2 <.LBB5_18+0x70>
8020179e: 93 06 00 04  	li	a3, 64
802017a2: 33 06 b0 40  	neg	a2, a1
802017a6: 6d 8e        	and	a2, a2, a1
802017a8: b3 06 d3 40  	sub	a3, t1, a3
802017ac: b3 96 d3 00  	sll	a3, t2, a3
802017b0: 63 63 d6 00  	bltu	a2, a3, 0x802017b6 <.LBB5_18+0x84>
802017b4: 36 86        	mv	a2, a3
802017b6: 05 ce        	beqz	a2, 0x802017ee <.LBB5_18+0xbc>
802017b8: 93 06 f6 ff  	addi	a3, a2, -1
802017bc: 93 47 f6 ff  	not	a5, a2
802017c0: fd 8e        	and	a3, a3, a5
802017c2: 93 d7 16 00  	srli	a5, a3, 1
802017c6: b3 f7 07 01  	and	a5, a5, a6
802017ca: 9d 8e        	sub	a3, a3, a5
802017cc: b3 f7 e6 01  	and	a5, a3, t5
802017d0: 89 82        	srli	a3, a3, 2
802017d2: b3 f6 e6 01  	and	a3, a3, t5
802017d6: be 96        	add	a3, a3, a5
802017d8: 93 d7 46 00  	srli	a5, a3, 4
802017dc: be 96        	add	a3, a3, a5
802017de: b3 f6 16 01  	and	a3, a3, a7
802017e2: b3 86 56 02  	mul	a3, a3, t0
802017e6: e1 92        	srli	a3, a3, 56
802017e8: 63 77 de 00  	bgeu	t3, a3, 0x802017f6 <.LBB5_18+0xc4>
802017ec: 0d a8        	j	0x8020181e <.LBB5_19>
802017ee: 93 06 00 04  	li	a3, 64
802017f2: 63 66 de 02  	bltu	t3, a3, 0x8020181e <.LBB5_19>
802017f6: 8e 06        	slli	a3, a3, 3
802017f8: aa 96        	add	a3, a3, a0
802017fa: 9c 62        	ld	a5, 0(a3)
802017fc: 9c e1        	sd	a5, 0(a1)
802017fe: 8c e2        	sd	a1, 0(a3)
80201800: b2 95        	add	a1, a1, a2
80201802: 93 86 85 00  	addi	a3, a1, 8
80201806: 32 97        	add	a4, a4, a2
80201808: e3 ff de f2  	bgeu	t4, a3, 0x80201746 <.LBB5_18+0x14>
8020180c: 83 35 05 11  	ld	a1, 272(a0)
80201810: ba 95        	add	a1, a1, a4
80201812: 23 38 b5 10  	sd	a1, 272(a0)
80201816: a2 60        	ld	ra, 8(sp)
80201818: 02 64        	ld	s0, 0(sp)
8020181a: 41 01        	addi	sp, sp, 16
8020181c: 82 80        	ret

000000008020181e <.LBB5_19>:
8020181e: 17 16 00 00  	auipc	a2, 1
80201822: 13 06 26 1c  	addi	a2, a2, 450
80201826: 93 05 00 02  	li	a1, 32
8020182a: 36 85        	mv	a0, a3
8020182c: 97 00 00 00  	auipc	ra, 0
80201830: e7 80 a0 0a  	jalr	170(ra)
80201834: 00 00        	unimp	

0000000080201836 <.LBB5_20>:
80201836: 17 15 00 00  	auipc	a0, 1
8020183a: 13 05 a5 10  	addi	a0, a0, 266

000000008020183e <.LBB5_21>:
8020183e: 17 16 00 00  	auipc	a2, 1
80201842: 13 06 a6 18  	addi	a2, a2, 394
80201846: f9 45        	li	a1, 30
80201848: 97 00 00 00  	auipc	ra, 0
8020184c: e7 80 20 06  	jalr	98(ra)
80201850: 00 00        	unimp	

Disassembly of section .text._ZN78_$LT$buddy_system_allocator..LockedHeap$u20$as$u20$core..ops..deref..Deref$GT$5deref17h2474381731d24de7E:

0000000080201852 <_ZN88_$LT$buddy_system_allocator..LockedHeapWithRescue$u20$as$u20$core..ops..deref..Deref$GT$5deref17h1624b06b126ab7f3E>:
80201852: 41 11        	addi	sp, sp, -16
80201854: 06 e4        	sd	ra, 8(sp)
80201856: 22 e0        	sd	s0, 0(sp)
80201858: 00 08        	addi	s0, sp, 16
8020185a: a2 60        	ld	ra, 8(sp)
8020185c: 02 64        	ld	s0, 0(sp)
8020185e: 41 01        	addi	sp, sp, 16
80201860: 82 80        	ret

Disassembly of section .text._ZN4core3ops8function6FnOnce9call_once17hfd3303d23173549bE:

0000000080201862 <_ZN4core3ops8function6FnOnce9call_once17hfd3303d23173549bE>:
80201862: 08 61        	ld	a0, 0(a0)
80201864: 01 a0        	j	0x80201864 <_ZN4core3ops8function6FnOnce9call_once17hfd3303d23173549bE+0x2>

Disassembly of section .text._ZN4core3ptr102drop_in_place$LT$$RF$core..iter..adapters..copied..Copied$LT$core..slice..iter..Iter$LT$u8$GT$$GT$$GT$17h53befd6046d0b90eE:

0000000080201866 <_ZN4core3ptr102drop_in_place$LT$$RF$core..iter..adapters..copied..Copied$LT$core..slice..iter..Iter$LT$u8$GT$$GT$$GT$17h53befd6046d0b90eE>:
80201866: 82 80        	ret

Disassembly of section .text._ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17hf7601e0e4f62b400E:

0000000080201868 <_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17hf7601e0e4f62b400E>:
80201868: 17 15 00 00  	auipc	a0, 1
8020186c: 13 05 05 c8  	addi	a0, a0, -896
80201870: 08 61        	ld	a0, 0(a0)
80201872: 82 80        	ret

Disassembly of section .text._ZN4core5panic10panic_info9PanicInfo7message17hcb7a5a3e466be904E:

0000000080201874 <_ZN4core5panic10panic_info9PanicInfo7message17hcb7a5a3e466be904E>:
80201874: 08 69        	ld	a0, 16(a0)
80201876: 82 80        	ret

Disassembly of section .text._ZN4core5panic10panic_info9PanicInfo8location17h43d8a14288f989fbE:

0000000080201878 <_ZN4core5panic10panic_info9PanicInfo8location17h43d8a14288f989fbE>:
80201878: 08 6d        	ld	a0, 24(a0)
8020187a: 82 80        	ret

Disassembly of section .text.unlikely._ZN4core9panicking9panic_fmt17h09608ae52bd0d3adE:

000000008020187c <_ZN4core9panicking9panic_fmt17h09608ae52bd0d3adE>:
8020187c: 79 71        	addi	sp, sp, -48
8020187e: 06 f4        	sd	ra, 40(sp)

0000000080201880 <.LBB169_1>:
80201880: 17 16 00 00  	auipc	a2, 1
80201884: 13 06 86 17  	addi	a2, a2, 376
80201888: 32 e0        	sd	a2, 0(sp)

000000008020188a <.LBB169_2>:
8020188a: 17 16 00 00  	auipc	a2, 1
8020188e: 13 06 66 1c  	addi	a2, a2, 454
80201892: 32 e4        	sd	a2, 8(sp)
80201894: 2a e8        	sd	a0, 16(sp)
80201896: 2e ec        	sd	a1, 24(sp)
80201898: 05 45        	li	a0, 1
8020189a: 23 00 a1 02  	sb	a0, 32(sp)
8020189e: 0a 85        	mv	a0, sp
802018a0: 97 00 00 00  	auipc	ra, 0
802018a4: e7 80 20 bf  	jalr	-1038(ra)
802018a8: 00 00        	unimp	

Disassembly of section .text.unlikely._ZN4core9panicking5panic17h968d2b6b541ffadfE:

00000000802018aa <_ZN4core9panicking5panic17h968d2b6b541ffadfE>:
802018aa: 5d 71        	addi	sp, sp, -80
802018ac: 86 e4        	sd	ra, 72(sp)
802018ae: 2a fc        	sd	a0, 56(sp)
802018b0: ae e0        	sd	a1, 64(sp)
802018b2: 28 18        	addi	a0, sp, 56
802018b4: 2a ec        	sd	a0, 24(sp)
802018b6: 05 45        	li	a0, 1
802018b8: 2a f0        	sd	a0, 32(sp)
802018ba: 02 e4        	sd	zero, 8(sp)

00000000802018bc <.LBB171_1>:
802018bc: 17 15 00 00  	auipc	a0, 1
802018c0: 13 05 c5 13  	addi	a0, a0, 316
802018c4: 2a f4        	sd	a0, 40(sp)
802018c6: 02 f8        	sd	zero, 48(sp)
802018c8: 28 00        	addi	a0, sp, 8
802018ca: b2 85        	mv	a1, a2
802018cc: 97 00 00 00  	auipc	ra, 0
802018d0: e7 80 00 fb  	jalr	-80(ra)
802018d4: 00 00        	unimp	

Disassembly of section .text.unlikely._ZN4core9panicking18panic_bounds_check17h03ed6527cd415bf9E:

00000000802018d6 <_ZN4core9panicking18panic_bounds_check17h03ed6527cd415bf9E>:
802018d6: 59 71        	addi	sp, sp, -112
802018d8: 86 f4        	sd	ra, 104(sp)
802018da: 2a e4        	sd	a0, 8(sp)
802018dc: 2e e8        	sd	a1, 16(sp)
802018de: 08 08        	addi	a0, sp, 16
802018e0: aa e4        	sd	a0, 72(sp)

00000000802018e2 <.LBB174_1>:
802018e2: 17 15 00 00  	auipc	a0, 1
802018e6: 13 05 25 a4  	addi	a0, a0, -1470
802018ea: aa e8        	sd	a0, 80(sp)
802018ec: 2c 00        	addi	a1, sp, 8
802018ee: ae ec        	sd	a1, 88(sp)
802018f0: aa f0        	sd	a0, 96(sp)

00000000802018f2 <.LBB174_2>:
802018f2: 17 15 00 00  	auipc	a0, 1
802018f6: 13 05 e5 13  	addi	a0, a0, 318
802018fa: 2a f4        	sd	a0, 40(sp)
802018fc: 09 45        	li	a0, 2
802018fe: 2a f8        	sd	a0, 48(sp)
80201900: 02 ec        	sd	zero, 24(sp)
80201902: ac 00        	addi	a1, sp, 72
80201904: 2e fc        	sd	a1, 56(sp)
80201906: aa e0        	sd	a0, 64(sp)
80201908: 28 08        	addi	a0, sp, 24
8020190a: b2 85        	mv	a1, a2
8020190c: 97 00 00 00  	auipc	ra, 0
80201910: e7 80 00 f7  	jalr	-144(ra)
80201914: 00 00        	unimp	

Disassembly of section .text.unlikely._ZN4core6result13unwrap_failed17h93c501911315d321E:

0000000080201916 <_ZN4core6result13unwrap_failed17h93c501911315d321E>:
80201916: 19 71        	addi	sp, sp, -128
80201918: 86 fc        	sd	ra, 120(sp)
8020191a: 2a e4        	sd	a0, 8(sp)
8020191c: 2e e8        	sd	a1, 16(sp)
8020191e: 32 ec        	sd	a2, 24(sp)
80201920: 36 f0        	sd	a3, 32(sp)
80201922: 28 00        	addi	a0, sp, 8
80201924: aa ec        	sd	a0, 88(sp)

0000000080201926 <.LBB181_1>:
80201926: 17 15 00 00  	auipc	a0, 1
8020192a: 13 05 65 a2  	addi	a0, a0, -1498
8020192e: aa f0        	sd	a0, 96(sp)
80201930: 28 08        	addi	a0, sp, 24
80201932: aa f4        	sd	a0, 104(sp)

0000000080201934 <.LBB181_2>:
80201934: 17 15 00 00  	auipc	a0, 1
80201938: 13 05 05 a1  	addi	a0, a0, -1520
8020193c: aa f8        	sd	a0, 112(sp)

000000008020193e <.LBB181_3>:
8020193e: 17 15 00 00  	auipc	a0, 1
80201942: 13 05 a5 13  	addi	a0, a0, 314
80201946: 2a fc        	sd	a0, 56(sp)
80201948: 09 45        	li	a0, 2
8020194a: aa e0        	sd	a0, 64(sp)
8020194c: 02 f4        	sd	zero, 40(sp)
8020194e: ac 08        	addi	a1, sp, 88
80201950: ae e4        	sd	a1, 72(sp)
80201952: aa e8        	sd	a0, 80(sp)
80201954: 28 10        	addi	a0, sp, 40
80201956: ba 85        	mv	a1, a4
80201958: 97 00 00 00  	auipc	ra, 0
8020195c: e7 80 40 f2  	jalr	-220(ra)
80201960: 00 00        	unimp	

Disassembly of section .text._ZN59_$LT$core..fmt..Arguments$u20$as$u20$core..fmt..Display$GT$3fmt17h14b26a2a8d914ef0E:

0000000080201962 <_ZN59_$LT$core..fmt..Arguments$u20$as$u20$core..fmt..Display$GT$3fmt17h14b26a2a8d914ef0E>:
80201962: 39 71        	addi	sp, sp, -64
80201964: 06 fc        	sd	ra, 56(sp)
80201966: 10 75        	ld	a2, 40(a0)
80201968: 18 71        	ld	a4, 32(a0)
8020196a: 1c 6d        	ld	a5, 24(a0)
8020196c: 32 f8        	sd	a2, 48(sp)
8020196e: 94 61        	ld	a3, 0(a1)
80201970: 3a f4        	sd	a4, 40(sp)
80201972: 3e f0        	sd	a5, 32(sp)
80201974: 10 69        	ld	a2, 16(a0)
80201976: 18 65        	ld	a4, 8(a0)
80201978: 08 61        	ld	a0, 0(a0)
8020197a: 8c 65        	ld	a1, 8(a1)
8020197c: 32 ec        	sd	a2, 24(sp)
8020197e: 3a e8        	sd	a4, 16(sp)
80201980: 2a e4        	sd	a0, 8(sp)
80201982: 30 00        	addi	a2, sp, 8
80201984: 36 85        	mv	a0, a3
80201986: 97 00 00 00  	auipc	ra, 0
8020198a: e7 80 e0 00  	jalr	14(ra)
8020198e: e2 70        	ld	ra, 56(sp)
80201990: 21 61        	addi	sp, sp, 64
80201992: 82 80        	ret

Disassembly of section .text._ZN4core3fmt5write17h42fcd7b837de3f75E:

0000000080201994 <_ZN4core3fmt5write17h42fcd7b837de3f75E>:
80201994: 19 71        	addi	sp, sp, -128
80201996: 86 fc        	sd	ra, 120(sp)
80201998: a2 f8        	sd	s0, 112(sp)
8020199a: a6 f4        	sd	s1, 104(sp)
8020199c: ca f0        	sd	s2, 96(sp)
8020199e: ce ec        	sd	s3, 88(sp)
802019a0: d2 e8        	sd	s4, 80(sp)
802019a2: d6 e4        	sd	s5, 72(sp)
802019a4: da e0        	sd	s6, 64(sp)
802019a6: b2 89        	mv	s3, a2
802019a8: 05 46        	li	a2, 1
802019aa: 16 16        	slli	a2, a2, 37
802019ac: 32 f8        	sd	a2, 48(sp)
802019ae: 0d 46        	li	a2, 3
802019b0: 23 0c c1 02  	sb	a2, 56(sp)
802019b4: 03 b6 09 00  	ld	a2, 0(s3)
802019b8: 02 e8        	sd	zero, 16(sp)
802019ba: 02 f0        	sd	zero, 32(sp)
802019bc: 2a e0        	sd	a0, 0(sp)
802019be: 2e e4        	sd	a1, 8(sp)
802019c0: 69 c6        	beqz	a2, 0x80201a8a <.LBB218_31+0x9e>
802019c2: 03 b5 89 00  	ld	a0, 8(s3)
802019c6: 63 0e 05 10  	beqz	a0, 0x80201ae2 <.LBB218_31+0xf6>
802019ca: 83 b5 09 01  	ld	a1, 16(s3)
802019ce: 93 06 f5 ff  	addi	a3, a0, -1
802019d2: 8e 06        	slli	a3, a3, 3
802019d4: 8d 82        	srli	a3, a3, 3
802019d6: 13 89 16 00  	addi	s2, a3, 1
802019da: 93 84 85 00  	addi	s1, a1, 8
802019de: 93 05 80 03  	li	a1, 56
802019e2: 33 0a b5 02  	mul	s4, a0, a1
802019e6: 13 04 86 01  	addi	s0, a2, 24
802019ea: 85 4a        	li	s5, 1

00000000802019ec <.LBB218_31>:
802019ec: 17 0b 00 00  	auipc	s6, 0
802019f0: 13 0b 6b e7  	addi	s6, s6, -394
802019f4: 90 60        	ld	a2, 0(s1)
802019f6: 09 ca        	beqz	a2, 0x80201a08 <.LBB218_31+0x1c>
802019f8: a2 66        	ld	a3, 8(sp)
802019fa: 02 65        	ld	a0, 0(sp)
802019fc: 83 b5 84 ff  	ld	a1, -8(s1)
80201a00: 94 6e        	ld	a3, 24(a3)
80201a02: 82 96        	jalr	a3
80201a04: 63 11 05 10  	bnez	a0, 0x80201b06 <.LBB218_31+0x11a>
80201a08: 48 44        	lw	a0, 12(s0)
80201a0a: 2a da        	sw	a0, 52(sp)
80201a0c: 03 05 04 01  	lb	a0, 16(s0)
80201a10: 23 0c a1 02  	sb	a0, 56(sp)
80201a14: 0c 44        	lw	a1, 8(s0)
80201a16: 03 b5 09 02  	ld	a0, 32(s3)
80201a1a: 2e d8        	sw	a1, 48(sp)
80201a1c: 83 36 84 ff  	ld	a3, -8(s0)
80201a20: 0c 60        	ld	a1, 0(s0)
80201a22: 89 ce        	beqz	a3, 0x80201a3c <.LBB218_31+0x50>
80201a24: 01 46        	li	a2, 0
80201a26: 63 9c 56 01  	bne	a3, s5, 0x80201a3e <.LBB218_31+0x52>
80201a2a: 92 05        	slli	a1, a1, 4
80201a2c: aa 95        	add	a1, a1, a0
80201a2e: 90 65        	ld	a2, 8(a1)
80201a30: 63 04 66 01  	beq	a2, s6, 0x80201a38 <.LBB218_31+0x4c>
80201a34: 01 46        	li	a2, 0
80201a36: 21 a0        	j	0x80201a3e <.LBB218_31+0x52>
80201a38: 8c 61        	ld	a1, 0(a1)
80201a3a: 8c 61        	ld	a1, 0(a1)
80201a3c: 05 46        	li	a2, 1
80201a3e: 32 e8        	sd	a2, 16(sp)
80201a40: 2e ec        	sd	a1, 24(sp)
80201a42: 83 36 84 fe  	ld	a3, -24(s0)
80201a46: 83 35 04 ff  	ld	a1, -16(s0)
80201a4a: 89 ce        	beqz	a3, 0x80201a64 <.LBB218_31+0x78>
80201a4c: 01 46        	li	a2, 0
80201a4e: 63 9c 56 01  	bne	a3, s5, 0x80201a66 <.LBB218_31+0x7a>
80201a52: 92 05        	slli	a1, a1, 4
80201a54: aa 95        	add	a1, a1, a0
80201a56: 90 65        	ld	a2, 8(a1)
80201a58: 63 04 66 01  	beq	a2, s6, 0x80201a60 <.LBB218_31+0x74>
80201a5c: 01 46        	li	a2, 0
80201a5e: 21 a0        	j	0x80201a66 <.LBB218_31+0x7a>
80201a60: 8c 61        	ld	a1, 0(a1)
80201a62: 8c 61        	ld	a1, 0(a1)
80201a64: 05 46        	li	a2, 1
80201a66: 32 f0        	sd	a2, 32(sp)
80201a68: 2e f4        	sd	a1, 40(sp)
80201a6a: 0c 6c        	ld	a1, 24(s0)
80201a6c: 92 05        	slli	a1, a1, 4
80201a6e: 2e 95        	add	a0, a0, a1
80201a70: 10 65        	ld	a2, 8(a0)
80201a72: 08 61        	ld	a0, 0(a0)
80201a74: 8a 85        	mv	a1, sp
80201a76: 02 96        	jalr	a2
80201a78: 59 e5        	bnez	a0, 0x80201b06 <.LBB218_31+0x11a>
80201a7a: c1 04        	addi	s1, s1, 16
80201a7c: 13 0a 8a fc  	addi	s4, s4, -56
80201a80: 13 04 84 03  	addi	s0, s0, 56
80201a84: e3 18 0a f6  	bnez	s4, 0x802019f4 <.LBB218_31+0x8>
80201a88: 81 a8        	j	0x80201ad8 <.LBB218_31+0xec>
80201a8a: 03 b5 89 02  	ld	a0, 40(s3)
80201a8e: 31 c9        	beqz	a0, 0x80201ae2 <.LBB218_31+0xf6>
80201a90: 83 b5 09 02  	ld	a1, 32(s3)
80201a94: 03 b6 09 01  	ld	a2, 16(s3)
80201a98: 93 06 f5 ff  	addi	a3, a0, -1
80201a9c: 92 06        	slli	a3, a3, 4
80201a9e: 91 82        	srli	a3, a3, 4
80201aa0: 13 89 16 00  	addi	s2, a3, 1
80201aa4: 13 04 86 00  	addi	s0, a2, 8
80201aa8: 13 1a 45 00  	slli	s4, a0, 4
80201aac: 93 84 85 00  	addi	s1, a1, 8
80201ab0: 10 60        	ld	a2, 0(s0)
80201ab2: 01 ca        	beqz	a2, 0x80201ac2 <.LBB218_31+0xd6>
80201ab4: a2 66        	ld	a3, 8(sp)
80201ab6: 02 65        	ld	a0, 0(sp)
80201ab8: 83 35 84 ff  	ld	a1, -8(s0)
80201abc: 94 6e        	ld	a3, 24(a3)
80201abe: 82 96        	jalr	a3
80201ac0: 39 e1        	bnez	a0, 0x80201b06 <.LBB218_31+0x11a>
80201ac2: 90 60        	ld	a2, 0(s1)
80201ac4: 03 b5 84 ff  	ld	a0, -8(s1)
80201ac8: 8a 85        	mv	a1, sp
80201aca: 02 96        	jalr	a2
80201acc: 0d ed        	bnez	a0, 0x80201b06 <.LBB218_31+0x11a>
80201ace: 41 04        	addi	s0, s0, 16
80201ad0: 41 1a        	addi	s4, s4, -16
80201ad2: c1 04        	addi	s1, s1, 16
80201ad4: e3 1e 0a fc  	bnez	s4, 0x80201ab0 <.LBB218_31+0xc4>
80201ad8: 03 b5 89 01  	ld	a0, 24(s3)
80201adc: 63 68 a9 00  	bltu	s2, a0, 0x80201aec <.LBB218_31+0x100>
80201ae0: 2d a0        	j	0x80201b0a <.LBB218_31+0x11e>
80201ae2: 01 49        	li	s2, 0
80201ae4: 03 b5 89 01  	ld	a0, 24(s3)
80201ae8: 63 71 a9 02  	bgeu	s2, a0, 0x80201b0a <.LBB218_31+0x11e>
80201aec: 03 b5 09 01  	ld	a0, 16(s3)
80201af0: 93 15 49 00  	slli	a1, s2, 4
80201af4: 33 06 b5 00  	add	a2, a0, a1
80201af8: a2 66        	ld	a3, 8(sp)
80201afa: 02 65        	ld	a0, 0(sp)
80201afc: 0c 62        	ld	a1, 0(a2)
80201afe: 10 66        	ld	a2, 8(a2)
80201b00: 94 6e        	ld	a3, 24(a3)
80201b02: 82 96        	jalr	a3
80201b04: 19 c1        	beqz	a0, 0x80201b0a <.LBB218_31+0x11e>
80201b06: 05 45        	li	a0, 1
80201b08: 11 a0        	j	0x80201b0c <.LBB218_31+0x120>
80201b0a: 01 45        	li	a0, 0
80201b0c: e6 70        	ld	ra, 120(sp)
80201b0e: 46 74        	ld	s0, 112(sp)
80201b10: a6 74        	ld	s1, 104(sp)
80201b12: 06 79        	ld	s2, 96(sp)
80201b14: e6 69        	ld	s3, 88(sp)
80201b16: 46 6a        	ld	s4, 80(sp)
80201b18: a6 6a        	ld	s5, 72(sp)
80201b1a: 06 6b        	ld	s6, 64(sp)
80201b1c: 09 61        	addi	sp, sp, 128
80201b1e: 82 80        	ret

Disassembly of section .text._ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E:

0000000080201b20 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E>:
80201b20: 59 71        	addi	sp, sp, -112
80201b22: 86 f4        	sd	ra, 104(sp)
80201b24: a2 f0        	sd	s0, 96(sp)
80201b26: a6 ec        	sd	s1, 88(sp)
80201b28: ca e8        	sd	s2, 80(sp)
80201b2a: ce e4        	sd	s3, 72(sp)
80201b2c: d2 e0        	sd	s4, 64(sp)
80201b2e: 56 fc        	sd	s5, 56(sp)
80201b30: 5a f8        	sd	s6, 48(sp)
80201b32: 5e f4        	sd	s7, 40(sp)
80201b34: 62 f0        	sd	s8, 32(sp)
80201b36: 66 ec        	sd	s9, 24(sp)
80201b38: 6a e8        	sd	s10, 16(sp)
80201b3a: 6e e4        	sd	s11, 8(sp)
80201b3c: be 89        	mv	s3, a5
80201b3e: 3a 89        	mv	s2, a4
80201b40: 36 8b        	mv	s6, a3
80201b42: 32 8a        	mv	s4, a2
80201b44: 2a 8c        	mv	s8, a0
80201b46: b9 c1        	beqz	a1, 0x80201b8c <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x6c>
80201b48: 03 64 0c 03  	lwu	s0, 48(s8)
80201b4c: 13 75 14 00  	andi	a0, s0, 1
80201b50: b7 0a 11 00  	lui	s5, 272
80201b54: 19 c1        	beqz	a0, 0x80201b5a <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x3a>
80201b56: 93 0a b0 02  	li	s5, 43
80201b5a: b3 0c 35 01  	add	s9, a0, s3
80201b5e: 13 75 44 00  	andi	a0, s0, 4
80201b62: 15 cd        	beqz	a0, 0x80201b9e <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x7e>
80201b64: 13 05 00 02  	li	a0, 32
80201b68: 63 70 ab 04  	bgeu	s6, a0, 0x80201ba8 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x88>
80201b6c: 01 45        	li	a0, 0
80201b6e: 63 03 0b 04  	beqz	s6, 0x80201bb4 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x94>
80201b72: da 85        	mv	a1, s6
80201b74: 52 86        	mv	a2, s4
80201b76: 83 06 06 00  	lb	a3, 0(a2)
80201b7a: 05 06        	addi	a2, a2, 1
80201b7c: 93 a6 06 fc  	slti	a3, a3, -64
80201b80: 93 c6 16 00  	xori	a3, a3, 1
80201b84: fd 15        	addi	a1, a1, -1
80201b86: 36 95        	add	a0, a0, a3
80201b88: fd f5        	bnez	a1, 0x80201b76 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x56>
80201b8a: 2d a0        	j	0x80201bb4 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x94>
80201b8c: 03 24 0c 03  	lw	s0, 48(s8)
80201b90: 93 8c 19 00  	addi	s9, s3, 1
80201b94: 93 0a d0 02  	li	s5, 45
80201b98: 13 75 44 00  	andi	a0, s0, 4
80201b9c: 61 f5        	bnez	a0, 0x80201b64 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x44>
80201b9e: 01 4a        	li	s4, 0
80201ba0: 03 35 0c 01  	ld	a0, 16(s8)
80201ba4: 01 ed        	bnez	a0, 0x80201bbc <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x9c>
80201ba6: 99 a0        	j	0x80201bec <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xcc>
80201ba8: 52 85        	mv	a0, s4
80201baa: da 85        	mv	a1, s6
80201bac: 97 00 00 00  	auipc	ra, 0
80201bb0: e7 80 c0 44  	jalr	1100(ra)
80201bb4: aa 9c        	add	s9, s9, a0
80201bb6: 03 35 0c 01  	ld	a0, 16(s8)
80201bba: 0d c9        	beqz	a0, 0x80201bec <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xcc>
80201bbc: 03 3d 8c 01  	ld	s10, 24(s8)
80201bc0: 63 f6 ac 03  	bgeu	s9, s10, 0x80201bec <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xcc>
80201bc4: 13 75 84 00  	andi	a0, s0, 8
80201bc8: 41 e5        	bnez	a0, 0x80201c50 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x130>
80201bca: 83 45 8c 03  	lbu	a1, 56(s8)
80201bce: 0d 46        	li	a2, 3
80201bd0: 05 45        	li	a0, 1
80201bd2: 63 83 c5 00  	beq	a1, a2, 0x80201bd8 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xb8>
80201bd6: 2e 85        	mv	a0, a1
80201bd8: 93 75 35 00  	andi	a1, a0, 3
80201bdc: 33 05 9d 41  	sub	a0, s10, s9
80201be0: e1 c1        	beqz	a1, 0x80201ca0 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x180>
80201be2: 05 46        	li	a2, 1
80201be4: 63 91 c5 0c  	bne	a1, a2, 0x80201ca6 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x186>
80201be8: 01 4d        	li	s10, 0
80201bea: d9 a0        	j	0x80201cb0 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x190>
80201bec: 03 34 0c 00  	ld	s0, 0(s8)
80201bf0: 83 34 8c 00  	ld	s1, 8(s8)
80201bf4: 22 85        	mv	a0, s0
80201bf6: a6 85        	mv	a1, s1
80201bf8: 56 86        	mv	a2, s5
80201bfa: d2 86        	mv	a3, s4
80201bfc: 5a 87        	mv	a4, s6
80201bfe: 97 00 00 00  	auipc	ra, 0
80201c02: e7 80 00 14  	jalr	320(ra)
80201c06: 85 4b        	li	s7, 1
80201c08: 0d c1        	beqz	a0, 0x80201c2a <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x10a>
80201c0a: 5e 85        	mv	a0, s7
80201c0c: a6 70        	ld	ra, 104(sp)
80201c0e: 06 74        	ld	s0, 96(sp)
80201c10: e6 64        	ld	s1, 88(sp)
80201c12: 46 69        	ld	s2, 80(sp)
80201c14: a6 69        	ld	s3, 72(sp)
80201c16: 06 6a        	ld	s4, 64(sp)
80201c18: e2 7a        	ld	s5, 56(sp)
80201c1a: 42 7b        	ld	s6, 48(sp)
80201c1c: a2 7b        	ld	s7, 40(sp)
80201c1e: 02 7c        	ld	s8, 32(sp)
80201c20: e2 6c        	ld	s9, 24(sp)
80201c22: 42 6d        	ld	s10, 16(sp)
80201c24: a2 6d        	ld	s11, 8(sp)
80201c26: 65 61        	addi	sp, sp, 112
80201c28: 82 80        	ret
80201c2a: 9c 6c        	ld	a5, 24(s1)
80201c2c: 22 85        	mv	a0, s0
80201c2e: ca 85        	mv	a1, s2
80201c30: 4e 86        	mv	a2, s3
80201c32: a6 70        	ld	ra, 104(sp)
80201c34: 06 74        	ld	s0, 96(sp)
80201c36: e6 64        	ld	s1, 88(sp)
80201c38: 46 69        	ld	s2, 80(sp)
80201c3a: a6 69        	ld	s3, 72(sp)
80201c3c: 06 6a        	ld	s4, 64(sp)
80201c3e: e2 7a        	ld	s5, 56(sp)
80201c40: 42 7b        	ld	s6, 48(sp)
80201c42: a2 7b        	ld	s7, 40(sp)
80201c44: 02 7c        	ld	s8, 32(sp)
80201c46: e2 6c        	ld	s9, 24(sp)
80201c48: 42 6d        	ld	s10, 16(sp)
80201c4a: a2 6d        	ld	s11, 8(sp)
80201c4c: 65 61        	addi	sp, sp, 112
80201c4e: 82 87        	jr	a5
80201c50: 03 24 4c 03  	lw	s0, 52(s8)
80201c54: 13 05 00 03  	li	a0, 48
80201c58: 83 45 8c 03  	lbu	a1, 56(s8)
80201c5c: 2e e0        	sd	a1, 0(sp)
80201c5e: 83 3d 0c 00  	ld	s11, 0(s8)
80201c62: 83 34 8c 00  	ld	s1, 8(s8)
80201c66: 23 2a ac 02  	sw	a0, 52(s8)
80201c6a: 85 4b        	li	s7, 1
80201c6c: 23 0c 7c 03  	sb	s7, 56(s8)
80201c70: 6e 85        	mv	a0, s11
80201c72: a6 85        	mv	a1, s1
80201c74: 56 86        	mv	a2, s5
80201c76: d2 86        	mv	a3, s4
80201c78: 5a 87        	mv	a4, s6
80201c7a: 97 00 00 00  	auipc	ra, 0
80201c7e: e7 80 40 0c  	jalr	196(ra)
80201c82: 41 f5        	bnez	a0, 0x80201c0a <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xea>
80201c84: 22 8a        	mv	s4, s0
80201c86: 33 05 9d 41  	sub	a0, s10, s9
80201c8a: 13 04 15 00  	addi	s0, a0, 1
80201c8e: 7d 14        	addi	s0, s0, -1
80201c90: 49 c4        	beqz	s0, 0x80201d1a <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x1fa>
80201c92: 90 70        	ld	a2, 32(s1)
80201c94: 93 05 00 03  	li	a1, 48
80201c98: 6e 85        	mv	a0, s11
80201c9a: 02 96        	jalr	a2
80201c9c: 6d d9        	beqz	a0, 0x80201c8e <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x16e>
80201c9e: b5 b7        	j	0x80201c0a <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xea>
80201ca0: 2a 8d        	mv	s10, a0
80201ca2: 2e 85        	mv	a0, a1
80201ca4: 31 a0        	j	0x80201cb0 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x190>
80201ca6: 93 05 15 00  	addi	a1, a0, 1
80201caa: 05 81        	srli	a0, a0, 1
80201cac: 13 dd 15 00  	srli	s10, a1, 1
80201cb0: 83 3c 0c 00  	ld	s9, 0(s8)
80201cb4: 83 3d 8c 00  	ld	s11, 8(s8)
80201cb8: 03 24 4c 03  	lw	s0, 52(s8)
80201cbc: 93 04 15 00  	addi	s1, a0, 1
80201cc0: fd 14        	addi	s1, s1, -1
80201cc2: 89 c8        	beqz	s1, 0x80201cd4 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x1b4>
80201cc4: 03 b6 0d 02  	ld	a2, 32(s11)
80201cc8: 66 85        	mv	a0, s9
80201cca: a2 85        	mv	a1, s0
80201ccc: 02 96        	jalr	a2
80201cce: 6d d9        	beqz	a0, 0x80201cc0 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x1a0>
80201cd0: 85 4b        	li	s7, 1
80201cd2: 25 bf        	j	0x80201c0a <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xea>
80201cd4: 37 05 11 00  	lui	a0, 272
80201cd8: 85 4b        	li	s7, 1
80201cda: e3 08 a4 f2  	beq	s0, a0, 0x80201c0a <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xea>
80201cde: 66 85        	mv	a0, s9
80201ce0: ee 85        	mv	a1, s11
80201ce2: 56 86        	mv	a2, s5
80201ce4: d2 86        	mv	a3, s4
80201ce6: 5a 87        	mv	a4, s6
80201ce8: 97 00 00 00  	auipc	ra, 0
80201cec: e7 80 60 05  	jalr	86(ra)
80201cf0: 09 fd        	bnez	a0, 0x80201c0a <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xea>
80201cf2: 83 b6 8d 01  	ld	a3, 24(s11)
80201cf6: 66 85        	mv	a0, s9
80201cf8: ca 85        	mv	a1, s2
80201cfa: 4e 86        	mv	a2, s3
80201cfc: 82 96        	jalr	a3
80201cfe: 11 f5        	bnez	a0, 0x80201c0a <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xea>
80201d00: 81 44        	li	s1, 0
80201d02: 63 0a 9d 02  	beq	s10, s1, 0x80201d36 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x216>
80201d06: 03 b6 0d 02  	ld	a2, 32(s11)
80201d0a: 85 04        	addi	s1, s1, 1
80201d0c: 66 85        	mv	a0, s9
80201d0e: a2 85        	mv	a1, s0
80201d10: 02 96        	jalr	a2
80201d12: 65 d9        	beqz	a0, 0x80201d02 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x1e2>
80201d14: 13 85 f4 ff  	addi	a0, s1, -1
80201d18: 05 a0        	j	0x80201d38 <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0x218>
80201d1a: 94 6c        	ld	a3, 24(s1)
80201d1c: 6e 85        	mv	a0, s11
80201d1e: ca 85        	mv	a1, s2
80201d20: 4e 86        	mv	a2, s3
80201d22: 82 96        	jalr	a3
80201d24: e3 13 05 ee  	bnez	a0, 0x80201c0a <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xea>
80201d28: 81 4b        	li	s7, 0
80201d2a: 23 2a 4c 03  	sw	s4, 52(s8)
80201d2e: 02 65        	ld	a0, 0(sp)
80201d30: 23 0c ac 02  	sb	a0, 56(s8)
80201d34: d9 bd        	j	0x80201c0a <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xea>
80201d36: 6a 85        	mv	a0, s10
80201d38: b3 3b a5 01  	sltu	s7, a0, s10
80201d3c: f9 b5        	j	0x80201c0a <_ZN4core3fmt9Formatter12pad_integral17h2910eee1e3128085E+0xea>

Disassembly of section .text._ZN4core3fmt9Formatter12pad_integral12write_prefix17h94560343c060f655E:

0000000080201d3e <_ZN4core3fmt9Formatter12pad_integral12write_prefix17h94560343c060f655E>:
80201d3e: 79 71        	addi	sp, sp, -48
80201d40: 06 f4        	sd	ra, 40(sp)
80201d42: 22 f0        	sd	s0, 32(sp)
80201d44: 26 ec        	sd	s1, 24(sp)
80201d46: 4a e8        	sd	s2, 16(sp)
80201d48: 4e e4        	sd	s3, 8(sp)
80201d4a: 9b 07 06 00  	sext.w	a5, a2
80201d4e: 37 08 11 00  	lui	a6, 272
80201d52: 3a 89        	mv	s2, a4
80201d54: b6 84        	mv	s1, a3
80201d56: 2e 84        	mv	s0, a1
80201d58: aa 89        	mv	s3, a0
80201d5a: 63 89 07 01  	beq	a5, a6, 0x80201d6c <_ZN4core3fmt9Formatter12pad_integral12write_prefix17h94560343c060f655E+0x2e>
80201d5e: 14 70        	ld	a3, 32(s0)
80201d60: 4e 85        	mv	a0, s3
80201d62: b2 85        	mv	a1, a2
80201d64: 82 96        	jalr	a3
80201d66: aa 85        	mv	a1, a0
80201d68: 05 45        	li	a0, 1
80201d6a: 91 ed        	bnez	a1, 0x80201d86 <_ZN4core3fmt9Formatter12pad_integral12write_prefix17h94560343c060f655E+0x48>
80201d6c: 81 cc        	beqz	s1, 0x80201d84 <_ZN4core3fmt9Formatter12pad_integral12write_prefix17h94560343c060f655E+0x46>
80201d6e: 1c 6c        	ld	a5, 24(s0)
80201d70: 4e 85        	mv	a0, s3
80201d72: a6 85        	mv	a1, s1
80201d74: 4a 86        	mv	a2, s2
80201d76: a2 70        	ld	ra, 40(sp)
80201d78: 02 74        	ld	s0, 32(sp)
80201d7a: e2 64        	ld	s1, 24(sp)
80201d7c: 42 69        	ld	s2, 16(sp)
80201d7e: a2 69        	ld	s3, 8(sp)
80201d80: 45 61        	addi	sp, sp, 48
80201d82: 82 87        	jr	a5
80201d84: 01 45        	li	a0, 0
80201d86: a2 70        	ld	ra, 40(sp)
80201d88: 02 74        	ld	s0, 32(sp)
80201d8a: e2 64        	ld	s1, 24(sp)
80201d8c: 42 69        	ld	s2, 16(sp)
80201d8e: a2 69        	ld	s3, 8(sp)
80201d90: 45 61        	addi	sp, sp, 48
80201d92: 82 80        	ret

Disassembly of section .text._ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E:

0000000080201d94 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E>:
80201d94: 5d 71        	addi	sp, sp, -80
80201d96: 86 e4        	sd	ra, 72(sp)
80201d98: a2 e0        	sd	s0, 64(sp)
80201d9a: 26 fc        	sd	s1, 56(sp)
80201d9c: 4a f8        	sd	s2, 48(sp)
80201d9e: 4e f4        	sd	s3, 40(sp)
80201da0: 52 f0        	sd	s4, 32(sp)
80201da2: 56 ec        	sd	s5, 24(sp)
80201da4: 5a e8        	sd	s6, 16(sp)
80201da6: 5e e4        	sd	s7, 8(sp)
80201da8: 2a 8a        	mv	s4, a0
80201daa: 83 32 05 01  	ld	t0, 16(a0)
80201dae: 08 71        	ld	a0, 32(a0)
80201db0: 93 86 f2 ff  	addi	a3, t0, -1
80201db4: b3 36 d0 00  	snez	a3, a3
80201db8: 13 07 f5 ff  	addi	a4, a0, -1
80201dbc: 33 37 e0 00  	snez	a4, a4
80201dc0: f9 8e        	and	a3, a3, a4
80201dc2: b2 89        	mv	s3, a2
80201dc4: 2e 89        	mv	s2, a1
80201dc6: 63 9d 06 16  	bnez	a3, 0x80201f40 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x1ac>
80201dca: 85 45        	li	a1, 1
80201dcc: 63 18 b5 10  	bne	a0, a1, 0x80201edc <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x148>
80201dd0: 03 35 8a 02  	ld	a0, 40(s4)
80201dd4: 81 45        	li	a1, 0
80201dd6: b3 06 39 01  	add	a3, s2, s3
80201dda: 13 07 15 00  	addi	a4, a0, 1
80201dde: 37 03 11 00  	lui	t1, 272
80201de2: 93 08 f0 0d  	li	a7, 223
80201de6: 13 08 00 0f  	li	a6, 240
80201dea: 4a 86        	mv	a2, s2
80201dec: 01 a8        	j	0x80201dfc <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x68>
80201dee: 13 05 16 00  	addi	a0, a2, 1
80201df2: 91 8d        	sub	a1, a1, a2
80201df4: aa 95        	add	a1, a1, a0
80201df6: 2a 86        	mv	a2, a0
80201df8: 63 02 64 0e  	beq	s0, t1, 0x80201edc <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x148>
80201dfc: 7d 17        	addi	a4, a4, -1
80201dfe: 25 c7        	beqz	a4, 0x80201e66 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0xd2>
80201e00: 63 0e d6 0c  	beq	a2, a3, 0x80201edc <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x148>
80201e04: 03 05 06 00  	lb	a0, 0(a2)
80201e08: 13 74 f5 0f  	andi	s0, a0, 255
80201e0c: e3 51 05 fe  	bgez	a0, 0x80201dee <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x5a>
80201e10: 03 45 16 00  	lbu	a0, 1(a2)
80201e14: 93 77 f4 01  	andi	a5, s0, 31
80201e18: 93 74 f5 03  	andi	s1, a0, 63
80201e1c: 63 f9 88 02  	bgeu	a7, s0, 0x80201e4e <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0xba>
80201e20: 03 45 26 00  	lbu	a0, 2(a2)
80201e24: 9a 04        	slli	s1, s1, 6
80201e26: 13 75 f5 03  	andi	a0, a0, 63
80201e2a: c9 8c        	or	s1, s1, a0
80201e2c: 63 67 04 03  	bltu	s0, a6, 0x80201e5a <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0xc6>
80201e30: 03 45 36 00  	lbu	a0, 3(a2)
80201e34: f6 17        	slli	a5, a5, 61
80201e36: ad 93        	srli	a5, a5, 43
80201e38: 9a 04        	slli	s1, s1, 6
80201e3a: 13 75 f5 03  	andi	a0, a0, 63
80201e3e: 45 8d        	or	a0, a0, s1
80201e40: 33 64 f5 00  	or	s0, a0, a5
80201e44: 63 0c 64 08  	beq	s0, t1, 0x80201edc <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x148>
80201e48: 13 05 46 00  	addi	a0, a2, 4
80201e4c: 5d b7        	j	0x80201df2 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x5e>
80201e4e: 13 05 26 00  	addi	a0, a2, 2
80201e52: 9a 07        	slli	a5, a5, 6
80201e54: 33 e4 97 00  	or	s0, a5, s1
80201e58: 69 bf        	j	0x80201df2 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x5e>
80201e5a: 13 05 36 00  	addi	a0, a2, 3
80201e5e: b2 07        	slli	a5, a5, 12
80201e60: 33 e4 f4 00  	or	s0, s1, a5
80201e64: 79 b7        	j	0x80201df2 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x5e>
80201e66: 63 0b d6 06  	beq	a2, a3, 0x80201edc <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x148>
80201e6a: 03 05 06 00  	lb	a0, 0(a2)
80201e6e: 63 53 05 04  	bgez	a0, 0x80201eb4 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x120>
80201e72: 13 75 f5 0f  	andi	a0, a0, 255
80201e76: 93 06 00 0e  	li	a3, 224
80201e7a: 63 6d d5 02  	bltu	a0, a3, 0x80201eb4 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x120>
80201e7e: 93 06 00 0f  	li	a3, 240
80201e82: 63 69 d5 02  	bltu	a0, a3, 0x80201eb4 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x120>
80201e86: 83 46 16 00  	lbu	a3, 1(a2)
80201e8a: 03 47 26 00  	lbu	a4, 2(a2)
80201e8e: 93 f6 f6 03  	andi	a3, a3, 63
80201e92: 13 77 f7 03  	andi	a4, a4, 63
80201e96: 03 46 36 00  	lbu	a2, 3(a2)
80201e9a: 76 15        	slli	a0, a0, 61
80201e9c: 2d 91        	srli	a0, a0, 43
80201e9e: b2 06        	slli	a3, a3, 12
80201ea0: 1a 07        	slli	a4, a4, 6
80201ea2: d9 8e        	or	a3, a3, a4
80201ea4: 13 76 f6 03  	andi	a2, a2, 63
80201ea8: 55 8e        	or	a2, a2, a3
80201eaa: 51 8d        	or	a0, a0, a2
80201eac: 37 06 11 00  	lui	a2, 272
80201eb0: 63 06 c5 02  	beq	a0, a2, 0x80201edc <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x148>
80201eb4: 85 c1        	beqz	a1, 0x80201ed4 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x140>
80201eb6: 63 fd 35 01  	bgeu	a1, s3, 0x80201ed0 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x13c>
80201eba: 33 05 b9 00  	add	a0, s2, a1
80201ebe: 03 05 05 00  	lb	a0, 0(a0)
80201ec2: 13 06 00 fc  	li	a2, -64
80201ec6: 63 57 c5 00  	bge	a0, a2, 0x80201ed4 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x140>
80201eca: 01 45        	li	a0, 0
80201ecc: 11 e5        	bnez	a0, 0x80201ed8 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x144>
80201ece: 39 a0        	j	0x80201edc <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x148>
80201ed0: e3 9d 35 ff  	bne	a1, s3, 0x80201eca <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x136>
80201ed4: 4a 85        	mv	a0, s2
80201ed6: 19 c1        	beqz	a0, 0x80201edc <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x148>
80201ed8: ae 89        	mv	s3, a1
80201eda: 2a 89        	mv	s2, a0
80201edc: 63 82 02 06  	beqz	t0, 0x80201f40 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x1ac>
80201ee0: 03 34 8a 01  	ld	s0, 24(s4)
80201ee4: 13 05 00 02  	li	a0, 32
80201ee8: 63 f4 a9 04  	bgeu	s3, a0, 0x80201f30 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x19c>
80201eec: 01 45        	li	a0, 0
80201eee: 63 8e 09 00  	beqz	s3, 0x80201f0a <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x176>
80201ef2: ce 85        	mv	a1, s3
80201ef4: 4a 86        	mv	a2, s2
80201ef6: 83 06 06 00  	lb	a3, 0(a2)
80201efa: 05 06        	addi	a2, a2, 1
80201efc: 93 a6 06 fc  	slti	a3, a3, -64
80201f00: 93 c6 16 00  	xori	a3, a3, 1
80201f04: fd 15        	addi	a1, a1, -1
80201f06: 36 95        	add	a0, a0, a3
80201f08: fd f5        	bnez	a1, 0x80201ef6 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x162>
80201f0a: 63 7b 85 02  	bgeu	a0, s0, 0x80201f40 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x1ac>
80201f0e: 83 45 8a 03  	lbu	a1, 56(s4)
80201f12: 8d 46        	li	a3, 3
80201f14: 01 46        	li	a2, 0
80201f16: 63 83 d5 00  	beq	a1, a3, 0x80201f1c <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x188>
80201f1a: 2e 86        	mv	a2, a1
80201f1c: 93 75 36 00  	andi	a1, a2, 3
80201f20: 33 05 a4 40  	sub	a0, s0, a0
80201f24: a1 c1        	beqz	a1, 0x80201f64 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x1d0>
80201f26: 05 46        	li	a2, 1
80201f28: 63 91 c5 04  	bne	a1, a2, 0x80201f6a <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x1d6>
80201f2c: 81 4a        	li	s5, 0
80201f2e: 99 a0        	j	0x80201f74 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x1e0>
80201f30: 4a 85        	mv	a0, s2
80201f32: ce 85        	mv	a1, s3
80201f34: 97 00 00 00  	auipc	ra, 0
80201f38: e7 80 40 0c  	jalr	196(ra)
80201f3c: e3 69 85 fc  	bltu	a0, s0, 0x80201f0e <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x17a>
80201f40: 83 35 8a 00  	ld	a1, 8(s4)
80201f44: 03 35 0a 00  	ld	a0, 0(s4)
80201f48: 9c 6d        	ld	a5, 24(a1)
80201f4a: ca 85        	mv	a1, s2
80201f4c: 4e 86        	mv	a2, s3
80201f4e: a6 60        	ld	ra, 72(sp)
80201f50: 06 64        	ld	s0, 64(sp)
80201f52: e2 74        	ld	s1, 56(sp)
80201f54: 42 79        	ld	s2, 48(sp)
80201f56: a2 79        	ld	s3, 40(sp)
80201f58: 02 7a        	ld	s4, 32(sp)
80201f5a: e2 6a        	ld	s5, 24(sp)
80201f5c: 42 6b        	ld	s6, 16(sp)
80201f5e: a2 6b        	ld	s7, 8(sp)
80201f60: 61 61        	addi	sp, sp, 80
80201f62: 82 87        	jr	a5
80201f64: aa 8a        	mv	s5, a0
80201f66: 2e 85        	mv	a0, a1
80201f68: 31 a0        	j	0x80201f74 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x1e0>
80201f6a: 93 05 15 00  	addi	a1, a0, 1
80201f6e: 05 81        	srli	a0, a0, 1
80201f70: 93 da 15 00  	srli	s5, a1, 1
80201f74: 03 3b 0a 00  	ld	s6, 0(s4)
80201f78: 83 3b 8a 00  	ld	s7, 8(s4)
80201f7c: 83 24 4a 03  	lw	s1, 52(s4)
80201f80: 13 04 15 00  	addi	s0, a0, 1
80201f84: 7d 14        	addi	s0, s0, -1
80201f86: 09 c8        	beqz	s0, 0x80201f98 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x204>
80201f88: 03 b6 0b 02  	ld	a2, 32(s7)
80201f8c: 5a 85        	mv	a0, s6
80201f8e: a6 85        	mv	a1, s1
80201f90: 02 96        	jalr	a2
80201f92: 6d d9        	beqz	a0, 0x80201f84 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x1f0>
80201f94: 05 4a        	li	s4, 1
80201f96: 2d a8        	j	0x80201fd0 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x23c>
80201f98: 37 05 11 00  	lui	a0, 272
80201f9c: 05 4a        	li	s4, 1
80201f9e: 63 89 a4 02  	beq	s1, a0, 0x80201fd0 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x23c>
80201fa2: 83 b6 8b 01  	ld	a3, 24(s7)
80201fa6: 5a 85        	mv	a0, s6
80201fa8: ca 85        	mv	a1, s2
80201faa: 4e 86        	mv	a2, s3
80201fac: 82 96        	jalr	a3
80201fae: 0d e1        	bnez	a0, 0x80201fd0 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x23c>
80201fb0: 01 44        	li	s0, 0
80201fb2: 63 8c 8a 00  	beq	s5, s0, 0x80201fca <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x236>
80201fb6: 03 b6 0b 02  	ld	a2, 32(s7)
80201fba: 05 04        	addi	s0, s0, 1
80201fbc: 5a 85        	mv	a0, s6
80201fbe: a6 85        	mv	a1, s1
80201fc0: 02 96        	jalr	a2
80201fc2: 65 d9        	beqz	a0, 0x80201fb2 <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x21e>
80201fc4: 13 05 f4 ff  	addi	a0, s0, -1
80201fc8: 11 a0        	j	0x80201fcc <_ZN4core3fmt9Formatter3pad17h4bb521065e6665e9E+0x238>
80201fca: 56 85        	mv	a0, s5
80201fcc: 33 3a 55 01  	sltu	s4, a0, s5
80201fd0: 52 85        	mv	a0, s4
80201fd2: a6 60        	ld	ra, 72(sp)
80201fd4: 06 64        	ld	s0, 64(sp)
80201fd6: e2 74        	ld	s1, 56(sp)
80201fd8: 42 79        	ld	s2, 48(sp)
80201fda: a2 79        	ld	s3, 40(sp)
80201fdc: 02 7a        	ld	s4, 32(sp)
80201fde: e2 6a        	ld	s5, 24(sp)
80201fe0: 42 6b        	ld	s6, 16(sp)
80201fe2: a2 6b        	ld	s7, 8(sp)
80201fe4: 61 61        	addi	sp, sp, 80
80201fe6: 82 80        	ret

Disassembly of section .text._ZN42_$LT$str$u20$as$u20$core..fmt..Display$GT$3fmt17h8884fddb1f24a834E:

0000000080201fe8 <_ZN42_$LT$str$u20$as$u20$core..fmt..Display$GT$3fmt17h8884fddb1f24a834E>:
80201fe8: ae 86        	mv	a3, a1
80201fea: aa 85        	mv	a1, a0
80201fec: 32 85        	mv	a0, a2
80201fee: 36 86        	mv	a2, a3
80201ff0: 17 03 00 00  	auipc	t1, 0
80201ff4: 67 00 43 da  	jr	-604(t1)

Disassembly of section .text._ZN4core3str5count14do_count_chars17h75bffc8ce7e643c7E:

0000000080201ff8 <_ZN4core3str5count14do_count_chars17h75bffc8ce7e643c7E>:
80201ff8: 2a 86        	mv	a2, a0
80201ffa: 1d 05        	addi	a0, a0, 7
80201ffc: 13 77 85 ff  	andi	a4, a0, -8
80202000: b3 08 c7 40  	sub	a7, a4, a2
80202004: 63 ec 15 01  	bltu	a1, a7, 0x8020201c <_ZN4core3str5count14do_count_chars17h75bffc8ce7e643c7E+0x24>
80202008: 33 88 15 41  	sub	a6, a1, a7
8020200c: 13 35 88 00  	sltiu	a0, a6, 8
80202010: 93 b7 98 00  	sltiu	a5, a7, 9
80202014: 93 c7 17 00  	xori	a5, a5, 1
80202018: 5d 8d        	or	a0, a0, a5
8020201a: 11 cd        	beqz	a0, 0x80202036 <_ZN4core3str5count14do_count_chars17h75bffc8ce7e643c7E+0x3e>
8020201c: 01 45        	li	a0, 0
8020201e: 99 c9        	beqz	a1, 0x80202034 <_ZN4core3str5count14do_count_chars17h75bffc8ce7e643c7E+0x3c>
80202020: 83 06 06 00  	lb	a3, 0(a2)
80202024: 05 06        	addi	a2, a2, 1
80202026: 93 a6 06 fc  	slti	a3, a3, -64
8020202a: 93 c6 16 00  	xori	a3, a3, 1
8020202e: fd 15        	addi	a1, a1, -1
80202030: 36 95        	add	a0, a0, a3
80202032: fd f5        	bnez	a1, 0x80202020 <_ZN4core3str5count14do_count_chars17h75bffc8ce7e643c7E+0x28>
80202034: 82 80        	ret
80202036: 93 75 78 00  	andi	a1, a6, 7
8020203a: 81 47        	li	a5, 0
8020203c: 63 0f c7 00  	beq	a4, a2, 0x8020205a <_ZN4core3str5count14do_count_chars17h75bffc8ce7e643c7E+0x62>
80202040: 33 07 e6 40  	sub	a4, a2, a4
80202044: 32 85        	mv	a0, a2
80202046: 83 06 05 00  	lb	a3, 0(a0)
8020204a: 05 05        	addi	a0, a0, 1
8020204c: 93 a6 06 fc  	slti	a3, a3, -64
80202050: 93 c6 16 00  	xori	a3, a3, 1
80202054: 05 07        	addi	a4, a4, 1
80202056: b6 97        	add	a5, a5, a3
80202058: 7d f7        	bnez	a4, 0x80202046 <_ZN4core3str5count14do_count_chars17h75bffc8ce7e643c7E+0x4e>
8020205a: b3 02 16 01  	add	t0, a2, a7
8020205e: 01 46        	li	a2, 0
80202060: 99 cd        	beqz	a1, 0x8020207e <_ZN4core3str5count14do_count_chars17h75bffc8ce7e643c7E+0x86>
80202062: 13 75 88 ff  	andi	a0, a6, -8
80202066: b3 86 a2 00  	add	a3, t0, a0
8020206a: 03 85 06 00  	lb	a0, 0(a3)
8020206e: 85 06        	addi	a3, a3, 1
80202070: 13 25 05 fc  	slti	a0, a0, -64
80202074: 13 45 15 00  	xori	a0, a0, 1
80202078: fd 15        	addi	a1, a1, -1
8020207a: 2a 96        	add	a2, a2, a0
8020207c: fd f5        	bnez	a1, 0x8020206a <_ZN4core3str5count14do_count_chars17h75bffc8ce7e643c7E+0x72>
8020207e: 13 57 38 00  	srli	a4, a6, 3

0000000080202082 <.LBB290_27>:
80202082: 17 05 00 00  	auipc	a0, 0
80202086: 13 05 e5 53  	addi	a0, a0, 1342
8020208a: 03 3f 05 00  	ld	t5, 0(a0)

000000008020208e <.LBB290_28>:
8020208e: 17 05 00 00  	auipc	a0, 0
80202092: 13 05 a5 53  	addi	a0, a0, 1338
80202096: 83 38 05 00  	ld	a7, 0(a0)
8020209a: 37 15 00 10  	lui	a0, 65537
8020209e: 12 05        	slli	a0, a0, 4
802020a0: 05 05        	addi	a0, a0, 1
802020a2: 42 05        	slli	a0, a0, 16
802020a4: 13 08 15 00  	addi	a6, a0, 1
802020a8: 33 05 f6 00  	add	a0, a2, a5
802020ac: 25 a0        	j	0x802020d4 <.LBB290_28+0x46>
802020ae: 13 16 3e 00  	slli	a2, t3, 3
802020b2: b3 02 c3 00  	add	t0, t1, a2
802020b6: 33 87 c3 41  	sub	a4, t2, t3
802020ba: 13 76 3e 00  	andi	a2, t3, 3
802020be: b3 f6 15 01  	and	a3, a1, a7
802020c2: a1 81        	srli	a1, a1, 8
802020c4: b3 f5 15 01  	and	a1, a1, a7
802020c8: b6 95        	add	a1, a1, a3
802020ca: b3 85 05 03  	mul	a1, a1, a6
802020ce: c1 91        	srli	a1, a1, 48
802020d0: 2e 95        	add	a0, a0, a1
802020d2: 41 e2        	bnez	a2, 0x80202152 <.LBB290_28+0xc4>
802020d4: 25 d3        	beqz	a4, 0x80202034 <_ZN4core3str5count14do_count_chars17h75bffc8ce7e643c7E+0x3c>
802020d6: ba 83        	mv	t2, a4
802020d8: 16 83        	mv	t1, t0
802020da: 93 05 00 0c  	li	a1, 192
802020de: 3a 8e        	mv	t3, a4
802020e0: 63 64 b7 00  	bltu	a4, a1, 0x802020e8 <.LBB290_28+0x5a>
802020e4: 13 0e 00 0c  	li	t3, 192
802020e8: 93 75 ce 0f  	andi	a1, t3, 252
802020ec: 13 96 35 00  	slli	a2, a1, 3
802020f0: b3 0e c3 00  	add	t4, t1, a2
802020f4: cd dd        	beqz	a1, 0x802020ae <.LBB290_28+0x20>
802020f6: 81 45        	li	a1, 0
802020f8: 1a 86        	mv	a2, t1
802020fa: 55 da        	beqz	a2, 0x802020ae <.LBB290_28+0x20>
802020fc: 18 62        	ld	a4, 0(a2)
802020fe: 93 47 f7 ff  	not	a5, a4
80202102: 9d 83        	srli	a5, a5, 7
80202104: 19 83        	srli	a4, a4, 6
80202106: 14 66        	ld	a3, 8(a2)
80202108: 5d 8f        	or	a4, a4, a5
8020210a: 33 77 e7 01  	and	a4, a4, t5
8020210e: ba 95        	add	a1, a1, a4
80202110: 13 c7 f6 ff  	not	a4, a3
80202114: 1d 83        	srli	a4, a4, 7
80202116: 99 82        	srli	a3, a3, 6
80202118: 1c 6a        	ld	a5, 16(a2)
8020211a: d9 8e        	or	a3, a3, a4
8020211c: b3 f6 e6 01  	and	a3, a3, t5
80202120: b6 95        	add	a1, a1, a3
80202122: 93 c6 f7 ff  	not	a3, a5
80202126: 9d 82        	srli	a3, a3, 7
80202128: 13 d7 67 00  	srli	a4, a5, 6
8020212c: 1c 6e        	ld	a5, 24(a2)
8020212e: d9 8e        	or	a3, a3, a4
80202130: b3 f6 e6 01  	and	a3, a3, t5
80202134: b6 95        	add	a1, a1, a3
80202136: 93 c6 f7 ff  	not	a3, a5
8020213a: 9d 82        	srli	a3, a3, 7
8020213c: 13 d7 67 00  	srli	a4, a5, 6
80202140: d9 8e        	or	a3, a3, a4
80202142: b3 f6 e6 01  	and	a3, a3, t5
80202146: 13 06 06 02  	addi	a2, a2, 32
8020214a: b6 95        	add	a1, a1, a3
8020214c: e3 17 d6 fb  	bne	a2, t4, 0x802020fa <.LBB290_28+0x6c>
80202150: b9 bf        	j	0x802020ae <.LBB290_28+0x20>
80202152: 63 0a 03 02  	beqz	t1, 0x80202186 <.LBB290_28+0xf8>
80202156: 93 05 00 0c  	li	a1, 192
8020215a: 63 e4 b3 00  	bltu	t2, a1, 0x80202162 <.LBB290_28+0xd4>
8020215e: 93 03 00 0c  	li	t2, 192
80202162: 81 45        	li	a1, 0
80202164: 13 f6 33 00  	andi	a2, t2, 3
80202168: 0e 06        	slli	a2, a2, 3
8020216a: 83 b6 0e 00  	ld	a3, 0(t4)
8020216e: a1 0e        	addi	t4, t4, 8
80202170: 13 c7 f6 ff  	not	a4, a3
80202174: 1d 83        	srli	a4, a4, 7
80202176: 99 82        	srli	a3, a3, 6
80202178: d9 8e        	or	a3, a3, a4
8020217a: b3 f6 e6 01  	and	a3, a3, t5
8020217e: 61 16        	addi	a2, a2, -8
80202180: b6 95        	add	a1, a1, a3
80202182: 65 f6        	bnez	a2, 0x8020216a <.LBB290_28+0xdc>
80202184: 11 a0        	j	0x80202188 <.LBB290_28+0xfa>
80202186: 81 45        	li	a1, 0
80202188: 33 f6 15 01  	and	a2, a1, a7
8020218c: a1 81        	srli	a1, a1, 8
8020218e: b3 f5 15 01  	and	a1, a1, a7
80202192: b2 95        	add	a1, a1, a2
80202194: b3 85 05 03  	mul	a1, a1, a6
80202198: c1 91        	srli	a1, a1, 48
8020219a: 2e 95        	add	a0, a0, a1
8020219c: 82 80        	ret

Disassembly of section .text._ZN4core3fmt3num3imp7fmt_u6417h2bebad4dea13b624E:

000000008020219e <_ZN4core3fmt3num3imp7fmt_u6417h2bebad4dea13b624E>:
8020219e: 39 71        	addi	sp, sp, -64
802021a0: 06 fc        	sd	ra, 56(sp)
802021a2: 22 f8        	sd	s0, 48(sp)
802021a4: 26 f4        	sd	s1, 40(sp)
802021a6: 32 88        	mv	a6, a2
802021a8: 93 56 45 00  	srli	a3, a0, 4
802021ac: 13 07 70 02  	li	a4, 39
802021b0: 93 07 10 27  	li	a5, 625

00000000802021b4 <.LBB570_10>:
802021b4: 97 1e 00 00  	auipc	t4, 1
802021b8: 93 8e 4e 8e  	addi	t4, t4, -1820
802021bc: 63 f3 f6 02  	bgeu	a3, a5, 0x802021e2 <.LBB570_10+0x2e>
802021c0: 93 06 30 06  	li	a3, 99
802021c4: 63 e9 a6 0a  	bltu	a3, a0, 0x80202276 <.LBB570_11+0x92>
802021c8: 29 46        	li	a2, 10
802021ca: 63 77 c5 0e  	bgeu	a0, a2, 0x802022b8 <.LBB570_11+0xd4>
802021ce: 93 06 f7 ff  	addi	a3, a4, -1
802021d2: 13 06 11 00  	addi	a2, sp, 1
802021d6: 36 96        	add	a2, a2, a3
802021d8: 1b 05 05 03  	addiw	a0, a0, 48
802021dc: 23 00 a6 00  	sb	a0, 0(a2)
802021e0: dd a8        	j	0x802022d6 <.LBB570_11+0xf2>
802021e2: 01 47        	li	a4, 0

00000000802021e4 <.LBB570_11>:
802021e4: 97 06 00 00  	auipc	a3, 0
802021e8: 93 86 c6 44  	addi	a3, a3, 1100
802021ec: 83 b8 06 00  	ld	a7, 0(a3)
802021f0: 89 66        	lui	a3, 2
802021f2: 9b 83 06 71  	addiw	t2, a3, 1808
802021f6: 85 66        	lui	a3, 1
802021f8: 1b 8e b6 47  	addiw	t3, a3, 1147
802021fc: 93 02 40 06  	li	t0, 100
80202200: 13 03 11 00  	addi	t1, sp, 1
80202204: b7 e6 f5 05  	lui	a3, 24414
80202208: 1b 8f f6 0f  	addiw	t5, a3, 255
8020220c: aa 87        	mv	a5, a0
8020220e: 33 35 15 03  	mulhu	a0, a0, a7
80202212: 2d 81        	srli	a0, a0, 11
80202214: 3b 06 75 02  	mulw	a2, a0, t2
80202218: 3b 86 c7 40  	subw	a2, a5, a2
8020221c: 93 16 06 03  	slli	a3, a2, 48
80202220: c9 92        	srli	a3, a3, 50
80202222: b3 86 c6 03  	mul	a3, a3, t3
80202226: 93 df 16 01  	srli	t6, a3, 17
8020222a: c1 82        	srli	a3, a3, 16
8020222c: 13 f4 e6 7f  	andi	s0, a3, 2046
80202230: bb 86 5f 02  	mulw	a3, t6, t0
80202234: 15 9e        	subw	a2, a2, a3
80202236: 46 16        	slli	a2, a2, 49
80202238: 41 92        	srli	a2, a2, 48
8020223a: b3 86 8e 00  	add	a3, t4, s0
8020223e: 33 04 e3 00  	add	s0, t1, a4
80202242: 83 cf 06 00  	lbu	t6, 0(a3)
80202246: 83 86 16 00  	lb	a3, 1(a3)
8020224a: 76 96        	add	a2, a2, t4
8020224c: 83 04 16 00  	lb	s1, 1(a2)
80202250: 03 46 06 00  	lbu	a2, 0(a2)
80202254: 23 02 d4 02  	sb	a3, 36(s0)
80202258: a3 01 f4 03  	sb	t6, 35(s0)
8020225c: 23 03 94 02  	sb	s1, 38(s0)
80202260: a3 02 c4 02  	sb	a2, 37(s0)
80202264: 71 17        	addi	a4, a4, -4
80202266: e3 63 ff fa  	bltu	t5, a5, 0x8020220c <.LBB570_11+0x28>
8020226a: 13 07 77 02  	addi	a4, a4, 39
8020226e: 93 06 30 06  	li	a3, 99
80202272: e3 fb a6 f4  	bgeu	a3, a0, 0x802021c8 <.LBB570_10+0x14>
80202276: 13 16 05 03  	slli	a2, a0, 48
8020227a: 49 92        	srli	a2, a2, 50
8020227c: 85 66        	lui	a3, 1
8020227e: 9b 86 b6 47  	addiw	a3, a3, 1147
80202282: 33 06 d6 02  	mul	a2, a2, a3
80202286: 45 82        	srli	a2, a2, 17
80202288: 93 06 40 06  	li	a3, 100
8020228c: bb 06 d6 02  	mulw	a3, a2, a3
80202290: 15 9d        	subw	a0, a0, a3
80202292: 46 15        	slli	a0, a0, 49
80202294: 41 91        	srli	a0, a0, 48
80202296: 79 17        	addi	a4, a4, -2
80202298: 76 95        	add	a0, a0, t4
8020229a: 83 06 15 00  	lb	a3, 1(a0)
8020229e: 03 45 05 00  	lbu	a0, 0(a0)
802022a2: 93 07 11 00  	addi	a5, sp, 1
802022a6: ba 97        	add	a5, a5, a4
802022a8: a3 80 d7 00  	sb	a3, 1(a5)
802022ac: 23 80 a7 00  	sb	a0, 0(a5)
802022b0: 32 85        	mv	a0, a2
802022b2: 29 46        	li	a2, 10
802022b4: e3 6d c5 f0  	bltu	a0, a2, 0x802021ce <.LBB570_10+0x1a>
802022b8: 06 05        	slli	a0, a0, 1
802022ba: 93 06 e7 ff  	addi	a3, a4, -2
802022be: 76 95        	add	a0, a0, t4
802022c0: 03 06 15 00  	lb	a2, 1(a0)
802022c4: 03 45 05 00  	lbu	a0, 0(a0)
802022c8: 13 07 11 00  	addi	a4, sp, 1
802022cc: 36 97        	add	a4, a4, a3
802022ce: a3 00 c7 00  	sb	a2, 1(a4)
802022d2: 23 00 a7 00  	sb	a0, 0(a4)
802022d6: 13 05 11 00  	addi	a0, sp, 1
802022da: 33 07 d5 00  	add	a4, a0, a3
802022de: 13 05 70 02  	li	a0, 39
802022e2: b3 07 d5 40  	sub	a5, a0, a3

00000000802022e6 <.LBB570_12>:
802022e6: 17 06 00 00  	auipc	a2, 0
802022ea: 13 06 26 71  	addi	a2, a2, 1810
802022ee: 42 85        	mv	a0, a6
802022f0: 81 46        	li	a3, 0
802022f2: 97 00 00 00  	auipc	ra, 0
802022f6: e7 80 e0 82  	jalr	-2002(ra)
802022fa: e2 70        	ld	ra, 56(sp)
802022fc: 42 74        	ld	s0, 48(sp)
802022fe: a2 74        	ld	s1, 40(sp)
80202300: 21 61        	addi	sp, sp, 64
80202302: 82 80        	ret

Disassembly of section .text._ZN4core3fmt3num3imp51_$LT$impl$u20$core..fmt..Display$u20$for$u20$u8$GT$3fmt17h93332490606bba67E:

0000000080202304 <_ZN4core3fmt3num3imp51_$LT$impl$u20$core..fmt..Display$u20$for$u20$u8$GT$3fmt17h93332490606bba67E>:
80202304: 03 45 05 00  	lbu	a0, 0(a0)
80202308: 2e 86        	mv	a2, a1
8020230a: 85 45        	li	a1, 1
8020230c: 17 03 00 00  	auipc	t1, 0
80202310: 67 00 23 e9  	jr	-366(t1)

Disassembly of section .text._ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h518678af98a1949fE:

0000000080202314 <_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h518678af98a1949fE>:
80202314: 03 65 05 00  	lwu	a0, 0(a0)
80202318: 2e 86        	mv	a2, a1
8020231a: 85 45        	li	a1, 1
8020231c: 17 03 00 00  	auipc	t1, 0
80202320: 67 00 23 e8  	jr	-382(t1)

Disassembly of section .text._ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u64$GT$3fmt17h77ff5d762b7f8e58E:

0000000080202324 <_ZN4core3fmt3num3imp54_$LT$impl$u20$core..fmt..Display$u20$for$u20$usize$GT$3fmt17hadb5d59c0aa64a0cE>:
80202324: 08 61        	ld	a0, 0(a0)
80202326: 2e 86        	mv	a2, a1
80202328: 85 45        	li	a1, 1
8020232a: 17 03 00 00  	auipc	t1, 0
8020232e: 67 00 43 e7  	jr	-396(t1)

Disassembly of section .text._ZN53_$LT$core..fmt..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h036960996838d966E:

0000000080202332 <_ZN53_$LT$core..fmt..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h036960996838d966E>:
80202332: 90 65        	ld	a2, 8(a1)
80202334: 88 61        	ld	a0, 0(a1)
80202336: 1c 6e        	ld	a5, 24(a2)

0000000080202338 <.LBB602_1>:
80202338: 97 15 00 00  	auipc	a1, 1
8020233c: 93 85 85 82  	addi	a1, a1, -2008
80202340: 15 46        	li	a2, 5
80202342: 82 87        	jr	a5

Disassembly of section .text._ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hcb8bce5ca6b6d1baE:

0000000080202344 <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hcb8bce5ca6b6d1baE>:
80202344: 10 65        	ld	a2, 8(a0)
80202346: 08 61        	ld	a0, 0(a0)
80202348: 1c 6e        	ld	a5, 24(a2)
8020234a: 82 87        	jr	a5

Disassembly of section .text._ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hcf3c30afa59af89fE:

000000008020234c <_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hcf3c30afa59af89fE>:
8020234c: 14 61        	ld	a3, 0(a0)
8020234e: 10 65        	ld	a2, 8(a0)
80202350: 2e 85        	mv	a0, a1
80202352: b6 85        	mv	a1, a3
80202354: 17 03 00 00  	auipc	t1, 0
80202358: 67 00 03 a4  	jr	-1472(t1)
