From: Charlie Mooney <charliemooney@chromium.org>
Subject: [PATCH] input: elan_i2c - Add product IDs FW names
Date: Fri,  5 Jun 2015 09:25:31 -0700
Message-ID: <1433521531-920-1-git-send-email-charliemooney@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:33931 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbbFEQ0E (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Jun 2015 12:26:04 -0400
Received: by iebmu5 with SMTP id mu5so26288464ieb.1
        for <linux-input@vger.kernel.org>; Fri, 05 Jun 2015 09:26:04 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, dusonlin@emc.com.tw, bleung@chromium.org, nicolas.iooss_linux@m4x.org, charliemooney@google.com, Charlie Mooney <charliemooney@chromium.org>

Previously the elan_i2c touchpad driver would simply request the
firmware "/lib/firmware/elan_i2c.bin"

This CL appends the "product ID" (by using the same function as
the sysfs interface for consistency) to the filename.  This results in
filenames of the form "/lib/firmware/elan_i2c_72.0.bin", allowing you
to support multiple elan_i2c touchpads on the same device by simply
naming each device's FW with its corresponding product ID.  This way
when you trigger a fw update the driver will load the correct binary.

Signed-off-by: Charlie Mooney <charliemooney@chromium.org>
---
 drivers/input/mouse/elan_i2c.h      |  4 +++-
 drivers/input/mouse/elan_i2c_core.c | 19 +++++++++++++++----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c.h b/drivers/input/mouse/elan_i2c.h
index 6d5f8a4..d793184 100644
--- a/drivers/input/mouse/elan_i2c.h
+++ b/drivers/input/mouse/elan_i2c.h
@@ -28,7 +28,9 @@
 #define ETP_PRESSURE_OFFSET	25
 
 /* IAP Firmware handling */
-#define ETP_FW_NAME		"elan_i2c.bin"
+#define ETP_FW_BASENAME		"elan_i2c"
+#define ETP_FW_EXTENSION	"bin"
+#define ETP_PRODUCT_ID_FORMAT_STRING	"%d.0"
 #define ETP_IAP_START_ADDR	0x0083
 #define ETP_FW_IAP_PAGE_ERR	(1 << 5)
 #define ETP_FW_IAP_INTF_ERR	(1 << 4)
diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index fd5068b..fea9837 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -403,7 +403,8 @@ static ssize_t elan_sysfs_read_product_id(struct device *dev,
 	struct i2c_client *client = to_i2c_client(dev);
 	struct elan_tp_data *data = i2c_get_clientdata(client);
 
-	return sprintf(buf, "%d.0\n", data->product_id);
+	return sprintf(buf, ETP_PRODUCT_ID_FORMAT_STRING "\n",
+		       data->product_id);
 }
 
 static ssize_t elan_sysfs_read_fw_ver(struct device *dev,
@@ -446,10 +447,20 @@ static ssize_t elan_sysfs_update_fw(struct device *dev,
 	const u8 *fw_signature;
 	static const u8 signature[] = {0xAA, 0x55, 0xCC, 0x33, 0xFF, 0xFF};
 
-	error = request_firmware(&fw, ETP_FW_NAME, dev);
+	/* Look for a firmware with the product id appended. */
+	char *full_fw_name = kasprintf(GFP_KERNEL,
+			"%s_" ETP_PRODUCT_ID_FORMAT_STRING ".%s",
+			ETP_FW_BASENAME, data->product_id, ETP_FW_EXTENSION);
+	if (!full_fw_name) {
+		dev_err(dev, "failed fw filename memory allocation.");
+		return -ENOMEM;
+	}
+	dev_info(dev, "requesting fw '%s'\n", fw_name);
+	error = request_firmware(&fw, full_fw_name, dev);
+	kfree(full_fw_name);
 	if (error) {
-		dev_err(dev, "cannot load firmware %s: %d\n",
-			ETP_FW_NAME, error);
+		dev_err(dev, "cannot load firmware '%s': %d\n",
+			full_fw_name, error);
 		return error;
 	}
 
-- 
2.1.2

