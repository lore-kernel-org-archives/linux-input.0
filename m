From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH v3 1/4] Input: zforce_ts: Reinitialize touch controller when  BOOT_COMPLETE received
Date: Wed, 4 May 2016 12:24:38 +0200
Message-ID: <1462357481-16258-2-git-send-email-dirk.behme@de.bosch.com>
References: <1462357481-16258-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:42114 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757394AbcEDKYr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 May 2016 06:24:47 -0400
Received: from vsmta12.fe.internet.bosch.com (unknown [10.4.98.52])
	by imta23.fe.bosch.de (Postfix) with ESMTP id B769B1580169
	for <linux-input@vger.kernel.org>; Wed,  4 May 2016 12:24:45 +0200 (CEST)
Received: from FE-HUB1000.de.bosch.com (vsgw23.fe.internet.bosch.com [10.4.98.23])
	by vsmta12.fe.internet.bosch.com (Postfix) with ESMTP id 745D41B80325
	for <linux-input@vger.kernel.org>; Wed,  4 May 2016 12:24:45 +0200 (CEST)
In-Reply-To: <1462357481-16258-1-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Marcel Grosshans <MarcelViktor.Grosshans@de.bosch.com>, Knut Wohlrab <Knut.Wohlrab@de.bosch.com>, Oleksij Rempel <linux@rempel-privat.de>

From: Marcel Grosshans <MarcelViktor.Grosshans@de.bosch.com>

Unexpected power interruption or reset of the touch controller may disable
touch panel function. To avoid this situation, the touch controller is
completely reinitialized if BOOT_COMPLETE notification occures. To make
it possible we process reinitialization in a separate queue.

Signed-off-by: Marcel Grosshans <MarcelViktor.Grosshans@de.bosch.com>
Signed-off-by: Knut Wohlrab <Knut.Wohlrab@de.bosch.com>
Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
---
 drivers/input/touchscreen/zforce_ts.c | 127 +++++++++++++++++++++++++++-------
 1 file changed, 102 insertions(+), 25 deletions(-)

diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
index 7b3845a..9839d86 100644
--- a/drivers/input/touchscreen/zforce_ts.c
+++ b/drivers/input/touchscreen/zforce_ts.c
@@ -31,6 +31,7 @@
 #include <linux/platform_data/zforce_ts.h>
 #include <linux/regulator/consumer.h>
 #include <linux/of.h>
+#include <linux/workqueue.h>
 
 #define WAIT_TIMEOUT		msecs_to_jiffies(1000)
 
@@ -98,6 +99,12 @@ struct zforce_point {
 	int prblty;
 };
 
+enum zforce_state {
+	ZF_STATE_UNINITIALZED = 0,
+	ZF_STATE_PROBE_COMPLETE,
+	ZF_STATE_DEV_OPENED,
+};
+
 /*
  * @client		the i2c_client
  * @input		the input device
@@ -138,6 +145,11 @@ struct zforce_ts {
 	struct mutex		command_mutex;
 	int			command_waiting;
 	int			command_result;
+
+	struct work_struct	ts_workq;
+	int			notification;
+
+	enum zforce_state	state;
 };
 
 static int zforce_command(struct zforce_ts *ts, u8 cmd)
@@ -188,6 +200,7 @@ static int zforce_send_wait(struct zforce_ts *ts, const char *buf, int len)
 		buf[1], buf[2]);
 
 	ts->command_waiting = buf[2];
+	reinit_completion(&ts->command_done);
 
 	mutex_lock(&ts->access_mutex);
 	ret = i2c_master_send(client, buf, len);
@@ -471,6 +484,15 @@ static void zforce_complete(struct zforce_ts *ts, int cmd, int result)
 		dev_dbg(&client->dev, "completing command 0x%x\n", cmd);
 		ts->command_result = result;
 		complete(&ts->command_done);
+	} else if (cmd == NOTIFICATION_BOOTCOMPLETE) {
+		dev_dbg(&client->dev, "got notification 0x%x\n", cmd);
+
+		/* abourt previous waiting command if any available */
+		ts->command_result = -ECONNABORTED;
+		ts->notification = cmd;
+		complete(&ts->command_done);
+
+		queue_work(system_long_wq, &ts->ts_workq);
 	} else {
 		dev_dbg(&client->dev, "command %d not for us\n", cmd);
 	}
