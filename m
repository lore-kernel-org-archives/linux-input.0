From: Chris Leech <christopher.leech@linux.intel.com>
Subject: [PATCH 4/5] qt602240_ts: add optional hooks for board specific reset
	logic
Date: Tue, 16 Nov 2010 12:42:06 -0800
Message-ID: <20101116204206.28796.34520.stgit@localhost6.localdomain6>
References: <20101116203914.28796.23141.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:34775 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756675Ab0KPUmG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Nov 2010 15:42:06 -0500
In-Reply-To: <20101116203914.28796.23141.stgit@localhost6.localdomain6>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Joonyoung Shim <jy0922.shim@samsung.com>

Hooks for board specific setup and tear-down, to be used if the controllers
reset is wired to a GPIO pin.

Signed-off-by: Chris Leech <christopher.leech@linux.intel.com>
---
 drivers/input/touchscreen/qt602240_ts.c |    7 +++++++
 include/linux/i2c/qt602240_ts.h         |    4 ++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/qt602240_ts.c b/drivers/input/touchscreen/qt602240_ts.c
index 11055ec..efe975e 100644
--- a/drivers/input/touchscreen/qt602240_ts.c
+++ b/drivers/input/touchscreen/qt602240_ts.c
@@ -1307,6 +1307,11 @@ static int __devinit qt602240_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, data);
 
+	if (data->pdata->hw_setup) {
+		error = data->pdata->hw_setup(client);
+		if (error)
+			goto err_free_object;
+	}
 	error = qt602240_initialize(data);
 	if (error)
 		goto err_free_object;
@@ -1376,6 +1381,8 @@ static int __devexit qt602240_remove(struct i2c_client *client)
 	sysfs_remove_group(&client->dev.kobj, &qt602240_attr_group);
 	free_irq(data->irq, data);
 	input_unregister_device(data->input_dev);
+	if (data->pdata->hw_teardown)
+		data->pdata->hw_teardown(client);
 	kfree(data->object_table);
 	kfree(data);
 
diff --git a/include/linux/i2c/qt602240_ts.h b/include/linux/i2c/qt602240_ts.h
index d2aa1b6..764dd45 100644
--- a/include/linux/i2c/qt602240_ts.h
+++ b/include/linux/i2c/qt602240_ts.h
@@ -41,6 +41,10 @@ struct qt602240_platform_data {
 	 * platform_data).
 	 */
 	unsigned char trust_nvm;
+
+	/* Board-specific HW hooks; NULL if not needed */
+	int (*hw_setup) (struct i2c_client *client);
+	void (*hw_teardown) (struct i2c_client *client);
 };
 
 #endif /* __LINUX_QT602240_TS_H */

