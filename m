From: Wayne Lin <00601wayne@gmail.com>
Subject: [RFC 28/36]  [Driver][Qualcomm 1070][EC_BL] Enable QCI backlight driver
Date: Mon, 26 Jul 2010 16:30:37 +0800
Message-ID: <1280133045-25945-28-git-send-email-wayne.lin@quantatw.com>
References: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:52463 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753994Ab0GZIda (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Jul 2010 04:33:30 -0400
Received: by pvc7 with SMTP id 7so4321295pvc.19
        for <linux-input@vger.kernel.org>; Mon, 26 Jul 2010 01:33:29 -0700 (PDT)
In-Reply-To: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: wayne <wayne.lin@quantatw.com>

From: wayne <wayne.lin@quantatw.com>

---
 arch/arm/configs/qsd8650a-st1_5_defconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/qsd8650a-st1_5_defconfig b/arch/arm/configs/qsd8650a-st1_5_defconfig
index 4f3006e..df7cc18 100644
--- a/arch/arm/configs/qsd8650a-st1_5_defconfig
+++ b/arch/arm/configs/qsd8650a-st1_5_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.32.9
-# Mon Jun 14 18:41:45 2010
+# Mon Jun 14 18:42:30 2010
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -1598,7 +1598,7 @@ CONFIG_LEDS_CLASS=y
 # CONFIG_LEDS_PCA955X is not set
 # CONFIG_LEDS_DAC124S085 is not set
 # CONFIG_LEDS_BD2802 is not set
-# CONFIG_LEDS_QCIBL is not set
+CONFIG_LEDS_QCIBL=y
 
 #
 # LED Triggers
-- 
1.7.0.4

