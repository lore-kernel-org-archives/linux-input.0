From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Subject: [PATCH v2 2/4] mfd: ioc3: Add driver for SGI IOC3 chip
Date: Tue,  9 Apr 2019 17:46:06 +0200
Message-ID: <20190409154610.6735-3-tbogendoerfer@suse.de>
References: <20190409154610.6735-1-tbogendoerfer@suse.de>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190409154610.6735-1-tbogendoerfer@suse.de>
Sender: netdev-owner@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, "David S. Miller" <davem@davemloft.net>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, netdev@vger.kernel.org, linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-input@vger.kernel.org

SGI IOC3 chip has integrated ethernet, keyboard and mouse interface.
It also supports connecting a SuperIO chip for serial and parallel
interfaces. IOC3 is used inside various SGI systemboards and add-on
cards with different equipped external interfaces.

Support for ethernet and serial interfaces were implemented inside
the network driver. This patchset moves out the not network related
parts to a new MFD driver, which takes care of card detection,
setup of platform devices and interrupt distribution for the subdevices.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 arch/mips/include/asm/sn/ioc3.h       |  345 +++---
 arch/mips/sgi-ip27/ip27-timer.c       |   20 -
 drivers/mfd/Kconfig                   |   13 +
 drivers/mfd/Makefile                  |    1 +
 drivers/mfd/ioc3.c                    |  802 ++++++++++++++
 drivers/net/ethernet/sgi/Kconfig      |    4 +-
 drivers/net/ethernet/sgi/ioc3-eth.c   | 1867 ++++++++++++---------------------
 drivers/tty/serial/8250/8250_ioc3.c   |   98 ++
 drivers/tty/serial/8250/Kconfig       |   11 +
 drivers/tty/serial/8250/Makefile      |    1 +
 include/linux/platform_data/ioc3eth.h |   15 +
 11 files changed, 1762 insertions(+), 1415 deletions(-)
 create mode 100644 drivers/mfd/ioc3.c
 create mode 100644 drivers/tty/serial/8250/8250_ioc3.c
 create mode 100644 include/linux/platform_data/ioc3eth.h

diff --git a/arch/mips/include/asm/sn/ioc3.h b/arch/mips/include/asm/sn/ioc3.h
index 25c8dccab51f..69069f420930 100644
--- a/arch/mips/include/asm/sn/ioc3.h
+++ b/arch/mips/include/asm/sn/ioc3.h
@@ -3,32 +3,43 @@
  * Copyright (C) 1999, 2000 Ralf Baechle
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
  */
-#ifndef _IOC3_H
-#define _IOC3_H
+#ifndef MIPS_SN_IOC3_H
+#define MIPS_SN_IOC3_H
 
 #include <linux/types.h>
 
+/* serial port register map */
+struct ioc3_serialregs {
+	uint32_t	sscr;
+	uint32_t	stpir;
+	uint32_t	stcir;
+	uint32_t	srpir;
+	uint32_t	srcir;
+	uint32_t	srtr;
+	uint32_t	shadow;
+};
+
 /* SUPERIO uart register map */
-typedef volatile struct ioc3_uartregs {
+struct ioc3_uartregs {
 	union {
-		volatile u8	rbr;	/* read only, DLAB == 0 */
-		volatile u8	thr;	/* write only, DLAB == 0 */
-		volatile u8	dll;	/* DLAB == 1 */
+		char	rbr;	/* read only, DLAB == 0 */
+		char	thr;	/* write only, DLAB == 0 */
+		char	dll;	/* DLAB == 1 */
 	} u1;
 	union {
-		volatile u8	ier;	/* DLAB == 0 */
-		volatile u8	dlm;	/* DLAB == 1 */
+		char	ier;	/* DLAB == 0 */
+		char	dlm;	/* DLAB == 1 */
 	} u2;
 	union {
-		volatile u8	iir;	/* read only */
-		volatile u8	fcr;	/* write only */
+		char	iir;	/* read only */
+		char	fcr;	/* write only */
 	} u3;
-	volatile u8	    iu_lcr;
-	volatile u8	    iu_mcr;
-	volatile u8	    iu_lsr;
-	volatile u8	    iu_msr;
-	volatile u8	    iu_scr;
-} ioc3_uregs_t;
+	char	iu_lcr;
+	char	iu_mcr;
+	char	iu_lsr;
+	char	iu_msr;
+	char	iu_scr;
+};
 
 #define iu_rbr u1.rbr
 #define iu_thr u1.thr
