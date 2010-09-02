From: Axel Lin <axel.lin@gmail.com>
Subject: Input: tps6507x-ts - add missing platform_set_drvdata() in
	tps6507x_ts_probe()
Date: Thu, 02 Sep 2010 17:20:41 +0800
Message-ID: <1283419241.19272.9.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:56581 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677Ab0IBJQn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 Sep 2010 05:16:43 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Todd Fischer <todd.fischer@ridgerun.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

We call platform_get_drvdata() in tps6507x_ts_remove(),
thus we should call platform_set_drvdata() in tps6507x_ts_probe().

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/input/touchscreen/tps6507x-ts.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/tps6507x-ts.c b/drivers/input/touchscreen/tps6507x-ts.c
index a644d18..7286209 100644
--- a/drivers/input/touchscreen/tps6507x-ts.c
+++ b/drivers/input/touchscreen/tps6507x-ts.c
@@ -335,6 +335,7 @@ static int tps6507x_ts_probe(struct platform_device *pdev)
 		dev_err(tsc->dev, "schedule failed");
 		goto err2;
 	 }
+	platform_set_drvdata(pdev, tps6507x_dev);
 
 	return 0;
 
-- 
1.7.2



