From: Kulikov Vasiliy <segooon@gmail.com>
Subject: [PATCH 2/8] touchscreen: fix sign bug
Date: Thu, 15 Jul 2010 22:43:54 +0400
Message-ID: <1279219435-12128-1-git-send-email-segooon@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:35888 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934208Ab0GOSob (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Jul 2010 14:44:31 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: kernel-janitors@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Luotao Fu <l.fu@pengutronix.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

platform_get_irq_byname() can return negative results, it is not seen to
unsigned ts_irq. Make it signed.

Signed-off-by: Kulikov Vasiliy <segooon@gmail.com>
---
 drivers/input/touchscreen/stmpe-ts.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/touchscreen/stmpe-ts.c
index 77f4374..656148e 100644
--- a/drivers/input/touchscreen/stmpe-ts.c
+++ b/drivers/input/touchscreen/stmpe-ts.c
@@ -269,7 +269,7 @@ static int __devinit stmpe_input_probe(struct platform_device *pdev)
 	struct input_dev *idev;
 	struct stmpe_ts_platform_data *ts_pdata = NULL;
 	int ret = 0;
-	unsigned int ts_irq;
+	int ts_irq;
 
 	ts_irq = platform_get_irq_byname(pdev, "FIFO_TH");
 	if (ts_irq < 0)
-- 
1.7.0.4

