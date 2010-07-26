From: Wayne Lin <00601wayne@gmail.com>
Subject: [RFC 32/36]  [Driver][Qualcomm 1070][MMC] Enable MMC1 HW detection
Date: Mon, 26 Jul 2010 16:30:41 +0800
Message-ID: <1280133045-25945-32-git-send-email-wayne.lin@quantatw.com>
References: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:46609 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753933Ab0GZIdh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Jul 2010 04:33:37 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so4323246pwi.19
        for <linux-input@vger.kernel.org>; Mon, 26 Jul 2010 01:33:37 -0700 (PDT)
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
index f82653b..fccad74 100644
--- a/arch/arm/configs/qsd8650a-st1_5_defconfig
+++ b/arch/arm/configs/qsd8650a-st1_5_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.32.9
-# Tue Jun 15 17:30:06 2010
+# Mon Jun 28 14:46:18 2010
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -1579,7 +1579,7 @@ CONFIG_MMC_BLOCK_PARANOID_RESUME=y
 CONFIG_MMC_MSM=y
 # CONFIG_MMC_MSM7X00A_RESUME_IN_WQ is not set
 # CONFIG_MMC_MSM_SDIO_SUPPORT is not set
-# CONFIG_MMC_MSM_CARD_HW_DETECTION is not set
+CONFIG_MMC_MSM_CARD_HW_DETECTION=y
 CONFIG_MMC_MSM_SDC1_SUPPORT=y
 # CONFIG_MMC_MSM_SDC1_8_BIT_SUPPORT is not set
 # CONFIG_MMC_MSM_SDC1_DUMMY52_REQUIRED is not set
-- 
1.7.0.4

