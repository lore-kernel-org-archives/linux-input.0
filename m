From: Duan Jiong <duanj.fnst@cn.fujitsu.com>
Subject: [PATCH] leds: leds-mc13783: replace IS_ERR and PTR_ERR with PTR_ERR_OR_ZERO
Date: Wed, 6 Nov 2013 15:54:44 +0800
Message-ID: <1383724484-15520-1-git-send-email-duanj.fnst@cn.fujitsu.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel@pengutronix.de, linux@arm.linux.org.uk, a.zummo@towertech.it, airlied@linux.ie, dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, linux-input@vger.kernel.org, Duan Jiong <duanj.fnst@cn.fujitsu.com>
List-Id: linux-input@vger.kernel.org

This patch fixes coccinelle error regarding usage of IS_ERR and
PTR_ERR instead of PTR_ERR_OR_ZERO.

Signed-off-by: Duan Jiong <duanj.fnst@cn.fujitsu.com>
---
 arch/arm/mach-imx/mach-mx31moboard.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index 6f424ec..118ea68 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -446,10 +446,7 @@ static int __init moboard_usbh2_init(void)
 		return -ENODEV;
 
 	pdev = imx31_add_mxc_ehci_hs(2, &usbh2_pdata);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(pdev);
 }
 
 static const struct gpio_led mx31moboard_leds[] __initconst = {
-- 
1.8.3.1
