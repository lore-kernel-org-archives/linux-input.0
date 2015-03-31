From: Aaron Sierra <asierra@xes-inc.com>
Subject: [PATCH 2/2] input: tsc2007: Don't require an interrupt to load
Date: Tue, 31 Mar 2015 10:06:05 -0500 (CDT)
Message-ID: <2054629675.19924.1427814365859.JavaMail.zimbra@xes-inc.com>
References: <1959876509.19488.1427814135809.JavaMail.zimbra@xes-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from xes-mad.com ([216.165.139.218]:33961 "EHLO xes-mad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754149AbbCaPlP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Mar 2015 11:41:15 -0400
In-Reply-To: <1959876509.19488.1427814135809.JavaMail.zimbra@xes-inc.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kwangwoo Lee <kwangwoo.lee@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thierry Reding <thierry.reding@avionic-design.de>, Philip Rakity <prakity@marvell.com>
Cc: linux-input@vger.kernel.org

When an IRQ isn't available, poll the device based on poll_period.

Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
---
 drivers/input/touchscreen/tsc2007.c | 43 +++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
index 4e97afb..e49a88f 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -71,6 +71,7 @@ struct tsc2007 {
 	char			phys[32];
 
 	struct i2c_client	*client;
+	struct delayed_work	work;
 
 	u16			model;
 	u16			x_plate_ohms;
@@ -82,6 +83,7 @@ struct tsc2007 {
 
 	unsigned		gpio;
 	int			irq;
+	bool			using_irq;
 
 	wait_queue_head_t	wait;
 	bool			stopped;
@@ -242,13 +244,27 @@ static irqreturn_t tsc2007_hard_irq(int irq, void *handle)
 	return IRQ_HANDLED;
 }
 
+static void tsc2007_work(struct work_struct *work)
+{
+	struct tsc2007 *ts =
+		container_of(to_delayed_work(work), struct tsc2007, work);
+
+	tsc2007_soft_irq(ts->irq, ts);
+
+	/* reschedule the task */
+	schedule_delayed_work(&ts->work, ts->poll_period);
+}
+
 static void tsc2007_stop(struct tsc2007 *ts)
 {
 	ts->stopped = true;
 	mb();
 	wake_up(&ts->wait);
 
-	disable_irq(ts->irq);
+	if (ts->using_irq)
+		disable_irq(ts->irq);
+	else
+		cancel_delayed_work_sync(&ts->work);
 }
 
 static int tsc2007_open(struct input_dev *input_dev)
@@ -259,7 +275,10 @@ static int tsc2007_open(struct input_dev *input_dev)
 	ts->stopped = false;
 	mb();
 
-	enable_irq(ts->irq);
+	if (ts->using_irq)
+		enable_irq(ts->irq);
+	else
+		schedule_delayed_work(&ts->work, ts->poll_period);
 
 	/* Prepare for touch readings - power down ADC and enable PENIRQ */
 	err = tsc2007_xfer(ts, PWRDOWN);
@@ -405,6 +424,7 @@ static int tsc2007_probe(struct i2c_client *client,
 
 	ts->client = client;
 	ts->irq = client->irq;
+	ts->using_irq = false;
 	ts->input = input_dev;
 	init_waitqueue_head(&ts->wait);
 
@@ -445,14 +465,23 @@ static int tsc2007_probe(struct i2c_client *client,
 			pdata->init_platform_hw();
 	}
 
-	err = devm_request_threaded_irq(&client->dev, ts->irq,
+	if (ts->irq >= 0) {
+		err = devm_request_threaded_irq(&client->dev, ts->irq,
 					tsc2007_hard_irq, tsc2007_soft_irq,
 					IRQF_ONESHOT,
 					client->dev.driver->name, ts);
-	if (err) {
-		dev_err(&client->dev, "Failed to request irq %d: %d\n",
-			ts->irq, err);
-		return err;
+		if (err) {
+			dev_warn(&client->dev, "Failed to request irq %d: %d\n",
+				ts->irq, err);
+		} else {
+			ts->using_irq = true;
+		}
+	}
+
+	if (!ts->using_irq) {
+		dev_info(&client->dev,
+			"No IRQ, polling every %ld ms\n", ts->poll_period);
+		INIT_DELAYED_WORK(&ts->work, tsc2007_work);
 	}
 
 	tsc2007_stop(ts);
-- 
1.9.1
