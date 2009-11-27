From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] sh: Move KEYSC header file
Date: Fri, 27 Nov 2009 16:32:24 +0900
Message-ID: <20091127073224.19786.60477.sendpatchset@rxone.opensource.se>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch moves the KEYSC header file from the
SuperH specific asm directory to a place where
it can be shared by multiple architectures.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/boards/mach-ecovec24/setup.c |    2 +-
 arch/sh/boards/mach-kfr2r09/setup.c  |    2 +-
 arch/sh/boards/mach-migor/setup.c    |    2 +-
 arch/sh/boards/mach-se/7722/setup.c  |    2 +-
 arch/sh/boards/mach-se/7724/setup.c  |    2 +-
 arch/sh/include/asm/sh_keysc.h       |   14 --------------
 drivers/input/keyboard/sh_keysc.c    |    2 +-
 include/linux/input/sh_keysc.h       |   14 ++++++++++++++
 8 files changed, 20 insertions(+), 20 deletions(-)

--- 0003/arch/sh/boards/mach-ecovec24/setup.c
+++ work/arch/sh/boards/mach-ecovec24/setup.c	2009-11-27 15:28:14.000000000 +0900
@@ -20,12 +20,12 @@
 #include <linux/i2c.h>
 #include <linux/i2c/tsc2007.h>
 #include <linux/input.h>
+#include <linux/input/sh_keysc.h>
 #include <linux/mfd/sh_mobile_sdhi.h>
 #include <video/sh_mobile_lcdc.h>
 #include <media/sh_mobile_ceu.h>
 #include <asm/heartbeat.h>
 #include <asm/sh_eth.h>
-#include <asm/sh_keysc.h>
 #include <asm/clock.h>
 #include <asm/suspend.h>
 #include <cpu/sh7724.h>
--- 0001/arch/sh/boards/mach-kfr2r09/setup.c
+++ work/arch/sh/boards/mach-kfr2r09/setup.c	2009-11-27 15:27:42.000000000 +0900
@@ -16,6 +16,7 @@
 #include <linux/clk.h>
 #include <linux/gpio.h>
 #include <linux/input.h>
+#include <linux/input/sh_keysc.h>
 #include <linux/i2c.h>
 #include <linux/usb/r8a66597.h>
 #include <media/soc_camera.h>
@@ -25,7 +26,6 @@
 #include <asm/clock.h>
 #include <asm/machvec.h>
 #include <asm/io.h>
-#include <asm/sh_keysc.h>
 #include <cpu/sh7724.h>
 #include <mach/kfr2r09.h>
 
--- 0001/arch/sh/boards/mach-migor/setup.c
+++ work/arch/sh/boards/mach-migor/setup.c	2009-11-27 15:28:55.000000000 +0900
@@ -11,6 +11,7 @@
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/input.h>
+#include <linux/input/sh_keysc.h>
 #include <linux/mtd/physmap.h>
 #include <linux/mtd/nand.h>
 #include <linux/i2c.h>
@@ -25,7 +26,6 @@
 #include <asm/clock.h>
 #include <asm/machvec.h>
 #include <asm/io.h>
-#include <asm/sh_keysc.h>
 #include <asm/suspend.h>
 #include <mach/migor.h>
 #include <cpu/sh7722.h>
--- 0001/arch/sh/boards/mach-se/7722/setup.c
+++ work/arch/sh/boards/mach-se/7722/setup.c	2009-11-27 16:00:13.000000000 +0900
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/ata_platform.h>
 #include <linux/input.h>
+#include <linux/input/sh_keysc.h>
 #include <linux/smc91x.h>
 #include <mach-se/mach/se7722.h>
 #include <mach-se/mach/mrshpc.h>
@@ -21,7 +22,6 @@
 #include <asm/clock.h>
 #include <asm/io.h>
 #include <asm/heartbeat.h>
-#include <asm/sh_keysc.h>
 #include <cpu/sh7722.h>
 
 /* Heartbeat */
--- 0001/arch/sh/boards/mach-se/7724/setup.c
+++ work/arch/sh/boards/mach-se/7724/setup.c	2009-11-27 15:27:28.000000000 +0900
@@ -19,6 +19,7 @@
 #include <linux/smc91x.h>
 #include <linux/gpio.h>
 #include <linux/input.h>
+#include <linux/input/sh_keysc.h>
 #include <linux/usb/r8a66597.h>
 #include <video/sh_mobile_lcdc.h>
 #include <media/sh_mobile_ceu.h>
@@ -27,7 +28,6 @@
 #include <asm/heartbeat.h>
 #include <asm/sh_eth.h>
 #include <asm/clock.h>
-#include <asm/sh_keysc.h>
 #include <asm/suspend.h>
 #include <cpu/sh7724.h>
 #include <mach-se/mach/se7724.h>
--- 0001/arch/sh/include/asm/sh_keysc.h
+++ /dev/null	2009-11-24 12:00:12.283019273 +0900
@@ -1,14 +0,0 @@
-#ifndef __ASM_KEYSC_H__
-#define __ASM_KEYSC_H__
-
-#define SH_KEYSC_MAXKEYS 30
-
-struct sh_keysc_info {
-	enum { SH_KEYSC_MODE_1, SH_KEYSC_MODE_2, SH_KEYSC_MODE_3 } mode;
-	int scan_timing; /* 0 -> 7, see KYCR1, SCN[2:0] */
-	int delay;
-	int kycr2_delay;
-	int keycodes[SH_KEYSC_MAXKEYS];
-};
-
-#endif /* __ASM_KEYSC_H__ */
--- 0001/drivers/input/keyboard/sh_keysc.c
+++ work/drivers/input/keyboard/sh_keysc.c	2009-11-27 15:29:03.000000000 +0900
@@ -18,9 +18,9 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/input.h>
+#include <linux/input/sh_keysc.h>
 #include <linux/clk.h>
 #include <linux/io.h>
-#include <asm/sh_keysc.h>
 
 #define KYCR1_OFFS   0x00
 #define KYCR2_OFFS   0x04
--- /dev/null
+++ work/include/linux/input/sh_keysc.h	2009-11-24 19:14:53.000000000 +0900
@@ -0,0 +1,14 @@
+#ifndef __SH_KEYSC_H__
+#define __SH_KEYSC_H__
+
+#define SH_KEYSC_MAXKEYS 30
+
+struct sh_keysc_info {
+	enum { SH_KEYSC_MODE_1, SH_KEYSC_MODE_2, SH_KEYSC_MODE_3 } mode;
+	int scan_timing; /* 0 -> 7, see KYCR1, SCN[2:0] */
+	int delay;
+	int kycr2_delay;
+	int keycodes[SH_KEYSC_MAXKEYS];
+};
+
+#endif /* __SH_KEYSC_H__ */
