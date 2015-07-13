From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH 2/3] Input: zforce - enable irq only if we are ready to process it
Date: Mon, 13 Jul 2015 14:49:38 +0200
Message-ID: <1436791779-21798-2-git-send-email-dirk.behme@de.bosch.com>
References: <1436791779-21798-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from imta22.fe.bosch.de ([139.15.243.26]:19697 "EHLO
	imta22.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbbGMMtp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jul 2015 08:49:45 -0400
Received: from smtp6-v.fe.bosch.de (imta23.fe.bosch.de [139.15.243.227])
	by imta22.fe.bosch.de (Postfix) with ESMTP id 350EA8405B8
	for <linux-input@vger.kernel.org>; Mon, 13 Jul 2015 14:49:44 +0200 (CEST)
Received: from vsmta14.fe.internet.bosch.com (unknown [10.4.98.54])
	by imta23.fe.bosch.de (Postfix) with ESMTP id 1BE661580226
	for <linux-input@vger.kernel.org>; Mon, 13 Jul 2015 14:49:43 +0200 (CEST)
Received: from FE-HUB1000.de.bosch.com (vsgw24.fe.internet.bosch.com [10.4.98.24])
	by vsmta14.fe.internet.bosch.com (Postfix) with ESMTP id C9A06A4049B
	for <linux-input@vger.kernel.org>; Mon, 13 Jul 2015 14:49:42 +0200 (CEST)
In-Reply-To: <1436791779-21798-1-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>, Dirk Behme <dirk.behme@de.bosch.com>

From: Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>

If zforce is not ready to process the interrupt, the touchscreen will
be lost forever. Make sure we enable the interrupt only if processing
is ready.

Signed-off-by: Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>
Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---
 drivers/input/touchscreen/zforce_ts.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
index 19dc297..a1889e5 100644
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
@@ -741,6 +742,7 @@ static int zforce_probe(struct i2c_client *client,
 	struct zforce_ts *ts;
 	struct input_dev *input_dev;
 	int ret;
+	unsigned int irq;
 
 	if (!pdata) {
 		pdata = zforce_parse_dt(&client->dev);
@@ -835,6 +837,7 @@ static int zforce_probe(struct i2c_client *client,
 
 	init_completion(&ts->command_done);
 
+	irq = client->irq;
 	/*
 	 * The zforce pulls the interrupt low when it has data ready.
 	 * After it is triggered the isr thread runs until all the available
@@ -842,7 +845,8 @@ static int zforce_probe(struct i2c_client *client,
 	 * Therefore we can trigger the interrupt anytime it is low and do
 	 * not need to limit it to the interrupt edge.
 	 */
-	ret = devm_request_threaded_irq(&client->dev, client->irq,
+	irq_set_status_flags(irq, IRQ_NOAUTOEN);
+	ret = devm_request_threaded_irq(&client->dev, irq,
 					zforce_irq, zforce_irq_thread,
 					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 					input_dev->name, ts);
@@ -855,6 +859,7 @@ static int zforce_probe(struct i2c_client *client,
 
 	/* let the controller boot */
 	zforce_reset_deassert(ts);
+	enable_irq(irq);
 
 	ts->command_waiting = NOTIFICATION_BOOTCOMPLETE;
 	if (wait_for_completion_timeout(&ts->command_done, WAIT_TIMEOUT) == 0)
-- 
2.3.4

