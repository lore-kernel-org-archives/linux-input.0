From: "Mark F. Brown" <mark.brown314@gmail.com>
Subject: [PATCH v2 5/6 RESEND] ARM: pxa168: added keypad wake clear event support for platform
Date: Fri,  3 Sep 2010 18:28:10 -0400
Message-ID: <1283552891-13966-6-git-send-email-mark.brown314__35014.215092133$1283553057$gmane$org@gmail.com>
References: <1283552891-13966-1-git-send-email-mark.brown314@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:51358 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754800Ab0ICW3v (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Sep 2010 18:29:51 -0400
In-Reply-To: <1283552891-13966-1-git-send-email-mark.brown314@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>li
Cc: "Mark F. Brown" <mark.brown314@gmail.com>

Signed-off-by: Mark F. Brown <mark.brown314@gmail.com>
---
 arch/arm/mach-mmp/include/mach/pxa168.h |    5 +++++
 arch/arm/mach-mmp/pxa168.c              |   10 ++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/include/mach/pxa168.h b/arch/arm/mach-mmp/include/mach/pxa168.h
index f34e663..1801e42 100644
--- a/arch/arm/mach-mmp/include/mach/pxa168.h
+++ b/arch/arm/mach-mmp/include/mach/pxa168.h
@@ -5,6 +5,7 @@ struct sys_timer;
 
 extern struct sys_timer pxa168_timer;
 extern void __init pxa168_init_irq(void);
+extern void pxa168_clear_keypad_wakeup(void);
 
 #include <linux/i2c.h>
 #include <mach/devices.h>
@@ -12,6 +13,7 @@ extern void __init pxa168_init_irq(void);
 #include <plat/pxa3xx_nand.h>
 #include <video/pxa168fb.h>
 #include <plat/pxa27x_keypad.h>
+#include <mach/cputype.h>
 
 extern struct pxa_device_desc pxa168_device_uart1;
 extern struct pxa_device_desc pxa168_device_uart2;
@@ -109,6 +111,9 @@ static inline int pxa168_add_fb(struct pxa168fb_mach_info *mi)
 
 static inline int pxa168_add_keypad(struct pxa27x_keypad_platform_data *data)
 {
+	if (cpu_is_pxa168())
+		data->clear_wakeup_event = pxa168_clear_keypad_wakeup;
+
 	return pxa_register_device(&pxa168_device_keypad, data, sizeof(*data));
 }
 
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 2fa16fb..72b4e76 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -136,6 +136,16 @@ struct sys_timer pxa168_timer = {
 	.init	= pxa168_timer_init,
 };
 
+void pxa168_clear_keypad_wakeup(void)
+{
+	uint32_t val;
+	uint32_t mask = APMU_PXA168_KP_WAKE_CLR;
+
+	/* wake event clear is needed in order to clear keypad interrupt */
+	val = __raw_readl(APMU_WAKE_CLR);
+	__raw_writel(val |  mask, APMU_WAKE_CLR);
+}
+
 /* on-chip devices */
 PXA168_DEVICE(uart1, "pxa2xx-uart", 0, UART1, 0xd4017000, 0x30, 21, 22);
 PXA168_DEVICE(uart2, "pxa2xx-uart", 1, UART2, 0xd4018000, 0x30, 23, 24);
-- 
1.7.0.4

