From: Wayne Lin <00601wayne@gmail.com>
Subject: [RFC 35/36]  [Driver][Qualcomm 1070][EC_BAT] Enable EC battery
Date: Mon, 26 Jul 2010 16:30:44 +0800
Message-ID: <1280133045-25945-35-git-send-email-wayne.lin@quantatw.com>
References: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48857 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754043Ab0GZIdn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Jul 2010 04:33:43 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so4323251pwi.19
        for <linux-input@vger.kernel.org>; Mon, 26 Jul 2010 01:33:43 -0700 (PDT)
In-Reply-To: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: wayne <wayne.lin@quantatw.com>

From: wayne <wayne.lin@quantatw.com>

---
 arch/arm/configs/qsd8650a-st1_5_defconfig |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/configs/qsd8650a-st1_5_defconfig b/arch/arm/configs/qsd8650a-st1_5_defconfig
index fccad74..30caca8 100644
--- a/arch/arm/configs/qsd8650a-st1_5_defconfig
+++ b/arch/arm/configs/qsd8650a-st1_5_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.32.9
-# Mon Jun 28 14:46:18 2010
+# Wed Jul 21 15:20:49 2010
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -993,6 +993,7 @@ CONFIG_POWER_SUPPLY=y
 # CONFIG_BATTERY_DS2782 is not set
 # CONFIG_BATTERY_BQ27x00 is not set
 # CONFIG_BATTERY_MAX17040 is not set
+CONFIG_BATTERY_QCIBAT=y
 CONFIG_HWMON=y
 # CONFIG_HWMON_VID is not set
 # CONFIG_HWMON_DEBUG_CHIP is not set
@@ -1572,13 +1573,14 @@ CONFIG_MMC_BLOCK_PARANOID_RESUME=y
 #
 # MMC/SD/SDIO Host Controller Drivers
 #
-# CONFIG_MMC_SDHCI is not set
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
 # CONFIG_MMC_AT91 is not set
 # CONFIG_MMC_ATMELMCI is not set
 # CONFIG_MMC_SPI is not set
 CONFIG_MMC_MSM=y
-# CONFIG_MMC_MSM7X00A_RESUME_IN_WQ is not set
-# CONFIG_MMC_MSM_SDIO_SUPPORT is not set
+CONFIG_MMC_MSM7X00A_RESUME_IN_WQ=y
+CONFIG_MMC_MSM_SDIO_SUPPORT=y
 CONFIG_MMC_MSM_CARD_HW_DETECTION=y
 CONFIG_MMC_MSM_SDC1_SUPPORT=y
 # CONFIG_MMC_MSM_SDC1_8_BIT_SUPPORT is not set
-- 
1.7.0.4

