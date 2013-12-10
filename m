From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>
Subject: [PATCH] Input: zforce: fix possible driver hang during suspend
Date: Tue, 10 Dec 2013 16:50:04 +0100
Message-ID: <201312101650.04799.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:57944 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754464Ab3LJPuJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Dec 2013 10:50:09 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

handle_level_irq masks the interrupt before handling it, and only
unmasks it after the handler is finished. So when a touch event
happens after threads are suspended, but before the system is fully asleep
the irq handler tries to wakeup the thread which will only happen on the
next resume, resulting in the wakeup event never being sent and the driver
not being able to wake the system from sleep due to the masked irq.

Therefore move the wakeup_event to a small non-threaded handler.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/input/touchscreen/zforce_ts.c |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
index 75762d6..aa127ba 100644
--- a/drivers/input/touchscreen/zforce_ts.c
+++ b/drivers/input/touchscreen/zforce_ts.c
@@ -455,7 +455,18 @@ static void zforce_complete(struct zforce_ts *ts, int cmd, int result)
 	}
 }
 
-static irqreturn_t zforce_interrupt(int irq, void *dev_id)
+static irqreturn_t zforce_irq(int irq, void *dev_id)
+{
+	struct zforce_ts *ts = dev_id;
+	struct i2c_client *client = ts->client;
+
+	if (ts->suspended && device_may_wakeup(&client->dev))
+		pm_wakeup_event(&client->dev, 500);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t zforce_irq_thread(int irq, void *dev_id)
 {
 	struct zforce_ts *ts = dev_id;
 	struct i2c_client *client = ts->client;
@@ -465,12 +476,10 @@ static irqreturn_t zforce_interrupt(int irq, void *dev_id)
 	u8 *payload;
 
 	/*
-	 * When suspended, emit a wakeup signal if necessary and return.
+	 * When still suspended, return.
 	 * Due to the level-interrupt we will get re-triggered later.
 	 */
 	if (ts->suspended) {
-		if (device_may_wakeup(&client->dev))
-			pm_wakeup_event(&client->dev, 500);
 		msleep(20);
 		return IRQ_HANDLED;
 	}
@@ -763,8 +772,8 @@ static int zforce_probe(struct i2c_client *client,
 	 * Therefore we can trigger the interrupt anytime it is low and do
 	 * not need to limit it to the interrupt edge.
 	 */
-	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
-					zforce_interrupt,
+	ret = devm_request_threaded_irq(&client->dev, client->irq,
+					zforce_irq, zforce_irq_thread,
 					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 					input_dev->name, ts);
 	if (ret) {
-- 
1.7.10.4

