From: Steven Joruk <steven@joruk.com>
Subject: [PATCH] Input: adxl34x - add support for adxl343
Date: Sat, 16 Sep 2017 12:05:17 +0100
Message-ID: <20170916110517.31972-1-steven@joruk.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay5.mymailcheap.com ([159.100.248.207]:41896 "EHLO
        relay5.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751185AbdIPLNT (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 16 Sep 2017 07:13:19 -0400
Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [217.182.66.162])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 16D4B26455
        for <linux-input@vger.kernel.org>; Sat, 16 Sep 2017 11:06:19 +0000 (UTC)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: michael.hennerich@analog.com, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Steven Joruk <steven@joruk.com>

The 343 has identical behaviour to the 345, other than having a
different ID.

Signed-off-by: Steven Joruk <steven@joruk.com>
---
 drivers/input/misc/adxl34x.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/misc/adxl34x.c b/drivers/input/misc/adxl34x.c
index 2b2d02f408bb..fe76878c5c76 100644
--- a/drivers/input/misc/adxl34x.c
+++ b/drivers/input/misc/adxl34x.c
@@ -57,6 +57,7 @@
 #define ORIENT		0x3C	/* R   Orientation status */
 
 /* DEVIDs */
+#define ID_ADXL343	0xFB
 #define ID_ADXL345	0xE5
 #define ID_ADXL346	0xE6
 
@@ -734,6 +735,9 @@ struct adxl34x *adxl34x_probe(struct device *dev, int irq,
 	revid = AC_READ(ac, DEVID);
 
 	switch (revid) {
+	case ID_ADXL343:
+		ac->model = 343;
+		break;
 	case ID_ADXL345:
 		ac->model = 345;
 		break;
-- 
2.14.1

