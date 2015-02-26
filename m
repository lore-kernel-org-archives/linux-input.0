From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: mma8450 - convert to using managed resources
Date: Wed, 25 Feb 2015 17:48:18 -0800
Message-ID: <20150226014818.GA2469@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:37222 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752907AbbBZBsX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Feb 2015 20:48:23 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Stefan Sauer <ensonic@google.com>, linux-kernel@vger.kernel.org

This simplifies error handling and device removal code. Also let's
get rid of setting driver's owner since i2c core does it for us.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

Note that the following removal was intentional as
devm_input_allocate_polled_device() does this for us:

-	idev->input->dev.parent = &c->dev;


 drivers/input/misc/mma8450.c | 35 ++++++++---------------------------
 1 file changed, 8 insertions(+), 27 deletions(-)

diff --git a/drivers/input/misc/mma8450.c b/drivers/input/misc/mma8450.c
index 9822877..19c7357 100644
--- a/drivers/input/misc/mma8450.c
+++ b/drivers/input/misc/mma8450.c
@@ -174,12 +174,13 @@ static int mma8450_probe(struct i2c_client *c,
 	struct mma8450 *m;
 	int err;
 
-	m = kzalloc(sizeof(struct mma8450), GFP_KERNEL);
-	idev = input_allocate_polled_device();
-	if (!m || !idev) {
-		err = -ENOMEM;
-		goto err_free_mem;
-	}
+	m = devm_kzalloc(&c->dev, sizeof(*m), GFP_KERNEL);
+	if (!m)
+		return -ENOMEM;
+
+	idev = devm_input_allocate_polled_device(&c->dev);
+	if (!idev)
+		return -ENOMEM;
 
 	m->client = c;
 	m->idev = idev;
@@ -187,7 +188,6 @@ static int mma8450_probe(struct i2c_client *c,
 	idev->private		= m;
 	idev->input->name	= MMA8450_DRV_NAME;
 	idev->input->id.bustype	= BUS_I2C;
-	idev->input->dev.parent = &c->dev;
 	idev->poll		= mma8450_poll;
 	idev->poll_interval	= POLL_INTERVAL;
 	idev->poll_interval_max	= POLL_INTERVAL_MAX;
@@ -202,29 +202,12 @@ static int mma8450_probe(struct i2c_client *c,
 	err = input_register_polled_device(idev);
 	if (err) {
 		dev_err(&c->dev, "failed to register polled input device\n");
-		goto err_free_mem;
+		return err;
 	}
 
 	i2c_set_clientdata(c, m);
 
 	return 0;
-
-err_free_mem:
-	input_free_polled_device(idev);
-	kfree(m);
-	return err;
-}
-
-static int mma8450_remove(struct i2c_client *c)
-{
-	struct mma8450 *m = i2c_get_clientdata(c);
-	struct input_polled_dev *idev = m->idev;
-
-	input_unregister_polled_device(idev);
-	input_free_polled_device(idev);
-	kfree(m);
-
-	return 0;
 }
 
 static const struct i2c_device_id mma8450_id[] = {
@@ -242,11 +225,9 @@ MODULE_DEVICE_TABLE(of, mma8450_dt_ids);
 static struct i2c_driver mma8450_driver = {
 	.driver = {
 		.name	= MMA8450_DRV_NAME,
-		.owner	= THIS_MODULE,
 		.of_match_table = mma8450_dt_ids,
 	},
 	.probe		= mma8450_probe,
-	.remove		= mma8450_remove,
 	.id_table	= mma8450_id,
 };
 
-- 
2.2.0.rc0.207.ga3a616c


-- 
Dmitry
