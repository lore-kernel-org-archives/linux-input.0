From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] HID: multitouch: Do not fetch initial feature reports for Win8 devices
Date: Thu, 24 Sep 2015 13:12:51 +0300
Message-ID: <1443089571-16561-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Some newer Intel Skylake based Dell laptops with Win8 precision touchpad
fail when initial feature reports are fetched from it. Below is an
example output with some additional debug included:

 i2c_hid i2c-DLL0704:01: Fetching the HID descriptor
 i2c_hid i2c-DLL0704:01: __i2c_hid_command: cmd=20 00
 i2c_hid i2c-DLL0704:01: HID Descriptor: 1e 00 00 01 99 02 21 00 24 ...
 ...
 i2c_hid i2c-DLL0704:01: i2c_hid_get_report
 i2c_hid i2c-DLL0704:01: __i2c_hid_command: cmd=22 00 38 02 23 00
 i2c_hid i2c-DLL0704:01: report (len=4): 04 00 08 05
 i2c_hid i2c-DLL0704:01: report id 13
 i2c_hid i2c-DLL0704:01: i2c_hid_get_report
 i2c_hid i2c-DLL0704:01: __i2c_hid_command: cmd=22 00 3d 02 23 00
 i2c_hid i2c-DLL0704:01: failed to retrieve report from device.
 i2c_hid i2c-DLL0704:01: report id 7
 i2c_hid i2c-DLL0704:01: i2c_hid_get_report
 i2c_hid i2c-DLL0704:01: __i2c_hid_command: cmd=22 00 37 02 23 00
 i2c_hid i2c-DLL0704:01: report (len=259): 03 01 07 fc 28 fe 84 40 ...
 i2c_hid i2c-DLL0704:01: report id 4
 i2c_hid i2c-DLL0704:01: i2c_hid_get_report
 i2c_hid i2c-DLL0704:01: __i2c_hid_command: cmd=22 00 34 02 23 00

We manage to fetch few reports but then the touchpad dies:

 i2c_designware i2c_designware.1: i2c_dw_handle_tx_abort: lost arbitration
 i2c_hid i2c-DLL0704:01: failed to retrieve report from device.

it eventually pulls the whole I2C bus low:

 i2c_designware i2c_designware.1: controller timed out
 i2c_hid i2c-DLL0704:01: failed to set a report to device.

Fix this by preventing initial feature report fetch for Win8 devices. It
should not be needed anyway according to [1] because the two "GET"
feature reports for these devices are about device capabilities and Win8
certification status which are not related to input events.

[1] https://msdn.microsoft.com/en-us/library/windows/hardware/dn467314(v=vs.85).aspx

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/hid/hid-multitouch.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 426b2f1a3450..1911f7698511 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1020,14 +1020,16 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	/*
 	 * Handle special quirks for Windows 8 certified devices.
 	 */
-	if (id->group == HID_GROUP_MULTITOUCH_WIN_8)
+	if (id->group == HID_GROUP_MULTITOUCH_WIN_8) {
 		/*
 		 * Some multitouch screens do not like to be polled for input
-		 * reports. Fortunately, the Win8 spec says that all touches
-		 * should be sent during each report, making the initialization
-		 * of input reports unnecessary.
+		 * and feature reports. Fortunately, the Win8 spec says that all
+		 * touches should be sent during each report, making the
+		 * initialization of input reports unnecessary.
 		 */
 		hdev->quirks |= HID_QUIRK_NO_INIT_INPUT_REPORTS;
+		hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
+	}
 
 	td = devm_kzalloc(&hdev->dev, sizeof(struct mt_device), GFP_KERNEL);
 	if (!td) {
-- 
2.5.1
