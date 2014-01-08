From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH] input synaptics-rmi4: move rmi_f01 query register parsing to its own function
Date: Tue, 7 Jan 2014 17:02:10 -0800
Message-ID: <1389142930-26279-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:9748 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754037AbaAHBCO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Jan 2014 20:02:14 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

In the near future, query register parsing is going to get a lot more
complicated.  It's also going to be needed by the reflash code.  Now is the
time to move this from the F01 initialization into its own function,
while the code is still fairly simple.

Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

 drivers/input/rmi4/rmi_f01.c | 71 +++++++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 28 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
index d547633..1cb11ea 100644
--- a/drivers/input/rmi4/rmi_f01.c
+++ b/drivers/input/rmi4/rmi_f01.c
@@ -167,6 +167,46 @@ static int rmi_f01_alloc_memory(struct rmi_function *fn,
 	return 0;
 }
 
+static int rmi_f01_read_properties(struct rmi_device *rmi_dev,
+				   u16 query_base_addr,
+				   struct f01_basic_properties *props)
+{
+	u8 basic_query[RMI_F01_BASIC_QUERY_LEN];
+	int error;
+
+	error = rmi_read_block(rmi_dev, query_base_addr,
+			       basic_query, sizeof(basic_query));
+	if (error < 0) {
+		dev_err(&rmi_dev->dev, "Failed to read device query registers.\n");
+		return error;
+	}
+
+	/* Now parse what we got */
+	props->manufacturer_id = basic_query[0];
+
+	props->has_lts = basic_query[1] & RMI_F01_QRY1_HAS_LTS;
+	props->has_adjustable_doze =
+			basic_query[1] & RMI_F01_QRY1_HAS_ADJ_DOZE;
+	props->has_adjustable_doze_holdoff =
+			basic_query[1] & RMI_F01_QRY1_HAS_ADJ_DOZE_HOFF;
+
+	snprintf(props->dom, sizeof(props->dom),
+		 "20%02x%02x%02x",
+		 basic_query[5] & RMI_F01_QRY5_YEAR_MASK,
+		 basic_query[6] & RMI_F01_QRY6_MONTH_MASK,
+		 basic_query[7] & RMI_F01_QRY7_DAY_MASK);
+
+	memcpy(props->product_id, &basic_query[11],
+		RMI_PRODUCT_ID_LENGTH);
+	props->product_id[RMI_PRODUCT_ID_LENGTH] = '\0';
+
+	props->productinfo =
+			((basic_query[2] & RMI_F01_QRY2_PRODINFO_MASK) << 7) |
+			(basic_query[3] & RMI_F01_QRY2_PRODINFO_MASK);
+
+	return 0;
+}
+
 static int rmi_f01_initialize(struct rmi_function *fn)
 {
 	u8 temp;
@@ -176,7 +216,6 @@ static int rmi_f01_initialize(struct rmi_function *fn)
 	struct rmi_driver_data *driver_data = dev_get_drvdata(&rmi_dev->dev);
 	struct f01_data *data = fn->data;
 	struct rmi_device_platform_data *pdata = to_rmi_platform_data(rmi_dev);
-	u8 basic_query[RMI_F01_BASIC_QUERY_LEN];
 
 	mutex_init(&data->control_mutex);
 
@@ -248,36 +287,12 @@ static int rmi_f01_initialize(struct rmi_function *fn)
 		return error;
 	}
 
-	error = rmi_read_block(rmi_dev, fn->fd.query_base_addr,
-			       basic_query, sizeof(basic_query));
+	error = rmi_f01_read_properties(rmi_dev, fn->fd.query_base_addr,
+		&data->properties);
 	if (error < 0) {
-		dev_err(&fn->dev, "Failed to read device query registers.\n");
+		dev_err(&fn->dev, "Failed to read F01 properties.\n");
 		return error;
 	}
-
-	/* Now parse what we got */
-	data->properties.manufacturer_id = basic_query[0];
-
-	data->properties.has_lts = basic_query[1] & RMI_F01_QRY1_HAS_LTS;
-	data->properties.has_adjustable_doze =
-			basic_query[1] & RMI_F01_QRY1_HAS_ADJ_DOZE;
-	data->properties.has_adjustable_doze_holdoff =
-			basic_query[1] & RMI_F01_QRY1_HAS_ADJ_DOZE_HOFF;
-
-	snprintf(data->properties.dom, sizeof(data->properties.dom),
-		 "20%02x%02x%02x",
-		 basic_query[5] & RMI_F01_QRY5_YEAR_MASK,
-		 basic_query[6] & RMI_F01_QRY6_MONTH_MASK,
-		 basic_query[7] & RMI_F01_QRY7_DAY_MASK);
-
-	memcpy(data->properties.product_id, &basic_query[11],
-		RMI_PRODUCT_ID_LENGTH);
-	data->properties.product_id[RMI_PRODUCT_ID_LENGTH] = '\0';
-
-	data->properties.productinfo =
-			((basic_query[2] & RMI_F01_QRY2_PRODINFO_MASK) << 7) |
-			(basic_query[3] & RMI_F01_QRY2_PRODINFO_MASK);
-
 	dev_info(&fn->dev, "found RMI device, manufacturer: %s, product: %s\n",
 		 data->properties.manufacturer_id == 1 ?
 							"Synaptics" : "unknown",
