From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v2 3/8] input: goodix: export id and version read from device
Date: Mon,  8 Jun 2015 17:37:48 +0300
Message-ID: <1433774273-23103-4-git-send-email-irina.tirdea@intel.com>
References: <1433774273-23103-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:52563 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932142AbbFHOjz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 8 Jun 2015 10:39:55 -0400
In-Reply-To: <1433774273-23103-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Irina Tirdea <irina.tirdea@intel.com>, Octavian Purdila <octavian.purdila@intel.com>

Goodix touchscreens export through their registers a Product ID
and Firmware Version. The Product ID is an ASCII encoding of the
product name (e.g.: "911").

Export to sysfs (through the input subsystem) the product id and
firmware version read from the device rather than using constant
values.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 drivers/input/touchscreen/goodix.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 18557e4..7cd3780 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -47,7 +47,7 @@ struct goodix_ts_data {
 /* Register defines */
 #define GOODIX_READ_COOR_ADDR		0x814E
 #define GOODIX_REG_CONFIG_DATA		0x8047
-#define GOODIX_REG_VERSION		0x8140
+#define GOODIX_REG_ID			0x8140
 
 #define RESOLUTION_LOC		1
 #define MAX_CONTACTS_LOC	5
@@ -230,22 +230,27 @@ static void goodix_read_config(struct goodix_ts_data *ts)
  *
  * @client: the i2c client
  * @version: output buffer containing the version on success
+ * @id: output buffer containing the id on success
  */
-static int goodix_read_version(struct i2c_client *client, u16 *version)
+static int goodix_read_version(struct i2c_client *client, u16 *version, u16 *id)
 {
 	int error;
 	u8 buf[6];
+	char id_str[5];
 
-	error = goodix_i2c_read(client, GOODIX_REG_VERSION, buf, sizeof(buf));
+	error = goodix_i2c_read(client, GOODIX_REG_ID, buf, sizeof(buf));
 	if (error) {
 		dev_err(&client->dev, "read version failed: %d\n", error);
 		return error;
 	}
 
-	if (version)
-		*version = get_unaligned_le16(&buf[4]);
+	memcpy(id_str, buf, 4);
+	id_str[4] = 0;
+	if (kstrtou16(id_str, 10, id))
+		*id = 0x1001;
+	*version = get_unaligned_le16(&buf[4]);
 
-	dev_info(&client->dev, "IC VERSION: %6ph\n", buf);
+	dev_info(&client->dev, "ID %d, version: %04x\n", *id, *version);
 
 	return 0;
 }
@@ -279,10 +284,13 @@ static int goodix_i2c_test(struct i2c_client *client)
  * goodix_request_input_dev - Allocate, populate and register the input device
  *
  * @ts: our goodix_ts_data pointer
+ * @version: device firmware version
+ * @id: device ID
  *
  * Must be called during probe
  */
-static int goodix_request_input_dev(struct goodix_ts_data *ts)
+static int goodix_request_input_dev(struct goodix_ts_data *ts, u16 version,
+				    u16 id)
 {
 	int error;
 
@@ -310,8 +318,8 @@ static int goodix_request_input_dev(struct goodix_ts_data *ts)
 	ts->input_dev->phys = "input/ts";
 	ts->input_dev->id.bustype = BUS_I2C;
 	ts->input_dev->id.vendor = 0x0416;
-	ts->input_dev->id.product = 0x1001;
-	ts->input_dev->id.version = 10427;
+	ts->input_dev->id.product = id;
+	ts->input_dev->id.version = version;
 
 	error = input_register_device(ts->input_dev);
 	if (error) {
@@ -329,7 +337,7 @@ static int goodix_ts_probe(struct i2c_client *client,
 	struct goodix_ts_data *ts;
 	unsigned long irq_flags;
 	int error;
-	u16 version_info;
+	u16 version_info, id_info;
 
 	dev_dbg(&client->dev, "I2C Address: 0x%02x\n", client->addr);
 
@@ -351,7 +359,7 @@ static int goodix_ts_probe(struct i2c_client *client,
 		return error;
 	}
 
-	error = goodix_read_version(client, &version_info);
+	error = goodix_read_version(client, &version_info, &id_info);
 	if (error) {
 		dev_err(&client->dev, "Read version failed.\n");
 		return error;
@@ -359,7 +367,7 @@ static int goodix_ts_probe(struct i2c_client *client,
 
 	goodix_read_config(ts);
 
-	error = goodix_request_input_dev(ts);
+	error = goodix_request_input_dev(ts, version_info, id_info);
 	if (error)
 		return error;
 
-- 
1.9.1

