From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/2] HID: i2c-hid: Do not register i2c_hid_driver on devices with CHPN0001 touchscreen
Date: Sun, 18 Jun 2017 12:14:48 +0200
Message-ID: <20170618101448.17734-3-hdegoede@redhat.com>
References: <20170618101448.17734-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57376 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751057AbdFRKOz (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 18 Jun 2017 06:14:55 -0400
In-Reply-To: <20170618101448.17734-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

The CHPN0001 ACPI device has a _CID of PNP0C50 but is not HID compatible,
it uses its own protocol which is handled by the chipone_icn8318 driver.

Registering the i2c_hid_driver first will cause probing to fail with a
"hid_descr_cmd failed" error.

Worse, after the probe failure the i2c / ACPI core code will put the ACPI
device in D3 state and when the chipone_icn8318 driver then loads the
device is put back in D0 state, executing its PS0 ACPI method, which
resets the controller, causing the controller to loose its firmware
which was loaded by the BIOS. The chipone_icn8318 driver has a workaround
for this, but that requires it to be the only (or the first) driver to
probe the device.

This commit adds a check for the presence of a CHPN0001 ACPI device to
i2c-hid and makes it not register the i2c_hid_driver on systems with this
touchscreen fixing the controller losing its firmware.

Note that acpi_dev_present is a stub always returning false on platforms
without ACPI so for non ACPI platforms this patch is a no-op.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hid/i2c-hid/i2c-hid.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 54b53d8f96ce..71a040d421c6 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -1278,6 +1278,14 @@ static struct i2c_driver i2c_hid_driver = {
 
 static int __init i2c_hid_init(void)
 {
+	/*
+	 * The CHPN0001 ACPI device has a _CID of PNP0C50 but is not HID
+	 * compatible, just probing it puts the device in an unusable state due
+	 * to it also have ACPI power management issues.
+	 */
+	if (acpi_dev_present("CHPN0001", NULL, -1))
+		return -ENODEV;
+
 	return i2c_add_driver(&i2c_hid_driver);
 }
 module_init(i2c_hid_init);
-- 
2.13.0

