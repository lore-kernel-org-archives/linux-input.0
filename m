From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH 3/3] Input: zforce - remove zforce_irq
Date: Mon, 13 Jul 2015 14:49:39 +0200
Message-ID: <1436791779-21798-3-git-send-email-dirk.behme@de.bosch.com>
References: <1436791779-21798-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from imta21.fe.bosch.de ([139.15.243.226]:19699 "EHLO
	imta21.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbbGMMtr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jul 2015 08:49:47 -0400
Received: from smtp6-v.fe.bosch.de (imta24.fe.bosch.de [139.15.243.27])
	by imta21.fe.bosch.de (Postfix) with ESMTP id C6E6FC0697
	for <linux-input@vger.kernel.org>; Mon, 13 Jul 2015 14:49:44 +0200 (CEST)
Received: from vsmta14.fe.internet.bosch.com (unknown [10.4.98.54])
	by imta24.fe.bosch.de (Postfix) with ESMTP id BBD0FD80002
	for <linux-input@vger.kernel.org>; Mon, 13 Jul 2015 14:49:43 +0200 (CEST)
Received: from FE-HUB1000.de.bosch.com (vsgw24.fe.internet.bosch.com [10.4.98.24])
	by vsmta14.fe.internet.bosch.com (Postfix) with ESMTP id 6E7FBA40702
	for <linux-input@vger.kernel.org>; Mon, 13 Jul 2015 14:49:43 +0200 (CEST)
In-Reply-To: <1436791779-21798-1-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>, Dirk Behme <dirk.behme@de.bosch.com>

From: Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>

zforce_irq will not be executed, since we use IRQF_ONESHOT.

Signed-off-by: Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>
Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---
 drivers/input/touchscreen/zforce_ts.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
index a1889e5..96bec6a 100644
--- a/drivers/input/touchscreen/zforce_ts.c
+++ b/drivers/input/touchscreen/zforce_ts.c
@@ -477,17 +477,6 @@ static void zforce_complete(struct zforce_ts *ts, int cmd, int result)
 	}
 }
 
-static irqreturn_t zforce_irq(int irq, void *dev_id)
-{
-	struct zforce_ts *ts = dev_id;
-	struct i2c_client *client = ts->client;
-
-	if (ts->suspended && device_may_wakeup(&client->dev))
-		pm_wakeup_event(&client->dev, 500);
-
-	return IRQ_WAKE_THREAD;
-}
-
 static irqreturn_t zforce_irq_thread(int irq, void *dev_id)
 {
 	struct zforce_ts *ts = dev_id;
@@ -847,7 +836,7 @@ static int zforce_probe(struct i2c_client *client,
 	 */
 	irq_set_status_flags(irq, IRQ_NOAUTOEN);
 	ret = devm_request_threaded_irq(&client->dev, irq,
-					zforce_irq, zforce_irq_thread,
+					NULL, zforce_irq_thread,
 					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 					input_dev->name, ts);
 	if (ret) {
-- 
2.3.4