@@ -39,133 +50,122 @@ typedef volatile struct ioc3_uartregs {
 #define iu_fcr u3.fcr
 
 struct ioc3_sioregs {
-	volatile u8		fill[0x141];	/* starts at 0x141 */
+	char	fill[0x141];	/* starts at 0x141 */
 
-	volatile u8		uartc;
-	volatile u8		kbdcg;
+	char	uartc;
+	char	kbdcg;
 
-	volatile u8		fill0[0x150 - 0x142 - 1];
+	char	fill0[0x150 - 0x142 - 1];
 
-	volatile u8		pp_data;
-	volatile u8		pp_dsr;
-	volatile u8		pp_dcr;
+	char	pp_data;
+	char	pp_dsr;
+	char	pp_dcr;
 
-	volatile u8		fill1[0x158 - 0x152 - 1];
+	char	fill1[0x158 - 0x152 - 1];
 
-	volatile u8		pp_fifa;
-	volatile u8		pp_cfgb;
-	volatile u8		pp_ecr;
+	char	pp_fifa;
+	char	pp_cfgb;
+	char	pp_ecr;
 
-	volatile u8		fill2[0x168 - 0x15a - 1];
+	char	fill2[0x168 - 0x15a - 1];
 
-	volatile u8		rtcad;
-	volatile u8		rtcdat;
+	char	rtcad;
+	char	rtcdat;
 
-	volatile u8		fill3[0x170 - 0x169 - 1];
+	char	fill3[0x170 - 0x169 - 1];
 
 	struct ioc3_uartregs	uartb;	/* 0x20170  */
 	struct ioc3_uartregs	uarta;	/* 0x20178  */
 };
 
+struct ioc3_ethregs {
+	uint32_t	emcr;		/* 0x000f0  */
+	uint32_t	eisr;		/* 0x000f4  */
+	uint32_t	eier;		/* 0x000f8  */
+	uint32_t	ercsr;		/* 0x000fc  */
+	uint32_t	erbr_h;		/* 0x00100  */
+	uint32_t	erbr_l;		/* 0x00104  */
+	uint32_t	erbar;		/* 0x00108  */
+	uint32_t	ercir;		/* 0x0010c  */
+	uint32_t	erpir;		/* 0x00110  */
+	uint32_t	ertr;		/* 0x00114  */
+	uint32_t	etcsr;		/* 0x00118  */
+	uint32_t	ersr;		/* 0x0011c  */
+	uint32_t	etcdc;		/* 0x00120  */
+	uint32_t	ebir;		/* 0x00124  */
+	uint32_t	etbr_h;		/* 0x00128  */
+	uint32_t	etbr_l;		/* 0x0012c  */
+	uint32_t	etcir;		/* 0x00130  */
+	uint32_t	etpir;		/* 0x00134  */
+	uint32_t	emar_h;		/* 0x00138  */
+	uint32_t	emar_l;		/* 0x0013c  */
+	uint32_t	ehar_h;		/* 0x00140  */
+	uint32_t	ehar_l;		/* 0x00144  */
+	uint32_t	micr;		/* 0x00148  */
+	uint32_t	midr_r;		/* 0x0014c  */
+	uint32_t	midr_w;		/* 0x00150  */
+};
+
+struct ioc3_serioregs {
+	uint32_t	km_csr;		/* 0x0009c  */
+	uint32_t	k_rd;		/* 0x000a0  */
+	uint32_t	m_rd;		/* 0x000a4  */
+	uint32_t	k_wd;		/* 0x000a8  */
+	uint32_t	m_wd;		/* 0x000ac  */
+};
+
 /* Register layout of IOC3 in configuration space.  */
 struct ioc3 {
-	volatile u32	pad0[7];	/* 0x00000  */
-	volatile u32	sio_ir;		/* 0x0001c  */
-	volatile u32	sio_ies;	/* 0x00020  */
-	volatile u32	sio_iec;	/* 0x00024  */
-	volatile u32	sio_cr;		/* 0x00028  */
-	volatile u32	int_out;	/* 0x0002c  */
-	volatile u32	mcr;		/* 0x00030  */
+	/* PCI Config Space registers  */
+	uint32_t	pci_id;		/* 0x00000  */
+	uint32_t	pci_scr;	/* 0x00004  */
+	uint32_t	pci_rev;	/* 0x00008  */
+	uint32_t	pci_lat;	/* 0x0000c  */
+	uint32_t	pci_addr;	/* 0x00010  */
+	uint32_t	pci_err_addr_l;	/* 0x00014  */
+	uint32_t	pci_err_addr_h;	/* 0x00018  */
+
+	uint32_t	sio_ir;		/* 0x0001c  */
+	uint32_t	sio_ies;	/* 0x00020  */
+	uint32_t	sio_iec;	/* 0x00024  */
+	uint32_t	sio_cr;		/* 0x00028  */
+	uint32_t	int_out;	/* 0x0002c  */
+	uint32_t	mcr;		/* 0x00030  */
 
 	/* General Purpose I/O registers  */
-	volatile u32	gpcr_s;		/* 0x00034  */
-	volatile u32	gpcr_c;		/* 0x00038  */
-	volatile u32	gpdr;		/* 0x0003c  */
-	volatile u32	gppr_0;		/* 0x00040  */
-	volatile u32	gppr_1;		/* 0x00044  */
-	volatile u32	gppr_2;		/* 0x00048  */
-	volatile u32	gppr_3;		/* 0x0004c  */
-	volatile u32	gppr_4;		/* 0x00050  */
-	volatile u32	gppr_5;		/* 0x00054  */
-	volatile u32	gppr_6;		/* 0x00058  */
-	volatile u32	gppr_7;		/* 0x0005c  */
-	volatile u32	gppr_8;		/* 0x00060  */
-	volatile u32	gppr_9;		/* 0x00064  */
-	volatile u32	gppr_10;	/* 0x00068  */
-	volatile u32	gppr_11;	/* 0x0006c  */
-	volatile u32	gppr_12;	/* 0x00070  */
-	volatile u32	gppr_13;	/* 0x00074  */
-	volatile u32	gppr_14;	/* 0x00078  */
-	volatile u32	gppr_15;	/* 0x0007c  */
+	uint32_t	gpcr_s;		/* 0x00034  */
+	uint32_t	gpcr_c;		/* 0x00038  */
+	uint32_t	gpdr;		/* 0x0003c  */
+	uint32_t	gppr[16];	/* 0x00040  */
 
 	/* Parallel Port Registers  */
-	volatile u32	ppbr_h_a;	/* 0x00080  */
-	volatile u32	ppbr_l_a;	/* 0x00084  */
-	volatile u32	ppcr_a;		/* 0x00088  */
-	volatile u32	ppcr;		/* 0x0008c  */
-	volatile u32	ppbr_h_b;	/* 0x00090  */
-	volatile u32	ppbr_l_b;	/* 0x00094  */
-	volatile u32	ppcr_b;		/* 0x00098  */
+	uint32_t	ppbr_h_a;	/* 0x00080  */
+	uint32_t	ppbr_l_a;	/* 0x00084  */
+	uint32_t	ppcr_a;		/* 0x00088  */
+	uint32_t	ppcr;		/* 0x0008c  */
+	uint32_t	ppbr_h_b;	/* 0x00090  */
+	uint32_t	ppbr_l_b;	/* 0x00094  */
+	uint32_t	ppcr_b;		/* 0x00098  */
 
 	/* Keyboard and Mouse Registers	 */
-	volatile u32	km_csr;		/* 0x0009c  */
-	volatile u32	k_rd;		/* 0x000a0  */
-	volatile u32	m_rd;		/* 0x000a4  */
-	volatile u32	k_wd;		/* 0x000a8  */
-	volatile u32	m_wd;		/* 0x000ac  */
+	struct ioc3_serioregs	serio;
 
 	/* Serial Port Registers  */
-	volatile u32	sbbr_h;		/* 0x000b0  */
-	volatile u32	sbbr_l;		/* 0x000b4  */
-	volatile u32	sscr_a;		/* 0x000b8  */
-	volatile u32	stpir_a;	/* 0x000bc  */
-	volatile u32	stcir_a;	/* 0x000c0  */
-	volatile u32	srpir_a;	/* 0x000c4  */
-	volatile u32	srcir_a;	/* 0x000c8  */
-	volatile u32	srtr_a;		/* 0x000cc  */
-	volatile u32	shadow_a;	/* 0x000d0  */
-	volatile u32	sscr_b;		/* 0x000d4  */
-	volatile u32	stpir_b;	/* 0x000d8  */
-	volatile u32	stcir_b;	/* 0x000dc  */
-	volatile u32	srpir_b;	/* 0x000e0  */
-	volatile u32	srcir_b;	/* 0x000e4  */
-	volatile u32	srtr_b;		/* 0x000e8  */
-	volatile u32	shadow_b;	/* 0x000ec  */
-
-	/* Ethernet Registers  */
-	volatile u32	emcr;		/* 0x000f0  */
-	volatile u32	eisr;		/* 0x000f4  */
-	volatile u32	eier;		/* 0x000f8  */
-	volatile u32	ercsr;		/* 0x000fc  */
-	volatile u32	erbr_h;		/* 0x00100  */
-	volatile u32	erbr_l;		/* 0x00104  */
-	volatile u32	erbar;		/* 0x00108  */
-	volatile u32	ercir;		/* 0x0010c  */
-	volatile u32	erpir;		/* 0x00110  */
-	volatile u32	ertr;		/* 0x00114  */
-	volatile u32	etcsr;		/* 0x00118  */
-	volatile u32	ersr;		/* 0x0011c  */
-	volatile u32	etcdc;		/* 0x00120  */
-	volatile u32	ebir;		/* 0x00124  */
-	volatile u32	etbr_h;		/* 0x00128  */
-	volatile u32	etbr_l;		/* 0x0012c  */
-	volatile u32	etcir;		/* 0x00130  */
-	volatile u32	etpir;		/* 0x00134  */
-	volatile u32	emar_h;		/* 0x00138  */
-	volatile u32	emar_l;		/* 0x0013c  */
-	volatile u32	ehar_h;		/* 0x00140  */
-	volatile u32	ehar_l;		/* 0x00144  */
-	volatile u32	micr;		/* 0x00148  */
-	volatile u32	midr_r;		/* 0x0014c  */
-	volatile u32	midr_w;		/* 0x00150  */
-	volatile u32	pad1[(0x20000 - 0x00154) / 4];
+	uint32_t	sbbr_h;		/* 0x000b0  */
+	uint32_t	sbbr_l;		/* 0x000b4  */
+	struct ioc3_serialregs	port_a;
+	struct ioc3_serialregs	port_b;
+
+	/* Ethernet Registers */
+	struct ioc3_ethregs	eth;
+	uint32_t	pad1[(0x20000 - 0x00154) / 4];
 
 	/* SuperIO Registers  XXX */
 	struct ioc3_sioregs	sregs;	/* 0x20000 */
-	volatile u32	pad2[(0x40000 - 0x20180) / 4];
+	uint32_t	pad2[(0x40000 - 0x20180) / 4];
 
 	/* SSRAM Diagnostic Access */
-	volatile u32	ssram[(0x80000 - 0x40000) / 4];
+	uint32_t	ssram[(0x80000 - 0x40000) / 4];
 
 	/* Bytebus device offsets
 	   0x80000 -   Access to the generic devices selected with   DEV0
@@ -178,6 +178,20 @@ struct ioc3 {
 	   0xFFFFF     bytebus DEV_SEL_3  */
 };
 
+
+#define PCI_LAT			0xc		/* Latency Timer */
+#define PCI_SCR_DROP_MODE_EN	0x00008000	/* drop pios on parity err */
+#define UARTA_BASE		0x178
+#define UARTB_BASE		0x170
+
+/*
+ * Bytebus device space
+ */
+#define IOC3_BYTEBUS_DEV0	0x80000L
+#define IOC3_BYTEBUS_DEV1	0xa0000L
+#define IOC3_BYTEBUS_DEV2	0xc0000L
+#define IOC3_BYTEBUS_DEV3	0xe0000L
+
 /*
  * Ethernet RX Buffer
  */
@@ -233,28 +247,20 @@ struct ioc3_etxd {
 #define ETXD_B2CNT_MASK		0x7ff00000
 #define ETXD_B2CNT_SHIFT	20
 
-/*
- * Bytebus device space
- */
-#define IOC3_BYTEBUS_DEV0	0x80000L
-#define IOC3_BYTEBUS_DEV1	0xa0000L
-#define IOC3_BYTEBUS_DEV2	0xc0000L
-#define IOC3_BYTEBUS_DEV3	0xe0000L
-
 /* ------------------------------------------------------------------------- */
 
 /* Superio Registers (PIO Access) */
 #define IOC3_SIO_BASE		0x20000
 #define IOC3_SIO_UARTC		(IOC3_SIO_BASE+0x141)	/* UART Config */
 #define IOC3_SIO_KBDCG		(IOC3_SIO_BASE+0x142)	/* KBD Config */
-#define IOC3_SIO_PP_BASE	(IOC3_SIO_BASE+PP_BASE)		/* Parallel Port */
+#define IOC3_SIO_PP_BASE	(IOC3_SIO_BASE+PP_BASE)	/* Parallel Port */
 #define IOC3_SIO_RTC_BASE	(IOC3_SIO_BASE+0x168)	/* Real Time Clock */
 #define IOC3_SIO_UB_BASE	(IOC3_SIO_BASE+UARTB_BASE)	/* UART B */
 #define IOC3_SIO_UA_BASE	(IOC3_SIO_BASE+UARTA_BASE)	/* UART A */
 
 /* SSRAM Diagnostic Access */
 #define IOC3_SSRAM	IOC3_RAM_OFF	/* base of SSRAM diagnostic access */
-#define IOC3_SSRAM_LEN	0x40000 /* 256kb (address space size, may not be fully populated) */
+#define IOC3_SSRAM_LEN	0x40000	/* 256kb (addrspc sz, may not be populated) */
 #define IOC3_SSRAM_DM	0x0000ffff	/* data mask */
 #define IOC3_SSRAM_PM	0x00010000	/* parity mask */
 
@@ -294,10 +300,10 @@ struct ioc3_etxd {
 					   SIO_IR to assert */
 #define KM_CSR_M_TO_EN	  0x00080000	/* KM_CSR_M_TO + KM_CSR_M_TO_EN = cause
 					   SIO_IR to assert */
-#define KM_CSR_K_CLAMP_ONE	0x00100000	/* Pull K_CLK low after rec. one char */
-#define KM_CSR_M_CLAMP_ONE	0x00200000	/* Pull M_CLK low after rec. one char */
-#define KM_CSR_K_CLAMP_THREE	0x00400000	/* Pull K_CLK low after rec. three chars */
-#define KM_CSR_M_CLAMP_THREE	0x00800000	/* Pull M_CLK low after rec. three char */
+#define KM_CSR_K_CLAMP_1  0x00100000	/* Pull K_CLK low aft recv 1 char */
+#define KM_CSR_M_CLAMP_1  0x00200000	/* Pull M_CLK low aft recv 1 char */
+#define KM_CSR_K_CLAMP_3  0x00400000	/* Pull K_CLK low aft recv 3 chars */
+#define KM_CSR_M_CLAMP_3  0x00800000	/* Pull M_CLK low aft recv 3 chars */
 
 /* bitmasks for IOC3_K_RD and IOC3_M_RD */
 #define KM_RD_DATA_2	0x000000ff	/* 3rd char recvd since last read */
@@ -440,10 +446,6 @@ struct ioc3_etxd {
 				 SIO_IR_PP_INTB | SIO_IR_PP_MEMERR)
 #define SIO_IR_RT		(SIO_IR_RT_INT | SIO_IR_GEN_INT1)
 
-/* macro to load pending interrupts */
-#define IOC3_PENDING_INTRS(mem) (PCI_INW(&((mem)->sio_ir)) & \
-				 PCI_INW(&((mem)->sio_ies_ro)))
-
 /* bitmasks for SIO_CR */
 #define SIO_CR_SIO_RESET	0x00000001	/* reset the SIO */
 #define SIO_CR_SER_A_BASE	0x000000fe	/* DMA poll addr port A */
@@ -500,10 +502,11 @@ struct ioc3_etxd {
 #define GPCR_UARTB_MODESEL	0x40	/* pin is output to port B mode sel */
 #define GPCR_UARTA_MODESEL	0x80	/* pin is output to port A mode sel */
 
-#define GPPR_PHY_RESET_PIN	5	/* GIO pin controlling phy reset */
-#define GPPR_UARTB_MODESEL_PIN	6	/* GIO pin controlling uart b mode select */
-#define GPPR_UARTA_MODESEL_PIN	7	/* GIO pin controlling uart a mode select */
+#define GPPR_PHY_RESET_PIN	5	/* GIO pin cntrlling phy reset */
+#define GPPR_UARTB_MODESEL_PIN	6	/* GIO pin cntrlling uart b mode sel */
+#define GPPR_UARTA_MODESEL_PIN	7	/* GIO pin cntrlling uart a mode sel */
 
+/* ethernet */
 #define EMCR_DUPLEX		0x00000001
 #define EMCR_PROMISC		0x00000002
 #define EMCR_PADEN		0x00000004
@@ -595,70 +598,8 @@ struct ioc3_etxd {
 
 #define MIDR_DATA_MASK		0x0000ffff
 
-#define ERXBUF_IPCKSUM_MASK	0x0000ffff
-#define ERXBUF_BYTECNT_MASK	0x07ff0000
-#define ERXBUF_BYTECNT_SHIFT	16
-#define ERXBUF_V		0x80000000
-
-#define ERXBUF_CRCERR		0x00000001	/* aka RSV15 */
-#define ERXBUF_FRAMERR		0x00000002	/* aka RSV14 */
-#define ERXBUF_CODERR		0x00000004	/* aka RSV13 */
-#define ERXBUF_INVPREAMB	0x00000008	/* aka RSV18 */
-#define ERXBUF_LOLEN		0x00007000	/* aka RSV2_0 */
-#define ERXBUF_HILEN		0x03ff0000	/* aka RSV12_3 */
-#define ERXBUF_MULTICAST	0x04000000	/* aka RSV16 */
-#define ERXBUF_BROADCAST	0x08000000	/* aka RSV17 */
-#define ERXBUF_LONGEVENT	0x10000000	/* aka RSV19 */
-#define ERXBUF_BADPKT		0x20000000	/* aka RSV20 */
-#define ERXBUF_GOODPKT		0x40000000	/* aka RSV21 */
-#define ERXBUF_CARRIER		0x80000000	/* aka RSV22 */
-
-#define ETXD_BYTECNT_MASK	0x000007ff	/* total byte count */
-#define ETXD_INTWHENDONE	0x00001000	/* intr when done */
-#define ETXD_D0V		0x00010000	/* data 0 valid */
-#define ETXD_B1V		0x00020000	/* buf 1 valid */
-#define ETXD_B2V		0x00040000	/* buf 2 valid */
-#define ETXD_DOCHECKSUM		0x00080000	/* insert ip cksum */
-#define ETXD_CHKOFF_MASK	0x07f00000	/* cksum byte offset */
-#define ETXD_CHKOFF_SHIFT	20
-
-#define ETXD_D0CNT_MASK		0x0000007f
-#define ETXD_B1CNT_MASK		0x0007ff00
-#define ETXD_B1CNT_SHIFT	8
-#define ETXD_B2CNT_MASK		0x7ff00000
-#define ETXD_B2CNT_SHIFT	20
-
-typedef enum ioc3_subdevs_e {
-    ioc3_subdev_ether,
-    ioc3_subdev_generic,
-    ioc3_subdev_nic,
-    ioc3_subdev_kbms,
-    ioc3_subdev_ttya,
-    ioc3_subdev_ttyb,
-    ioc3_subdev_ecpp,
-    ioc3_subdev_rt,
-    ioc3_nsubdevs
-} ioc3_subdev_t;
-
-/* subdevice disable bits,
- * from the standard INFO_LBL_SUBDEVS
- */
-#define IOC3_SDB_ETHER		(1<<ioc3_subdev_ether)
-#define IOC3_SDB_GENERIC	(1<<ioc3_subdev_generic)
-#define IOC3_SDB_NIC		(1<<ioc3_subdev_nic)
-#define IOC3_SDB_KBMS		(1<<ioc3_subdev_kbms)
-#define IOC3_SDB_TTYA		(1<<ioc3_subdev_ttya)
-#define IOC3_SDB_TTYB		(1<<ioc3_subdev_ttyb)
-#define IOC3_SDB_ECPP		(1<<ioc3_subdev_ecpp)
-#define IOC3_SDB_RT		(1<<ioc3_subdev_rt)
-
-#define IOC3_ALL_SUBDEVS	((1<<ioc3_nsubdevs)-1)
-
-#define IOC3_SDB_SERIAL		(IOC3_SDB_TTYA|IOC3_SDB_TTYB)
-
-#define IOC3_STD_SUBDEVS	IOC3_ALL_SUBDEVS
-
-#define IOC3_INTA_SUBDEVS	IOC3_SDB_ETHER
-#define IOC3_INTB_SUBDEVS	(IOC3_SDB_GENERIC|IOC3_SDB_KBMS|IOC3_SDB_SERIAL|IOC3_SDB_ECPP|IOC3_SDB_RT)
+#if defined(CONFIG_SGI_IP27) || defined(CONFIG_SGI_IP30)
+extern int bridge_alloc_irq(struct pci_dev *dev);
+#endif
 
-#endif /* _IOC3_H */
+#endif /* MIPS_SN_IOC3_H */
diff --git a/arch/mips/sgi-ip27/ip27-timer.c b/arch/mips/sgi-ip27/ip27-timer.c
index 9b4b9ac621a3..5631e93ea350 100644
--- a/arch/mips/sgi-ip27/ip27-timer.c
+++ b/arch/mips/sgi-ip27/ip27-timer.c
@@ -188,23 +188,3 @@ void hub_rtc_init(cnodeid_t cnode)
 		LOCAL_HUB_S(PI_RT_PEND_B, 0);
 	}
 }
-
-static int __init sgi_ip27_rtc_devinit(void)
-{
-	struct resource res;
-
-	memset(&res, 0, sizeof(res));
-	res.start = XPHYSADDR(KL_CONFIG_CH_CONS_INFO(master_nasid)->memory_base +
-			      IOC3_BYTEBUS_DEV0);
-	res.end = res.start + 32767;
-	res.flags = IORESOURCE_MEM;
-
-	return IS_ERR(platform_device_register_simple("rtc-m48t35", -1,
-						      &res, 1));
-}
-
-/*
- * kludge make this a device_initcall after ioc3 resource conflicts
- * are resolved
- */
-late_initcall(sgi_ip27_rtc_devinit);
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 0ce2d8dfc5f1..871d66a86c86 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1951,5 +1951,18 @@ config RAVE_SP_CORE
 	  Select this to get support for the Supervisory Processor
 	  device found on several devices in RAVE line of hardware.
 
+config SGI_MFD_IOC3
+	tristate "SGI IOC3 core driver"
+	depends on PCI && MIPS
+	select MFD_CORE
+	help
+	  This option enables basic support for the SGI IOC3-based
+	  controller cards.  This option does not enable any specific
+	  functions on such a card, but provides necessary infrastructure
+	  for other drivers to utilize.
+
+	  If you have an SGI Origin, Octane, or a PCI IOC3 card,
+	  then say Y. Otherwise say N.
+
 endmenu
 endif
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index b4569ed7f3f3..07255e499129 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -246,4 +246,5 @@ obj-$(CONFIG_MFD_MXS_LRADC)     += mxs-lradc.o
 obj-$(CONFIG_MFD_SC27XX_PMIC)	+= sprd-sc27xx-spi.o
 obj-$(CONFIG_RAVE_SP_CORE)	+= rave-sp.o
 obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
+obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
 
diff --git a/drivers/mfd/ioc3.c b/drivers/mfd/ioc3.c
new file mode 100644
index 000000000000..ad715805b16e
--- /dev/null
+++ b/drivers/mfd/ioc3.c
@@ -0,0 +1,802 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SGI IOC3 multifunction device driver
+ *
+ * Copyright (C) 2018, 2019 Thomas Bogendoerfer <tbogendoerfer@suse.de>
+ *
+ * Based on work by:
+ *   Stanislaw Skowronek <skylark@unaligned.org>
+ *   Joshua Kinard <kumba@gentoo.org>
+ *   Brent Casavant <bcasavan@sgi.com> - IOC4 master driver
+ *   Pat Gefre <pfg@sgi.com> - IOC3 serial port IRQ demuxer
+ */
+
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/mfd/core.h>
+#include <linux/platform_device.h>
+#include <linux/platform_data/ioc3eth.h>
+
+#include <asm/sn/ioc3.h>
+#include <asm/pci/bridge.h>
+
+#define IOC3_ETH	BIT(0)
+#define IOC3_SER	BIT(1)
+#define IOC3_PAR	BIT(2)
+#define IOC3_KBD	BIT(3)
+#define IOC3_M48T35	BIT(4)
+
+static int ioc3_serial_id = 1;
+static int ioc3_eth_id = 1;
+static int ioc3_kbd_id = 1;
+static struct mfd_cell ioc3_mfd_cells[5];
+
+struct ioc3_board_info {
+	const char *name;
+	int irq_offset;
+	int funcs;
+};
+
+struct ioc3_priv_data {
+	struct ioc3_board_info *info;
+	struct irq_domain *domain;
+	struct ioc3 __iomem *regs;
+	struct pci_dev *pdev;
+	char nic_part[32];
+	char nic_mac[6];
+	int irq_io;
+};
+
+#define MCR_PACK(pulse, sample)	(((pulse) << 10) | ((sample) << 2))
+
+static int ioc3_nic_wait(u32 __iomem *mcr)
+{
+	u32 mcr_val;
+
+	do {
+		mcr_val = readl(mcr);
+	} while (!(mcr_val & 2));
+
+	return (mcr_val & 1);
+}
+
+static int ioc3_nic_reset(u32 __iomem *mcr)
+{
+	int presence;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	writel(MCR_PACK(520, 65), mcr);
+	presence = ioc3_nic_wait(mcr);
+	local_irq_restore(flags);
+
+	udelay(500);
+
+	return presence;
+}
+
+static int ioc3_nic_read_bit(u32 __iomem *mcr)
+{
+	int result;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	writel(MCR_PACK(6, 13), mcr);
+	result = ioc3_nic_wait(mcr);
+	local_irq_restore(flags);
+
+	udelay(100);
+
+	return result;
+}
+
+static u32 ioc3_nic_read_byte(u32 __iomem *mcr)
+{
+	u32 result = 0;
+	int i;
+
+	for (i = 0; i < 8; i++)
+		result = ((result >> 1) | (ioc3_nic_read_bit(mcr) << 7));
+
+	return result;
+}
+
+static void ioc3_nic_write_bit(u32 __iomem *mcr, int bit)
+{
+	if (bit)
+		writel(MCR_PACK(6, 110), mcr);
+	else
+		writel(MCR_PACK(80, 30), mcr);
+
+	ioc3_nic_wait(mcr);
+}
+
+static void ioc3_nic_write_byte(u32 __iomem *mcr, int byte)
+{
+	int i;
+
+	for (i = 0; i < 8; i++) {
+		ioc3_nic_write_bit(mcr, byte & 1);
+		byte >>= 1;
+	}
+}
+
+static u64 ioc3_nic_find(u32 __iomem *mcr, int *last, u64 addr)
+{
+	int a, b, index, disc;
+
+	ioc3_nic_reset(mcr);
+
+	/* Search ROM.  */
+	ioc3_nic_write_byte(mcr, 0xf0);
+
+	/* Algorithm from ``Book of iButton Standards''.  */
+	for (index = 0, disc = 0; index < 64; index++) {
+		a = ioc3_nic_read_bit(mcr);
+		b = ioc3_nic_read_bit(mcr);
+
+		if (unlikely(a && b)) {
+			pr_warn("ioc3: NIC search failed.\n");
+			*last = 0;
+			return 0;
+		}
+
+		if (!a && !b) {
+			if (index == *last)
+				addr |= 1UL << index;
+			else if (index > *last) {
+				addr &= ~(1UL << index);
+				disc = index;
+			} else if ((addr & (1UL << index)) == 0)
+				disc = index;
+			ioc3_nic_write_bit(mcr, (addr >> index) & 1);
+			continue;
+		} else {
+			if (a)
+				addr |= (1UL << index);
+			else
+				addr &= ~(1UL << index);
+			ioc3_nic_write_bit(mcr, a);
+			continue;
+		}
+	}
+	*last = disc;
+	return addr;
+}
+
+static void ioc3_nic_addr(u32 __iomem *mcr, u64 addr)
+{
+	int index;
+
+	ioc3_nic_reset(mcr);
+	ioc3_nic_write_byte(mcr, 0xf0);
+
+	for (index = 0; index < 64; index++) {
+		ioc3_nic_read_bit(mcr);
+		ioc3_nic_read_bit(mcr);
+		ioc3_nic_write_bit(mcr, ((addr >> index) & 1));
+	}
+}
+
+static void crc16_byte(u32 *crc, u8 db)
+{
+	int i;
+
+	for (i = 0; i < 8; i++) {
+		*crc <<= 1;
+		if ((db ^ (*crc >> 16)) & 1)
+			*crc ^= 0x8005;
+		db >>= 1;
+	}
+	*crc &= 0xffff;
+}
+
+static u32 crc16_area(u8 *dbs, int size, u32 crc)
+{
+	while (size--)
+		crc16_byte(&crc, *(dbs++));
+
+	return crc;
+}
+
+static void crc8_byte(u32 *crc, u8 db)
+{
+	int i, f;
+
+	for (i = 0; i < 8; i++) {
+		f = ((*crc ^ db) & 1);
+		*crc >>= 1;
+		db >>= 1;
+		if (f)
+			*crc ^= 0x8c;
+	}
+	*crc &= 0xff;
+}
+
+static u32 crc8_addr(u64 addr)
+{
+	u32 crc = 0;
+	int i;
+
+	for (i = 0; i < 64; i += 8)
+		crc8_byte(&crc, addr >> i);
+	return crc;
+}
+
+static void ioc3_read_redir_page(u32 __iomem *mcr, u64 addr, int page,
+				 u8 *redir, u8 *data)
+{
+	int loops = 16, i;
+
+	while (redir[page] != 0xff) {
+		page = (redir[page] ^ 0xff);
+		loops--;
+		if (unlikely(loops < 0)) {
+			pr_err("ioc3: NIC circular redirection\n");
+			return;
+		}
+	}
+
+	loops = 3;
+	while (loops > 0) {
+		ioc3_nic_addr(mcr, addr);
+		ioc3_nic_write_byte(mcr, 0xf0);
+		ioc3_nic_write_byte(mcr, (page << 5) & 0xe0);
+		ioc3_nic_write_byte(mcr, (page >> 3) & 0x1f);
+
+		for (i = 0; i < 0x20; i++)
+			data[i] = ioc3_nic_read_byte(mcr);
+
+		if (crc16_area(data, 0x20, 0) == 0x800d)
+			return;
+
+		loops--;
+	}
+
+	pr_err("ioc3: CRC error in data page\n");
+	for (i = 0; i < 0x20; i++)
+		data[i] = 0x00;
+}
+
+static void ioc3_read_redir_map(u32 __iomem *mcr, u64 addr, u8 *redir)
+{
+	int i, j, crc_ok, loops = 3;
+	u32 crc;
+
+	while (loops > 0) {
+		crc_ok = 1;
+		ioc3_nic_addr(mcr, addr);
+		ioc3_nic_write_byte(mcr, 0xaa);
+		ioc3_nic_write_byte(mcr, 0x00);
+		ioc3_nic_write_byte(mcr, 0x01);
+
+		for (i = 0; i < 64; i += 8) {
+			for (j = 0; j < 8; j++)
+				redir[i + j] = ioc3_nic_read_byte(mcr);
+
+			crc = crc16_area(redir + i, 8, i == 0 ? 0x8707 : 0);
+
+			crc16_byte(&crc, ioc3_nic_read_byte(mcr));
+			crc16_byte(&crc, ioc3_nic_read_byte(mcr));
+
+			if (crc != 0x800d)
+				crc_ok = 0;
+		}
+		if (crc_ok)
+			return;
+		loops--;
+	}
+	pr_err("ioc3: CRC error in redirection page\n");
+	for (i = 0; i < 64; i++)
+		redir[i] = 0xff;
+}
+
+static void ioc3_read_nic(struct ioc3_priv_data *ipd, u32 __iomem *mcr,
+			  u64 addr)
+{
+	u8 redir[64];
+	u8 data[64], part[32];
+	int i, j;
+
+	/* Read redirections */
+	ioc3_read_redir_map(mcr, addr, redir);
+
+	/* Read data pages */
+	ioc3_read_redir_page(mcr, addr, 0, redir, data);
+	ioc3_read_redir_page(mcr, addr, 1, redir, (data + 32));
+
+	/* Assemble the part # */
+	j = 0;
+	for (i = 0; i < 19; i++)
+		if (data[i + 11] != ' ')
+			part[j++] = data[i + 11];
+
+	for (i = 0; i < 6; i++)
+		if (data[i + 32] != ' ')
+			part[j++] = data[i + 32];
+
+	part[j] = 0;
+
+	/* Skip Octane (IP30) power supplies */
+	if (!(strncmp(part, "060-0035-", 9)) ||
+	    !(strncmp(part, "060-0038-", 9)) ||
+	    !(strncmp(part, "060-0028-", 9)))
+		return;
+
+	strlcpy(ipd->nic_part, part, sizeof(ipd->nic_part));
+}
+
+static void ioc3_read_mac(struct ioc3_priv_data *ipd, u64 addr)
+{
+	int i, loops = 3;
+	u8 data[13];
+	u32 __iomem *mcr = &ipd->regs->mcr;
+
+	while (loops > 0) {
+		ioc3_nic_addr(mcr, addr);
+		ioc3_nic_write_byte(mcr, 0xf0);
+		ioc3_nic_write_byte(mcr, 0x00);
+		ioc3_nic_write_byte(mcr, 0x00);
+		ioc3_nic_read_byte(mcr);
+
+		for (i = 0; i < 13; i++)
+			data[i] = ioc3_nic_read_byte(mcr);
+
+		if (crc16_area(data, 13, 0) == 0x800d) {
+			for (i = 10; i > 4; i--)
+				ipd->nic_mac[10 - i] = data[i];
+			return;
+		}
+		loops--;
+	}
+
+	pr_err("ioc3: CRC error in MAC address\n");
+	for (i = 0; i < 6; i++)
+		ipd->nic_mac[i] = 0x00;
+}
+
+static void ioc3_probe_nic(struct ioc3_priv_data *ipd, u32 __iomem *mcr)
+{
+	int save = 0, loops = 3;
+	u64 first, addr;
+
+	while (loops > 0) {
+		ipd->nic_part[0] = 0;
+		first = ioc3_nic_find(mcr, &save, 0);
+		addr = first;
+
+		if (unlikely(!first))
+			return;
+
+		while (1) {
+			if (crc8_addr(addr))
+				break;
+
+			switch (addr & 0xff) {
+			case 0x0b:
+				ioc3_read_nic(ipd, mcr, addr);
+				break;
+			case 0x09:
+			case 0x89:
+			case 0x91:
+				ioc3_read_mac(ipd, addr);
+				break;
+			}
+
+			addr = ioc3_nic_find(mcr, &save, addr);
+			if (addr == first)
+				return;
+		}
+		loops--;
+	}
+	pr_err("ioc3: CRC error in NIC address\n");
+}
+
+static void ioc3_irq_ack(struct irq_data *d)
+{
+	struct ioc3_priv_data *ipd = irq_data_get_irq_chip_data(d);
+	unsigned int hwirq = irqd_to_hwirq(d);
+
+	writel(BIT(hwirq), &ipd->regs->sio_ir);
+}
+
+static void ioc3_irq_mask(struct irq_data *d)
+{
+	struct ioc3_priv_data *ipd = irq_data_get_irq_chip_data(d);
+	unsigned int hwirq = irqd_to_hwirq(d);
+
+	writel(BIT(hwirq), &ipd->regs->sio_iec);
+}
+
+static void ioc3_irq_unmask(struct irq_data *d)
+{
+	struct ioc3_priv_data *ipd = irq_data_get_irq_chip_data(d);
+	unsigned int hwirq = irqd_to_hwirq(d);
+
+	writel(BIT(hwirq), &ipd->regs->sio_ies);
+}
+
+static struct irq_chip ioc3_irq_chip = {
+	.name		= "IOC3",
+	.irq_ack	= ioc3_irq_ack,
+	.irq_mask	= ioc3_irq_mask,
+	.irq_unmask	= ioc3_irq_unmask,
+};
+
+#define IOC3_LVL_MASK	(BIT(0) | BIT(2) | BIT(6) | BIT(9) | BIT(11) | BIT(15))
+
+static int ioc3_irq_domain_map(struct irq_domain *d, unsigned int irq,
+			      irq_hw_number_t hwirq)
+{
+	if (BIT(hwirq) & IOC3_LVL_MASK)
+		irq_set_chip_and_handler(irq, &ioc3_irq_chip, handle_level_irq);
+	else
+		irq_set_chip_and_handler(irq, &ioc3_irq_chip, handle_edge_irq);
+
+	irq_set_chip_data(irq, d->host_data);
+	return 0;
+}
+
+
+static const struct irq_domain_ops ioc3_irq_domain_ops = {
+	.map = ioc3_irq_domain_map,
+};
+
+static void ioc3_irq_handler(struct irq_desc *desc)
+{
+	struct irq_domain *domain = irq_desc_get_handler_data(desc);
+	struct ioc3_priv_data *ipd = domain->host_data;
+	struct ioc3 __iomem *regs = ipd->regs;
+	unsigned int irq = 0;
+	u32 pending;
+
+	pending = readl(&regs->sio_ir);
+	pending &= readl(&regs->sio_ies);
+	if (pending)
+		irq = irq_find_mapping(domain, __ffs(pending));
+	else if (!ipd->info->irq_offset &&
+		 (readl(&regs->eth.eisr) & readl(&regs->eth.eier)))
+		irq = irq_find_mapping(domain, 23);
+
+	if (irq)
+		generic_handle_irq(irq);
+	else
+		spurious_interrupt();
+}
+
+static struct resource ioc3_uarta_resources[] = {
+	DEFINE_RES_MEM(offsetof(struct ioc3, sregs.uarta),
+		       sizeof_field(struct ioc3, sregs.uarta)),
+	DEFINE_RES_IRQ(6)
+};
+
+static struct resource ioc3_uartb_resources[] = {
+	DEFINE_RES_MEM(offsetof(struct ioc3, sregs.uartb),
+		       sizeof_field(struct ioc3, sregs.uartb)),
+	DEFINE_RES_IRQ(15)
+};
+
+static struct resource ioc3_kbd_resources[] = {
+	DEFINE_RES_MEM(offsetof(struct ioc3, serio),
+		       sizeof_field(struct ioc3, serio)),
+	DEFINE_RES_IRQ(22)
+};
+
+static struct resource ioc3_eth_resources[] = {
+	DEFINE_RES_MEM(offsetof(struct ioc3, eth),
+		       sizeof_field(struct ioc3, eth)),
+	DEFINE_RES_MEM(offsetof(struct ioc3, ssram),
+		       sizeof_field(struct ioc3, ssram)),
+	DEFINE_RES_IRQ(0)
+};
+
+static struct ioc3eth_platform_data ioc3_eth_platform_data;
+
+#ifdef CONFIG_SGI_IP27
+
+static struct resource ioc3_rtc_resources[] = {
+	DEFINE_RES_MEM(IOC3_BYTEBUS_DEV0, 32768)
+};
+
+static struct ioc3_board_info ip27_baseio_info = {
+	.name = "IP27 BaseIO",
+	.funcs = IOC3_ETH | IOC3_SER | IOC3_M48T35,
+	.irq_offset = 2
+};
+
+static struct ioc3_board_info ip27_baseio6g_info = {
+	.name = "IP27 BaseIO6G",
+	.funcs = IOC3_ETH | IOC3_SER | IOC3_KBD | IOC3_M48T35,
+	.irq_offset = 2
+};
+
+static struct ioc3_board_info ip27_mio_info = {
+	.name = "MIO",
+	.funcs = IOC3_SER | IOC3_PAR | IOC3_KBD,
+	.irq_offset = 0
+};
+
+static struct ioc3_board_info ip29_baseio_info = {
+	.name = "IP29 System Board",
+	.funcs = IOC3_ETH | IOC3_SER | IOC3_PAR | IOC3_KBD | IOC3_M48T35,
+	.irq_offset = 1
+};
+
+#endif /* CONFIG_SGI_IP27 */
+
+static struct ioc3_board_info ioc3_menet_info = {
+	.name = "MENET",
+	.funcs = IOC3_ETH | IOC3_SER,
+	.irq_offset = 4
+};
+
+static struct ioc3_board_info ioc3_cad_duo_info = {
+	.name = "CAD DUO",
+	.funcs = IOC3_ETH | IOC3_KBD,
+	.irq_offset = 0
+};
+
+#define IOC3_BOARD(_partno, _info) {   .info = _info, .match = _partno }
+
+static struct {
+	struct ioc3_board_info *info;
+	const char *match;
+} ioc3_boards[] = {
+#ifdef CONFIG_SGI_IP27
+	IOC3_BOARD("030-0734-", &ip27_baseio6g_info),
+	IOC3_BOARD("030-1023-", &ip27_baseio_info),
+	IOC3_BOARD("030-1124-", &ip27_baseio_info),
+	IOC3_BOARD("030-1025-", &ip29_baseio_info),
+	IOC3_BOARD("030-1244-", &ip29_baseio_info),
+	IOC3_BOARD("030-1389-", &ip29_baseio_info),
+	IOC3_BOARD("030-0880-", &ip27_mio_info),
+#endif
+	IOC3_BOARD("030-0873-", &ioc3_menet_info),
+	IOC3_BOARD("030-1155-", &ioc3_cad_duo_info),
+};
+
+static int ioc3_identify(struct ioc3_priv_data *idp)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ioc3_boards); i++)
+		if (!strncmp(idp->nic_part, ioc3_boards[i].match,
+			     strlen(ioc3_boards[i].match))) {
+			idp->info = ioc3_boards[i].info;
+			return 0;
+		}
+
+	return -1;
+}
+
+static void ioc3_create_devices(struct ioc3_priv_data *ipd)
+{
+	struct mfd_cell *cell;
+
+	memset(ioc3_mfd_cells, 0, sizeof(ioc3_mfd_cells));
+	cell = ioc3_mfd_cells;
+
+	if (ipd->info->funcs & IOC3_ETH) {
+		memcpy(ioc3_eth_platform_data.mac_addr, ipd->nic_mac,
+		       sizeof(ioc3_eth_platform_data.mac_addr));
+		cell->name = "ioc3-eth";
+		cell->id = ioc3_eth_id++;
+		cell->resources = ioc3_eth_resources;
+		cell->num_resources = ARRAY_SIZE(ioc3_eth_resources);
+		cell->platform_data = &ioc3_eth_platform_data;
+		cell->pdata_size = sizeof(ioc3_eth_platform_data);
+		if (ipd->info->irq_offset) {
+			/*
+			 * Ethernet interrupt is on an extra interrupt
+			 * not inside the irq domain, so we need an
+			 * extra mfd_add_devices without the domain
+			 * argument
+			 */
+			ioc3_eth_resources[2].start = ipd->pdev->irq;
+			ioc3_eth_resources[2].end = ipd->pdev->irq;
+			mfd_add_devices(&ipd->pdev->dev, -1, cell, 1,
+					&ipd->pdev->resource[0], 0, NULL);
+			memset(cell, 0, sizeof(*cell));
+		} else {
+			/* fake hwirq in domain */
+			ioc3_eth_resources[2].start = 23;
+			ioc3_eth_resources[2].end = 23;
+			cell++;
+		}
+	}
+	if (ipd->info->funcs & IOC3_SER) {
+		writel(GPCR_UARTA_MODESEL | GPCR_UARTB_MODESEL,
+			&ipd->regs->gpcr_s);
+		writel(0, &ipd->regs->gppr[6]);
+		writel(0, &ipd->regs->gppr[7]);
+		udelay(100);
+		writel(readl(&ipd->regs->port_a.sscr) & ~SSCR_DMA_EN,
+		       &ipd->regs->port_a.sscr);
+		writel(readl(&ipd->regs->port_b.sscr) & ~SSCR_DMA_EN,
+		       &ipd->regs->port_b.sscr);
+		udelay(1000);
+		cell->name = "ioc3-serial8250";
+		cell->id = ioc3_serial_id++;
+		cell->resources = ioc3_uarta_resources;
+		cell->num_resources = ARRAY_SIZE(ioc3_uarta_resources);
+		cell++;
+		cell->name = "ioc3-serial8250";
+		cell->id = ioc3_serial_id++;
+		cell->resources = ioc3_uartb_resources;
+		cell->num_resources = ARRAY_SIZE(ioc3_uartb_resources);
+		cell++;
+	}
+	if (ipd->info->funcs & IOC3_KBD) {
+		cell->name = "ioc3-kbd",
+		cell->id = ioc3_kbd_id++;
+		cell->resources = ioc3_kbd_resources,
+		cell->num_resources = ARRAY_SIZE(ioc3_kbd_resources),
+		cell++;
+	}
+#if defined(CONFIG_SGI_IP27)
+	if (ipd->info->funcs & IOC3_M48T35) {
+		cell->name = "rtc-m48t35";
+		cell->id = -1;
+		cell->resources = ioc3_rtc_resources;
+		cell->num_resources = ARRAY_SIZE(ioc3_rtc_resources);
+		cell++;
+	}
+#endif
+	mfd_add_devices(&ipd->pdev->dev, -1, ioc3_mfd_cells,
+			cell - ioc3_mfd_cells, &ipd->pdev->resource[0],
+			0, ipd->domain);
+}
+
+static int ioc3_mfd_probe(struct pci_dev *pdev,
+			  const struct pci_device_id *pci_id)
+{
+	struct ioc3_priv_data *ipd;
+	int err, ret = -ENODEV, io_irqno;
+	struct ioc3 __iomem *regs;
+	struct irq_domain *domain;
+	struct fwnode_handle *fn;
+
+	err = pci_enable_device(pdev);
+	if (err)
+		return err;
+
+	pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 64);
+	pci_set_master(pdev);
+
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (ret) {
+		dev_warn(&pdev->dev, "Warning: couldn_t set 64-bit DMA mask\n");
+		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+		if (ret) {
+			dev_err(&pdev->dev, "Can't set DMA mask, aborting\n");
+			return ret;
+		}
+	}
+
+	/* Set up per-IOC3 data */
+	ipd = kzalloc(sizeof(struct ioc3_priv_data), GFP_KERNEL);
+	if (!ipd) {
+		ret = -ENOMEM;
+		goto out_disable_device;
+	}
+	ipd->pdev = pdev;
+
+	/*
+	 * Map all IOC3 registers.  These are shared between subdevices
+	 * so the main IOC3 module manages them.
+	 */
+	regs = pci_ioremap_bar(pdev, 0);
+	if (!regs) {
+		pr_warn("ioc3: Unable to remap PCI BAR for %s.\n",
+			pci_name(pdev));
+		goto out_free_ipd;
+	}
+	ipd->regs = regs;
+
+	/* Track PCI-device specific data */
+	pci_set_drvdata(pdev, ipd);
+
+	writel(GPCR_MLAN_EN, &ipd->regs->gpcr_s);
+	ioc3_probe_nic(ipd, &regs->mcr);
+
+#ifdef CONFIG_SGI_IP27
+	/* BaseIO NIC is attached to bridge */
+	if (!ipd->nic_part[0]) {
+		struct bridge_controller *bc = BRIDGE_CONTROLLER(pdev->bus);
+
+		ioc3_probe_nic(ipd, &bc->base->b_nic);
+	}
+#endif
+
+	if (ioc3_identify(ipd)) {
+		pr_err("ioc3: part: [%s] unknown card\n", ipd->nic_part);
+		goto out_iounmap;
+	}
+
+	pr_info("ioc3: part: [%s] %s\n", ipd->nic_part, ipd->info->name);
+
+	/* Clear IRQs */
+	writel(~0, &regs->sio_iec);
+	writel(~0, &regs->sio_ir);
+	writel(0, &regs->eth.eier);
+	writel(~0, &regs->eth.eisr);
+
+	if (ipd->info->irq_offset) {
+		struct pci_host_bridge *hbrg = pci_find_host_bridge(pdev->bus);
+
+		io_irqno = hbrg->map_irq(pdev,
+			PCI_SLOT(pdev->devfn) + ipd->info->irq_offset, 0);
+	} else {
+		io_irqno = pdev->irq;
+	}
+	ipd->irq_io = io_irqno;
+
+	fn = irq_domain_alloc_named_fwnode("IOC3");
+	if (!fn)
+		goto out_iounmap;
+
+	domain = irq_domain_create_linear(fn, 24, &ioc3_irq_domain_ops, ipd);
+	irq_domain_free_fwnode(fn);
+	if (!domain)
+		goto out_iounmap;
+	ipd->domain = domain;
+
+	irq_set_chained_handler_and_data(io_irqno, ioc3_irq_handler, domain);
+
+	ioc3_create_devices(ipd);
+
+	return 0;
+
+out_iounmap:
+	iounmap(ipd->regs);
+
+out_free_ipd:
+	kfree(ipd);
+
+out_disable_device:
+	pci_disable_device(pdev);
+	return ret;
+}
+
+static void ioc3_mfd_remove(struct pci_dev *pdev)
+{
+	struct ioc3_priv_data *ipd;
+
+	ipd = pci_get_drvdata(pdev);
+
+	/* Clear and disable all IRQs */
+	writel(~0, &ipd->regs->sio_iec);
+	writel(~0, &ipd->regs->sio_ir);
+
+	/* Release resources */
+	irq_domain_remove(ipd->domain);
+	free_irq(ipd->irq_io, (void *)ipd);
+	iounmap(ipd->regs);
+
+	pci_disable_device(pdev);
+
+	kfree(ipd);
+}
+
+static struct pci_device_id ioc3_mfd_id_table[] = {
+	{ PCI_VENDOR_ID_SGI, PCI_DEVICE_ID_SGI_IOC3, PCI_ANY_ID, PCI_ANY_ID },
+	{ 0, },
+};
+MODULE_DEVICE_TABLE(pci, ioc3_mfd_id_table);
+
+static struct pci_driver ioc3_mfd_driver = {
+	.name = "IOC3",
+	.id_table = ioc3_mfd_id_table,
+	.probe = ioc3_mfd_probe,
+	.remove = ioc3_mfd_remove,
+};
+
+module_pci_driver(ioc3_mfd_driver);
+
+MODULE_AUTHOR("Thomas Bogendoerfer <tbogendoerfer@suse.de>");
+MODULE_DESCRIPTION("SGI IOC3 MFD driver");
+MODULE_LICENSE("GPL");
+
diff --git a/drivers/net/ethernet/sgi/Kconfig b/drivers/net/ethernet/sgi/Kconfig
index fbbb21c13e95..814f793cf6fe 100644
--- a/drivers/net/ethernet/sgi/Kconfig
+++ b/drivers/net/ethernet/sgi/Kconfig
@@ -5,7 +5,7 @@
 config NET_VENDOR_SGI
 	bool "SGI devices"
 	default y
