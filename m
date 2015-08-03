From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH 4/9] Input: atmel_mxt_ts - move mxt_initialize after sysfs init
Date: Mon,  3 Aug 2015 16:23:12 +0100
Message-ID: <1438615397-17112-5-git-send-email-nick.dyer@itdev.co.uk>
References: <1438615397-17112-1-git-send-email-nick.dyer@itdev.co.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:15845 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754241AbbHCPct (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Aug 2015 11:32:49 -0400
In-Reply-To: <1438615397-17112-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Alan Bowens <Alan.Bowens@atmel.com>, Nick Dyer <nick.dyer@itdev.co.uk>

An error in the sysfs init may otherwise interfere with the async return
from the firmware loader

Add guards for sysfs functions

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 800ee0d..869dbb3 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -2092,6 +2092,10 @@ static ssize_t mxt_fw_version_show(struct device *dev,
 {
 	struct mxt_data *data = dev_get_drvdata(dev);
 	struct mxt_info *info = &data->info;
+
+	if (!data->object_table)
+		return -EINVAL;
+
 	return scnprintf(buf, PAGE_SIZE, "%u.%u.%02X\n",
 			 info->version >> 4, info->version & 0xf, info->build);
 }
@@ -2102,6 +2106,10 @@ static ssize_t mxt_hw_version_show(struct device *dev,
 {
 	struct mxt_data *data = dev_get_drvdata(dev);
 	struct mxt_info *info = &data->info;
+
+	if (!data->object_table)
+		return -EINVAL;
+
 	return scnprintf(buf, PAGE_SIZE, "%u.%u\n",
 			 info->family_id, info->variant_id);
 }
@@ -2134,6 +2142,9 @@ static ssize_t mxt_object_show(struct device *dev,
 	int error;
 	u8 *obuf;
 
+	if (!data->object_table)
+		return -EINVAL;
+
 	/* Pre-allocate buffer large enough to hold max sized object. */
 	obuf = kmalloc(256, GFP_KERNEL);
 	if (!obuf)
@@ -2603,22 +2614,19 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 	disable_irq(client->irq);
 
-	error = mxt_initialize(data);
-	if (error)
-		goto err_free_irq;
-
 	error = sysfs_create_group(&client->dev.kobj, &mxt_attr_group);
 	if (error) {
 		dev_err(&client->dev, "Failure %d creating sysfs group\n",
 			error);
-		goto err_free_object;
+		goto err_free_irq;
 	}
 
+	error = mxt_initialize(data);
+	if (error)
+		goto err_free_irq;
+
 	return 0;
 
-err_free_object:
-	mxt_free_input_device(data);
-	mxt_free_object_table(data);
 err_free_irq:
 	free_irq(client->irq, data);
 err_free_mem:
-- 
2.4.6

