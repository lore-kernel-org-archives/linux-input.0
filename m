From: Iiro Valkonen <iiro.valkonen@atmel.com>
Subject: [PATCH 2/2 v2] Input: atmel_mxt_ts - Make CHG line high after the
 interrupts are enabled
Date: Fri, 01 Apr 2011 17:04:32 +0300
Message-ID: <4D95DB70.2090604@atmel.com>
References: <4D821E00.5060104@atmel.com> <AANLkTikncdvefBBYyhmjNGrqy5915Xw_pqmSG85VO2xV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:53218 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756620Ab1DAOEx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Apr 2011 10:04:53 -0400
In-Reply-To: <AANLkTikncdvefBBYyhmjNGrqy5915Xw_pqmSG85VO2xV@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Joonyoung Shim <dofmind@gmail.com>, linux-input@vger.kernel.org

This is version 2 of the patch, where sysfs group is correctly removed in case of error, and the firmware update is also considered (mxt_make_highchg is also called from mxt_initialize).

Original description:

Make the CHG line (interrupt line) go high after the interrupts have been enabled to make sure we don't miss the falling edge.

Signed-off-by: Iiro Valkonen <iiro.valkonen@atmel.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 4012436..08ea846 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -804,10 +804,6 @@ static int mxt_initialize(struct mxt_data *data)
 	if (error)
 		return error;
 
-	error = mxt_make_highchg(data);
-	if (error)
-		return error;
-
 	mxt_handle_pdata(data);
 
 	/* Backup to memory */
@@ -832,6 +828,10 @@ static int mxt_initialize(struct mxt_data *data)
 		return error;
 	info->matrix_ysize = val;
 
+	error = mxt_make_highchg(data);
+	if (error)
+		return error;
+
 	dev_info(&client->dev,
 			"Family ID: %d Variant ID: %d Version: %d Build: %d\n",
 			info->family_id, info->variant_id, info->version,
@@ -1098,8 +1098,14 @@ static int __devinit mxt_probe(struct i2c_client *client,
 	if (error)
 		goto err_unregister_device;
 
+	error = mxt_make_highchg(data);
+	if (error)
+		goto err_remove_sysfs_group;
+
 	return 0;
 
+err_remove_sysfs_group:
+	sysfs_remove_group(&client->dev.kobj, &mxt_attr_group);
 err_unregister_device:
 	input_unregister_device(input_dev);
 	input_dev = NULL;
-- 
1.7.0.4
