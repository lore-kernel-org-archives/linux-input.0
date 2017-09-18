From: Steven Joruk <steven@joruk.com>
Subject: [PATCH] Input: adxl34x - avoid int-in-bool-context warning
Date: Mon, 18 Sep 2017 16:43:57 +0100
Message-ID: <20170918154357.2949-1-steven@joruk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay5.mymailcheap.com ([159.100.241.64]:57196 "EHLO
        relay5.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752364AbdIRP6f (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 18 Sep 2017 11:58:35 -0400
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.80.156])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id AEA9120091
        for <linux-input@vger.kernel.org>; Mon, 18 Sep 2017 15:48:50 +0000 (UTC)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: michael.hennerich@analog.com, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Steven Joruk <steven@joruk.com>

The code is fine, but make it clear to the compiler.

drivers/input/misc/adxl34x.c:134:35: warning: ‘<<’ in boolean context

Signed-off-by: Steven Joruk <steven@joruk.com>
---
 drivers/input/misc/adxl34x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/adxl34x.c b/drivers/input/misc/adxl34x.c
index 2b2d02f408bb..e0caaa0de454 100644
--- a/drivers/input/misc/adxl34x.c
+++ b/drivers/input/misc/adxl34x.c
@@ -796,7 +796,7 @@ struct adxl34x *adxl34x_probe(struct device *dev, int irq,
 
 	if (pdata->watermark) {
 		ac->int_mask |= WATERMARK;
-		if (!FIFO_MODE(pdata->fifo_mode))
+		if (FIFO_MODE(pdata->fifo_mode) == 0)
 			ac->pdata.fifo_mode |= FIFO_STREAM;
 	} else {
 		ac->int_mask |= DATA_READY;
-- 
2.14.1

