From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko.stuebner@bqreaders.com>
Subject: [PATCH 2/3] Input: zforce: Use internal pdata pointer instead of dev_get_platdata
Date: Thu, 09 Jan 2014 22:21:39 +0100
Message-ID: <9329039.m1JhHsx7ix@phil>
References: <2587208.XYbbI8xJiH@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:34278 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756546AbaAIVV5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 9 Jan 2014 16:21:57 -0500
In-Reply-To: <2587208.XYbbI8xJiH@phil>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

When the device is initialized from devicetree the platformdata is created
locally making dev_get_platdata return NULL.

Therefore directly use the internal pointer to the pdata instead.

Signed-off-by: Heiko Stuebner <heiko.stuebner@bqreaders.com>
---
 drivers/input/touchscreen/zforce_ts.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
index 2175f34..5a1a93b 100644
--- a/drivers/input/touchscreen/zforce_ts.c
+++ b/drivers/input/touchscreen/zforce_ts.c
@@ -255,7 +255,7 @@ static int zforce_setconfig(struct zforce_ts *ts, char b1)
 static int zforce_start(struct zforce_ts *ts)
 {
 	struct i2c_client *client = ts->client;
-	const struct zforce_ts_platdata *pdata = dev_get_platdata(&client->dev);
+	const struct zforce_ts_platdata *pdata = ts->pdata;
 	int ret;
 
 	dev_dbg(&client->dev, "starting device\n");
@@ -326,7 +326,7 @@ static int zforce_stop(struct zforce_ts *ts)
 static int zforce_touch_event(struct zforce_ts *ts, u8 *payload)
 {
 	struct i2c_client *client = ts->client;
-	const struct zforce_ts_platdata *pdata = dev_get_platdata(&client->dev);
+	const struct zforce_ts_platdata *pdata = ts->pdata;
 	struct zforce_point point;
 	int count, i, num = 0;
 
@@ -471,7 +471,7 @@ static irqreturn_t zforce_irq_thread(int irq, void *dev_id)
 {
 	struct zforce_ts *ts = dev_id;
 	struct i2c_client *client = ts->client;
-	const struct zforce_ts_platdata *pdata = dev_get_platdata(&client->dev);
+	const struct zforce_ts_platdata *pdata = ts->pdata;
 	int ret;
 	u8 payload_buffer[512];
 	u8 *payload;
-- 
1.7.10.4


