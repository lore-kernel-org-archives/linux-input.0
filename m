From: Bibek Basu <bbasu@nvidia.com>
Subject: [PATCH] HID: i2c-hid: add platform data for quirks
Date: Thu, 3 Oct 2013 14:18:41 +0530
Message-ID: <1380790121-1355-1-git-send-email-bbasu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17685 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753334Ab3JCItP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Oct 2013 04:49:15 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: benjamin.tissoires@gmail.com
Cc: linux-tegra@vger.kernel.org, jkosina@suse.cz, kadduri@nvidia.com, linux-input@vger.kernel.org, Bibek Basu <bbasu@nvidia.com>

Some HID device does not responds to INPUT/FEATURE
report query during initialization. As a result HID driver
throws error even when its not mandatory according to the
HID specification. Add platform data to provide
quirk information to the driver so that init query is not
done on such devices.

Signed-off-by: Bibek Basu <bbasu@nvidia.com>
---
 drivers/hid/i2c-hid/i2c-hid.c | 1 +
 include/linux/i2c/i2c-hid.h   | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index fd7ce37..a7aec2c 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -1017,6 +1017,7 @@ static int i2c_hid_probe(struct i2c_client *client,
 	hid->version = le16_to_cpu(ihid->hdesc.bcdVersion);
 	hid->vendor = le16_to_cpu(ihid->hdesc.wVendorID);
 	hid->product = le16_to_cpu(ihid->hdesc.wProductID);
+	hid->quirks = platform_data->quirks;
 
 	snprintf(hid->name, sizeof(hid->name), "%s %04hX:%04hX",
 		 client->name, hid->vendor, hid->product);
diff --git a/include/linux/i2c/i2c-hid.h b/include/linux/i2c/i2c-hid.h
index 7aa901d..12e682d 100644
--- a/include/linux/i2c/i2c-hid.h
+++ b/include/linux/i2c/i2c-hid.h
@@ -17,7 +17,7 @@
 /**
  * struct i2chid_platform_data - used by hid over i2c implementation.
  * @hid_descriptor_address: i2c register where the HID descriptor is stored.
- *
+ * @quirks: quirks, if any for i2c-hid devices
  * Note that it is the responsibility of the platform driver (or the acpi 5.0
  * driver, or the flattened device tree) to setup the irq related to the gpio in
  * the struct i2c_board_info.
@@ -31,6 +31,7 @@
  */
 struct i2c_hid_platform_data {
 	u16 hid_descriptor_address;
+	u32 quirks;
 };
 
 #endif /* __LINUX_I2C_HID_H */
-- 
1.8.1.5

