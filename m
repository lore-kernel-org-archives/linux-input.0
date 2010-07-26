From: Wayne Lin <00601wayne@gmail.com>
Subject: [RFC 05/36]  [Driver][Qualcomm 1070][TPM] Enable TPM module
Date: Mon, 26 Jul 2010 16:30:14 +0800
Message-ID: <1280133045-25945-5-git-send-email-wayne.lin@quantatw.com>
References: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:62361 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753933Ab0GZIbD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Jul 2010 04:31:03 -0400
Received: by mail-px0-f174.google.com with SMTP id 14so4452135pxi.19
        for <linux-input@vger.kernel.org>; Mon, 26 Jul 2010 01:31:01 -0700 (PDT)
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
index 4778703..d72bd03 100644
--- a/arch/arm/configs/qsd8650a-st1_5_defconfig
+++ b/arch/arm/configs/qsd8650a-st1_5_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.32.9
-# Fri Jun  4 15:48:06 2010
+# Sat Jun  5 18:26:10 2010
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -907,7 +907,10 @@ CONFIG_UNIX98_PTYS=y
 # CONFIG_HW_RANDOM is not set
 # CONFIG_R3964 is not set
 # CONFIG_RAW_DRIVER is not set
-# CONFIG_TCG_TPM is not set
+CONFIG_TCG_TPM=y
+# CONFIG_TCG_NSC is not set
+# CONFIG_TCG_ATMEL is not set
+CONFIG_TCG_ST_I2C=y
 CONFIG_Q6_VENC=y
 CONFIG_MSM_KGSL=y
 CONFIG_MSM_KGSL_DRM=y
@@ -1973,7 +1976,7 @@ CONFIG_DEBUG_LL=y
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
-# CONFIG_SECURITYFS is not set
+CONFIG_SECURITYFS=y
 CONFIG_SECURITY_FILE_CAPABILITIES=y
 # CONFIG_CRYPTO is not set
 CONFIG_BINARY_PRINTF=y
-- 
1.7.0.4

