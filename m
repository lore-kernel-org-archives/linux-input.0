From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Input: wm831x-ts - Remove unneeded clearing of driver data
Date: Tue,  7 Jun 2011 15:37:44 +0100
Message-ID: <1307457464-24747-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:50991 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753517Ab1FGOhr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 7 Jun 2011 10:37:47 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>

This is unneeded, only a bound driver can use driver data and a driver
relying on the state prior to probe() is buggy.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/touchscreen/wm831x-ts.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/wm831x-ts.c b/drivers/input/touchscreen/wm831x-ts.c
index 9175d49..e5b63b9 100644
--- a/drivers/input/touchscreen/wm831x-ts.c
+++ b/drivers/input/touchscreen/wm831x-ts.c
@@ -389,7 +389,6 @@ static __devexit int wm831x_ts_remove(struct platform_device *pdev)
 	input_unregister_device(wm831x_ts->input_dev);
 	kfree(wm831x_ts);
 
-	platform_set_drvdata(pdev, NULL);
 	return 0;
 }
 
-- 
1.7.5.3

