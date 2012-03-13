From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 06/20] Input: atmel_mxt_ts - allow writing to object sysfs entry
Date: Tue, 13 Mar 2012 20:04:09 +0800
Message-ID: <1331640263-18935-7-git-send-email-djkurtz@chromium.org>
References: <1331640263-18935-1-git-send-email-djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1331640263-18935-1-git-send-email-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Iiro Valkonen <iiro.valkonen@atmel.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>
List-Id: linux-input@vger.kernel.org

Userspace can write a 24-bit value (encoded as a 6 character hex string)
to the 'object' sysfs entry to modify a single byte of the object table.
The hex string encodes a 3 bytes, in the following format:
 TTFFVV

Where:
 TT = object type
 FF = object offset
 VV = byte value

The object table is modified in device ram, which means the change is
volatile, and will be overwritten on the next device reset.  To make
changes permanent, the new settings should be persisted in the device's
Non-Voltatile Memory using the updatenv sysfs entry.

Also, since the device driver initializes itself by reading some values
from the object table, the entire driver may need to be unloaded and
reloaded after writing the values for the driver to stay in sync.  Whether
this is required depends on exactly which values were updated.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |   27 ++++++++++++++++++++++++++-
 1 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index dd3919a..ac3dbb7 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -970,6 +970,30 @@ static ssize_t mxt_object_show(struct device *dev,
 	return count;
 }
 
+static ssize_t mxt_object_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct mxt_data *data = dev_get_drvdata(dev);
+	int ret;
+	u32 param;
+	u8 type, offset, val;
+
+	ret = kstrtou32(buf, 16, &param);
+	if (ret < 0)
+		return -EINVAL;
+
+	type = (param & 0x00ff0000) >> 16;
+	offset = (param & 0x00ff00) >> 8;
+	val = param & 0x00ff;
+
+	ret = mxt_write_object(data, type, offset, val);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
 static int mxt_load_fw(struct device *dev, const char *fn)
 {
 	struct mxt_data *data = dev_get_drvdata(dev);
@@ -1075,7 +1099,8 @@ static ssize_t mxt_update_fw_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(object, S_IRUGO, mxt_object_show, NULL);
+static DEVICE_ATTR(object, S_IRUGO | S_IWUSR, mxt_object_show,
+		   mxt_object_store);
 static DEVICE_ATTR(update_fw, S_IWUSR, NULL, mxt_update_fw_store);
 
 static struct attribute *mxt_attrs[] = {
-- 
1.7.7.3