@@ -596,11 +618,85 @@ static irqreturn_t zforce_irq_thread(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+/*
+ * This device is used in automotive environment. In this
+ * we should never fail. Some connection issues caused by vibration
+ * should be ignored and can be recoverable.
+ */
+static void zforce_boot(struct zforce_ts *ts)
+{
+	struct device *dev = &ts->client->dev;
+	int ret;
+
+	/* need to start device to get version information */
+	ret = zforce_command_wait(ts, COMMAND_INITIALIZE);
+	if (ret)
+		dev_err(dev, "unable to initialize, %d\n", ret);
+
+	switch (ts->state) {
+	case ZF_STATE_UNINITIALZED:
+		ret = zforce_command_wait(ts, COMMAND_STATUS);
+		if (ret)
+			dev_err(dev, "couldn't get status, %d\n", ret);
+		/* fallthrough, we need zforce_stop to complete. */
+	case ZF_STATE_PROBE_COMPLETE:
+		/* stop device and put it into sleep until it is opened */
+		ret = zforce_stop(ts);
+		if (ret)
+			dev_err(dev, "couldn't stop zforce, %d\n", ret);
+
+		ts->state = ZF_STATE_PROBE_COMPLETE;
+		break;
+	case ZF_STATE_DEV_OPENED:
+		ret = zforce_start(ts);
+		if (ret)
+			dev_err(dev, "Failed to restart, %d\n", ret);
+		break;
+	}
+}
+
+static void zforce_notification_queue(struct work_struct *work)
+{
+	struct zforce_ts *ts = container_of(work, struct zforce_ts, ts_workq);
+	struct i2c_client *client = ts->client;
+	struct input_dev *input = ts->input;
+
+	if (device_may_wakeup(&client->dev)) {
+		if (!ts->suspending)
+			pm_stay_awake(&client->dev);
+		else
+			pm_wakeup_event(&client->dev, 500);
+	}
+
+	mutex_lock(&input->mutex);
+
+	switch (ts->notification) {
+	case NOTIFICATION_BOOTCOMPLETE:
+		zforce_boot(ts);
+		break;
+	default:
+		dev_err(&client->dev,
+			"unknown notification: %#x\n", ts->notification);
+	}
+
+	mutex_unlock(&input->mutex);
+
+	if (!ts->suspending && device_may_wakeup(&client->dev))
+		pm_relax(&client->dev);
+}
+
 static int zforce_input_open(struct input_dev *dev)
 {
 	struct zforce_ts *ts = input_get_drvdata(dev);
+	int ret;
+
+	ret = zforce_start(ts);
+	if (ret)
+		return ret;
 
-	return zforce_start(ts);
+	ts->state = ZF_STATE_DEV_OPENED;
+
+	return 0;
 }
 
 static void zforce_input_close(struct input_dev *dev)
@@ -613,6 +709,8 @@ static void zforce_input_close(struct input_dev *dev)
 	if (ret)
 		dev_warn(&client->dev, "stopping zforce failed\n");
 
+	ts->state = ZF_STATE_PROBE_COMPLETE;
+
 	return;
 }
 
@@ -875,6 +973,7 @@ static int zforce_probe(struct i2c_client *client,
 	input_set_drvdata(ts->input, ts);
 
 	init_completion(&ts->command_done);
+	INIT_WORK(&ts->ts_workq, zforce_notification_queue);
 
 	/*
 	 * The zforce pulls the interrupt low when it has data ready.
@@ -894,33 +993,11 @@ static int zforce_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, ts);
 
+	ts->state = ZF_STATE_UNINITIALZED;
+
 	/* let the controller boot */
 	zforce_reset_deassert(ts);
 
-	ts->command_waiting = NOTIFICATION_BOOTCOMPLETE;
-	if (wait_for_completion_timeout(&ts->command_done, WAIT_TIMEOUT) == 0)
-		dev_warn(&client->dev, "bootcomplete timed out\n");
-
-	/* need to start device to get version information */
-	ret = zforce_command_wait(ts, COMMAND_INITIALIZE);
-	if (ret) {
-		dev_err(&client->dev, "unable to initialize, %d\n", ret);
-		return ret;
-	}
-
-	/* this gets the firmware version among other information */
-	ret = zforce_command_wait(ts, COMMAND_STATUS);
-	if (ret < 0) {
-		dev_err(&client->dev, "couldn't get status, %d\n", ret);
-		zforce_stop(ts);
-		return ret;
-	}
-
-	/* stop device and put it into sleep until it is opened */
-	ret = zforce_stop(ts);
-	if (ret < 0)
-		return ret;
-
 	device_set_wakeup_capable(&client->dev, true);
 
 	ret = input_register_device(input_dev);
-- 
1.9.1

