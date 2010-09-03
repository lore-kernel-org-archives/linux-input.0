From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/2] Input: stmpe-ts - return -ENOMEM if memory allocation
	fail
Date: Fri, 03 Sep 2010 09:32:13 +0800
Message-ID: <1283477533.5439.8.camel@mola>
References: <1283477451.5439.6.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46494 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281Ab0ICB2K (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 Sep 2010 21:28:10 -0400
In-Reply-To: <1283477451.5439.6.camel@mola>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Luotao Fu <l.fu@pengutronix.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/input/touchscreen/stmpe-ts.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/touchscreen/stmpe-ts.c
index 0339d1d..e715b27 100644
--- a/drivers/input/touchscreen/stmpe-ts.c
+++ b/drivers/input/touchscreen/stmpe-ts.c
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
1.7.2



