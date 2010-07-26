From: Wayne Lin <00601wayne@gmail.com>
Subject: [RFC 01/36]  [Driver][Qualcomm 1070][LCD] Resolve the booting to Chromium issue
Date: Mon, 26 Jul 2010 16:30:10 +0800
Message-ID: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:62361 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121Ab0GZIaw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Jul 2010 04:30:52 -0400
Received: by pxi14 with SMTP id 14so4452135pxi.19
        for <linux-input@vger.kernel.org>; Mon, 26 Jul 2010 01:30:52 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: wayne <wayne.lin@quantatw.com>

From: wayne <wayne.lin@quantatw.com>

---
 drivers/video/msm/lcdc_st15.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/msm/lcdc_st15.c b/drivers/video/msm/lcdc_st15.c
index c554193..1fc228d 100644
--- a/drivers/video/msm/lcdc_st15.c
+++ b/drivers/video/msm/lcdc_st15.c
@@ -506,7 +506,7 @@ static int __init lcdc_st15_init(void)
 	pinfo->type = LCDC_PANEL;
 	pinfo->pdest = DISPLAY_1;
 	pinfo->wait_cycle = 0;
-	pinfo->bpp = 24;
+	pinfo->bpp = 18;
 	pinfo->fb_num = 2;
 	pinfo->clk_rate = 74250000;
 
-- 
1.7.0.4

