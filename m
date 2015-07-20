From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH 4/4 v2] Input: zforce - enable irq only if we are ready to process it
Date: Mon, 20 Jul 2015 14:56:37 +0200
Message-ID: <1437396997-3182-5-git-send-email-dirk.behme@de.bosch.com>
References: <1437396997-3182-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:30548 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754232AbbGTM4m (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jul 2015 08:56:42 -0400
Received: from vsmta11.fe.internet.bosch.com (unknown [10.4.98.51])
	by imta23.fe.bosch.de (Postfix) with ESMTP id 039191580227
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2015 14:56:41 +0200 (CEST)
Received: from FE-HUB1000.de.bosch.com (vsgw23.fe.internet.bosch.com [10.4.98.23])
	by vsmta11.fe.internet.bosch.com (Postfix) with ESMTP id A590D238050F
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2015 14:56:40 +0200 (CEST)
In-Reply-To: <1437396997-3182-1-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>, Dirk Behme <dirk.behme@de.bosch.com>

From: Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>

If zforce is not ready to process the interrupt, the touchscreen will
be lost forever. Make sure we enable the interrupt only if processing
is ready.

Signed-off-by: Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>
Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---
Changes in v2: No changes, just re-send

 drivers/input/touchscreen/zforce_ts.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
index fdd00b1..fab1bb0 100644
--- a/drivers/input/touchscreen/zforce_ts.c
+++ b/drivers/input/touchscreen/zforce_ts.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/i2c.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
@@ -755,6 +756,7 @@ static int zforce_probe(struct i2c_client *client,
 	struct zforce_ts *ts;
 	struct input_dev *input_dev;
 	int ret;
+	unsigned int irq;
 
 	if (!pdata) {
 		pdata = zforce_parse_dt(&client->dev);
@@ -859,6 +861,7 @@ static int zforce_probe(struct i2c_client *client,
 
 	init_completion(&ts->command_done);
 
+	irq = client->irq;
 	/*
 	 * The zforce pulls the interrupt low when it has data ready.
 	 * After it is triggered the isr thread runs until all the available
@@ -866,7 +869,8 @@ static int zforce_probe(struct i2c_client *client,
 	 * Therefore we can trigger the interrupt anytime it is low and do
 	 * not need to limit it to the interrupt edge.
 	 */
-	ret = devm_request_threaded_irq(&client->dev, client->irq,
+	irq_set_status_flags(irq, IRQ_NOAUTOEN);
+	ret = devm_request_threaded_irq(&client->dev, irq,
 					zforce_irq, zforce_irq_thread,
 					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 					input_dev->name, ts);
@@ -879,6 +883,7 @@ static int zforce_probe(struct i2c_client *client,
 
 	/* let the controller boot */
 	zforce_reset_deassert(ts);
+	enable_irq(irq);
 
 	ts->command_waiting = NOTIFICATION_BOOTCOMPLETE;
 	if (wait_for_completion_timeout(&ts->command_done, WAIT_TIMEOUT) == 0)
-- 
2.3.4

