From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] Input: s3c2410 - Trivial cleanup in header file
Date: Fri, 14 Feb 2014 12:35:39 +0530
Message-ID: <1392361539-24397-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:47074 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135AbaBNHK4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Feb 2014 02:10:56 -0500
Received: by mail-pd0-f171.google.com with SMTP id g10so11538047pdj.16
        for <linux-input@vger.kernel.org>; Thu, 13 Feb 2014 23:10:55 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, trivial@kernel.org, sachin.kamat@linaro.org

Commit 436d42c61c3e ("ARM: samsung: move platform_data definitions")
moved the files to the current location but forgot to remove the pointer
to its previous location. Clean it up. While at it also change the header
file protection macros appropriately and remove whitespace errors.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 include/linux/platform_data/touchscreen-s3c2410.h |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/linux/platform_data/touchscreen-s3c2410.h b/include/linux/platform_data/touchscreen-s3c2410.h
index 26fdb22e0fc2..58dc7c5ae63b 100644
--- a/include/linux/platform_data/touchscreen-s3c2410.h
+++ b/include/linux/platform_data/touchscreen-s3c2410.h
@@ -1,5 +1,4 @@
-/* arch/arm/plat-samsung/include/plat/ts.h
- *
+/*
  * Copyright (c) 2005 Arnaud Patard <arnaud.patard@rtp-net.org>
  *
  * This program is free software; you can redistribute it and/or modify
@@ -7,14 +6,14 @@
  * published by the Free Software Foundation.
 */
 
-#ifndef __ASM_ARM_TS_H
-#define __ASM_ARM_TS_H
+#ifndef __TOUCHSCREEN_S3C2410_H
+#define __TOUCHSCREEN_S3C2410_H
 
 struct s3c2410_ts_mach_info {
-       int             delay;
-       int             presc;
-       int             oversampling_shift;
-	void    (*cfg_gpio)(struct platform_device *dev);
+	int delay;
+	int presc;
+	int oversampling_shift;
+	void (*cfg_gpio)(struct platform_device *dev);
 };
 
 extern void s3c24xx_ts_set_platdata(struct s3c2410_ts_mach_info *);
@@ -22,4 +21,4 @@ extern void s3c24xx_ts_set_platdata(struct s3c2410_ts_mach_info *);
 /* defined by architecture to configure gpio */
 extern void s3c24xx_ts_cfg_gpio(struct platform_device *dev);
 
-#endif /* __ASM_ARM_TS_H */
+#endif /*__TOUCHSCREEN_S3C2410_H */
-- 
1.7.9.5

