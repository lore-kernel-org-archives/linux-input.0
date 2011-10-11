From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] touchscreen: tsc2007.c  x_plat_ohms must be > 0 for touch
 to  work
Date: Tue, 11 Oct 2011 14:28:05 -0700
Message-ID: <37B624E6-712E-4909-988F-62E5526180DA@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:52420 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750791Ab1JKV2Q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Oct 2011 17:28:16 -0400
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Touch events are not processed unless pressure > 0.
x_plat_ohms is used in pressure calculation.  ensure driver
will not start if zero value and indicate reason why there is
a failure

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/input/touchscreen/tsc2007.c |    6 ++++++
 include/linux/i2c/tsc2007.h         |    2 +-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
index 0acca68..628261b 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -310,6 +310,12 @@ static int __devinit tsc2007_probe(struct i2c_client *client,
 	ts->get_pendown_state = pdata->get_pendown_state;
 	ts->clear_penirq      = pdata->clear_penirq;
 
+	if (pdata->x_plate_ohms == 0) {
+		dev_err(&client->dev, "pdata->x_plate_ohms must be > 0");
+		err = -EINVAL;
+		goto err_free_mem;
+	}
+
 	snprintf(ts->phys, sizeof(ts->phys),
 		 "%s/input0", dev_name(&client->dev));
 
diff --git a/include/linux/i2c/tsc2007.h b/include/linux/i2c/tsc2007.h
index 591427a..506a9f7 100644
--- a/include/linux/i2c/tsc2007.h
+++ b/include/linux/i2c/tsc2007.h
@@ -5,7 +5,7 @@
 
 struct tsc2007_platform_data {
 	u16	model;				/* 2007. */
-	u16	x_plate_ohms;
+	u16	x_plate_ohms;	/* must be non-zero value */
 	u16	max_rt; /* max. resistance above which samples are ignored */
 	unsigned long poll_delay; /* delay (in ms) after pen-down event
 				     before polling starts */
-- 
1.7.6


