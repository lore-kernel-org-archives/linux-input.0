From: Wayne Lin <00601wayne@gmail.com>
Subject: [RFC 22/36]  [Driver][Qualcomm 1070][CLOCK] Modify the AXI bus maximum speed
Date: Mon, 26 Jul 2010 16:30:31 +0800
Message-ID: <1280133045-25945-22-git-send-email-wayne.lin@quantatw.com>
References: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48857 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884Ab0GZIdU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Jul 2010 04:33:20 -0400
Received: by pwi5 with SMTP id 5so4323251pwi.19
        for <linux-input@vger.kernel.org>; Mon, 26 Jul 2010 01:33:20 -0700 (PDT)
In-Reply-To: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: wayne <wayne.lin@quantatw.com>

From: wayne <wayne.lin@quantatw.com>

---
 arch/arm/mach-msm/board-qsd8x50.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/board-qsd8x50.c b/arch/arm/mach-msm/board-qsd8x50.c
index 0d44c2d..54ca8e7 100644
--- a/arch/arm/mach-msm/board-qsd8x50.c
+++ b/arch/arm/mach-msm/board-qsd8x50.c
@@ -2129,7 +2129,11 @@ static struct resource kgsl_resources[] = {
 #endif
 };
 static struct kgsl_platform_data kgsl_pdata = {
+#ifdef CONFIG_MSM_SOC_REV_A
+	.max_axi_freq = 192000, /*Max for 8650A*/
+#else
 	.max_axi_freq = 128000, /*Max for 8K*/
+#endif
 };
 
 static struct platform_device msm_device_kgsl = {
-- 
1.7.0.4

