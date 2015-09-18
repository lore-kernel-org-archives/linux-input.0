From: Daniel Drake <drake@endlessm.com>
Subject: [PATCH v2] elan_i2c - Don't require known iap version
Date: Fri, 18 Sep 2015 07:38:15 -0600
Message-ID: <1442583495-4593-1-git-send-email-drake@endlessm.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33949 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596AbbIRNib (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Sep 2015 09:38:31 -0400
Received: by padhy16 with SMTP id hy16so51917393pad.1
        for <linux-input@vger.kernel.org>; Fri, 18 Sep 2015 06:38:31 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, dusonlin@emc.com.tw
Cc: jprvita@gmail.com, linux-input@vger.kernel.org

The Asus X456UA has an ELAN1000 touchpad with IAP version 0xe.
This is unknown to elan_get_fwinfo() so driver probe fails and I
am left with an unusable touchpad.

However, the fwinfo is not required for general driver usage,
it is only needed if the user decides to upload new firmware.

Adjust the driver so that fwinfo is only calculated and used
when it is really needed.

Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 drivers/input/mouse/elan_i2c_core.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

v2: simplified dev_err call

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index fa94530..bababfe 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -84,8 +84,6 @@ struct elan_tp_data {
 	int			pressure_adjustment;
 	u8			mode;
 	u8			ic_type;
-	u16			fw_validpage_count;
-	u16			fw_signature_address;
 
 	bool			irq_wake;
 
@@ -264,14 +262,6 @@ static int elan_query_device_info(struct elan_tp_data *data)
 	if (error)
 		return error;
 
-	error = elan_get_fwinfo(data->iap_version, &data->fw_validpage_count,
-				&data->fw_signature_address);
-	if (error) {
-		dev_err(&data->client->dev,
-			"unknown iap version %d\n", data->iap_version);
-		return error;
-	}
-
 	return 0;
 }
 
@@ -339,7 +329,8 @@ static int elan_write_fw_block(struct elan_tp_data *data,
 }
 
 static int __elan_update_firmware(struct elan_tp_data *data,
-				  const struct firmware *fw)
+				  const struct firmware *fw,
+				  u16 fw_validpage_count)
 {
 	struct i2c_client *client = data->client;
 	struct device *dev = &client->dev;
@@ -356,7 +347,7 @@ static int __elan_update_firmware(struct elan_tp_data *data,
 	iap_start_addr = get_unaligned_le16(&fw->data[ETP_IAP_START_ADDR * 2]);
 
 	boot_page_count = (iap_start_addr * 2) / ETP_FW_PAGE_SIZE;
-	for (i = boot_page_count; i < data->fw_validpage_count; i++) {
+	for (i = boot_page_count; i < fw_validpage_count; i++) {
 		u16 checksum = 0;
 		const u8 *page = &fw->data[i * ETP_FW_PAGE_SIZE];
 
@@ -393,7 +384,8 @@ static int __elan_update_firmware(struct elan_tp_data *data,
 }
 
 static int elan_update_firmware(struct elan_tp_data *data,
-				const struct firmware *fw)
+				const struct firmware *fw,
+				u16 fw_validpage_count)
 {
 	struct i2c_client *client = data->client;
 	int retval;
@@ -403,7 +395,7 @@ static int elan_update_firmware(struct elan_tp_data *data,
 	disable_irq(client->irq);
 	data->in_fw_update = true;
 
-	retval = __elan_update_firmware(data, fw);
+	retval = __elan_update_firmware(data, fw, fw_validpage_count);
 	if (retval) {
 		dev_err(&client->dev, "firmware update failed: %d\n", retval);
 		data->ops->iap_reset(client);
@@ -485,6 +477,15 @@ static ssize_t elan_sysfs_update_fw(struct device *dev,
 	int error;
 	const u8 *fw_signature;
 	static const u8 signature[] = {0xAA, 0x55, 0xCC, 0x33, 0xFF, 0xFF};
+	u16 fw_validpage_count;
+	u16 fw_signature_address;
+
+	error = elan_get_fwinfo(data->iap_version, &fw_validpage_count,
+				&fw_signature_address);
+	if (error) {
+		dev_err(dev, "unknown iap version %d\n", data->iap_version);
+		return error;
+	}
 
 	/* Look for a firmware with the product id appended. */
 	fw_name = kasprintf(GFP_KERNEL, ETP_FW_NAME, data->product_id);
@@ -502,7 +503,7 @@ static ssize_t elan_sysfs_update_fw(struct device *dev,
 	}
 
 	/* Firmware file must match signature data */
-	fw_signature = &fw->data[data->fw_signature_address];
+	fw_signature = &fw->data[fw_signature_address];
 	if (memcmp(fw_signature, signature, sizeof(signature)) != 0) {
 		dev_err(dev, "signature mismatch (expected %*ph, got %*ph)\n",
 			(int)sizeof(signature), signature,
@@ -515,7 +516,7 @@ static ssize_t elan_sysfs_update_fw(struct device *dev,
 	if (error)
 		goto out_release_fw;
 
-	error = elan_update_firmware(data, fw);
+	error = elan_update_firmware(data, fw, fw_validpage_count);
 
 	mutex_unlock(&data->sysfs_mutex);
 
-- 
2.1.4

