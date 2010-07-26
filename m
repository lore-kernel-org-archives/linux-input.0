From: Wayne Lin <00601wayne@gmail.com>
Subject: [RFC 14/36]  [Driver][Qualcomm 1070][CLOCK] Modify the AXI bus speed
Date: Mon, 26 Jul 2010 16:30:23 +0800
Message-ID: <1280133045-25945-14-git-send-email-wayne.lin@quantatw.com>
References: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56228 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753954Ab0GZIbS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Jul 2010 04:31:18 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so4322709pwi.19
        for <linux-input@vger.kernel.org>; Mon, 26 Jul 2010 01:31:18 -0700 (PDT)
In-Reply-To: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: wayne <wayne.lin@quantatw.com>

From: wayne <wayne.lin@quantatw.com>

---
 arch/arm/mach-msm/acpuclock-8x50a.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-msm/acpuclock-8x50a.c b/arch/arm/mach-msm/acpuclock-8x50a.c
index fab4c27..beaac14 100644
--- a/arch/arm/mach-msm/acpuclock-8x50a.c
+++ b/arch/arm/mach-msm/acpuclock-8x50a.c
@@ -106,7 +106,7 @@ struct clkctl_acpu_speed acpu_freq_tbl[] = {
 	{ 0,  921600, ACPU_PLL_3, 0, 0, 0, 0, 128000, 1, 0x18, 1225 },
 	{ 0,  960000, ACPU_PLL_3, 0, 0, 0, 0, 128000, 1, 0x19, 1225 },
 	{ 1,  998400, ACPU_PLL_3, 0, 0, 0, 0, 128000, 1, 0x1A, 1225 },
-	{ 1, 1190400, ACPU_PLL_3, 0, 0, 0, 0, 128000, 1, 0x1F, 1225 },
+	{ 1, 1190400, ACPU_PLL_3, 0, 0, 0, 0, 192000, 1, 0x1F, 1225 },
 	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
 };
 
-- 
1.7.0.4

