From: Aaron Sierra <asierra@xes-inc.com>
Subject: [PATCH 1/2] input: tsc2007: Convert msecs to jiffies only once
Date: Tue, 31 Mar 2015 10:05:59 -0500 (CDT)
Message-ID: <295524964.19874.1427814359807.JavaMail.zimbra@xes-inc.com>
References: <1273443062.19653.1427814254249.JavaMail.zimbra@xes-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from xes-mad.com ([216.165.139.218]:33961 "EHLO xes-mad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754608AbbCaPlN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Mar 2015 11:41:13 -0400
In-Reply-To: <1273443062.19653.1427814254249.JavaMail.zimbra@xes-inc.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kwangwoo Lee <kwangwoo.lee@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thierry Reding <thierry.reding@avionic-design.de>, Philip Rakity <prakity@marvell.com>
Cc: linux-input@vger.kernel.org

Eliminate redundant calculations by performing millisecond to jiffy
calculations once during driver initialization.

Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
---
 drivers/input/touchscreen/tsc2007.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
index 1bf9906..4e97afb 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -214,8 +214,7 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
 			dev_dbg(&ts->client->dev, "ignored pressure %d\n", rt);
 		}
 
-		wait_event_timeout(ts->wait, ts->stopped,
-				   msecs_to_jiffies(ts->poll_period));
+		wait_event_timeout(ts->wait, ts->stopped, ts->poll_period);
 	}
 
 	dev_dbg(&ts->client->dev, "UP\n");
@@ -314,9 +313,9 @@ static int tsc2007_probe_dt(struct i2c_client *client, struct tsc2007 *ts)
 		ts->fuzzz = val32;
 
 	if (!of_property_read_u64(np, "ti,poll-period", &val64))
-		ts->poll_period = val64;
+		ts->poll_period = msecs_to_jiffies(val64);
 	else
-		ts->poll_period = 1;
+		ts->poll_period = msecs_to_jiffies(1);
 
 	if (!of_property_read_u32(np, "ti,x-plate-ohms", &val32)) {
 		ts->x_plate_ohms = val32;
@@ -350,7 +349,9 @@ static int tsc2007_probe_pdev(struct i2c_client *client, struct tsc2007 *ts,
 	ts->model             = pdata->model;
 	ts->x_plate_ohms      = pdata->x_plate_ohms;
 	ts->max_rt            = pdata->max_rt ? : MAX_12BIT;
-	ts->poll_period       = pdata->poll_period ? : 1;
+	ts->poll_period       = pdata->poll_period ?
+					msecs_to_jiffies(pdata->poll_period) :
+					msecs_to_jiffies(1);
 	ts->get_pendown_state = pdata->get_pendown_state;
 	ts->clear_penirq      = pdata->clear_penirq;
 	ts->fuzzx             = pdata->fuzzx;
-- 
1.9.1
