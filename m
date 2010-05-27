From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH] s3c2410_ts: restore s3c24xx ids
Date: Thu, 27 May 2010 09:16:37 +0300
Message-ID: <1274940997-23706-1-git-send-email-anarsoul@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46210 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428Ab0E0GTA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 May 2010 02:19:00 -0400
Received: by bwz11 with SMTP id 11so64860bwz.19
        for <linux-input@vger.kernel.org>; Wed, 26 May 2010 23:18:59 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>

Without s3c24xx ids driver doesn't attach on s3c2410 and s3c244x

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/input/touchscreen/s3c2410_ts.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
index e0b7c83..ac5d0f9 100644
--- a/drivers/input/touchscreen/s3c2410_ts.c
+++ b/drivers/input/touchscreen/s3c2410_ts.c
@@ -413,6 +413,8 @@ static struct dev_pm_ops s3c_ts_pmops = {
 #endif
 
 static struct platform_device_id s3cts_driver_ids[] = {
+	{ "s3c2410-ts", 0 },
+	{ "s3c2440-ts", 0 },
 	{ "s3c64xx-ts", FEAT_PEN_IRQ },
 	{ }
 };
-- 
1.7.1

