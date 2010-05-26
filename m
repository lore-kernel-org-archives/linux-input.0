From: Christoph Egger <siccegge@cs.fau.de>
Subject: [PATCH] config SPRUCE
Date: Wed, 26 May 2010 15:36:21 +0200
Message-ID: <20100526133621.GB7508__31953.7669224248$1274881466$gmane$org@faui49.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:65189 "EHLO
	faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755091Ab0EZNoT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 26 May 2010 09:44:19 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, Greg Ungerer <gerg@uclinux.org>, Thiago Farina <tfransosi@gmail.com>linux
Cc: vamos@i4.informatik.uni-erlangen.de

Hi all!

	As part of the VAMOS[0] research project at the University of
Erlangen we are looking at multiple integrity errors in linux'
configuration system.

	CONFIG_SPRUCE is obsolete since kernel 2.6.26 so this last bit
should be killed as well I guess.

	Please keep me informed of this patch getting confirmed /
merged so we can keep track of it.

Regards

	Christoph Egger

[0] http://vamos1.informatik.uni-erlangen.de/

----
>From 2f75bae3a66c39b85d83024fa86113cc5ea2c10b Mon Sep 17 00:00:00 2001
From: Christoph Egger <siccegge@cs.fau.de>
Date: Wed, 26 May 2010 12:47:42 +0200
Subject: [PATCH] Remaining of CONFIG_SPRUCE removal (2.6.26)

CONFIG_SPRUCE was removed from kernel around 2.6.26. Last piece of
relevant code that is still in linux' source tree will be removed by
this patch.

Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
---
 drivers/input/serio/i8042-ppcio.h |   75 -------------------------------------
 1 files changed, 0 insertions(+), 75 deletions(-)

diff --git a/drivers/input/serio/i8042-ppcio.h b/drivers/input/serio/i8042-ppcio.h
index 2906e1b..f708c75 100644
--- a/drivers/input/serio/i8042-ppcio.h
+++ b/drivers/input/serio/i8042-ppcio.h
@@ -52,81 +52,6 @@ static inline void i8042_platform_exit(void)
 {
 }
 
-#elif defined(CONFIG_SPRUCE)
-
-#define I8042_KBD_IRQ 22
-#define I8042_AUX_IRQ 21
-
-#define I8042_KBD_PHYS_DESC "spruceps2/serio0"
-#define I8042_AUX_PHYS_DESC "spruceps2/serio1"
-#define I8042_MUX_PHYS_DESC "spruceps2/serio%d"
-
-#define I8042_COMMAND_REG 0xff810000
-#define I8042_DATA_REG 0xff810001
-
-static inline int i8042_read_data(void)
-{
-	unsigned long kbd_data;
-
-	__raw_writel(0x00000088, 0xff500008);
-	eieio();
-
-	__raw_writel(0x03000000, 0xff50000c);
-	eieio();
-
-	asm volatile("lis     7,0xff88        \n\
-		      lswi    6,7,0x8         \n\
-		      mr      %0,6"
-	              : "=r" (kbd_data) :: "6", "7");
-
-	__raw_writel(0x00000000, 0xff50000c);
-	eieio();
-
-	return (unsigned char)(kbd_data >> 24);
-}
-
-static inline int i8042_read_status(void)
-{
-	unsigned long kbd_status;
-
-	__raw_writel(0x00000088, 0xff500008);
-	eieio();
-
-	__raw_writel(0x03000000, 0xff50000c);
-	eieio();
-
-	asm volatile("lis     7,0xff88        \n\
-		      ori     7,7,0x8         \n\
-		      lswi    6,7,0x8         \n\
-		      mr      %0,6"
-		      : "=r" (kbd_status) :: "6", "7");
-
-	__raw_writel(0x00000000, 0xff50000c);
-	eieio();
-
-	return (unsigned char)(kbd_status >> 24);
-}
-
-static inline void i8042_write_data(int val)
-{
-	*((unsigned char *)0xff810000) = (char)val;
-}
-
-static inline void i8042_write_command(int val)
-{
-	*((unsigned char *)0xff810001) = (char)val;
-}
-
-static inline int i8042_platform_init(void)
-{
-	i8042_reset = 1;
-	return 0;
-}
-
-static inline void i8042_platform_exit(void)
-{
-}
-
 #else
 
 #include "i8042-io.h"
-- 
1.6.3.3















