From: Wayne Lin <00601wayne@gmail.com>
Subject: [RFC 19/36]  [Driver][Qualcomm 1070][BT] Enable Athros BT driver
Date: Mon, 26 Jul 2010 16:30:28 +0800
Message-ID: <1280133045-25945-19-git-send-email-wayne.lin@quantatw.com>
References: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:54628 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753737Ab0GZIdP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Jul 2010 04:33:15 -0400
Received: by pwi5 with SMTP id 5so4323235pwi.19
        for <linux-input@vger.kernel.org>; Mon, 26 Jul 2010 01:33:15 -0700 (PDT)
In-Reply-To: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: wayne <wayne.lin@quantatw.com>

From: wayne <wayne.lin@quantatw.com>

---
 arch/arm/configs/qsd8650a-st1_5_defconfig |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm/configs/qsd8650a-st1_5_defconfig b/arch/arm/configs/qsd8650a-st1_5_defconfig
index 5c9d1e7..a88f1d9 100644
--- a/arch/arm/configs/qsd8650a-st1_5_defconfig
+++ b/arch/arm/configs/qsd8650a-st1_5_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.32.9
-# Mon Jun  7 13:35:03 2010
+# Mon Jun  7 13:56:07 2010
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -1719,12 +1719,19 @@ CONFIG_STAGING=y
 # Chromeos Supplied Third-Party Device Drivers
 #
 CONFIG_ATH6K_LEGACY=m
-CONFIG_AR600x_SD31_XXX=y
-# CONFIG_AR600x_WB31_XXX is not set
+# CONFIG_AR600x_SD31_XXX is not set
+CONFIG_AR600x_WB31_XXX=y
 # CONFIG_AR600x_SD32_XXX is not set
 # CONFIG_AR600x_CUSTOM_XXX is not set
-# CONFIG_ATH6KL_ENABLE_COEXISTENCE is not set
-# CONFIG_ATH6KL_HCI_BRIDGE is not set
+CONFIG_ATH6KL_ENABLE_COEXISTENCE=y
+CONFIG_AR600x_DUAL_ANTENNA=y
+# CONFIG_AR600x_SINGLE_ANTENNA is not set
+# CONFIG_AR600x_BT_QCOM is not set
+# CONFIG_AR600x_BT_CSR is not set
+CONFIG_AR600x_BT_AR3001=y
+CONFIG_ATH6KL_HCI_BRIDGE=y
+CONFIG_ATH6KL_CONFIG_GPIO_BT_RESET=y
+CONFIG_AR600x_BT_RESET_PIN=22
 # CONFIG_ATH6KL_CFG80211 is not set
 # CONFIG_ATH6KL_HTC_RAW_INTERFACE is not set
 # CONFIG_ATH6KL_VIRTUAL_SCATTER_GATHER is not set
-- 
1.7.0.4

