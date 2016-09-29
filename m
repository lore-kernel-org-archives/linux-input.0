From: Sangwon Jee <jeesw@melfas.com>
Subject: Input: melfas_mip4 - add ic_name sysfs attribute
Date: Thu, 29 Sep 2016 14:37:20 +0900
Message-ID: <1475127440-4100-1-git-send-email-jeesw@melfas.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sbs.melfas.com ([39.118.242.30]:56700 "EHLO sbs.melfas.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754342AbcI2FhE (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 29 Sep 2016 01:37:04 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, jeesw@melfas.com

Add ic_name sysfs attribute for retrieving IC model name.

Signed-off-by: Sangwon Jee <jeesw@melfas.com>
---
 drivers/input/touchscreen/melfas_mip4.c | 36 ++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/melfas_mip4.c b/drivers/input/touchscreen/melfas_mip4.c
index fb5fb91..a3e681c 100644
--- a/drivers/input/touchscreen/melfas_mip4.c
+++ b/drivers/input/touchscreen/melfas_mip4.c
@@ -157,6 +157,7 @@ struct mip4_ts {
 
 	char phys[32];
 	char product_name[16];
+	char ic_name[4];
 
 	unsigned int max_x;
 	unsigned int max_y;
@@ -263,6 +264,18 @@ static int mip4_query_device(struct mip4_ts *ts)
 		dev_dbg(&ts->client->dev, "product name: %.*s\n",
 			(int)sizeof(ts->product_name), ts->product_name);
 
+	/* IC name */
+	cmd[0] = MIP4_R0_INFO;
+	cmd[1] = MIP4_R1_INFO_IC_NAME;
+	error = mip4_i2c_xfer(ts, cmd, sizeof(cmd),
+			      ts->ic_name, sizeof(ts->ic_name));
+	if (error)
+		dev_warn(&ts->client->dev,
+			 "Failed to retrieve IC name: %d\n", error);
+	else
+		dev_dbg(&ts->client->dev, "IC name: %.*s\n",
+			(int)sizeof(ts->ic_name), ts->ic_name);
+
 	/* Firmware version */
 	error = mip4_get_fw_version(ts);
 	if (error)
@@ -1335,9 +1348,30 @@ static ssize_t mip4_sysfs_read_hw_version(struct device *dev,
 
 static DEVICE_ATTR(hw_version, S_IRUGO, mip4_sysfs_read_hw_version, NULL);
 
+static ssize_t mip4_sysfs_read_ic_name(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mip4_ts *ts = i2c_get_clientdata(client);
+	size_t count;
+
+	mutex_lock(&ts->input->mutex);
+
+	count = snprintf(buf, PAGE_SIZE, "%.*s\n",
+		(int)sizeof(ts->ic_name), ts->ic_name);
+
+	mutex_unlock(&ts->input->mutex);
+
+	return count;
+}
+
+static DEVICE_ATTR(ic_name, S_IRUGO, mip4_sysfs_read_ic_name, NULL);
+
 static struct attribute *mip4_attrs[] = {
 	&dev_attr_fw_version.attr,
 	&dev_attr_hw_version.attr,
+	&dev_attr_ic_name.attr,
 	&dev_attr_update_fw.attr,
 	NULL,
 };
@@ -1538,6 +1572,6 @@ static struct i2c_driver mip4_driver = {
 module_i2c_driver(mip4_driver);
 
 MODULE_DESCRIPTION("MELFAS MIP4 Touchscreen");
-MODULE_VERSION("2016.03.12");
+MODULE_VERSION("2016.09.28");
 MODULE_AUTHOR("Sangwon Jee <jeesw@melfas.com>");
 MODULE_LICENSE("GPL");
-- 
1.9.1

