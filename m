From: Sangwon Jee <jeesw@melfas.com>
Subject: Input: melfas_mip4 - add support for user firmware file name
Date: Wed, 12 Oct 2016 17:21:21 +0900
Message-ID: <1476260481-24754-1-git-send-email-jeesw@melfas.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sbs.melfas.com ([39.118.242.30]:41252 "EHLO sbs.melfas.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752274AbcJLI2w (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 12 Oct 2016 04:28:52 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, jeesw@melfas.com

To support user firmware file name, add fw_name sysfs attribute
and modify to use fw_name variable instead of predefined value.

Signed-off-by: Sangwon Jee <jeesw@melfas.com>
---
 drivers/input/touchscreen/melfas_mip4.c | 48 ++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/melfas_mip4.c b/drivers/input/touchscreen/melfas_mip4.c
index 552a377..efd0a59 100644
--- a/drivers/input/touchscreen/melfas_mip4.c
+++ b/drivers/input/touchscreen/melfas_mip4.c
@@ -158,6 +158,7 @@ struct mip4_ts {
 	char phys[32];
 	char product_name[16];
 	char ic_name[4];
+	char *fw_name;
 
 	unsigned int max_x;
 	unsigned int max_y;
@@ -1269,11 +1270,11 @@ static ssize_t mip4_sysfs_fw_update(struct device *dev,
 	const struct firmware *fw;
 	int error;
 
-	error = request_firmware(&fw, MIP4_FW_NAME, dev);
+	error = request_firmware(&fw, ts->fw_name, dev);
 	if (error) {
 		dev_err(&ts->client->dev,
 			"Failed to retrieve firmware %s: %d\n",
-			MIP4_FW_NAME, error);
+			ts->fw_name, error);
 		return error;
 	}
 
@@ -1368,10 +1369,50 @@ static ssize_t mip4_sysfs_read_ic_name(struct device *dev,
 
 static DEVICE_ATTR(ic_name, S_IRUGO, mip4_sysfs_read_ic_name, NULL);
 
+static ssize_t mip4_sysfs_read_fw_name(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mip4_ts *ts = i2c_get_clientdata(client);
+	size_t count;
+
+	mutex_lock(&ts->input->mutex);
+
+	count = snprintf(buf, PAGE_SIZE, "%s\n", ts->fw_name);
+
+	mutex_unlock(&ts->input->mutex);
+
+	return count;
+}
+
+static ssize_t mip4_sysfs_write_fw_name(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf,
+					size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mip4_ts *ts = i2c_get_clientdata(client);
+	char *filename;
+
+	filename = devm_kzalloc(dev, count - 1, GFP_KERNEL);
+	memcpy(filename, buf, count - 1);
+
+	ts->fw_name = devm_kstrdup(dev, filename, GFP_KERNEL);
+
+	devm_kfree(dev, filename);
+
+	return count;
+}
+
+static DEVICE_ATTR(fw_name, S_IRUGO | S_IWUSR,
+			mip4_sysfs_read_fw_name, mip4_sysfs_write_fw_name);
+
 static struct attribute *mip4_attrs[] = {
 	&dev_attr_fw_version.attr,
 	&dev_attr_hw_version.attr,
 	&dev_attr_ic_name.attr,
+	&dev_attr_fw_name.attr,
 	&dev_attr_update_fw.attr,
 	NULL,
 };
@@ -1408,6 +1449,7 @@ static int mip4_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 	ts->client = client;
 	ts->input = input;
+	ts->fw_name = devm_kstrdup(&client->dev, MIP4_FW_NAME, GFP_KERNEL);
 
 	snprintf(ts->phys, sizeof(ts->phys),
 		 "%s/input0", dev_name(&client->dev));
@@ -1572,6 +1614,6 @@ static struct i2c_driver mip4_driver = {
 module_i2c_driver(mip4_driver);
 
 MODULE_DESCRIPTION("MELFAS MIP4 Touchscreen");
-MODULE_VERSION("2016.09.28");
+MODULE_VERSION("2016.10.12");
 MODULE_AUTHOR("Sangwon Jee <jeesw@melfas.com>");
 MODULE_LICENSE("GPL");
-- 
1.9.1

