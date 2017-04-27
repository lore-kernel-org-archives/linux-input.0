From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] HID: Support i2c-hid multitouch compatible Wacom touchscreens
Date: Thu, 27 Apr 2017 16:57:57 +0300
Message-ID: <20170427135757.29947-1-jarkko.nikula@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:57761 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033461AbdD0OEY (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 27 Apr 2017 10:04:24 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

Vendor specific handling in hid_scan_report() overrides the hid->group
to HID_GROUP_WACOM for all devices with vendor ID equal to
USB_VENDOR_ID_WACOM.

However there is an i2c-hid multitouch compatible Wacom touschreen which
is parsed as generic HID_GROUP_MULTITOUCH_WIN_8 device but
hid-multitouch doesn't probe because of this overriding.

Support this touschreen by overring the group only when the bus is
different than I2C.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
I'm not an HID expert and I don't know is there any existing Wacom
tablets using the I2C bus. There are USB and Bluetooth tablets so that's
the reason I'm checking id->bus != BUS_I2C when overring the group.
I've done only basic testing that device is registered as an
hid-multitouch device and "hexdump /dev/input/eventX" produces a bunch
of hexadecimals when touschscreen is touched.
---
 drivers/hid/hid-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index d162f0dc76e3..cfb0b7262de7 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -816,7 +816,8 @@ static int hid_scan_report(struct hid_device *hid)
 	 */
 	switch (hid->vendor) {
 	case USB_VENDOR_ID_WACOM:
-		hid->group = HID_GROUP_WACOM;
+		if (hid->bus != BUS_I2C)
+			hid->group = HID_GROUP_WACOM;
 		break;
 	case USB_VENDOR_ID_SYNAPTICS:
 		if (hid->group == HID_GROUP_GENERIC)
-- 
2.11.0

