From: Wayne Lin <00601wayne@gmail.com>
Subject: [RFC 02/36]  [Driver][Qualcomm 1070][USB] Register GPIO#109 for USB analog switch configuration
Date: Mon, 26 Jul 2010 16:30:11 +0800
Message-ID: <1280133045-25945-2-git-send-email-wayne.lin@quantatw.com>
References: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f194.google.com ([74.125.83.194]:57937 "EHLO
	mail-pv0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753321Ab0GZJ0Q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Jul 2010 05:26:16 -0400
Received: by pvc7 with SMTP id 7so4889491pvc.1
        for <linux-input@vger.kernel.org>; Mon, 26 Jul 2010 02:26:16 -0700 (PDT)
In-Reply-To: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: wayne <wayne.lin@quantatw.com>

From: wayne <wayne.lin@quantatw.com>

---
 arch/arm/mach-msm/board-qsd8x50.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-msm/board-qsd8x50.c b/arch/arm/mach-msm/board-qsd8x50.c
index 0cab166..633514a 100644
--- a/arch/arm/mach-msm/board-qsd8x50.c
+++ b/arch/arm/mach-msm/board-qsd8x50.c
@@ -416,7 +416,7 @@ static struct msm_gpio hsusb_gpio_config_data[] = {
 	{ GPIO_CFG(98, 0, GPIO_OUTPUT, GPIO_NO_PULL, GPIO_2MA), "fs_power" },
 	{ GPIO_CFG(HUB_RESET_GPIO, 0, GPIO_OUTPUT, GPIO_NO_PULL, GPIO_2MA),
 								"swch_ctrl" },
-	{ GPIO_CFG(108, 0, GPIO_OUTPUT, GPIO_NO_PULL, GPIO_2MA), "hub_reset" },
+	{ GPIO_CFG(109, 0, GPIO_OUTPUT, GPIO_NO_PULL, GPIO_2MA), "hub_reset" },
 };
 
 static int msm_otg_gpio_init(void)
@@ -441,12 +441,12 @@ static void msm_otg_setup_gpio(unsigned int enable)
 			/* Config analog switch as USB host. */
 			gpio_set_value(98, 0); /* USB_FS_POWER_EN */
 			gpio_set_value(HUB_RESET_GPIO, 0); /* SWITCH_CONTROL */
-			gpio_set_value(108, 1); /* USB_HUB_RESET */
+			gpio_set_value(109, 1); /* USB_HUB_RESET */
 		} else {
 			/* Config analog switch as USB peripheral. */
 			gpio_set_value(98, 0); /* USB_FS_POWER_EN */
 			gpio_set_value(HUB_RESET_GPIO, 1); /* SWITCH_CONTROL */
-			gpio_set_value(108, 0); /* USB_HUB_RESET */
+			gpio_set_value(109, 0); /* USB_HUB_RESET */
 		}
 	}
 }
-- 
1.7.0.4

