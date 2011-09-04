From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH] arm: exynos4: fix incorrect pad configuration for keypad row
 lines
Date: Sun, 04 Sep 2011 15:10:44 +0530
Message-ID: <1315129244-26489-1-git-send-email-thomas.abraham@linaro.org>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:26498 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752965Ab1IDJlG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 4 Sep 2011 05:41:06 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org
Cc: kgene.kim@samsung.com, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The keypad controller requires a external pull-up for all the keypad
row lines. Fix the incorrect pad configuration for keypad controller
row lines by enabling the pad pull-up for the all row lines of the
keypad controller.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
SMDKV310 board does not have pull-up resistors populated for the keypad
row lines (unlike the smdk boards for the previous Samsung SoC's). So
the pad pull-up for all keypad row lines should be enabled for
smdkv310 board.

The default requirement for the keypad controller is to enable the
pull-up for all the keypad row lines. If a exynos4 based board has
on-board pull-up's populated for keypad row lines, this patch would
cause no harm. And in such cases, if internal pad pull-up is to be
disabled (to reduce some power consumption), an alternative gpio
configuration function can be supplied that does not enable the
internal pad pull-up.
---
 arch/arm/mach-exynos4/setup-keypad.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-exynos4/setup-keypad.c b/arch/arm/mach-exynos4/setup-keypad.c
index 1ee0ebf..7862bfb 100644
--- a/arch/arm/mach-exynos4/setup-keypad.c
+++ b/arch/arm/mach-exynos4/setup-keypad.c
@@ -19,15 +19,16 @@ void samsung_keypad_cfg_gpio(unsigned int rows, unsigned int cols)
 
 	if (rows > 8) {
 		/* Set all the necessary GPX2 pins: KP_ROW[0~7] */
-		s3c_gpio_cfgrange_nopull(EXYNOS4_GPX2(0), 8, S3C_GPIO_SFN(3));
+		s3c_gpio_cfgall_range(EXYNOS4_GPX2(0), 8, S3C_GPIO_SFN(3),
+					S3C_GPIO_PULL_UP);
 
 		/* Set all the necessary GPX3 pins: KP_ROW[8~] */
-		s3c_gpio_cfgrange_nopull(EXYNOS4_GPX3(0), (rows - 8),
-					 S3C_GPIO_SFN(3));
+		s3c_gpio_cfgall_range(EXYNOS4_GPX3(0), (rows - 8),
+					 S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);
 	} else {
 		/* Set all the necessary GPX2 pins: KP_ROW[x] */
-		s3c_gpio_cfgrange_nopull(EXYNOS4_GPX2(0), rows,
-					 S3C_GPIO_SFN(3));
+		s3c_gpio_cfgall_range(EXYNOS4_GPX2(0), rows, S3C_GPIO_SFN(3),
+					S3C_GPIO_PULL_UP);
 	}
 
 	/* Set all the necessary GPX1 pins to special-function 3: KP_COL[x] */
-- 
1.6.6.rc2

