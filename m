From: Wayne Lin <00601wayne@gmail.com>
Subject: [RFC 30/36]  [Driver][Qualcomm 1070][EC_G_SENSOR] Enable EC gravitation sensor
Date: Mon, 26 Jul 2010 16:30:39 +0800
Message-ID: <1280133045-25945-30-git-send-email-wayne.lin@quantatw.com>
References: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:46745 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753737Ab0GZIde (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Jul 2010 04:33:34 -0400
Received: by mail-pv0-f174.google.com with SMTP id 7so4321238pvc.19
        for <linux-input@vger.kernel.org>; Mon, 26 Jul 2010 01:33:32 -0700 (PDT)
In-Reply-To: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: wayne <wayne.lin@quantatw.com>

From: wayne <wayne.lin@quantatw.com>

---
 arch/arm/configs/qsd8650a-st1_5_defconfig |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/qsd8650a-st1_5_defconfig b/arch/arm/configs/qsd8650a-st1_5_defconfig
index df7cc18..f82653b 100644
--- a/arch/arm/configs/qsd8650a-st1_5_defconfig
+++ b/arch/arm/configs/qsd8650a-st1_5_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.32.9
-# Mon Jun 14 18:42:30 2010
+# Tue Jun 15 17:30:06 2010
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -995,6 +995,11 @@ CONFIG_POWER_SUPPLY=y
 # CONFIG_BATTERY_MAX17040 is not set
 CONFIG_HWMON=y
 # CONFIG_HWMON_VID is not set
+# CONFIG_HWMON_DEBUG_CHIP is not set
+
+#
+# Native drivers
+#
 # CONFIG_SENSORS_AD7414 is not set
 # CONFIG_SENSORS_AD7418 is not set
 # CONFIG_SENSORS_ADCXX is not set
@@ -1046,6 +1051,7 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_ADS7828 is not set
 # CONFIG_SENSORS_THMC50 is not set
 # CONFIG_SENSORS_TMP401 is not set
+# CONFIG_SENSORS_TMP421 is not set
 # CONFIG_SENSORS_VT1211 is not set
 # CONFIG_SENSORS_W83781D is not set
 # CONFIG_SENSORS_W83791D is not set
@@ -1056,10 +1062,10 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_W83627HF is not set
 # CONFIG_SENSORS_W83627EHF is not set
 # CONFIG_SENSORS_LIS3_SPI is not set
-CONFIG_SENSORS_HMC5843=y
-# CONFIG_HWMON_DEBUG_CHIP is not set
 CONFIG_SENSORS_ISL29011=y
 # CONFIG_SENSORS_WPCE775X is not set
+CONFIG_SENSORS_HMC5843=y
+CONFIG_SENSORS_BOSCH_BMA150=y
 CONFIG_SENSORS_NPCE781X=y
 # CONFIG_THERMAL is not set
 # CONFIG_WATCHDOG is not set
-- 
1.7.0.4

