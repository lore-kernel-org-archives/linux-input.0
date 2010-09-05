From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/2 v2] Input: stmpe-ts - return -ENOMEM if memory
 allocation fail
Date: Sun, 05 Sep 2010 11:10:44 +0800
Message-ID: <1283656244.8339.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58465 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841Ab0IEDKN (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 4 Sep 2010 23:10:13 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, Luotao Fu <l.fu@pengutronix.de>, linux-input@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
Change since v1:
remove unneeded initialization of 'ret' variable

 drivers/input/touchscreen/stmpe-ts.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/touchscreen/stmpe-ts.c
index 656148e..06869e4 100644
--- a/drivers/input/touchscreen/stmpe-ts.c
+++ b/drivers/input/touchscreen/stmpe-ts.c
@@ -268,7 +268,7 @@ static int __devinit stmpe_input_probe(struct platform_device *pdev)
 	struct stmpe_touch *ts;
 	struct input_dev *idev;
 	struct stmpe_ts_platform_data *ts_pdata = NULL;
-	int ret = 0;
+	int ret;
 	int ts_irq;
 
 	ts_irq = platform_get_irq_byname(pdev, "FIFO_TH");
@@ -276,12 +276,16 @@ static int __devinit stmpe_input_probe(struct platform_device *pdev)
 		return ts_irq;
 
 	ts = kzalloc(sizeof(*ts), GFP_KERNEL);
-	if (!ts)
+	if (!ts) {
+		ret = -ENOMEM;
 		goto err_out;
+	}
 
 	idev = input_allocate_device();
-	if (!idev)
+	if (!idev) {
+		ret = -ENOMEM;
 		goto err_free_ts;
+	}
 
 	platform_set_drvdata(pdev, ts);
 	ts->stmpe = stmpe;
-- 
1.7.0.4



