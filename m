From: Colin King <colin.king@canonical.com>
Subject: [PATCH] HID: usbhid: Quirk a AMI virtual mouse and keyboard with ALWAYS_POLL
Date: Thu, 26 Jan 2017 17:34:40 +0000
Message-ID: <20170126173440.3653-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Quirking the following AMI USB device with ALWAYS_POLL fixes an AMI
virtual keyboard and mouse from not responding and timing out when
it is attached to a ppc64el Power 8 system and when we have some
rapid open/closes on the mouse device.

 usb 1-3: new high-speed USB device number 2 using xhci_hcd
 usb 1-3: New USB device found, idVendor=046b, idProduct=ff01
 usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
 usb 1-3: Product: Virtual Hub
 usb 1-3: Manufacturer: American Megatrends Inc.
 usb 1-3: SerialNumber: serial
 usb 1-3.3: new high-speed USB device number 3 using xhci_hcd
 usb 1-3.3: New USB device found, idVendor=046b, idProduct=ff31
 usb 1-3.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
 usb 1-3.3: Product: Virtual HardDisk Device
 usb 1-3.3: Manufacturer: American Megatrends Inc.
 usb 1-3.4: new low-speed USB device number 4 using xhci_hcd
 usb 1-3.4: New USB device found, idVendor=046b, idProduct=ff10
 usb 1-3.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
 usb 1-3.4: Product: Virtual Keyboard and Mouse
 usb 1-3.4: Manufacturer: American Megatrends Inc.

With the quirk I have not been able to trigger the issue with
half an hour of saturation soak testing.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/hid/hid-ids.h           | 3 +++
 drivers/hid/usbhid/hid-quirks.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index e348865..45317d3 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -76,6 +76,9 @@
 #define USB_VENDOR_ID_ALPS_JP		0x044E
 #define HID_DEVICE_ID_ALPS_U1_DUAL	0x120B
 
+#define USB_VENDOR_ID_AMI		0x046b
+#define USB_DEVICE_ID_AMI_VIRT_KEYBOARD_AND_MOUSE	0xff10
+
 #define USB_VENDOR_ID_ANTON		0x1130
 #define USB_DEVICE_ID_ANTON_TOUCH_PAD	0x3101
 
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 37d17f7..d6847a6 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -57,6 +57,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_AIREN, USB_DEVICE_ID_AIREN_SLIMPLUS, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_AKAI, USB_DEVICE_ID_AKAI_MPKMINI2, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_AKAI_09E8, USB_DEVICE_ID_AKAI_09E8_MIDIMIX, HID_QUIRK_NO_INIT_REPORTS },
+	{ USB_VENDOR_ID_AMI, USB_DEVICE_ID_AMI_VIRT_KEYBOARD_AND_MOUSE, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_UC100KM, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_CS124U, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_2PORTKVM, HID_QUIRK_NOGET },
-- 
2.10.2
