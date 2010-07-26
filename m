From: Wayne Lin <00601wayne@gmail.com>
Subject: [RFC 27/36]  [Driver][Qualcomm 1070][EC_BRG] Enable NuvoTon WPCE775X driver and disable WinBond WPCE775X driver
Date: Mon, 26 Jul 2010 16:30:36 +0800
Message-ID: <1280133045-25945-27-git-send-email-wayne.lin@quantatw.com>
References: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59899 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753958Ab0GZId2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Jul 2010 04:33:28 -0400
Received: by pzk26 with SMTP id 26so890251pzk.19
        for <linux-input@vger.kernel.org>; Mon, 26 Jul 2010 01:33:28 -0700 (PDT)
In-Reply-To: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: wayne <wayne.lin@quantatw.com>

From: wayne <wayne.lin@quantatw.com>

---
 arch/arm/configs/qsd8650a-st1_5_defconfig |   17 ++++++-----------
 1 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/arm/configs/qsd8650a-st1_5_defconfig b/arch/arm/configs/qsd8650a-st1_5_defconfig
index 18ab3c2..4f3006e 100644
--- a/arch/arm/configs/qsd8650a-st1_5_defconfig
+++ b/arch/arm/configs/qsd8650a-st1_5_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.32.9
-# Mon Jun  7 14:52:04 2010
+# Mon Jun 14 18:41:45 2010
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -993,14 +993,8 @@ CONFIG_POWER_SUPPLY=y
 # CONFIG_BATTERY_DS2782 is not set
 # CONFIG_BATTERY_BQ27x00 is not set
 # CONFIG_BATTERY_MAX17040 is not set
-CONFIG_BATTERY_QCIBAT=y
 CONFIG_HWMON=y
 # CONFIG_HWMON_VID is not set
-# CONFIG_HWMON_DEBUG_CHIP is not set
-
-#
-# Native drivers
-#
 # CONFIG_SENSORS_AD7414 is not set
 # CONFIG_SENSORS_AD7418 is not set
 # CONFIG_SENSORS_ADCXX is not set
@@ -1052,7 +1046,6 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_ADS7828 is not set
 # CONFIG_SENSORS_THMC50 is not set
 # CONFIG_SENSORS_TMP401 is not set
-# CONFIG_SENSORS_TMP421 is not set
 # CONFIG_SENSORS_VT1211 is not set
 # CONFIG_SENSORS_W83781D is not set
 # CONFIG_SENSORS_W83791D is not set
@@ -1063,10 +1056,11 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_W83627HF is not set
 # CONFIG_SENSORS_W83627EHF is not set
 # CONFIG_SENSORS_LIS3_SPI is not set
-CONFIG_SENSORS_ISL29011=y
-CONFIG_SENSORS_WPCE775X=y
 CONFIG_SENSORS_HMC5843=y
-CONFIG_SENSORS_BOSCH_BMA150=y
+# CONFIG_HWMON_DEBUG_CHIP is not set
+CONFIG_SENSORS_ISL29011=y
+# CONFIG_SENSORS_WPCE775X is not set
+CONFIG_SENSORS_NPCE781X=y
 # CONFIG_THERMAL is not set
 # CONFIG_WATCHDOG is not set
 CONFIG_SSB_POSSIBLE=y
@@ -1604,6 +1598,7 @@ CONFIG_LEDS_CLASS=y
 # CONFIG_LEDS_PCA955X is not set
 # CONFIG_LEDS_DAC124S085 is not set
 # CONFIG_LEDS_BD2802 is not set
+# CONFIG_LEDS_QCIBL is not set
 
 #
 # LED Triggers
-- 
1.7.0.4

