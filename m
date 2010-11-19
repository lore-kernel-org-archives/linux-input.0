From: "Kim, HeungJun" <riverful.kim@samsung.com>
Subject: [PATCH v2 1/2] input: keyboard: MCS5080: support suspend/resume.
Date: Fri, 19 Nov 2010 15:22:18 +0900
Message-ID: <4CE6179A.5050404@samsung.com>
Reply-To: riverful.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:64347 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704Ab0KSGWa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Nov 2010 01:22:30 -0500
Received: from epmmp1 (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LC400FQ6CD586D0@mailout2.samsung.com> for
 linux-input@vger.kernel.org; Fri, 19 Nov 2010 15:22:18 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LC400HASCD540@mmp1.samsung.com> for
 linux-input@vger.kernel.org; Fri, 19 Nov 2010 15:22:17 +0900 (KST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>

This patch supports suspend/resume functions for mcs5080 touchkey
driver.

Signed-off-by: Heungjun Kim <riverful.kim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/input/keyboard/mcs_touchkey.c |   51 +++++++++++++++++++++++++++++++++
 include/linux/i2c/mcs.h               |    1 +
 2 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/mcs_touchkey.c b/drivers/input/keyboard/mcs_touchkey.c
index 63b849d..92149e4 100644
--- a/drivers/input/keyboard/mcs_touchkey.c
+++ b/drivers/input/keyboard/mcs_touchkey.c
@@ -19,6 +19,7 @@
 #include <linux/input.h>
 #include <linux/irq.h>
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 
 /* MCS5000 Touchkey */
 #define MCS5000_TOUCHKEY_STATUS		0x04
@@ -45,6 +46,8 @@ struct mcs_touchkey_chip {
 };
 
 struct mcs_touchkey_data {
+	void (*poweron)(bool);
+
 	struct i2c_client *client;
 	struct input_dev *input_dev;
 	struct mcs_touchkey_chip chip;
@@ -168,6 +171,10 @@ static int __devinit mcs_touchkey_probe(struct i2c_client *client,
 
 	if (pdata->cfg_pin)
 		pdata->cfg_pin();
+	if (pdata->poweron) {
+		data->poweron = pdata->poweron;
+		data->poweron(1);
+	}
 
 	error = request_threaded_irq(client->irq, NULL, mcs_touchkey_interrupt,
 			IRQF_TRIGGER_FALLING, client->dev.driver->name, data);
@@ -181,6 +188,9 @@ static int __devinit mcs_touchkey_probe(struct i2c_client *client,
 		goto err_free_irq;
 
 	i2c_set_clientdata(client, data);
+
+	pm_runtime_set_active(&client->dev);
+
 	return 0;
 
 err_free_irq:
@@ -202,6 +212,46 @@ static int __devexit mcs_touchkey_remove(struct i2c_client *client)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int mcs_touchkey_suspend(struct device *dev)
+{
+	struct mcs_touchkey_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
+
+	/* Disable the work */
+	disable_irq(client->irq);
+
+	/* Finally turn off the power */
+	if (data->poweron)
+		data->poweron(0);
+
+	return 0;
+}
+
+static int mcs_touchkey_resume(struct device *dev)
+{
+	struct mcs_touchkey_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
+
+	/* Enable the device first */
+	if (data->poweron)
+		data->poweron(1);
+
+	/* Enable irq again */
+	enable_irq(client->irq);
+
+	return 0;
+}
+
+static const struct dev_pm_ops mcs_touchkey_pm_ops = {
+	.suspend		= mcs_touchkey_suspend,
+	.resume			= mcs_touchkey_resume,
+};
+#define MCS_TOUCHKEY_PM_OPS		(&mcs_touchkey_pm_ops)
+#else
+#define MCS_TOUCHKEY_PM_OPS		NULL
+#endif
+
 static const struct i2c_device_id mcs_touchkey_id[] = {
 	{ "mcs5000_touchkey", MCS5000_TOUCHKEY },
 	{ "mcs5080_touchkey", MCS5080_TOUCHKEY },
@@ -213,6 +263,7 @@ static struct i2c_driver mcs_touchkey_driver = {
 	.driver = {
 		.name	= "mcs_touchkey",
 		.owner	= THIS_MODULE,
+		.pm	= MCS_TOUCHKEY_PM_OPS,
 	},
 	.probe		= mcs_touchkey_probe,
 	.remove		= __devexit_p(mcs_touchkey_remove),
diff --git a/include/linux/i2c/mcs.h b/include/linux/i2c/mcs.h
index 725ae7c..61bb18a 100644
--- a/include/linux/i2c/mcs.h
+++ b/include/linux/i2c/mcs.h
@@ -18,6 +18,7 @@
 #define MCS_KEY_CODE(v)		((v) & 0xffff)
 
 struct mcs_platform_data {
+	void (*poweron)(bool);
 	void (*cfg_pin)(void);
 
 	/* touchscreen */
-- 
1.7.0.4