-	depends on (PCI && SGI_IP27) || SGI_IP32
+	depends on (PCI && SGI_MFD_IOC3) ||  SGI_IP32
 	---help---
 	  If you have a network (Ethernet) card belonging to this class, say Y.
 
@@ -18,7 +18,7 @@ if NET_VENDOR_SGI
 
 config SGI_IOC3_ETH
 	bool "SGI IOC3 Ethernet"
-	depends on PCI && SGI_IP27
+	depends on PCI && SGI_MFD_IOC3
 	select CRC32
 	select MII
 	---help---
diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
index 358e66b81926..21fe722ebcd8 100644
--- a/drivers/net/ethernet/sgi/ioc3-eth.c
+++ b/drivers/net/ethernet/sgi/ioc3-eth.c
@@ -7,6 +7,8 @@
  *
  * Copyright (C) 1999, 2000, 01, 03, 06 Ralf Baechle
  * Copyright (C) 1995, 1999, 2000, 2001 by Silicon Graphics, Inc.
+ * Copyright (C) 2005 Stanislaw Skowronek (port to meta-driver)
+ *               2009 Johannes Dickgreber <tanzy@gmx.de>
  *
  * References:
  *  o IOC3 ASIC specification 4.51, 1996-04-18
@@ -20,8 +22,6 @@
  *  o Use prefetching for large packets.  What is a good lower limit for
  *    prefetching?
  *  o We're probably allocating a bit too much memory.
- *  o Use hardware checksums.
- *  o Convert to using a IOC3 meta driver.
  *  o Which PHYs might possibly be attached to the IOC3 in real live,
  *    which workarounds are required for them?  Do we ever have Lucent's?
  *  o For the 2.5 branch kill the mii-tool ioctls.
@@ -30,484 +30,220 @@
 #define IOC3_NAME	"ioc3-eth"
 #define IOC3_VERSION	"2.6.3-4"
 
+#include <net/ip.h>
+
+#include <linux/crc32.h>
 #include <linux/delay.h>
