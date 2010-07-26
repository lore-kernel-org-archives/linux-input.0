From: Wayne Lin <00601wayne@gmail.com>
Subject: [RFC 17/36]  [Driver][Qualcomm 1070][WIFI/BT] Enable Athros WIFI driver
Date: Mon, 26 Jul 2010 16:30:26 +0800
Message-ID: <1280133045-25945-17-git-send-email-wayne.lin@quantatw.com>
References: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:46745 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463Ab0GZIdM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Jul 2010 04:33:12 -0400
Received: by pvc7 with SMTP id 7so4321238pvc.19
        for <linux-input@vger.kernel.org>; Mon, 26 Jul 2010 01:33:12 -0700 (PDT)
In-Reply-To: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: wayne <wayne.lin@quantatw.com>

From: wayne <wayne.lin@quantatw.com>

---
 arch/arm/configs/qsd8650a-st1_5_defconfig |   29 +++++++++++++++++++++++++++--
 1 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/qsd8650a-st1_5_defconfig b/arch/arm/configs/qsd8650a-st1_5_defconfig
index 9c8742b..5c9d1e7 100644
--- a/arch/arm/configs/qsd8650a-st1_5_defconfig
+++ b/arch/arm/configs/qsd8650a-st1_5_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.32.9
-# Mon Jun  7 11:41:09 2010
+# Mon Jun  7 13:35:03 2010
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -757,8 +757,14 @@ CONFIG_SMSC911X=y
 # CONFIG_NETDEV_10000 is not set
 CONFIG_WLAN=y
 # CONFIG_WLAN_PRE80211 is not set
-# CONFIG_WLAN_80211 is not set
+CONFIG_WLAN_80211=y
+# CONFIG_LIBERTAS is not set
+# CONFIG_USB_ZD1201 is not set
+# CONFIG_USB_NET_RNDIS_WLAN is not set
 CONFIG_LIBRA_SDIOIF=y
+# CONFIG_ATH_COMMON is not set
+# CONFIG_HOSTAP is not set
+# CONFIG_IWM is not set
 
 #
 # Enable WiMAX (Networking options) to see the WiMAX drivers
@@ -1710,6 +1716,25 @@ CONFIG_STAGING=y
 # CONFIG_IIO is not set
 
 #
+# Chromeos Supplied Third-Party Device Drivers
+#
+CONFIG_ATH6K_LEGACY=m
+CONFIG_AR600x_SD31_XXX=y
+# CONFIG_AR600x_WB31_XXX is not set
+# CONFIG_AR600x_SD32_XXX is not set
+# CONFIG_AR600x_CUSTOM_XXX is not set
+# CONFIG_ATH6KL_ENABLE_COEXISTENCE is not set
+# CONFIG_ATH6KL_HCI_BRIDGE is not set
+# CONFIG_ATH6KL_CFG80211 is not set
+# CONFIG_ATH6KL_HTC_RAW_INTERFACE is not set
+# CONFIG_ATH6KL_VIRTUAL_SCATTER_GATHER is not set
+CONFIG_ATH6KL_DEBUG=y
+# CONFIG_ATH6KL_ENABLE_HOST_DEBUG is not set
+CONFIG_ATH6KL_ENABLE_TARGET_DEBUG_PRINTS=y
+CONFIG_AR600x_DEBUG_UART_TX_PIN=8
+# CONFIG_ATH6KL_DISABLE_TARGET_DBGLOGS is not set
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
-- 
1.7.0.4

