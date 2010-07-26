From: Wayne Lin <00601wayne@gmail.com>
Subject: [RFC 07/36]  [Driver][Qualcomm 1070][EC_BRG] Enable EC Bridge
Date: Mon, 26 Jul 2010 16:30:16 +0800
Message-ID: <1280133045-25945-7-git-send-email-wayne.lin@quantatw.com>
References: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56228 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753954Ab0GZIbF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Jul 2010 04:31:05 -0400
Received: by pwi5 with SMTP id 5so4322709pwi.19
        for <linux-input@vger.kernel.org>; Mon, 26 Jul 2010 01:31:05 -0700 (PDT)
In-Reply-To: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: wayne <wayne.lin@quantatw.com>

From: wayne <wayne.lin@quantatw.com>

---
 arch/arm/configs/qsd8650a-st1_5_defconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/qsd8650a-st1_5_defconfig b/arch/arm/configs/qsd8650a-st1_5_defconfig
index d72bd03..efb0f05 100644
--- a/arch/arm/configs/qsd8650a-st1_5_defconfig
+++ b/arch/arm/configs/qsd8650a-st1_5_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.32.9
-# Sat Jun  5 18:26:10 2010
+# Mon Jun  7 11:20:32 2010
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -1057,6 +1057,7 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_W83627EHF is not set
 # CONFIG_SENSORS_LIS3_SPI is not set
 CONFIG_SENSORS_ISL29011=y
+CONFIG_SENSORS_WPCE775X=y
 # CONFIG_THERMAL is not set
 # CONFIG_WATCHDOG is not set
 CONFIG_SSB_POSSIBLE=y
-- 
1.7.0.4