+#include <linux/etherdevice.h>
+#include <linux/ethtool.h>
+#include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/errno.h>
-#include <linux/module.h>
-#include <linux/pci.h>
-#include <linux/crc32.h>
 #include <linux/mii.h>
-#include <linux/in.h>
-#include <linux/ip.h>
+#include <linux/netdevice.h>
 #include <linux/tcp.h>
 #include <linux/udp.h>
-#include <linux/dma-mapping.h>
+#include <linux/module.h>
 #include <linux/gfp.h>
+#include <linux/platform_device.h>
+#include <linux/platform_data/ioc3eth.h>
 
-#ifdef CONFIG_SERIAL_8250
-#include <linux/serial_core.h>
-#include <linux/serial_8250.h>
-#include <linux/serial_reg.h>
-#endif
-
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/ethtool.h>
-#include <linux/skbuff.h>
-#include <net/ip.h>
-
-#include <asm/byteorder.h>
-#include <asm/io.h>
-#include <asm/pgtable.h>
-#include <linux/uaccess.h>
-#include <asm/sn/types.h>
 #include <asm/sn/ioc3.h>
 #include <asm/pci/bridge.h>
 
+#define IOC3_CACHELINE	128UL
+
 /*
  * 64 RX buffers.  This is tunable in the range of 16 <= x < 512.  The
  * value must be a power of two.
  */
-#define RX_BUFFS 64
+#define RX_BUFFS 512
+#define RX_MASK (RX_BUFFS - 1)
 
-#define ETCSR_FD	((17<<ETCSR_IPGR2_SHIFT) | (11<<ETCSR_IPGR1_SHIFT) | 21)
-#define ETCSR_HD	((21<<ETCSR_IPGR2_SHIFT) | (21<<ETCSR_IPGR1_SHIFT) | 21)
+/* 128 TX buffers (not tunable) */
+#define TX_BUFFS 128
+#define TX_MASK (TX_BUFFS - 1)
+
+/* BEWARE: The IOC3 documentation documents the size of rx buffers as
+ * 1644 while it's actually 1664.  This one was nasty to track down...
+ */
+#define RX_OFFSET		18
+#define RX_BUF_SIZE		1664
+#define RX_BUF_ALLOC_SIZE	(RX_BUF_SIZE + RX_OFFSET + IOC3_CACHELINE)
 
-/* Private per NIC data of the driver.  */
+/* Private per NIC data of the driver. */
 struct ioc3_private {
-	struct ioc3 *regs;
+	struct ioc3_ethregs *regs;
+	u32 *ssram;
 	unsigned long *rxr;		/* pointer to receiver ring */
 	struct ioc3_etxd *txr;
-	struct sk_buff *rx_skbs[512];
-	struct sk_buff *tx_skbs[128];
+	struct sk_buff *rx_skbs[RX_BUFFS];
+	struct sk_buff *tx_skbs[TX_BUFFS];
 	int rx_ci;			/* RX consumer index */
 	int rx_pi;			/* RX producer index */
 	int tx_ci;			/* TX consumer index */
 	int tx_pi;			/* TX producer index */
-	int txqlen;
+	int txbfree;
 	u32 emcr, ehar_h, ehar_l;
 	spinlock_t ioc3_lock;
 	struct mii_if_info mii;
+	unsigned long flags;
+ #define IOC3_FLAG_RX_CHECKSUMS 1
 
-	struct net_device *dev;
-	struct pci_dev *pdev;
-
-	/* Members used by autonegotiation  */
 	struct timer_list ioc3_timer;
 };
 
-static int ioc3_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
-static void ioc3_set_multicast_list(struct net_device *dev);
-static netdev_tx_t ioc3_start_xmit(struct sk_buff *skb, struct net_device *dev);
-static void ioc3_timeout(struct net_device *dev);
-static inline unsigned int ioc3_hash(const unsigned char *addr);
-static inline void ioc3_stop(struct ioc3_private *ip);
-static void ioc3_init(struct net_device *dev);
-
-static const char ioc3_str[] = "IOC3 Ethernet";
-static const struct ethtool_ops ioc3_ethtool_ops;
-
 /* We use this to acquire receive skb's that we can DMA directly into. */
-
-#define IOC3_CACHELINE	128UL
-
 static inline unsigned long aligned_rx_skb_addr(unsigned long addr)
 {
-	return (~addr + 1) & (IOC3_CACHELINE - 1UL);
+	return ((addr + 127) & ~127UL) - addr;
 }
 
-static inline struct sk_buff * ioc3_alloc_skb(unsigned long length,
-	unsigned int gfp_mask)
+static struct sk_buff *ioc3_alloc_skb(struct net_device *dev)
 {
 	struct sk_buff *skb;
 
-	skb = alloc_skb(length + IOC3_CACHELINE - 1, gfp_mask);
+	skb = alloc_skb(RX_BUF_ALLOC_SIZE + IOC3_CACHELINE - 1, GFP_ATOMIC);
 	if (likely(skb)) {
 		int offset = aligned_rx_skb_addr((unsigned long) skb->data);
 		if (offset)
 			skb_reserve(skb, offset);
+		skb->dev = dev;
 	}
 
 	return skb;
 }
 
-static inline unsigned long ioc3_map(void *ptr, unsigned long vdev)
+static unsigned long ioc3_map(void *ptr, unsigned long dma_attr)
 {
 #ifdef CONFIG_SGI_IP27
-	vdev <<= 57;   /* Shift to PCI64_ATTR_VIRTUAL */
-
-	return vdev | (0xaUL << PCI64_ATTR_TARG_SHFT) | PCI64_ATTR_PREF |
-	       ((unsigned long)ptr & TO_PHYS_MASK);
+	return ((0xaUL << PCI64_ATTR_TARG_SHFT) | dma_attr |
+		((unsigned long)ptr & TO_PHYS_MASK));
 #else
 	return virt_to_bus(ptr);
 #endif
 }
 
-/* BEWARE: The IOC3 documentation documents the size of rx buffers as
-   1644 while it's actually 1664.  This one was nasty to track down ...  */
-#define RX_OFFSET		10
-#define RX_BUF_ALLOC_SIZE	(1664 + RX_OFFSET + IOC3_CACHELINE)
-
-/* DMA barrier to separate cached and uncached accesses.  */
-#define BARRIER()							\
-	__asm__("sync" ::: "memory")
-
-
-#define IOC3_SIZE 0x100000
-
-/*
- * IOC3 is a big endian device
- *
- * Unorthodox but makes the users of these macros more readable - the pointer
- * to the IOC3's memory mapped registers is expected as struct ioc3 * ioc3
- * in the environment.
- */
-#define ioc3_r_mcr()		be32_to_cpu(ioc3->mcr)
-#define ioc3_w_mcr(v)		do { ioc3->mcr = cpu_to_be32(v); } while (0)
-#define ioc3_w_gpcr_s(v)	do { ioc3->gpcr_s = cpu_to_be32(v); } while (0)
-#define ioc3_r_emcr()		be32_to_cpu(ioc3->emcr)
-#define ioc3_w_emcr(v)		do { ioc3->emcr = cpu_to_be32(v); } while (0)
-#define ioc3_r_eisr()		be32_to_cpu(ioc3->eisr)
-#define ioc3_w_eisr(v)		do { ioc3->eisr = cpu_to_be32(v); } while (0)
-#define ioc3_r_eier()		be32_to_cpu(ioc3->eier)
-#define ioc3_w_eier(v)		do { ioc3->eier = cpu_to_be32(v); } while (0)
-#define ioc3_r_ercsr()		be32_to_cpu(ioc3->ercsr)
-#define ioc3_w_ercsr(v)		do { ioc3->ercsr = cpu_to_be32(v); } while (0)
-#define ioc3_r_erbr_h()		be32_to_cpu(ioc3->erbr_h)
-#define ioc3_w_erbr_h(v)	do { ioc3->erbr_h = cpu_to_be32(v); } while (0)
-#define ioc3_r_erbr_l()		be32_to_cpu(ioc3->erbr_l)
-#define ioc3_w_erbr_l(v)	do { ioc3->erbr_l = cpu_to_be32(v); } while (0)
-#define ioc3_r_erbar()		be32_to_cpu(ioc3->erbar)
-#define ioc3_w_erbar(v)		do { ioc3->erbar = cpu_to_be32(v); } while (0)
-#define ioc3_r_ercir()		be32_to_cpu(ioc3->ercir)
-#define ioc3_w_ercir(v)		do { ioc3->ercir = cpu_to_be32(v); } while (0)
-#define ioc3_r_erpir()		be32_to_cpu(ioc3->erpir)
-#define ioc3_w_erpir(v)		do { ioc3->erpir = cpu_to_be32(v); } while (0)
-#define ioc3_r_ertr()		be32_to_cpu(ioc3->ertr)
-#define ioc3_w_ertr(v)		do { ioc3->ertr = cpu_to_be32(v); } while (0)
-#define ioc3_r_etcsr()		be32_to_cpu(ioc3->etcsr)
-#define ioc3_w_etcsr(v)		do { ioc3->etcsr = cpu_to_be32(v); } while (0)
-#define ioc3_r_ersr()		be32_to_cpu(ioc3->ersr)
-#define ioc3_w_ersr(v)		do { ioc3->ersr = cpu_to_be32(v); } while (0)
-#define ioc3_r_etcdc()		be32_to_cpu(ioc3->etcdc)
-#define ioc3_w_etcdc(v)		do { ioc3->etcdc = cpu_to_be32(v); } while (0)
-#define ioc3_r_ebir()		be32_to_cpu(ioc3->ebir)
-#define ioc3_w_ebir(v)		do { ioc3->ebir = cpu_to_be32(v); } while (0)
-#define ioc3_r_etbr_h()		be32_to_cpu(ioc3->etbr_h)
-#define ioc3_w_etbr_h(v)	do { ioc3->etbr_h = cpu_to_be32(v); } while (0)
-#define ioc3_r_etbr_l()		be32_to_cpu(ioc3->etbr_l)
-#define ioc3_w_etbr_l(v)	do { ioc3->etbr_l = cpu_to_be32(v); } while (0)
-#define ioc3_r_etcir()		be32_to_cpu(ioc3->etcir)
-#define ioc3_w_etcir(v)		do { ioc3->etcir = cpu_to_be32(v); } while (0)
-#define ioc3_r_etpir()		be32_to_cpu(ioc3->etpir)
-#define ioc3_w_etpir(v)		do { ioc3->etpir = cpu_to_be32(v); } while (0)
-#define ioc3_r_emar_h()		be32_to_cpu(ioc3->emar_h)
-#define ioc3_w_emar_h(v)	do { ioc3->emar_h = cpu_to_be32(v); } while (0)
-#define ioc3_r_emar_l()		be32_to_cpu(ioc3->emar_l)
-#define ioc3_w_emar_l(v)	do { ioc3->emar_l = cpu_to_be32(v); } while (0)
-#define ioc3_r_ehar_h()		be32_to_cpu(ioc3->ehar_h)
-#define ioc3_w_ehar_h(v)	do { ioc3->ehar_h = cpu_to_be32(v); } while (0)
-#define ioc3_r_ehar_l()		be32_to_cpu(ioc3->ehar_l)
-#define ioc3_w_ehar_l(v)	do { ioc3->ehar_l = cpu_to_be32(v); } while (0)
-#define ioc3_r_micr()		be32_to_cpu(ioc3->micr)
-#define ioc3_w_micr(v)		do { ioc3->micr = cpu_to_be32(v); } while (0)
-#define ioc3_r_midr_r()		be32_to_cpu(ioc3->midr_r)
-#define ioc3_w_midr_r(v)	do { ioc3->midr_r = cpu_to_be32(v); } while (0)
-#define ioc3_r_midr_w()		be32_to_cpu(ioc3->midr_w)
-#define ioc3_w_midr_w(v)	do { ioc3->midr_w = cpu_to_be32(v); } while (0)
-
-static inline u32 mcr_pack(u32 pulse, u32 sample)
-{
-	return (pulse << 10) | (sample << 2);
-}
-
-static int nic_wait(struct ioc3 *ioc3)
-{
-	u32 mcr;
-
-        do {
-                mcr = ioc3_r_mcr();
-        } while (!(mcr & 2));
-
-        return mcr & 1;
-}
-
-static int nic_reset(struct ioc3 *ioc3)
-{
-        int presence;
-
-	ioc3_w_mcr(mcr_pack(500, 65));
-	presence = nic_wait(ioc3);
-
-	ioc3_w_mcr(mcr_pack(0, 500));
-	nic_wait(ioc3);
-
-        return presence;
-}
-
-static inline int nic_read_bit(struct ioc3 *ioc3)
-{
-	int result;
-
-	ioc3_w_mcr(mcr_pack(6, 13));
-	result = nic_wait(ioc3);
-	ioc3_w_mcr(mcr_pack(0, 100));
-	nic_wait(ioc3);
-
-	return result;
-}
-
-static inline void nic_write_bit(struct ioc3 *ioc3, int bit)
+static void __ioc3_set_mac_address(struct net_device *dev,
+				   struct ioc3_ethregs *regs)
 {
-	if (bit)
-		ioc3_w_mcr(mcr_pack(6, 110));
-	else
-		ioc3_w_mcr(mcr_pack(80, 30));
-
-	nic_wait(ioc3);
-}
-
-/*
- * Read a byte from an iButton device
- */
-static u32 nic_read_byte(struct ioc3 *ioc3)
-{
-	u32 result = 0;
-	int i;
-
-	for (i = 0; i < 8; i++)
-		result = (result >> 1) | (nic_read_bit(ioc3) << 7);
-
-	return result;
+	writel((dev->dev_addr[5] <<  8) |
+		dev->dev_addr[4],
+		&regs->emar_h);
+	writel((dev->dev_addr[3] << 24) |
+		(dev->dev_addr[2] << 16) |
+		(dev->dev_addr[1] <<  8) |
+		dev->dev_addr[0],
+		&regs->emar_l);
 }
 
 /*
- * Write a byte to an iButton device
+ * Caller must hold the ioc3_lock ever for MII readers.  This is also
+ * used to protect the transmitter side but it's low contention.
  */
-static void nic_write_byte(struct ioc3 *ioc3, int byte)
+static int ioc3_mdio_read(struct net_device *dev, int phy, int reg)
 {
-	int i, bit;
+	struct ioc3_private *ip = netdev_priv(dev);
+	struct ioc3_ethregs *regs = ip->regs;
 
-	for (i = 8; i; i--) {
-		bit = byte & 1;
-		byte >>= 1;
+	while (readl(&regs->micr) & MICR_BUSY)
+		;
+	writel((phy << MICR_PHYADDR_SHIFT) | reg | MICR_READTRIG,
+	       &regs->micr);
+	while (readl(&regs->micr) & MICR_BUSY)
+		;
 
-		nic_write_bit(ioc3, bit);
-	}
+	return readl(&regs->midr_r) & MIDR_DATA_MASK;
 }
 
-static u64 nic_find(struct ioc3 *ioc3, int *last)
+static void ioc3_mdio_write(struct net_device *dev, int phy, int reg, int data)
 {
-	int a, b, index, disc;
-	u64 address = 0;
-
-	nic_reset(ioc3);
-	/* Search ROM.  */
-	nic_write_byte(ioc3, 0xf0);
-
-	/* Algorithm from ``Book of iButton Standards''.  */
-	for (index = 0, disc = 0; index < 64; index++) {
-		a = nic_read_bit(ioc3);
-		b = nic_read_bit(ioc3);
-
-		if (a && b) {
-			printk("NIC search failed (not fatal).\n");
-			*last = 0;
-			return 0;
-		}
-
-		if (!a && !b) {
-			if (index == *last) {
-				address |= 1UL << index;
-			} else if (index > *last) {
-				address &= ~(1UL << index);
-				disc = index;
-			} else if ((address & (1UL << index)) == 0)
-				disc = index;
-			nic_write_bit(ioc3, address & (1UL << index));
-			continue;
-		} else {
-			if (a)
-				address |= 1UL << index;
-			else
-				address &= ~(1UL << index);
-			nic_write_bit(ioc3, a);
-			continue;
-		}
-	}
-
-	*last = disc;
-
-	return address;
+	struct ioc3_private *ip = netdev_priv(dev);
+	struct ioc3_ethregs *regs = ip->regs;
+
+	while (readl(&regs->micr) & MICR_BUSY)
+		;
+	writel(data, &regs->midr_w);
+	writel((phy << MICR_PHYADDR_SHIFT) | reg, &regs->micr);
+	while (readl(&regs->micr) & MICR_BUSY)
+		;
 }
 
-static int nic_init(struct ioc3 *ioc3)
+static void ioc3_stop(struct ioc3_private *ip)
 {
-	const char *unknown = "unknown";
-	const char *type = unknown;
-	u8 crc;
-	u8 serial[6];
-	int save = 0, i;
-
-	while (1) {
-		u64 reg;
-		reg = nic_find(ioc3, &save);
-
-		switch (reg & 0xff) {
-		case 0x91:
-			type = "DS1981U";
-			break;
-		default:
-			if (save == 0) {
-				/* Let the caller try again.  */
-				return -1;
-			}
-			continue;
-		}
-
-		nic_reset(ioc3);
-
-		/* Match ROM.  */
-		nic_write_byte(ioc3, 0x55);
-		for (i = 0; i < 8; i++)
-			nic_write_byte(ioc3, (reg >> (i << 3)) & 0xff);
-
-		reg >>= 8; /* Shift out type.  */
-		for (i = 0; i < 6; i++) {
-			serial[i] = reg & 0xff;
-			reg >>= 8;
-		}
-		crc = reg & 0xff;
-		break;
-	}
+	struct ioc3_ethregs *regs = ip->regs;
 
-	printk("Found %s NIC", type);
-	if (type != unknown)
-		printk (" registration number %pM, CRC %02x", serial, crc);
-	printk(".\n");
-
-	return 0;
+	writel(0, &regs->emcr);		/* Shutup */
+	writel(0, &regs->eier);		/* Disable interrupts */
+	(void)readl(&regs->eier);	/* Flush */
 }
 
 /*
- * Read the NIC (Number-In-a-Can) device used to store the MAC address on
- * SN0 / SN00 nodeboards and PCI cards.
+ * Given a multicast ethernet address, this routine calculates the
+ * address's bit index in the logical address filter mask
  */
