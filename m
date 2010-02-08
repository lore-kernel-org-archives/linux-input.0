From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 03/03] input: update sh_keysc driver with mode 6
Date: Mon, 08 Feb 2010 15:32:43 +0900
Message-ID: <20100208063243.2003.6889.sendpatchset@rxone.opensource.se>
References: <20100208063216.2003.84260.sendpatchset@rxone.opensource.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f189.google.com ([209.85.211.189]:44357 "EHLO
	mail-yw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127Ab0BHGjX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Feb 2010 01:39:23 -0500
In-Reply-To: <20100208063216.2003.84260.sendpatchset@rxone.opensource.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org, dmitry.torokhov@gmail.com, linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add mode 6 support to the sh_keysc driver. Also update
the KYOUTDR mask value to include all 16 register bits.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/input/keyboard/sh_keysc.c |    3 ++-
 include/linux/input/sh_keysc.h    |    6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

--- 0006/drivers/input/keyboard/sh_keysc.c
+++ work/drivers/input/keyboard/sh_keysc.c	2010-02-05 13:19:52.000000000 +0900
@@ -31,6 +31,7 @@ static const struct {
 	[SH_KEYSC_MODE_3] = { 2, 4, 7 },
 	[SH_KEYSC_MODE_4] = { 3, 6, 6 },
 	[SH_KEYSC_MODE_5] = { 4, 6, 7 },
+	[SH_KEYSC_MODE_6] = { 5, 7, 7 },
 };
 
 struct sh_keysc_map {
@@ -121,7 +122,7 @@ static irqreturn_t sh_keysc_isr(int irq,
 			n = keyin_nr * i;
 
 			/* drive one KEYOUT pin low, read KEYIN pins */
-			sh_keysc_write(priv, KYOUTDR, 0xfff ^ (3 << (i * 2)));
+			sh_keysc_write(priv, KYOUTDR, 0xffff ^ (3 << (i * 2)));
 			udelay(pdata->delay);
 			tmp = sh_keysc_read(priv, KYINDR);
 
--- 0004/include/linux/input/sh_keysc.h
+++ work/include/linux/input/sh_keysc.h	2010-02-05 13:19:52.000000000 +0900
@@ -1,15 +1,15 @@
 #ifndef __SH_KEYSC_H__
 #define __SH_KEYSC_H__
 
-#define SH_KEYSC_MAXKEYS 42
+#define SH_KEYSC_MAXKEYS 49
 
 struct sh_keysc_info {
 	enum { SH_KEYSC_MODE_1, SH_KEYSC_MODE_2, SH_KEYSC_MODE_3,
-	       SH_KEYSC_MODE_4, SH_KEYSC_MODE_5 } mode;
+	       SH_KEYSC_MODE_4, SH_KEYSC_MODE_5, SH_KEYSC_MODE_6 } mode;
 	int scan_timing; /* 0 -> 7, see KYCR1, SCN[2:0] */
 	int delay;
 	int kycr2_delay;
-	int keycodes[SH_KEYSC_MAXKEYS];
+	int keycodes[SH_KEYSC_MAXKEYS]; /* KEYIN * KEYOUT */
 };
 
 #endif /* __SH_KEYSC_H__ */
