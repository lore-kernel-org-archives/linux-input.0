From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH 2/2] input: mcs - Modify header file of MCS5000 touchscreen
Date: Wed, 16 Jun 2010 10:03:49 +0900
Message-ID: <1276650229-1322-2-git-send-email-jy0922.shim@samsung.com>
References: <1276650229-1322-1-git-send-email-jy0922.shim@samsung.com>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:21191 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544Ab0FPBDz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Jun 2010 21:03:55 -0400
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0L4300FKF1MFD490@mailout2.samsung.com> for
 linux-input@vger.kernel.org; Wed, 16 Jun 2010 10:03:51 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L4300L9F1MFFJ@mmp2.samsung.com> for
 linux-input@vger.kernel.org; Wed, 16 Jun 2010 10:03:51 +0900 (KST)
In-reply-to: <1276650229-1322-1-git-send-email-jy0922.shim@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, kyungmin.park@samsung.com

This patch is to use same header file - mcs.h at mcs5000 touchscreen and
touchkey driver.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 drivers/input/touchscreen/mcs5000_ts.c |    6 +++---
 include/linux/i2c/mcs5000_ts.h         |   24 ------------------------
 2 files changed, 3 insertions(+), 27 deletions(-)
 delete mode 100644 include/linux/i2c/mcs5000_ts.h

diff --git a/drivers/input/touchscreen/mcs5000_ts.c b/drivers/input/touchscreen/mcs5000_ts.c
index 1fb0c2f..6ee9940 100644
--- a/drivers/input/touchscreen/mcs5000_ts.c
+++ b/drivers/input/touchscreen/mcs5000_ts.c
@@ -16,7 +16,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
-#include <linux/i2c/mcs5000_ts.h>
+#include <linux/i2c/mcs.h>
 #include <linux/interrupt.h>
 #include <linux/input.h>
 #include <linux/irq.h>
@@ -105,7 +105,7 @@ enum mcs5000_ts_read_offset {
 struct mcs5000_ts_data {
 	struct i2c_client *client;
 	struct input_dev *input_dev;
-	const struct mcs5000_ts_platform_data *platform_data;
+	const struct mcs_platform_data *platform_data;
 };
 
 static irqreturn_t mcs5000_ts_interrupt(int irq, void *dev_id)
@@ -164,7 +164,7 @@ static irqreturn_t mcs5000_ts_interrupt(int irq, void *dev_id)
 
 static void mcs5000_ts_phys_init(struct mcs5000_ts_data *data)
 {
-	const struct mcs5000_ts_platform_data *platform_data =
+	const struct mcs_platform_data *platform_data =
 		data->platform_data;
 	struct i2c_client *client = data->client;
 
diff --git a/include/linux/i2c/mcs5000_ts.h b/include/linux/i2c/mcs5000_ts.h
deleted file mode 100644
index 5a117b5..0000000
--- a/include/linux/i2c/mcs5000_ts.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * mcs5000_ts.h
- *
- * Copyright (C) 2009 Samsung Electronics Co.Ltd
- * Author: Joonyoung Shim <jy0922.shim@samsung.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- */
-
-#ifndef __LINUX_MCS5000_TS_H
-#define __LINUX_MCS5000_TS_H
-
-/* platform data for the MELFAS MCS-5000 touchscreen driver */
-struct mcs5000_ts_platform_data {
-	void (*cfg_pin)(void);
-	int x_size;
-	int y_size;
-};
-
-#endif	/* __LINUX_MCS5000_TS_H */
-- 
1.7.0.4

