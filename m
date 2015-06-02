From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH] HID: i2c-hid: Do not set the ACPI companion field in the HID device
Date: Tue, 2 Jun 2015 14:46:20 -0700
Message-ID: <1433281580-8319-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:42412 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751411AbbFBV4c (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Jun 2015 17:56:32 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Benson Leung <bleung@chromium.org>

The HID device does not need to know about the ACPI device associated with
the underlying i2c device. Setting the ACPI companion field in the HID device
also has the side effect of causing HID to be set as wake capable, since
acpi_bind_one uses's the companion ACPI device's wakeup flags to set the
device as wake capable. Which results in power/wakeup files in sysfs for
the HID device which do not do anything.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 drivers/hid/i2c-hid/i2c-hid.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 92d6cdf..0dfb5d1 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -1019,7 +1019,6 @@ static int i2c_hid_probe(struct i2c_client *client,
 	hid->driver_data = client;
 	hid->ll_driver = &i2c_hid_ll_driver;
 	hid->dev.parent = &client->dev;
-	ACPI_COMPANION_SET(&hid->dev, ACPI_COMPANION(&client->dev));
 	hid->bus = BUS_I2C;
 	hid->version = le16_to_cpu(ihid->hdesc.bcdVersion);
 	hid->vendor = le16_to_cpu(ihid->hdesc.wVendorID);
-- 
2.1.4

