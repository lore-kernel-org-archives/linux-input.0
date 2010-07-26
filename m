From: Wayne Lin <00601wayne@gmail.com>
Subject: [RFC 20/36]  [Driver][Qualcomm 1070][WIFI/BT] Enable MMC1 dummy send read and configure Athros WIFI build-in driver
Date: Mon, 26 Jul 2010 16:30:29 +0800
Message-ID: <1280133045-25945-20-git-send-email-wayne.lin@quantatw.com>
References: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:46745 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852Ab0GZIdR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Jul 2010 04:33:17 -0400
Received: by mail-pv0-f174.google.com with SMTP id 7so4321238pvc.19
        for <linux-input@vger.kernel.org>; Mon, 26 Jul 2010 01:33:17 -0700 (PDT)
In-Reply-To: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: wayne <wayne.lin@quantatw.com>

From: wayne <wayne.lin@quantatw.com>

---
 arch/arm/configs/qsd8650a-st1_5_defconfig |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/qsd8650a-st1_5_defconfig b/arch/arm/configs/qsd8650a-st1_5_defconfig
index a88f1d9..18ab3c2 100644
--- a/arch/arm/configs/qsd8650a-st1_5_defconfig
+++ b/arch/arm/configs/qsd8650a-st1_5_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.32.9
-# Mon Jun  7 13:56:07 2010
+# Mon Jun  7 14:52:04 2010
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -1582,12 +1582,15 @@ CONFIG_MMC_MSM=y
 # CONFIG_MMC_MSM_CARD_HW_DETECTION is not set
 CONFIG_MMC_MSM_SDC1_SUPPORT=y
 # CONFIG_MMC_MSM_SDC1_8_BIT_SUPPORT is not set
+# CONFIG_MMC_MSM_SDC1_DUMMY52_REQUIRED is not set
 CONFIG_MMC_MSM_SDC2_SUPPORT=y
 # CONFIG_MMC_MSM_SDC2_8_BIT_SUPPORT is not set
+CONFIG_MMC_MSM_SDC2_DUMMY52_REQUIRED=y
 CONFIG_MMC_MSM_SDC3_SUPPORT=y
 CONFIG_MMC_MSM_SDC3_8_BIT_SUPPORT=y
+# CONFIG_MMC_MSM_SDC3_DUMMY52_REQUIRED is not set
 # CONFIG_MMC_MSM_SDC4_SUPPORT is not set
-CONFIG_MMC_MSM_PROG_DONE_SCAN=y
+# CONFIG_MMC_MSM_PROG_DONE_SCAN is not set
 # CONFIG_MEMSTICK is not set
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
@@ -1718,7 +1721,7 @@ CONFIG_STAGING=y
 #
 # Chromeos Supplied Third-Party Device Drivers
 #
-CONFIG_ATH6K_LEGACY=m
+CONFIG_ATH6K_LEGACY=y
 # CONFIG_AR600x_SD31_XXX is not set
 CONFIG_AR600x_WB31_XXX=y
 # CONFIG_AR600x_SD32_XXX is not set
-- 
1.7.0.4

