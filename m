From: Sangwon Jee <jeesw@melfas.com>
Subject: [1/2] Input: melfas_mip4 - add product_id sysfs attribute
Date: Fri, 21 Oct 2016 19:48:49 +0900
Message-ID: <1477046929-9337-1-git-send-email-jeesw@melfas.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sbs.melfas.com ([39.118.242.30]:16435 "EHLO sbs.melfas.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754798AbcJUKtE (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 21 Oct 2016 06:49:04 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, jeesw@melfas.com

Add product_id sysfs attribute and update protocol version to support it.

Signed-off-by: Sangwon Jee <jeesw@melfas.com>
---
 drivers/input/touchscreen/melfas_mip4.c | 40 +++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/melfas_mip4.c b/drivers/input/touchscreen/melfas_mip4.c
index 552a377..8739cb7 100644
--- a/drivers/input/touchscreen/melfas_mip4.c
+++ b/drivers/input/touchscreen/melfas_mip4.c
@@ -33,7 +33,7 @@
 
 /*****************************************************************
  * Protocol
- * Version : MIP 4.0 Rev 4.6
+ * Version : MIP 4.0 Rev 5.4
  *****************************************************************/
 
 /* Address */
@@ -81,6 +81,9 @@
 #define MIP4_R1_INFO_IC_HW_CATEGORY		0x77
 #define MIP4_R1_INFO_CONTACT_THD_SCR		0x78
 #define MIP4_R1_INFO_CONTACT_THD_KEY		0x7A
+#define MIP4_R1_INFO_PID				0x7C
+#define MIP4_R1_INFO_VID				0x7E
+#define MIP4_R1_INFO_SLAVE_ADDR			0x80
 
 #define MIP4_R0_EVENT				0x02
 #define MIP4_R1_EVENT_SUPPORTED_FUNC		0x00
@@ -157,6 +160,7 @@ struct mip4_ts {
 
 	char phys[32];
 	char product_name[16];
+	u16 product_id;
 	char ic_name[4];
 
 	unsigned int max_x;
@@ -264,6 +268,18 @@ static int mip4_query_device(struct mip4_ts *ts)
 		dev_dbg(&ts->client->dev, "product name: %.*s\n",
 			(int)sizeof(ts->product_name), ts->product_name);
 
+	/* Product ID */
+	cmd[0] = MIP4_R0_INFO;
+	cmd[1] = MIP4_R1_INFO_PID;
+	error = mip4_i2c_xfer(ts, cmd, sizeof(cmd), buf, 2);
+	if (error) {
+		dev_warn(&ts->client->dev,
+			 "Failed to retrieve product id: %d\n", error);
+	} else {
+		ts->product_id = get_unaligned_le16(&buf[0]);
+		dev_dbg(&ts->client->dev, "product id: %04X\n", ts->product_id);
+	}
+
 	/* IC name */
 	cmd[0] = MIP4_R0_INFO;
 	cmd[1] = MIP4_R1_INFO_IC_NAME;
@@ -1348,6 +1364,25 @@ static ssize_t mip4_sysfs_read_hw_version(struct device *dev,
 
 static DEVICE_ATTR(hw_version, S_IRUGO, mip4_sysfs_read_hw_version, NULL);
 
+static ssize_t mip4_sysfs_read_product_id(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mip4_ts *ts = i2c_get_clientdata(client);
+	size_t count;
+
+	mutex_lock(&ts->input->mutex);
+
+	count = snprintf(buf, PAGE_SIZE, "%04X\n", ts->product_id);
+
+	mutex_unlock(&ts->input->mutex);
+
+	return count;
+}
+
+static DEVICE_ATTR(product_id, S_IRUGO, mip4_sysfs_read_product_id, NULL);
+
 static ssize_t mip4_sysfs_read_ic_name(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf)
@@ -1371,6 +1406,7 @@ static DEVICE_ATTR(ic_name, S_IRUGO, mip4_sysfs_read_ic_name, NULL);
 static struct attribute *mip4_attrs[] = {
 	&dev_attr_fw_version.attr,
 	&dev_attr_hw_version.attr,
+	&dev_attr_product_id.attr,
 	&dev_attr_ic_name.attr,
 	&dev_attr_update_fw.attr,
 	NULL,
@@ -1572,6 +1608,6 @@ static struct i2c_driver mip4_driver = {
 module_i2c_driver(mip4_driver);
 
 MODULE_DESCRIPTION("MELFAS MIP4 Touchscreen");
-MODULE_VERSION("2016.09.28");
+MODULE_VERSION("2016.10.20");
 MODULE_AUTHOR("Sangwon Jee <jeesw@melfas.com>");
 MODULE_LICENSE("GPL");
-- 
1.9.1