-static void ioc3_get_eaddr_nic(struct ioc3_private *ip)
+static u32 ioc3_hash(const u8 *addr)
 {
-	struct ioc3 *ioc3 = ip->regs;
-	u8 nic[14];
-	int tries = 2; /* There may be some problem with the battery?  */
-	int i;
-
-	ioc3_w_gpcr_s(1 << 21);
+	u32 crc, temp = 0;
+	int bits;
 
-	while (tries--) {
-		if (!nic_init(ioc3))
-			break;
-		udelay(500);
-	}
+	crc = ether_crc_le(ETH_ALEN, addr);
 
-	if (tries < 0) {
-		printk("Failed to read MAC address\n");
-		return;
+	crc &= 0x3f;    /* bit reverse lowest 6 bits for hash index */
+	for (bits = 6; --bits >= 0; ) {
+		temp <<= 1;
+		temp |= (crc & 0x1);
+		crc >>= 1;
 	}
 
-	/* Read Memory.  */
-	nic_write_byte(ioc3, 0xf0);
-	nic_write_byte(ioc3, 0x00);
-	nic_write_byte(ioc3, 0x00);
-
-	for (i = 13; i >= 0; i--)
-		nic[i] = nic_read_byte(ioc3);
-
-	for (i = 2; i < 8; i++)
-		ip->dev->dev_addr[i - 2] = nic[i];
-}
-
-/*
- * Ok, this is hosed by design.  It's necessary to know what machine the
- * NIC is in in order to know how to read the NIC address.  We also have
- * to know if it's a PCI card or a NIC in on the node board ...
- */
-static void ioc3_get_eaddr(struct ioc3_private *ip)
-{
-	ioc3_get_eaddr_nic(ip);
-
-	printk("Ethernet address is %pM.\n", ip->dev->dev_addr);
-}
-
-static void __ioc3_set_mac_address(struct net_device *dev)
-{
-	struct ioc3_private *ip = netdev_priv(dev);
-	struct ioc3 *ioc3 = ip->regs;
-
-	ioc3_w_emar_h((dev->dev_addr[5] <<  8) | dev->dev_addr[4]);
-	ioc3_w_emar_l((dev->dev_addr[3] << 24) | (dev->dev_addr[2] << 16) |
-	              (dev->dev_addr[1] <<  8) | dev->dev_addr[0]);
+	return temp;
 }
 
-static int ioc3_set_mac_address(struct net_device *dev, void *addr)
+static void ioc3_set_multicast_list(struct net_device *dev)
 {
+	struct netdev_hw_addr *ha;
 	struct ioc3_private *ip = netdev_priv(dev);
-	struct sockaddr *sa = addr;
-
-	memcpy(dev->dev_addr, sa->sa_data, dev->addr_len);
+	struct ioc3_ethregs *regs = ip->regs;
+	u64 ehar = 0;
 
 	spin_lock_irq(&ip->ioc3_lock);
-	__ioc3_set_mac_address(dev);
-	spin_unlock_irq(&ip->ioc3_lock);
-
-	return 0;
-}
-
-/*
- * Caller must hold the ioc3_lock ever for MII readers.  This is also
- * used to protect the transmitter side but it's low contention.
- */
-static int ioc3_mdio_read(struct net_device *dev, int phy, int reg)
-{
-	struct ioc3_private *ip = netdev_priv(dev);
-	struct ioc3 *ioc3 = ip->regs;
-
-	while (ioc3_r_micr() & MICR_BUSY);
-	ioc3_w_micr((phy << MICR_PHYADDR_SHIFT) | reg | MICR_READTRIG);
-	while (ioc3_r_micr() & MICR_BUSY);
-
-	return ioc3_r_midr_r() & MIDR_DATA_MASK;
-}
-
-static void ioc3_mdio_write(struct net_device *dev, int phy, int reg, int data)
-{
-	struct ioc3_private *ip = netdev_priv(dev);
-	struct ioc3 *ioc3 = ip->regs;
-
-	while (ioc3_r_micr() & MICR_BUSY);
-	ioc3_w_midr_w(data);
-	ioc3_w_micr((phy << MICR_PHYADDR_SHIFT) | reg);
-	while (ioc3_r_micr() & MICR_BUSY);
-}
-
-static int ioc3_mii_init(struct ioc3_private *ip);
+	if (dev->flags & IFF_PROMISC) {		/* Set promiscuous.  */
+		ip->emcr |= EMCR_PROMISC;
+		writel(ip->emcr, &regs->emcr);
+		(void)readl(&regs->emcr);
+	} else {
+		ip->emcr &= ~EMCR_PROMISC;
+		writel(ip->emcr, &regs->emcr);	/* Clear promiscuous. */
+		(void)readl(&regs->emcr);
 
-static struct net_device_stats *ioc3_get_stats(struct net_device *dev)
-{
-	struct ioc3_private *ip = netdev_priv(dev);
-	struct ioc3 *ioc3 = ip->regs;
+		if ((dev->flags & IFF_ALLMULTI) ||
+		    (netdev_mc_count(dev) > 64)) {
+			/* Too many for hashing to make sense or we want all
+			 * multicast packets anyway,  so skip computing all
+			 * the hashes and just accept all packets.
+			 */
+			ip->ehar_h = 0xffffffff;
+			ip->ehar_l = 0xffffffff;
+		} else {
+			netdev_for_each_mc_addr(ha, dev) {
+				ehar |= (1UL << ioc3_hash(ha->addr));
+			}
+			ip->ehar_h = ehar >> 32;
+			ip->ehar_l = ehar & 0xffffffff;
+		}
+		writel(ip->ehar_h, &regs->ehar_h);
+		writel(ip->ehar_l, &regs->ehar_l);
+	}
 
-	dev->stats.collisions += (ioc3_r_etcdc() & ETCDC_COLLCNT_MASK);
-	return &dev->stats;
+	spin_unlock_irq(&ip->ioc3_lock);
 }
 
 static void ioc3_tcpudp_checksum(struct sk_buff *skb, uint32_t hwsum, int len)
 {
 	struct ethhdr *eh = eth_hdr(skb);
-	uint32_t csum, ehsum;
-	unsigned int proto;
 	struct iphdr *ih;
-	uint16_t *ew;
-	unsigned char *cp;
+	u8 *cp;
+	u16 *ew;
+	u32 csum, ehsum, proto;
 
 	/*
 	 * Did hardware handle the checksum at all?  The cases we can handle
@@ -568,277 +304,95 @@ static void ioc3_tcpudp_checksum(struct sk_buff *skb, uint32_t hwsum, int len)
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 }
 
-static inline void ioc3_rx(struct net_device *dev)
-{
-	struct ioc3_private *ip = netdev_priv(dev);
-	struct sk_buff *skb, *new_skb;
-	struct ioc3 *ioc3 = ip->regs;
-	int rx_entry, n_entry, len;
-	struct ioc3_erxbuf *rxb;
-	unsigned long *rxr;
-	u32 w0, err;
+#define ETCSR_FD ((17 << ETCSR_IPGR2_SHIFT) | (11 << ETCSR_IPGR1_SHIFT) | 21)
+#define ETCSR_HD ((21 << ETCSR_IPGR2_SHIFT) | (21 << ETCSR_IPGR1_SHIFT) | 21)
 
-	rxr = ip->rxr;		/* Ring base */
-	rx_entry = ip->rx_ci;				/* RX consume index */
-	n_entry = ip->rx_pi;
+static void ioc3_setup_duplex(struct ioc3_private *ip)
+{
+	struct ioc3_ethregs *regs = ip->regs;
 
-	skb = ip->rx_skbs[rx_entry];
-	rxb = (struct ioc3_erxbuf *) (skb->data - RX_OFFSET);
-	w0 = be32_to_cpu(rxb->w0);
+	if (ip->mii.full_duplex) {
+		writel(ETCSR_FD, &regs->etcsr);
+		ip->emcr |= EMCR_DUPLEX;
+	} else {
+		writel(ETCSR_HD, &regs->etcsr);
+		ip->emcr &= ~EMCR_DUPLEX;
+	}
+	writel(ip->emcr, &regs->emcr);
+	(void)readl(&regs->emcr);
+}
 
-	while (w0 & ERXBUF_V) {
-		err = be32_to_cpu(rxb->err);		/* It's valid ...  */
-		if (err & ERXBUF_GOODPKT) {
-			len = ((w0 >> ERXBUF_BYTECNT_SHIFT) & 0x7ff) - 4;
-			skb_trim(skb, len);
-			skb->protocol = eth_type_trans(skb, dev);
+static void ioc3_timer(struct timer_list *t)
+{
+	struct ioc3_private *ip = from_timer(ip, t, ioc3_timer);
 
-			new_skb = ioc3_alloc_skb(RX_BUF_ALLOC_SIZE, GFP_ATOMIC);
-			if (!new_skb) {
-				/* Ouch, drop packet and just recycle packet
-				   to keep the ring filled.  */
-				dev->stats.rx_dropped++;
-				new_skb = skb;
-				goto next;
-			}
+	/* Print the link status if it has changed */
+	mii_check_media(&ip->mii, 1, 0);
+	ioc3_setup_duplex(ip);
 
-			if (likely(dev->features & NETIF_F_RXCSUM))
-				ioc3_tcpudp_checksum(skb,
-					w0 & ERXBUF_IPCKSUM_MASK, len);
+	ip->ioc3_timer.expires = jiffies + ((12 * HZ) / 10); /* 1.2s */
+	add_timer(&ip->ioc3_timer);
+}
 
-			netif_rx(skb);
+/* Try to find a PHY.  There is no apparent relation between the MII addresses
+ * in the SGI documentation and what we find in reality, so we simply probe
+ * for the PHY.  It seems IOC3 PHYs usually live on address 31.  One of my
+ * onboard IOC3s has the special oddity that probing doesn't seem to find it
+ * yet the interface seems to work fine, so if probing fails we for now will
+ * simply default to PHY 31 instead of bailing out.
+ */
+static int ioc3_mii_init(struct ioc3_private *ip)
+{
+	int i, found = 0, res = 0;
+	int ioc3_phy_workaround = 1;
+	u16 word;
 
-			ip->rx_skbs[rx_entry] = NULL;	/* Poison  */
+	for (i = 0; i < 32; i++) {
+		word = ioc3_mdio_read(ip->mii.dev, i, MII_PHYSID1);
 
-			/* Because we reserve afterwards. */
-			skb_put(new_skb, (1664 + RX_OFFSET));
-			rxb = (struct ioc3_erxbuf *) new_skb->data;
-			skb_reserve(new_skb, RX_OFFSET);
+		if (word != 0xffff && word != 0x0000) {
+			found = 1;
+			break;  /* Found a PHY */
+		}
+	}
 
-			dev->stats.rx_packets++;		/* Statistics */
-			dev->stats.rx_bytes += len;
+	if (!found) {
+		if (ioc3_phy_workaround) {
+			i = 31;
 		} else {
-			/* The frame is invalid and the skb never
-			   reached the network layer so we can just
-			   recycle it.  */
-			new_skb = skb;
-			dev->stats.rx_errors++;
+			ip->mii.phy_id = -1;
+			res = -ENODEV;
+			goto out;
 		}
-		if (err & ERXBUF_CRCERR)	/* Statistics */
-			dev->stats.rx_crc_errors++;
-		if (err & ERXBUF_FRAMERR)
-			dev->stats.rx_frame_errors++;
-next:
-		ip->rx_skbs[n_entry] = new_skb;
-		rxr[n_entry] = cpu_to_be64(ioc3_map(rxb, 1));
-		rxb->w0 = 0;				/* Clear valid flag */
-		n_entry = (n_entry + 1) & 511;		/* Update erpir */
-
-		/* Now go on to the next ring entry.  */
-		rx_entry = (rx_entry + 1) & 511;
-		skb = ip->rx_skbs[rx_entry];
-		rxb = (struct ioc3_erxbuf *) (skb->data - RX_OFFSET);
-		w0 = be32_to_cpu(rxb->w0);
 	}
-	ioc3_w_erpir((n_entry << 3) | ERPIR_ARM);
-	ip->rx_pi = n_entry;
-	ip->rx_ci = rx_entry;
+
+	ip->mii.phy_id = i;
+
+out:
+	return res;
 }
 
-static inline void ioc3_tx(struct net_device *dev)
+static void ioc3_mii_start(struct ioc3_private *ip)
+{
+	ip->ioc3_timer.expires = jiffies + (12 * HZ) / 10;  /* 1.2 sec. */
+	add_timer(&ip->ioc3_timer);
+}
+
+static void ioc3_clean_rx_ring(struct ioc3_private *ip)
 {
-	struct ioc3_private *ip = netdev_priv(dev);
-	unsigned long packets, bytes;
-	struct ioc3 *ioc3 = ip->regs;
-	int tx_entry, o_entry;
 	struct sk_buff *skb;
-	u32 etcir;
+	struct ioc3_erxbuf *rxb;
+	int i;
 
-	spin_lock(&ip->ioc3_lock);
-	etcir = ioc3_r_etcir();
-
-	tx_entry = (etcir >> 7) & 127;
-	o_entry = ip->tx_ci;
-	packets = 0;
-	bytes = 0;
-
-	while (o_entry != tx_entry) {
-		packets++;
-		skb = ip->tx_skbs[o_entry];
-		bytes += skb->len;
-		dev_consume_skb_irq(skb);
-		ip->tx_skbs[o_entry] = NULL;
-
-		o_entry = (o_entry + 1) & 127;		/* Next */
-
-		etcir = ioc3_r_etcir();			/* More pkts sent?  */
-		tx_entry = (etcir >> 7) & 127;
-	}
-
-	dev->stats.tx_packets += packets;
-	dev->stats.tx_bytes += bytes;
-	ip->txqlen -= packets;
-
-	if (ip->txqlen < 128)
-		netif_wake_queue(dev);
-
-	ip->tx_ci = o_entry;
-	spin_unlock(&ip->ioc3_lock);
-}
-
-/*
- * Deal with fatal IOC3 errors.  This condition might be caused by a hard or
- * software problems, so we should try to recover
- * more gracefully if this ever happens.  In theory we might be flooded
- * with such error interrupts if something really goes wrong, so we might
- * also consider to take the interface down.
- */
-static void ioc3_error(struct net_device *dev, u32 eisr)
-{
-	struct ioc3_private *ip = netdev_priv(dev);
-	unsigned char *iface = dev->name;
-
-	spin_lock(&ip->ioc3_lock);
-
-	if (eisr & EISR_RXOFLO)
-		printk(KERN_ERR "%s: RX overflow.\n", iface);
-	if (eisr & EISR_RXBUFOFLO)
-		printk(KERN_ERR "%s: RX buffer overflow.\n", iface);
-	if (eisr & EISR_RXMEMERR)
-		printk(KERN_ERR "%s: RX PCI error.\n", iface);
-	if (eisr & EISR_RXPARERR)
-		printk(KERN_ERR "%s: RX SSRAM parity error.\n", iface);
-	if (eisr & EISR_TXBUFUFLO)
-		printk(KERN_ERR "%s: TX buffer underflow.\n", iface);
-	if (eisr & EISR_TXMEMERR)
-		printk(KERN_ERR "%s: TX PCI error.\n", iface);
-
-	ioc3_stop(ip);
-	ioc3_init(dev);
-	ioc3_mii_init(ip);
-
-	netif_wake_queue(dev);
-
-	spin_unlock(&ip->ioc3_lock);
-}
-
-/* The interrupt handler does all of the Rx thread work and cleans up
-   after the Tx thread.  */
-static irqreturn_t ioc3_interrupt(int irq, void *_dev)
-{
-	struct net_device *dev = (struct net_device *)_dev;
-	struct ioc3_private *ip = netdev_priv(dev);
-	struct ioc3 *ioc3 = ip->regs;
-	const u32 enabled = EISR_RXTIMERINT | EISR_RXOFLO | EISR_RXBUFOFLO |
-	                    EISR_RXMEMERR | EISR_RXPARERR | EISR_TXBUFUFLO |
-	                    EISR_TXEXPLICIT | EISR_TXMEMERR;
-	u32 eisr;
-
-	eisr = ioc3_r_eisr() & enabled;
-
-	ioc3_w_eisr(eisr);
-	(void) ioc3_r_eisr();				/* Flush */
-
-	if (eisr & (EISR_RXOFLO | EISR_RXBUFOFLO | EISR_RXMEMERR |
-	            EISR_RXPARERR | EISR_TXBUFUFLO | EISR_TXMEMERR))
-		ioc3_error(dev, eisr);
-	if (eisr & EISR_RXTIMERINT)
-		ioc3_rx(dev);
-	if (eisr & EISR_TXEXPLICIT)
-		ioc3_tx(dev);
-
-	return IRQ_HANDLED;
-}
-
-static inline void ioc3_setup_duplex(struct ioc3_private *ip)
-{
-	struct ioc3 *ioc3 = ip->regs;
-
-	if (ip->mii.full_duplex) {
-		ioc3_w_etcsr(ETCSR_FD);
-		ip->emcr |= EMCR_DUPLEX;
-	} else {
-		ioc3_w_etcsr(ETCSR_HD);
-		ip->emcr &= ~EMCR_DUPLEX;
-	}
-	ioc3_w_emcr(ip->emcr);
-}
-
-static void ioc3_timer(struct timer_list *t)
-{
-	struct ioc3_private *ip = from_timer(ip, t, ioc3_timer);
-
-	/* Print the link status if it has changed */
-	mii_check_media(&ip->mii, 1, 0);
-	ioc3_setup_duplex(ip);
-
-	ip->ioc3_timer.expires = jiffies + ((12 * HZ)/10); /* 1.2s */
-	add_timer(&ip->ioc3_timer);
-}
-
-/*
- * Try to find a PHY.  There is no apparent relation between the MII addresses
- * in the SGI documentation and what we find in reality, so we simply probe
- * for the PHY.  It seems IOC3 PHYs usually live on address 31.  One of my
- * onboard IOC3s has the special oddity that probing doesn't seem to find it
- * yet the interface seems to work fine, so if probing fails we for now will
- * simply default to PHY 31 instead of bailing out.
- */
-static int ioc3_mii_init(struct ioc3_private *ip)
-{
-	int i, found = 0, res = 0;
-	int ioc3_phy_workaround = 1;
-	u16 word;
-
-	for (i = 0; i < 32; i++) {
-		word = ioc3_mdio_read(ip->dev, i, MII_PHYSID1);
-
-		if (word != 0xffff && word != 0x0000) {
-			found = 1;
-			break;			/* Found a PHY		*/
-		}
-	}
-
-	if (!found) {
-		if (ioc3_phy_workaround)
-			i = 31;
-		else {
-			ip->mii.phy_id = -1;
-			res = -ENODEV;
-			goto out;
-		}
-	}
-
-	ip->mii.phy_id = i;
-
-out:
-	return res;
-}
-
-static void ioc3_mii_start(struct ioc3_private *ip)
-{
-	ip->ioc3_timer.expires = jiffies + (12 * HZ)/10;  /* 1.2 sec. */
-	add_timer(&ip->ioc3_timer);
-}
-
-static inline void ioc3_clean_rx_ring(struct ioc3_private *ip)
-{
-	struct sk_buff *skb;
-	int i;
-
-	for (i = ip->rx_ci; i & 15; i++) {
-		ip->rx_skbs[ip->rx_pi] = ip->rx_skbs[ip->rx_ci];
-		ip->rxr[ip->rx_pi++] = ip->rxr[ip->rx_ci++];
-	}
-	ip->rx_pi &= 511;
-	ip->rx_ci &= 511;
-
-	for (i = ip->rx_ci; i != ip->rx_pi; i = (i+1) & 511) {
-		struct ioc3_erxbuf *rxb;
+	for (i = 0; i < RX_BUFFS; i++) {
 		skb = ip->rx_skbs[i];
-		rxb = (struct ioc3_erxbuf *) (skb->data - RX_OFFSET);
-		rxb->w0 = 0;
+		if (skb) {
+			rxb = (struct ioc3_erxbuf *)(skb->data - RX_OFFSET);
+			rxb->w0 = 0;
+		}
 	}
+	ip->rx_ci = 0;
+	ip->rx_pi = RX_BUFFS - 16;
 }
 
 static inline void ioc3_clean_tx_ring(struct ioc3_private *ip)
@@ -846,7 +400,7 @@ static inline void ioc3_clean_tx_ring(struct ioc3_private *ip)
 	struct sk_buff *skb;
 	int i;
 
-	for (i=0; i < 128; i++) {
+	for (i = 0; i < TX_BUFFS; i++) {
 		skb = ip->tx_skbs[i];
 		if (skb) {
 			ip->tx_skbs[i] = NULL;
@@ -861,7 +415,7 @@ static inline void ioc3_clean_tx_ring(struct ioc3_private *ip)
 static void ioc3_free_rings(struct ioc3_private *ip)
 {
 	struct sk_buff *skb;
-	int rx_entry, n_entry;
+	int i;
 
 	if (ip->txr) {
 		ioc3_clean_tx_ring(ip);
@@ -870,15 +424,10 @@ static void ioc3_free_rings(struct ioc3_private *ip)
 	}
 
 	if (ip->rxr) {
-		n_entry = ip->rx_ci;
-		rx_entry = ip->rx_pi;
-
-		while (n_entry != rx_entry) {
-			skb = ip->rx_skbs[n_entry];
+		for (i = 0; i < RX_BUFFS; i++) {
+			skb = ip->rx_skbs[i];
 			if (skb)
 				dev_kfree_skb_any(skb);
-
-			n_entry = (n_entry + 1) & 511;
 		}
 		free_page((unsigned long)ip->rxr);
 		ip->rxr = NULL;
@@ -897,15 +446,16 @@ static void ioc3_alloc_rings(struct net_device *dev)
 		ip->rxr = (unsigned long *) get_zeroed_page(GFP_ATOMIC);
 		rxr = ip->rxr;
 		if (!rxr)
-			printk("ioc3_alloc_rings(): get_zeroed_page() failed!\n");
+			printk(KERN_ERR "ioc3_alloc_rings(): get_zeroed_page() failed!\n");
 
-		/* Now the rx buffers.  The RX ring may be larger but
-		   we only allocate 16 buffers for now.  Need to tune
-		   this for performance and memory later.  */
+		/* Now the rx buffers.  The RX ring may be larger but we
+		 * only allocate RX_BUFFS buffers for now.  Need to tune
+		 * this for performance and memory later.
+		 */
 		for (i = 0; i < RX_BUFFS; i++) {
 			struct sk_buff *skb;
 
-			skb = ioc3_alloc_skb(RX_BUF_ALLOC_SIZE, GFP_ATOMIC);
+			skb = ioc3_alloc_skb(dev);
 			if (!skb) {
 				show_free_areas(0, NULL);
 				continue;
@@ -914,141 +464,135 @@ static void ioc3_alloc_rings(struct net_device *dev)
 			ip->rx_skbs[i] = skb;
 
 			/* Because we reserve afterwards. */
-			skb_put(skb, (1664 + RX_OFFSET));
+			skb_put(skb, (RX_BUF_SIZE + RX_OFFSET));
 			rxb = (struct ioc3_erxbuf *) skb->data;
-			rxr[i] = cpu_to_be64(ioc3_map(rxb, 1));
+			rxr[i] = cpu_to_be64(ioc3_map(rxb, PCI64_ATTR_BAR));
 			skb_reserve(skb, RX_OFFSET);
 		}
-		ip->rx_ci = 0;
-		ip->rx_pi = RX_BUFFS;
 	}
 
 	if (ip->txr == NULL) {
 		/* Allocate and initialize tx rings.  16kb = 128 bufs.  */
-		ip->txr = (struct ioc3_etxd *)__get_free_pages(GFP_KERNEL, 2);
+		ip->txr = (struct ioc3_etxd *)__get_free_pages((GFP_ATOMIC |
+								__GFP_ZERO), 2);
 		if (!ip->txr)
-			printk("ioc3_alloc_rings(): __get_free_pages() failed!\n");
-		ip->tx_pi = 0;
-		ip->tx_ci = 0;
+			printk(KERN_ERR "ioc3_alloc_rings(): __get_free_pages() failed!\n");
 	}
 }
 
 static void ioc3_init_rings(struct net_device *dev)
 {
 	struct ioc3_private *ip = netdev_priv(dev);
-	struct ioc3 *ioc3 = ip->regs;
+	struct ioc3_ethregs *regs = ip->regs;
 	unsigned long ring;
 
 	ioc3_free_rings(ip);
 	ioc3_alloc_rings(dev);
-
 	ioc3_clean_rx_ring(ip);
 	ioc3_clean_tx_ring(ip);
 
 	/* Now the rx ring base, consume & produce registers.  */
-	ring = ioc3_map(ip->rxr, 0);
-	ioc3_w_erbr_h(ring >> 32);
-	ioc3_w_erbr_l(ring & 0xffffffff);
-	ioc3_w_ercir(ip->rx_ci << 3);
-	ioc3_w_erpir((ip->rx_pi << 3) | ERPIR_ARM);
-
-	ring = ioc3_map(ip->txr, 0);
-
-	ip->txqlen = 0;					/* nothing queued  */
+	ring = ioc3_map(ip->rxr, PCI64_ATTR_VIRTUAL | PCI64_ATTR_PREC);
+	writel(ring >> 32, &regs->erbr_h);
+	writel(ring & 0xffffffff, &regs->erbr_l);
+	writel(ip->rx_ci << 3, &regs->ercir);
+	writel((ip->rx_pi << 3) | ERPIR_ARM, &regs->erpir);
 
 	/* Now the tx ring base, consume & produce registers.  */
-	ioc3_w_etbr_h(ring >> 32);
-	ioc3_w_etbr_l(ring & 0xffffffff);
-	ioc3_w_etpir(ip->tx_pi << 7);
-	ioc3_w_etcir(ip->tx_ci << 7);
-	(void) ioc3_r_etcir();				/* Flush */
+	ring = ioc3_map(ip->txr, PCI64_ATTR_VIRTUAL | PCI64_ATTR_PREC);
+	ip->txbfree = TX_BUFFS;  /* nothing queued  */
+	writel(ring >> 32, &regs->etbr_h);
+	writel(ring & 0xffffffff, &regs->etbr_l);
+	writel(ip->tx_pi << 7, &regs->etpir);
+	writel(ip->tx_ci << 7, &regs->etcir);
+	(void)readl(&regs->etcir);  /* Flush */
 }
 
-static inline void ioc3_ssram_disc(struct ioc3_private *ip)
+static void ioc3_ssram_disc(struct ioc3_private *ip)
 {
-	struct ioc3 *ioc3 = ip->regs;
-	volatile u32 *ssram0 = &ioc3->ssram[0x0000];
-	volatile u32 *ssram1 = &ioc3->ssram[0x4000];
-	unsigned int pattern = 0x5555;
+	struct ioc3_ethregs *regs = ip->regs;
+	u32 *emcr_p = &regs->emcr;
+	u32 *ssram0 = &ip->ssram[0x0000];
+	u32 *ssram1 = &ip->ssram[0x4000];
+	const u32 pattern0 = 0x5555;
+	const u32 pattern1 = ~pattern0 & IOC3_SSRAM_DM;
 
 	/* Assume the larger size SSRAM and enable parity checking */
-	ioc3_w_emcr(ioc3_r_emcr() | (EMCR_BUFSIZ | EMCR_RAMPAR));
+	writel(readl(emcr_p) | EMCR_BUFSIZ | EMCR_RAMPAR, emcr_p);
+	(void)readl(emcr_p);
 
-	*ssram0 = pattern;
-	*ssram1 = ~pattern & IOC3_SSRAM_DM;
+	writel(pattern0, ssram0);
+	writel(pattern1, ssram1);
 
-	if ((*ssram0 & IOC3_SSRAM_DM) != pattern ||
-	    (*ssram1 & IOC3_SSRAM_DM) != (~pattern & IOC3_SSRAM_DM)) {
+	if (((readl(ssram0) & IOC3_SSRAM_DM) != pattern0) ||
+	    ((readl(ssram1) & IOC3_SSRAM_DM) != pattern1)) {
 		/* set ssram size to 64 KB */
-		ip->emcr = EMCR_RAMPAR;
-		ioc3_w_emcr(ioc3_r_emcr() & ~EMCR_BUFSIZ);
-	} else
-		ip->emcr = EMCR_BUFSIZ | EMCR_RAMPAR;
+		ip->emcr |= EMCR_RAMPAR;
+		writel(readl(emcr_p) & ~EMCR_BUFSIZ, emcr_p);
+		(void)readl(emcr_p);
+	} else {
+		ip->emcr |= EMCR_RAMPAR | EMCR_BUFSIZ;
+	}
 }
 
 static void ioc3_init(struct net_device *dev)
 {
 	struct ioc3_private *ip = netdev_priv(dev);
-	struct ioc3 *ioc3 = ip->regs;
+	struct ioc3_ethregs *regs = ip->regs;
 
 	del_timer_sync(&ip->ioc3_timer);	/* Kill if running	*/
 
-	ioc3_w_emcr(EMCR_RST);			/* Reset		*/
-	(void) ioc3_r_emcr();			/* Flush WB		*/
-	udelay(4);				/* Give it time ...	*/
-	ioc3_w_emcr(0);
-	(void) ioc3_r_emcr();
+	writel(EMCR_RST, &regs->emcr);		/* Reset */
+	(void)readl(&regs->emcr);		/* Flush WB */
+	udelay(4);				/* Give it time... */
+	writel(0, &regs->emcr);
+	(void)readl(&regs->emcr);
 
 	/* Misc registers  */
 #ifdef CONFIG_SGI_IP27
-	ioc3_w_erbar(PCI64_ATTR_BAR >> 32);	/* Barrier on last store */
+	/* Barrier on last store */
+	writel(readl(&regs->erbar) |
+		(ERBAR_BARRIER_BIT << ERBAR_RXBARR_SHIFT), &regs->erbar);
 #else
-	ioc3_w_erbar(0);			/* Let PCI API get it right */
+	/* Let PCI API get it right */
+	writel(0, &regs->erbar);
 #endif
-	(void) ioc3_r_etcdc();			/* Clear on read */
-	ioc3_w_ercsr(15);			/* RX low watermark  */
-	ioc3_w_ertr(0);				/* Interrupt immediately */
-	__ioc3_set_mac_address(dev);
-	ioc3_w_ehar_h(ip->ehar_h);
-	ioc3_w_ehar_l(ip->ehar_l);
-	ioc3_w_ersr(42);			/* XXX should be random */
+	readl(&regs->etcdc);			/* Clear on read */
+	writel(15, &regs->ercsr);		/* RX low watermark  */
+	writel(1, &regs->ertr);			/* Interrupt immediately */
+	__ioc3_set_mac_address(dev, regs);
+	writel(ip->ehar_h, &regs->ehar_h);
+	writel(ip->ehar_l, &regs->ehar_l);
+	writel(42, &regs->ersr);		/* XXX Should be random */
 
 	ioc3_init_rings(dev);
 
-	ip->emcr |= ((RX_OFFSET / 2) << EMCR_RXOFF_SHIFT) | EMCR_TXDMAEN |
-	             EMCR_TXEN | EMCR_RXDMAEN | EMCR_RXEN | EMCR_PADEN;
-	ioc3_w_emcr(ip->emcr);
-	ioc3_w_eier(EISR_RXTIMERINT | EISR_RXOFLO | EISR_RXBUFOFLO |
-	            EISR_RXMEMERR | EISR_RXPARERR | EISR_TXBUFUFLO |
-	            EISR_TXEXPLICIT | EISR_TXMEMERR);
-	(void) ioc3_r_eier();
-}
-
-static inline void ioc3_stop(struct ioc3_private *ip)
-{
-	struct ioc3 *ioc3 = ip->regs;
-
-	ioc3_w_emcr(0);				/* Shutup */
-	ioc3_w_eier(0);				/* Disable interrupts */
-	(void) ioc3_r_eier();			/* Flush */
+	ip->emcr |= ((RX_OFFSET / 2) << EMCR_RXOFF_SHIFT) |
+			EMCR_TXDMAEN | EMCR_TXEN |
+			EMCR_RXDMAEN | EMCR_RXEN |
+			EMCR_PADEN;
+	writel(ip->emcr, &regs->emcr);
+	readl(&regs->emcr);
+	writel(EISR_RXTIMERINT | EISR_RXTHRESHINT |
+		EISR_RXOFLO | EISR_RXBUFOFLO |
+		EISR_RXMEMERR | EISR_RXPARERR |
+		EISR_TXEXDEF |
+		EISR_TXBUFUFLO |
+		EISR_TXMEMERR, &regs->eier);
+	readl(&regs->eier);
 }
 
 static int ioc3_open(struct net_device *dev)
 {
 	struct ioc3_private *ip = netdev_priv(dev);
 
-	if (request_irq(dev->irq, ioc3_interrupt, IRQF_SHARED, ioc3_str, dev)) {
-		printk(KERN_ERR "%s: Can't get irq %d\n", dev->name, dev->irq);
-
-		return -EAGAIN;
-	}
-
 	ip->ehar_h = 0;
 	ip->ehar_l = 0;
 	ioc3_init(dev);
+	ioc3_mii_init(ip);
 	ioc3_mii_start(ip);
-
 	netif_start_queue(dev);
+
 	return 0;
 }
 
@@ -1061,444 +605,152 @@ static int ioc3_close(struct net_device *dev)
 	netif_stop_queue(dev);
 
 	ioc3_stop(ip);
-	free_irq(dev->irq, dev);
+	ioc3_free_rings(ip);
 
 	ioc3_free_rings(ip);
 	return 0;
 }
 
-/*
- * MENET cards have four IOC3 chips, which are attached to two sets of
- * PCI slot resources each: the primary connections are on slots
- * 0..3 and the secondaries are on 4..7
- *
- * All four ethernets are brought out to connectors; six serial ports
- * (a pair from each of the first three IOC3s) are brought out to
- * MiniDINs; all other subdevices are left swinging in the wind, leave
- * them disabled.
- */
-
-static int ioc3_adjacent_is_ioc3(struct pci_dev *pdev, int slot)
+static netdev_tx_t ioc3_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
-	struct pci_dev *dev = pci_get_slot(pdev->bus, PCI_DEVFN(slot, 0));
-	int ret = 0;
-
-	if (dev) {
-		if (dev->vendor == PCI_VENDOR_ID_SGI &&
-			dev->device == PCI_DEVICE_ID_SGI_IOC3)
-			ret = 1;
-		pci_dev_put(dev);
-	}
-
-	return ret;
-}
+	struct ioc3_private *ip = netdev_priv(dev);
+	struct ioc3_etxd *desc;
+	unsigned long data;
+	u32 len, w0 = 0;
+	int produce;
 
-static int ioc3_is_menet(struct pci_dev *pdev)
-{
-	return pdev->bus->parent == NULL &&
-	       ioc3_adjacent_is_ioc3(pdev, 0) &&
-	       ioc3_adjacent_is_ioc3(pdev, 1) &&
-	       ioc3_adjacent_is_ioc3(pdev, 2);
-}
+	/* IOC3 has a fairly simple minded checksumming hardware which simply
+	 * adds up the 1's complement checksum for the entire packet and
+	 * inserts it at an offset which can be specified in the descriptor
+	 * into the transmit packet.  This means we have to compensate for the
+	 * MAC header which should not be summed and the TCP/UDP pseudo headers
+	 * manually.
+	 */
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		struct iphdr *ih = ip_hdr(skb);
+		u32 proto = ntohs(ih->protocol);
+		u32 csoff, csum, ehsum;
+		u16 *eh;
 
-#ifdef CONFIG_SERIAL_8250
-/*
- * Note about serial ports and consoles:
- * For console output, everyone uses the IOC3 UARTA (offset 0x178)
- * connected to the master node (look in ip27_setup_console() and
- * ip27prom_console_write()).
- *
- * For serial (/dev/ttyS0 etc), we can not have hardcoded serial port
- * addresses on a partitioned machine. Since we currently use the ioc3
- * serial ports, we use dynamic serial port discovery that the serial.c
- * driver uses for pci/pnp ports (there is an entry for the SGI ioc3
- * boards in pci_boards[]). Unfortunately, UARTA's pio address is greater
- * than UARTB's, although UARTA on o200s has traditionally been known as
- * port 0. So, we just use one serial port from each ioc3 (since the
- * serial driver adds addresses to get to higher ports).
- *
- * The first one to do a register_console becomes the preferred console
- * (if there is no kernel command line console= directive). /dev/console
- * (ie 5, 1) is then "aliased" into the device number returned by the
- * "device" routine referred to in this console structure
- * (ip27prom_console_dev).
- *
- * Also look in ip27-pci.c:pci_fixup_ioc3() for some comments on working
- * around ioc3 oddities in this respect.
- *
- * The IOC3 serials use a 22MHz clock rate with an additional divider which
- * can be programmed in the SCR register if the DLAB bit is set.
- *
- * Register to interrupt zero because we share the interrupt with
- * the serial driver which we don't properly support yet.
- *
- * Can't use UPF_IOREMAP as the whole of IOC3 resources have already been
- * registered.
- */
-static void ioc3_8250_register(struct ioc3_uartregs __iomem *uart)
-{
-#define COSMISC_CONSTANT 6
-
-	struct uart_8250_port port = {
-	        .port = {
-			.irq		= 0,
-			.flags		= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF,
-			.iotype		= UPIO_MEM,
-			.regshift	= 0,
-			.uartclk	= (22000000 << 1) / COSMISC_CONSTANT,
-
-			.membase	= (unsigned char __iomem *) uart,
-			.mapbase	= (unsigned long) uart,
-                }
-	};
-	unsigned char lcr;
-
-	lcr = uart->iu_lcr;
-	uart->iu_lcr = lcr | UART_LCR_DLAB;
-	uart->iu_scr = COSMISC_CONSTANT,
-	uart->iu_lcr = lcr;
-	uart->iu_lcr;
-	serial8250_register_8250_port(&port);
-}
+		/* The MAC header.  skb->mac seems the logical approach
+		 * to find the MAC header.  Except if it's a NULL pointer...
+		 */
+		eh = (u16 *)skb->data;
 
-static void ioc3_serial_probe(struct pci_dev *pdev, struct ioc3 *ioc3)
-{
-	/*
-	 * We need to recognice and treat the fourth MENET serial as it
-	 * does not have an SuperIO chip attached to it, therefore attempting
-	 * to access it will result in bus errors.  We call something an
-	 * MENET if PCI slot 0, 1, 2 and 3 of a master PCI bus all have an IOC3
-	 * in it.  This is paranoid but we want to avoid blowing up on a
-	 * showhorn PCI box that happens to have 4 IOC3 cards in it so it's
-	 * not paranoid enough ...
-	 */
-	if (ioc3_is_menet(pdev) && PCI_SLOT(pdev->devfn) == 3)
-		return;
+		/* Sum up dest addr, src addr and protocol  */
+		ehsum = eh[0] + eh[1] + eh[2] + eh[3] + eh[4] + eh[5] + eh[6];
 
-	/*
-	 * Switch IOC3 to PIO mode.  It probably already was but let's be
-	 * paranoid
-	 */
-	ioc3->gpcr_s = GPCR_UARTA_MODESEL | GPCR_UARTB_MODESEL;
-	ioc3->gpcr_s;
-	ioc3->gppr_6 = 0;
-	ioc3->gppr_6;
-	ioc3->gppr_7 = 0;
-	ioc3->gppr_7;
-	ioc3->sscr_a = ioc3->sscr_a & ~SSCR_DMA_EN;
-	ioc3->sscr_a;
-	ioc3->sscr_b = ioc3->sscr_b & ~SSCR_DMA_EN;
-	ioc3->sscr_b;
-	/* Disable all SA/B interrupts except for SA/B_INT in SIO_IEC. */
-	ioc3->sio_iec &= ~ (SIO_IR_SA_TX_MT | SIO_IR_SA_RX_FULL |
-			    SIO_IR_SA_RX_HIGH | SIO_IR_SA_RX_TIMER |
-			    SIO_IR_SA_DELTA_DCD | SIO_IR_SA_DELTA_CTS |
-			    SIO_IR_SA_TX_EXPLICIT | SIO_IR_SA_MEMERR);
-	ioc3->sio_iec |= SIO_IR_SA_INT;
-	ioc3->sscr_a = 0;
-	ioc3->sio_iec &= ~ (SIO_IR_SB_TX_MT | SIO_IR_SB_RX_FULL |
-			    SIO_IR_SB_RX_HIGH | SIO_IR_SB_RX_TIMER |
-			    SIO_IR_SB_DELTA_DCD | SIO_IR_SB_DELTA_CTS |
-			    SIO_IR_SB_TX_EXPLICIT | SIO_IR_SB_MEMERR);
-	ioc3->sio_iec |= SIO_IR_SB_INT;
-	ioc3->sscr_b = 0;
-
-	ioc3_8250_register(&ioc3->sregs.uarta);
-	ioc3_8250_register(&ioc3->sregs.uartb);
-}
-#endif
+		/* Skip IP header; it's sum is always zero and was already
+		 * filled in by ip_output.c
+		 */
+		csum = csum_tcpudp_nofold(ih->saddr, ih->daddr,
+					  ih->tot_len - (ih->ihl << 2),
+					  proto, csum_fold(ehsum));
 
-static const struct net_device_ops ioc3_netdev_ops = {
-	.ndo_open		= ioc3_open,
-	.ndo_stop		= ioc3_close,
-	.ndo_start_xmit		= ioc3_start_xmit,
-	.ndo_tx_timeout		= ioc3_timeout,
-	.ndo_get_stats		= ioc3_get_stats,
-	.ndo_set_rx_mode	= ioc3_set_multicast_list,
-	.ndo_do_ioctl		= ioc3_ioctl,
-	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_set_mac_address	= ioc3_set_mac_address,
-};
+		csum = (csum & 0xffff) + (csum >> 16); /* Fold again */
+		csum = (csum & 0xffff) + (csum >> 16);
 
-static int ioc3_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
-{
-	unsigned int sw_physid1, sw_physid2;
-	struct net_device *dev = NULL;
-	struct ioc3_private *ip;
-	struct ioc3 *ioc3;
-	unsigned long ioc3_base, ioc3_size;
-	u32 vendor, model, rev;
-	int err, pci_using_dac;
-
-	/* Configure DMA attributes. */
-	err = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
-	if (!err) {
-		pci_using_dac = 1;
-		err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
-		if (err < 0) {
-			printk(KERN_ERR "%s: Unable to obtain 64 bit DMA "
-			       "for consistent allocations\n", pci_name(pdev));
-			goto out;
+		csoff = ETH_HLEN + (ih->ihl << 2);
+		if (proto == IPPROTO_UDP) {
+			csoff += offsetof(struct udphdr, check);
+			udp_hdr(skb)->check = csum;
 		}
-	} else {
-		err = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
-		if (err) {
-			printk(KERN_ERR "%s: No usable DMA configuration, "
-			       "aborting.\n", pci_name(pdev));
-			goto out;
+		if (proto == IPPROTO_TCP) {
+			csoff += offsetof(struct tcphdr, check);
+			tcp_hdr(skb)->check = csum;
 		}
-		pci_using_dac = 0;
+
+		w0 = ETXD_DOCHECKSUM | (csoff << ETXD_CHKOFF_SHIFT);
 	}
 
-	if (pci_enable_device(pdev))
-		return -ENODEV;
+	spin_lock_irq(&ip->ioc3_lock);
 
-	dev = alloc_etherdev(sizeof(struct ioc3_private));
-	if (!dev) {
-		err = -ENOMEM;
-		goto out_disable;
+	if (ip->txbfree <= 0) {
+		netif_stop_queue(dev);
+		spin_unlock_irq(&ip->ioc3_lock);
+		printk(KERN_ERR "%s: BUG! Tx Ring full when queue awake!\n",
+		       dev->name);
+		return NETDEV_TX_BUSY;
 	}
 
-	if (pci_using_dac)
-		dev->features |= NETIF_F_HIGHDMA;
+	data = (unsigned long)skb->data;
+	len = skb->len;
 
-	err = pci_request_regions(pdev, "ioc3");
-	if (err)
-		goto out_free;
+	produce = ip->tx_pi;
+	desc = &ip->txr[produce];
 
-	SET_NETDEV_DEV(dev, &pdev->dev);
+	if (len <= 104) {
+		/* Short packet, let's copy it directly into the ring.  */
+		skb_copy_from_linear_data(skb, desc->data, skb->len);
+		if (len < ETH_ZLEN) {
+			/* Very short packet, pad with zeros at the end. */
+			memset(desc->data + len, 0, ETH_ZLEN - len);
+			len = ETH_ZLEN;
+		}
+		desc->cmd = cpu_to_be32(len | ETXD_INTWHENDONE | ETXD_D0V | w0);
+		desc->bufcnt = cpu_to_be32(len);
+	} else if ((data ^ (data + len - 1)) & 0x4000) {
+		unsigned long b2 = (data | 0x3fffUL) + 1UL;
+		unsigned long s1 = b2 - data;
+		unsigned long s2 = data + len - b2;
 
-	ip = netdev_priv(dev);
-	ip->dev = dev;
-
-	dev->irq = pdev->irq;
-
-	ioc3_base = pci_resource_start(pdev, 0);
-	ioc3_size = pci_resource_len(pdev, 0);
-	ioc3 = (struct ioc3 *) ioremap(ioc3_base, ioc3_size);
-	if (!ioc3) {
-		printk(KERN_CRIT "ioc3eth(%s): ioremap failed, goodbye.\n",
-		       pci_name(pdev));
-		err = -ENOMEM;
-		goto out_res;
+		desc->cmd    = cpu_to_be32(len | ETXD_INTWHENDONE |
+					   ETXD_B1V | ETXD_B2V | w0);
+		desc->bufcnt = cpu_to_be32((s1 << ETXD_B1CNT_SHIFT) |
+					   (s2 << ETXD_B2CNT_SHIFT));
+		desc->p1     = cpu_to_be64(ioc3_map(skb->data,
+						    PCI64_ATTR_PREF));
+		desc->p2     = cpu_to_be64(ioc3_map((void *)b2,
+						    PCI64_ATTR_PREF));
+	} else {
+		/* Normal sized packet that doesn't cross a page boundary. */
+		desc->cmd = cpu_to_be32(len | ETXD_INTWHENDONE | ETXD_B1V | w0);
+		desc->bufcnt = cpu_to_be32(len << ETXD_B1CNT_SHIFT);
+		desc->p1     = cpu_to_be64(ioc3_map(skb->data,
+						    PCI64_ATTR_PREF));
 	}
-	ip->regs = ioc3;
 
-#ifdef CONFIG_SERIAL_8250
-	ioc3_serial_probe(pdev, ioc3);
-#endif
+	mb(); /* make sure all descriptor changes are visible */
 
-	spin_lock_init(&ip->ioc3_lock);
-	timer_setup(&ip->ioc3_timer, ioc3_timer, 0);
+	ip->tx_skbs[produce] = skb;			/* Remember skb */
+	produce = (produce + 1) & TX_MASK;
+	ip->tx_pi = produce;
+	writel(produce << 7, &ip->regs->etpir);	/* Fire! */
 
-	ioc3_stop(ip);
-	ioc3_init(dev);
+	ip->txbfree--;
+	if (ip->txbfree == 0)
+		netif_stop_queue(dev);
 
-	ip->pdev = pdev;
-
-	ip->mii.phy_id_mask = 0x1f;
-	ip->mii.reg_num_mask = 0x1f;
-	ip->mii.dev = dev;
-	ip->mii.mdio_read = ioc3_mdio_read;
-	ip->mii.mdio_write = ioc3_mdio_write;
-
-	ioc3_mii_init(ip);
-
-	if (ip->mii.phy_id == -1) {
-		printk(KERN_CRIT "ioc3-eth(%s): Didn't find a PHY, goodbye.\n",
-		       pci_name(pdev));
-		err = -ENODEV;
-		goto out_stop;
-	}
-
-	ioc3_mii_start(ip);
-	ioc3_ssram_disc(ip);
-	ioc3_get_eaddr(ip);
-
-	/* The IOC3-specific entries in the device structure. */
-	dev->watchdog_timeo	= 5 * HZ;
-	dev->netdev_ops		= &ioc3_netdev_ops;
-	dev->ethtool_ops	= &ioc3_ethtool_ops;
-	dev->hw_features	= NETIF_F_IP_CSUM | NETIF_F_RXCSUM;
-	dev->features		= NETIF_F_IP_CSUM;
-
-	sw_physid1 = ioc3_mdio_read(dev, ip->mii.phy_id, MII_PHYSID1);
-	sw_physid2 = ioc3_mdio_read(dev, ip->mii.phy_id, MII_PHYSID2);
-
-	err = register_netdev(dev);
-	if (err)
-		goto out_stop;
-
-	mii_check_media(&ip->mii, 1, 1);
-	ioc3_setup_duplex(ip);
-
-	vendor = (sw_physid1 << 12) | (sw_physid2 >> 4);
-	model  = (sw_physid2 >> 4) & 0x3f;
-	rev    = sw_physid2 & 0xf;
-	printk(KERN_INFO "%s: Using PHY %d, vendor 0x%x, model %d, "
-	       "rev %d.\n", dev->name, ip->mii.phy_id, vendor, model, rev);
-	printk(KERN_INFO "%s: IOC3 SSRAM has %d kbyte.\n", dev->name,
-	       ip->emcr & EMCR_BUFSIZ ? 128 : 64);
-
-	return 0;
+	spin_unlock_irq(&ip->ioc3_lock);
 
-out_stop:
-	ioc3_stop(ip);
-	del_timer_sync(&ip->ioc3_timer);
-	ioc3_free_rings(ip);
-out_res:
-	pci_release_regions(pdev);
-out_free:
-	free_netdev(dev);
-out_disable:
-	/*
-	 * We should call pci_disable_device(pdev); here if the IOC3 wasn't
-	 * such a weird device ...
-	 */
-out:
-	return err;
+	return NETDEV_TX_OK;
 }
 
-static void ioc3_remove_one(struct pci_dev *pdev)
+static int ioc3_set_mac_address(struct net_device *dev, void *addr)
 {
-	struct net_device *dev = pci_get_drvdata(pdev);
 	struct ioc3_private *ip = netdev_priv(dev);
-	struct ioc3 *ioc3 = ip->regs;
-
-	unregister_netdev(dev);
-	del_timer_sync(&ip->ioc3_timer);
+	struct ioc3_ethregs *regs = ip->regs;
+	struct sockaddr *sa = addr;
 
-	iounmap(ioc3);
-	pci_release_regions(pdev);
-	free_netdev(dev);
-	/*
-	 * We should call pci_disable_device(pdev); here if the IOC3 wasn't
-	 * such a weird device ...
-	 */
-}
+	memcpy(dev->dev_addr, sa->sa_data, dev->addr_len);
 
-static const struct pci_device_id ioc3_pci_tbl[] = {
-	{ PCI_VENDOR_ID_SGI, PCI_DEVICE_ID_SGI_IOC3, PCI_ANY_ID, PCI_ANY_ID },
-	{ 0 }
-};
-MODULE_DEVICE_TABLE(pci, ioc3_pci_tbl);
+	spin_lock_irq(&ip->ioc3_lock);
+	__ioc3_set_mac_address(dev, regs);
+	spin_unlock_irq(&ip->ioc3_lock);
 
-static struct pci_driver ioc3_driver = {
-	.name		= "ioc3-eth",
-	.id_table	= ioc3_pci_tbl,
-	.probe		= ioc3_probe,
-	.remove		= ioc3_remove_one,
-};
+	return 0;
+}
 
-static netdev_tx_t ioc3_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static int ioc3_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
-	unsigned long data;
 	struct ioc3_private *ip = netdev_priv(dev);
-	struct ioc3 *ioc3 = ip->regs;
-	unsigned int len;
-	struct ioc3_etxd *desc;
-	uint32_t w0 = 0;
-	int produce;
-
-	/*
-	 * IOC3 has a fairly simple minded checksumming hardware which simply
-	 * adds up the 1's complement checksum for the entire packet and
-	 * inserts it at an offset which can be specified in the descriptor
-	 * into the transmit packet.  This means we have to compensate for the
-	 * MAC header which should not be summed and the TCP/UDP pseudo headers
-	 * manually.
-	 */
-	if (skb->ip_summed == CHECKSUM_PARTIAL) {
-		const struct iphdr *ih = ip_hdr(skb);
-		const int proto = ntohs(ih->protocol);
-		unsigned int csoff;
-		uint32_t csum, ehsum;
-		uint16_t *eh;
-
-		/* The MAC header.  skb->mac seem the logic approach
-		   to find the MAC header - except it's a NULL pointer ...  */
-		eh = (uint16_t *) skb->data;
-
-		/* Sum up dest addr, src addr and protocol  */
-		ehsum = eh[0] + eh[1] + eh[2] + eh[3] + eh[4] + eh[5] + eh[6];
-
-		/* Fold ehsum.  can't use csum_fold which negates also ...  */
-		ehsum = (ehsum & 0xffff) + (ehsum >> 16);
-		ehsum = (ehsum & 0xffff) + (ehsum >> 16);
-
-		/* Skip IP header; it's sum is always zero and was
-		   already filled in by ip_output.c */
-		csum = csum_tcpudp_nofold(ih->saddr, ih->daddr,
-		                          ih->tot_len - (ih->ihl << 2),
-		                          proto, 0xffff ^ ehsum);
-
-		csum = (csum & 0xffff) + (csum >> 16);	/* Fold again */
-		csum = (csum & 0xffff) + (csum >> 16);
-
-		csoff = ETH_HLEN + (ih->ihl << 2);
-		if (proto == IPPROTO_UDP) {
-			csoff += offsetof(struct udphdr, check);
-			udp_hdr(skb)->check = csum;
-		}
-		if (proto == IPPROTO_TCP) {
-			csoff += offsetof(struct tcphdr, check);
-			tcp_hdr(skb)->check = csum;
-		}
-
-		w0 = ETXD_DOCHECKSUM | (csoff << ETXD_CHKOFF_SHIFT);
-	}
+	int rc;
 
 	spin_lock_irq(&ip->ioc3_lock);
-
-	data = (unsigned long) skb->data;
-	len = skb->len;
-
-	produce = ip->tx_pi;
-	desc = &ip->txr[produce];
-
-	if (len <= 104) {
-		/* Short packet, let's copy it directly into the ring.  */
-		skb_copy_from_linear_data(skb, desc->data, skb->len);
-		if (len < ETH_ZLEN) {
-			/* Very short packet, pad with zeros at the end. */
-			memset(desc->data + len, 0, ETH_ZLEN - len);
-			len = ETH_ZLEN;
-		}
-		desc->cmd = cpu_to_be32(len | ETXD_INTWHENDONE | ETXD_D0V | w0);
-		desc->bufcnt = cpu_to_be32(len);
-	} else if ((data ^ (data + len - 1)) & 0x4000) {
-		unsigned long b2 = (data | 0x3fffUL) + 1UL;
-		unsigned long s1 = b2 - data;
-		unsigned long s2 = data + len - b2;
-
-		desc->cmd    = cpu_to_be32(len | ETXD_INTWHENDONE |
-		                           ETXD_B1V | ETXD_B2V | w0);
-		desc->bufcnt = cpu_to_be32((s1 << ETXD_B1CNT_SHIFT) |
-		                           (s2 << ETXD_B2CNT_SHIFT));
-		desc->p1     = cpu_to_be64(ioc3_map(skb->data, 1));
-		desc->p2     = cpu_to_be64(ioc3_map((void *) b2, 1));
-	} else {
-		/* Normal sized packet that doesn't cross a page boundary. */
-		desc->cmd = cpu_to_be32(len | ETXD_INTWHENDONE | ETXD_B1V | w0);
-		desc->bufcnt = cpu_to_be32(len << ETXD_B1CNT_SHIFT);
-		desc->p1     = cpu_to_be64(ioc3_map(skb->data, 1));
-	}
-
-	BARRIER();
-
-	ip->tx_skbs[produce] = skb;			/* Remember skb */
-	produce = (produce + 1) & 127;
-	ip->tx_pi = produce;
-	ioc3_w_etpir(produce << 7);			/* Fire ... */
-
-	ip->txqlen++;
-
-	if (ip->txqlen >= 127)
-		netif_stop_queue(dev);
-
+	rc = generic_mii_ioctl(&ip->mii, if_mii(rq), cmd, NULL);
 	spin_unlock_irq(&ip->ioc3_lock);
 
-	return NETDEV_TX_OK;
+	return rc;
 }
 
 static void ioc3_timeout(struct net_device *dev)
@@ -1507,49 +759,42 @@ static void ioc3_timeout(struct net_device *dev)
 
 	printk(KERN_ERR "%s: transmit timed out, resetting\n", dev->name);
 
-	spin_lock_irq(&ip->ioc3_lock);
-
 	ioc3_stop(ip);
 	ioc3_init(dev);
 	ioc3_mii_init(ip);
 	ioc3_mii_start(ip);
 
-	spin_unlock_irq(&ip->ioc3_lock);
-
 	netif_wake_queue(dev);
 }
 
-/*
- * Given a multicast ethernet address, this routine calculates the
- * address's bit index in the logical address filter mask
- */
-
-static inline unsigned int ioc3_hash(const unsigned char *addr)
+static struct net_device_stats *ioc3_get_stats(struct net_device *dev)
 {
-	unsigned int temp = 0;
-	u32 crc;
-	int bits;
-
-	crc = ether_crc_le(ETH_ALEN, addr);
-
-	crc &= 0x3f;    /* bit reverse lowest 6 bits for hash index */
-	for (bits = 6; --bits >= 0; ) {
-		temp <<= 1;
-		temp |= (crc & 0x1);
-		crc >>= 1;
-	}
+	struct ioc3_private *ip = netdev_priv(dev);
+	struct ioc3_ethregs *regs = ip->regs;
 
-	return temp;
+	dev->stats.collisions += (readl(&regs->etcdc) & ETCDC_COLLCNT_MASK);
+	return &dev->stats;
 }
 
-static void ioc3_get_drvinfo (struct net_device *dev,
-	struct ethtool_drvinfo *info)
-{
-	struct ioc3_private *ip = netdev_priv(dev);
+static const struct net_device_ops ioc3_netdev_ops = {
+	.ndo_open		= ioc3_open,
+	.ndo_stop		= ioc3_close,
+	.ndo_start_xmit		= ioc3_start_xmit,
+	.ndo_tx_timeout		= ioc3_timeout,
+	.ndo_get_stats		= ioc3_get_stats,
+	.ndo_set_rx_mode	= ioc3_set_multicast_list,
+	.ndo_do_ioctl		= ioc3_ioctl,
+	.ndo_validate_addr	= eth_validate_addr,
+	.ndo_set_mac_address	= ioc3_set_mac_address,
+};
 
+static void ioc3_get_drvinfo(struct net_device *dev,
+			     struct ethtool_drvinfo *info)
+{
 	strlcpy(info->driver, IOC3_NAME, sizeof(info->driver));
 	strlcpy(info->version, IOC3_VERSION, sizeof(info->version));
-	strlcpy(info->bus_info, pci_name(ip->pdev), sizeof(info->bus_info));
+	strlcpy(info->bus_info, pci_name(to_pci_dev(dev->dev.parent)),
+		sizeof(info->bus_info));
 }
 
 static int ioc3_get_link_ksettings(struct net_device *dev,
@@ -1609,58 +854,298 @@ static const struct ethtool_ops ioc3_ethtool_ops = {
 	.set_link_ksettings	= ioc3_set_link_ksettings,
 };
 
-static int ioc3_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
+/* Deal with fatal IOC3 errors.  This condition might be caused by a hard or
+ * software problems, so we should try to recover
+ * more gracefully if this ever happens.  In theory we might be flooded
+ * with such error interrupts if something really goes wrong, so we might
+ * also consider to take the interface down.
+ */
+static noinline void ioc3_error(struct ioc3_private *ip,
+				struct net_device *dev, u32 eisr)
 {
-	struct ioc3_private *ip = netdev_priv(dev);
-	int rc;
+	u8 *iface = dev->name;
 
-	spin_lock_irq(&ip->ioc3_lock);
-	rc = generic_mii_ioctl(&ip->mii, if_mii(rq), cmd, NULL);
-	spin_unlock_irq(&ip->ioc3_lock);
+	if (eisr & EISR_RXOFLO)
+		printk(KERN_ERR "%s: RX overflow.\n", iface);
+	if (eisr & EISR_RXBUFOFLO)
+		printk(KERN_ERR "%s: RX buffer overflow.\n", iface);
+	if (eisr & EISR_RXMEMERR)
+		printk(KERN_ERR "%s: RX PCI error.\n", iface);
+	if (eisr & EISR_RXPARERR)
+		printk(KERN_ERR "%s: RX SSRAM parity error.\n", iface);
+	if (eisr & EISR_TXBUFUFLO)
+		printk(KERN_ERR "%s: TX buffer underflow.\n", iface);
+	if (eisr & EISR_TXMEMERR)
+		printk(KERN_ERR "%s: TX PCI error.\n", iface);
 
-	return rc;
+	ioc3_stop(ip);
+
+	/* This can trigger a BUG(): sleeping function called */
+	ioc3_init(dev);
+	ioc3_mii_init(ip);
+	ioc3_mii_start(ip);
+
+	netif_wake_queue(dev);
 }
 
-static void ioc3_set_multicast_list(struct net_device *dev)
+static noinline void ioc3_rx(struct ioc3_private *ip, struct net_device *dev)
 {
-	struct netdev_hw_addr *ha;
-	struct ioc3_private *ip = netdev_priv(dev);
-	struct ioc3 *ioc3 = ip->regs;
-	u64 ehar = 0;
+	struct sk_buff *skb, *new_skb;
+	struct ioc3_erxbuf *rxb;
+	int rx_entry, n_entry, len;
+	u32 w0, err;
 
-	netif_stop_queue(dev);				/* Lock out others. */
+	rx_entry = ip->rx_ci;  /* RX consume index */
+	n_entry = ip->rx_pi;
 
-	if (dev->flags & IFF_PROMISC) {			/* Set promiscuous.  */
-		ip->emcr |= EMCR_PROMISC;
-		ioc3_w_emcr(ip->emcr);
-		(void) ioc3_r_emcr();
-	} else {
-		ip->emcr &= ~EMCR_PROMISC;
-		ioc3_w_emcr(ip->emcr);			/* Clear promiscuous. */
-		(void) ioc3_r_emcr();
+	skb = ip->rx_skbs[rx_entry];
+	rxb = (struct ioc3_erxbuf *)(skb->data - RX_OFFSET);
+	w0 = be32_to_cpu(rxb->w0);
 
-		if ((dev->flags & IFF_ALLMULTI) ||
-		    (netdev_mc_count(dev) > 64)) {
-			/* Too many for hashing to make sense or we want all
-			   multicast packets anyway,  so skip computing all the
-			   hashes and just accept all packets.  */
-			ip->ehar_h = 0xffffffff;
-			ip->ehar_l = 0xffffffff;
-		} else {
-			netdev_for_each_mc_addr(ha, dev) {
-				ehar |= (1UL << ioc3_hash(ha->addr));
+	while (w0 & ERXBUF_V) {
+		err = be32_to_cpu(rxb->err);  /* It's valid */
+		if (err & ERXBUF_GOODPKT) {
+			len = ((w0 >> ERXBUF_BYTECNT_SHIFT) & 0x7ff) - 4;
+			skb_trim(skb, len);
+			skb->protocol = eth_type_trans(skb, dev);
+
+			new_skb = ioc3_alloc_skb(dev);
+			if (!new_skb) {
+				/* Ouch, drop packet and just recycle packet
+				 * to keep the ring filled.
+				 */
+				dev->stats.rx_dropped++;
+				new_skb = skb;
+				goto next;
 			}
-			ip->ehar_h = ehar >> 32;
-			ip->ehar_l = ehar & 0xffffffff;
+
+			if (likely(ip->flags & IOC3_FLAG_RX_CHECKSUMS))
+				ioc3_tcpudp_checksum(skb,
+						     (w0 & ERXBUF_IPCKSUM_MASK),
+						      len);
+
+			netif_rx(skb);
+
+			ip->rx_skbs[rx_entry] = NULL;  /* Poison */
+
+			/* Because we reserve afterwards. */
+			skb_put(new_skb, (RX_BUF_SIZE + RX_OFFSET));
+			rxb = (struct ioc3_erxbuf *)new_skb->data;
+			skb_reserve(new_skb, RX_OFFSET);
+
+			dev->stats.rx_packets++;  /* Statistics */
+			dev->stats.rx_bytes += len;
+		} else {
+			/* The frame is invalid and the skb never reached the
+			 * network layer so we can just recycle it.
+			 */
+			new_skb = skb;
+			dev->stats.rx_errors++;
 		}
-		ioc3_w_ehar_h(ip->ehar_h);
-		ioc3_w_ehar_l(ip->ehar_l);
+
+		/* Statistics */
+		if (err & ERXBUF_CRCERR)
+			dev->stats.rx_crc_errors++;
+		if (err & ERXBUF_FRAMERR)
+			dev->stats.rx_frame_errors++;
+next:
+		ip->rx_skbs[rx_entry] = new_skb;
+		ip->rxr[rx_entry] = cpu_to_be64(ioc3_map(rxb, PCI64_ATTR_BAR));
+		rxb->w0 = 0;				/* Clear valid flag */
+
+		/* Now go on to the next ring entry.  */
+		n_entry++;
+		n_entry &= RX_MASK;
+		rx_entry++;
+		rx_entry &= RX_MASK;
+
+		skb = ip->rx_skbs[rx_entry];
+		rxb = (struct ioc3_erxbuf *)(skb->data - RX_OFFSET);
+		w0 = be32_to_cpu(rxb->w0);
+	}
+	ip->rx_ci = rx_entry;
+	ip->rx_pi = n_entry;
+	writel((n_entry << 3) | ERPIR_ARM, &ip->regs->erpir);
+}
+
+static noinline void ioc3_tx(struct ioc3_private *ip, struct net_device *dev)
+{
+	struct sk_buff *skb;
+	struct ioc3_ethregs *regs = ip->regs;
+	unsigned long packets = 0;
+	unsigned long bytes = 0;
+	int tx_entry, o_entry;
+	u32 etcir;
+
+	etcir = readl(&regs->etcir);
+	tx_entry = (etcir >> 7) & TX_MASK;
+	o_entry = ip->tx_ci;
+
+	while (o_entry != tx_entry) {
+		packets++;
+		skb = ip->tx_skbs[o_entry];
+		bytes += skb->len;
+		dev_consume_skb_irq(skb);
+		ip->tx_skbs[o_entry] = NULL;
+
+		etcir = readl(&regs->etcir);		/* More pkts sent?  */
+		tx_entry = (etcir >> 7) & TX_MASK;
+		o_entry = (o_entry + 1) & TX_MASK;	/* Next */
+	}
+	ip->tx_ci = o_entry;
+
+	dev->stats.tx_bytes   += bytes;
+	dev->stats.tx_packets += packets;
+	ip->txbfree += packets;
+
+	if (netif_queue_stopped(dev) && ip->txbfree > 0)
+		netif_wake_queue(dev);
+}
+
+/* The interrupt handler does all of the Rx thread work
+ * and cleans up after the Tx thread.
+ */
+static irqreturn_t ioc3eth_intr(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct ioc3_private *ip = netdev_priv(dev);
+	struct ioc3_ethregs *regs = ip->regs;
+	u32 eisr;
+
+	spin_lock(&ip->ioc3_lock);
+
+	eisr = readl(&regs->eisr);
+
+	writel(eisr, &regs->eisr);
+	(void)readl(&regs->eisr);	/* Flush */
+
+	if (eisr & (EISR_RXTIMERINT | EISR_RXTHRESHINT))
+		ioc3_rx(ip, dev);
+
+	if (eisr & (EISR_TXEMPTY | EISR_TXEXDEF | EISR_TXEXPLICIT))
+		ioc3_tx(ip, dev);
+
+	if (eisr & (EISR_RXOFLO | EISR_RXBUFOFLO |
+		    EISR_RXMEMERR | EISR_RXPARERR |
+		    EISR_TXBUFUFLO | EISR_TXMEMERR))
+		ioc3_error(ip, dev, eisr);
+
+	spin_unlock(&ip->ioc3_lock);
+
+	return eisr ? IRQ_HANDLED : IRQ_NONE;
+}
+
+static int ioc3eth_probe(struct platform_device *pdev)
+{
+	struct ioc3eth_platform_data *data = dev_get_platdata(&pdev->dev);
+	struct net_device *dev;
+	struct ioc3_private *ip;
+	struct resource *r;
+	u32 sw_physid1, sw_physid2, vendor, model, rev;
+	int err;
+
+	dev = alloc_etherdev(sizeof(struct ioc3_private));
+	if (!dev)
+		return -ENOMEM;
+
+	/* The IOC3-specific entries in the device structure. */
+	dev->watchdog_timeo	= 5 * HZ;
+	dev->netdev_ops		= &ioc3_netdev_ops;
+	dev->ethtool_ops	= &ioc3_ethtool_ops;
+	dev->features		= NETIF_F_IP_CSUM | NETIF_F_HIGHDMA;
+
+	SET_NETDEV_DEV(dev, &pdev->dev);
+	ip = netdev_priv(dev);
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ip->regs = ioremap(r->start, resource_size(r));
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	ip->ssram = ioremap(r->start, resource_size(r));
+
+	dev->irq = platform_get_irq(pdev, 0);
+	if (dev->irq < 0)
+		return dev->irq;
+
+	if (request_irq(dev->irq, ioc3eth_intr, IRQF_SHARED, "ioc3-eth", dev)) {
+		pr_err("%s: Can't get irq %d\n", dev->name, dev->irq);
+		return -ENODEV;
 	}
 
-	netif_wake_queue(dev);			/* Let us get going again. */
+	spin_lock_init(&ip->ioc3_lock);
+	timer_setup(&ip->ioc3_timer, ioc3_timer, 0);
+
+	ioc3_stop(ip);
+	ioc3_init(dev);
+
+	ip->mii.phy_id_mask = 0x1f;
+	ip->mii.reg_num_mask = 0x1f;
+	ip->mii.dev = dev;
+	ip->mii.mdio_read = ioc3_mdio_read;
+	ip->mii.mdio_write = ioc3_mdio_write;
+
+	ioc3_mii_init(ip);
+
+	if (ip->mii.phy_id == -1) {
+		printk(KERN_CRIT "ioc3-eth(%s): Didn't find a PHY, goodbye.\n",
+		       dev->name);
+		err = -ENODEV;
+		goto out_stop;
+	}
+
+	ioc3_mii_start(ip);
+	ioc3_ssram_disc(ip);
+	memcpy(dev->dev_addr, data->mac_addr, ETH_ALEN);
+
+	sw_physid1 = ioc3_mdio_read(dev, ip->mii.phy_id, MII_PHYSID1);
+	sw_physid2 = ioc3_mdio_read(dev, ip->mii.phy_id, MII_PHYSID2);
+
+	err = register_netdev(dev);
+	if (err)
+		goto out_stop;
+
+	mii_check_media(&ip->mii, 1, 1);
+	ioc3_setup_duplex(ip);
+
+	vendor = (sw_physid1 << 12) | (sw_physid2 >> 4);
+	model  = (sw_physid2 >> 4) & 0x3f;
+	rev    = sw_physid2 & 0xf;
+	printk(KERN_INFO "%s: Using PHY %d, vendor 0x%x, model %d, rev %d.\n",
+	       dev->name, ip->mii.phy_id, vendor, model, rev);
+	printk(KERN_INFO "%s: IOC3 SSRAM has %d kbyte.\n", dev->name,
+	       (ip->emcr & EMCR_BUFSIZ ? 128 : 64));
+
+	return 0;
+
+out_stop:
+	ioc3_stop(ip);
+	del_timer_sync(&ip->ioc3_timer);
+	ioc3_free_rings(ip);
+	free_netdev(dev);
+	return err;
+}
+
+static int ioc3eth_remove(struct platform_device *pdev)
+{
+	struct net_device *dev = platform_get_drvdata(pdev);
+	struct ioc3_private *ip = netdev_priv(dev);
+
+	unregister_netdev(dev);
+	del_timer_sync(&ip->ioc3_timer);
+	ioc3_free_rings(ip);
+	free_netdev(dev);
+
+	return 0;
 }
 
-module_pci_driver(ioc3_driver);
+static struct platform_driver ioc3eth_driver = {
+	.probe  = ioc3eth_probe,
+	.remove = ioc3eth_remove,
+	.driver = {
+		.name = "ioc3-eth",
+	}
+};
+
+module_platform_driver(ioc3eth_driver);
+
 MODULE_AUTHOR("Ralf Baechle <ralf@linux-mips.org>");
 MODULE_DESCRIPTION("SGI IOC3 Ethernet driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/8250/8250_ioc3.c b/drivers/tty/serial/8250/8250_ioc3.c
new file mode 100644
index 000000000000..2be6ed2967e0
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_ioc3.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SGI IOC3 8250 UART driver
+ *
+ * Copyright (C) 2019 Thomas Bogendoerfer <tbogendoerfer@suse.de>
+ *
+ * based on code Copyright (C) 2005 Stanislaw Skowronek <skylark@unaligned.org>
+ *               Copyright (C) 2014 Joshua Kinard <kumba@gentoo.org>
+ */
+
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+
+#include "8250.h"
+
+#define IOC3_UARTCLK (22000000 / 3)
+
+struct ioc3_8250_data {
+	int line;
+};
+
+static unsigned int ioc3_serial_in(struct uart_port *p, int offset)
+{
+	return readb(p->membase + offset);
+}
+
+static void ioc3_serial_out(struct uart_port *p, int offset, int value)
+{
+	writeb(value, p->membase + offset);
+}
+
+static int serial8250_ioc3_probe(struct platform_device *pdev)
+{
+	struct ioc3_8250_data *data;
+	struct uart_8250_port up;
+	struct resource *r;
+	void __iomem *membase;
+	int irq, line;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r)
+		return -ENODEV;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	membase = devm_ioremap_nocache(&pdev->dev, r->start, resource_size(r));
+	if (!membase)
+		return -ENOMEM;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		irq = 0; /* no interrupt -> use polling */
+
+	/* Register serial ports with 8250.c */
+	memset(&up, 0, sizeof(struct uart_8250_port));
+	up.port.iotype = UPIO_MEM;
+	up.port.uartclk = IOC3_UARTCLK;
+	up.port.type = PORT_16550A;
+	up.port.irq = irq;
+	up.port.flags = (UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ);
+	up.port.dev = &pdev->dev;
+	up.port.membase = membase;
+	up.port.mapbase = r->start;
+	up.port.serial_in = ioc3_serial_in;
+	up.port.serial_out = ioc3_serial_out;
+	line = serial8250_register_8250_port(&up);
+	if (line < 0)
+		return line;
+
+	platform_set_drvdata(pdev, data);
+	return 0;
+}
+
+static int serial8250_ioc3_remove(struct platform_device *pdev)
+{
+	struct ioc3_8250_data *data = platform_get_drvdata(pdev);
+
+	serial8250_unregister_port(data->line);
+	return 0;
+}
+
+static struct platform_driver serial8250_ioc3_driver = {
+	.probe  = serial8250_ioc3_probe,
+	.remove = serial8250_ioc3_remove,
+	.driver = {
+		.name = "ioc3-serial8250",
+	}
+};
+
+module_platform_driver(serial8250_ioc3_driver);
+
+MODULE_AUTHOR("Thomas Bogendoerfer <tbogendoerfer@suse.de>");
+MODULE_DESCRIPTION("SGI IOC3 8250 UART driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 15c2c5463835..9d24615aabfb 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -364,6 +364,17 @@ config SERIAL_8250_EM
 	  port hardware found on the Emma Mobile line of processors.
 	  If unsure, say N.
 
+config SERIAL_8250_IOC3
+	tristate "SGI IOC3 8250 UART support"
+	depends on SGI_MFD_IOC3 && SERIAL_8250
+	select SERIAL_8250_EXTENDED
+	select SERIAL_8250_SHARE_IRQ
+	help
+	  Enable this if you have a SGI Origin or Octane machine. This module
+	  provides basic serial support by directly driving the UART chip
+	  behind the IOC3 device on those systems.  Maximum baud speed is
+	  38400bps using this driver.
+
 config SERIAL_8250_RT288X
 	bool "Ralink RT288x/RT305x/RT3662/RT3883 serial port support"
 	depends on SERIAL_8250
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 18751bc63a84..79f74b4d57e5 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_SERIAL_8250_FSL)		+= 8250_fsl.o
 obj-$(CONFIG_SERIAL_8250_MEN_MCB)	+= 8250_men_mcb.o
 obj-$(CONFIG_SERIAL_8250_DW)		+= 8250_dw.o
 obj-$(CONFIG_SERIAL_8250_EM)		+= 8250_em.o
+obj-$(CONFIG_SERIAL_8250_IOC3)		+= 8250_ioc3.o
 obj-$(CONFIG_SERIAL_8250_OMAP)		+= 8250_omap.o
 obj-$(CONFIG_SERIAL_8250_LPC18XX)	+= 8250_lpc18xx.o
 obj-$(CONFIG_SERIAL_8250_MT6577)	+= 8250_mtk.o
diff --git a/include/linux/platform_data/ioc3eth.h b/include/linux/platform_data/ioc3eth.h
new file mode 100644
index 000000000000..d8a688c7db48
--- /dev/null
+++ b/include/linux/platform_data/ioc3eth.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Ethernet driver for the SGI IOC3 chip.
+ */
+
+#ifndef PLATFORM_DATA_IOC3ETH_H
+#define PLATFORM_DATA_IOC3ETH_H
+
+#include <linux/if_ether.h>
+
+struct ioc3eth_platform_data {
+	u8	mac_addr[ETH_ALEN];
+};
+
+#endif /* PLATFORM_DATA_IOC3ETH_H */
-- 
2.13.7
