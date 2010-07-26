From: Wayne Lin <00601wayne@gmail.com>
Subject: [RFC 09/36]  [Driver][Qualcomm 1070][EC_BAT] Enable EC battery
Date: Mon, 26 Jul 2010 16:30:18 +0800
Message-ID: <1280133045-25945-9-git-send-email-wayne.lin@quantatw.com>
References: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:53596 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754025Ab0GZIbI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Jul 2010 04:31:08 -0400
Received: by mail-pz0-f46.google.com with SMTP id 26so889701pzk.19
        for <linux-input@vger.kernel.org>; Mon, 26 Jul 2010 01:31:08 -0700 (PDT)
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
index efb0f05..365137b 100644
--- a/arch/arm/configs/qsd8650a-st1_5_defconfig
+++ b/arch/arm/configs/qsd8650a-st1_5_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.32.9
-# Mon Jun  7 11:20:32 2010
+# Mon Jun  7 11:24:52 2010
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -987,6 +987,7 @@ CONFIG_POWER_SUPPLY=y
 # CONFIG_BATTERY_DS2782 is not set
 # CONFIG_BATTERY_BQ27x00 is not set
 # CONFIG_BATTERY_MAX17040 is not set
+CONFIG_BATTERY_QCIBAT=y
 CONFIG_HWMON=y
 # CONFIG_HWMON_VID is not set
 # CONFIG_HWMON_DEBUG_CHIP is not set
-- 
1.7.0.4

