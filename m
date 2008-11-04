From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [RFC 2.6.27 4/5] Move am200 specific gpio pins into am200epd.
Date: Tue,  4 Nov 2008 08:55:12 +0800
Message-ID: <12257601463698-git-send-email-jayakumar.lkml@gmail.com>
References: <12257601131298-git-send-email-jayakumar.lkml@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.238]:54998 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbYKDAzw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Nov 2008 19:55:52 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2922566rvb.1
        for <linux-input@vger.kernel.org>; Mon, 03 Nov 2008 16:55:52 -0800 (PST)
In-Reply-To: <12257601131298-git-send-email-jayakumar.lkml@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-input@vger.kernel.org, Jaya Kumar <jayakumar.lkml@gmail.com>

The gpio setup for AM200 specific GPIO pins should be done in the AM200
code rather than in generic gumstix code.

Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
---
 arch/arm/mach-pxa/am200epd.c |   15 +++++++++++++++
 arch/arm/mach-pxa/gumstix.c  |    7 -------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-pxa/am200epd.c b/arch/arm/mach-pxa/am200epd.c
index b965085..3a4f8d8 100644
--- a/arch/arm/mach-pxa/am200epd.c
+++ b/arch/arm/mach-pxa/am200epd.c
@@ -30,8 +30,12 @@
 #include <linux/irq.h>
 #include <linux/gpio.h>
 
+#include <mach/gumstix.h>
+#include <mach/mfp-pxa25x.h>
 #include <mach/pxafb.h>
 
+#include "generic.h"
+
 #include <video/metronomefb.h>
 
 static unsigned int panel_type = 6;
@@ -331,6 +335,15 @@ static struct metronome_board am200_board = {
 	.cleanup		= am200_cleanup,
 };
 
+static unsigned long am200_pin_config[] __initdata = {
+	GPIO51_GPIO,
+	GPIO49_GPIO,
+	GPIO48_GPIO,
+	GPIO32_GPIO,
+	GPIO17_GPIO,
+	GPIO16_GPIO,
+};
+
 static int __init am200_init(void)
 {
 	int ret;
@@ -339,6 +352,8 @@ static int __init am200_init(void)
 	 * creation events */
 	fb_register_client(&am200_fb_notif);
 
+	pxa2xx_mfp_config(ARRAY_AND_SIZE(am200_pin_config));
+
 	/* request our platform independent driver */
 	request_module("metronomefb");
 
diff --git a/arch/arm/mach-pxa/gumstix.c b/arch/arm/mach-pxa/gumstix.c
index d8962a0..06bc667 100644
--- a/arch/arm/mach-pxa/gumstix.c
+++ b/arch/arm/mach-pxa/gumstix.c
@@ -184,13 +184,6 @@ static unsigned long gumstix_pin_config[] __initdata = {
 	GPIO6_MMC_CLK,
 	GPIO53_MMC_CLK,
 	GPIO8_MMC_CS0,
-	/* these are used by AM200EPD */
-	GPIO51_GPIO,
-	GPIO49_GPIO,
-	GPIO48_GPIO,
-	GPIO32_GPIO,
-	GPIO17_GPIO,
-	GPIO16_GPIO,
 };
 
 static void __init gumstix_init(void)
-- 
1.5.2.3

