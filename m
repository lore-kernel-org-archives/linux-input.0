From: Paul Walmsley <paul@booyaka.com>
Subject: [PATCH 2/7] usbhid: consolidate USB_VENDOR*, USB_DEVICE* defines
Date: Wed, 11 Apr 2007 00:49:59 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0704110032550.28726@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org


From: Paul Walmsley <paul@booyaka.com>

Consolidate the USB_VENDOR* and USB_DEVICE* defines into one block.

Signed-off-by: Paul Walmsley <paul@booyaka.com>

---
  drivers/usb/input/hid-core.c |   12 ++++++------
  1 file changed, 6 insertions(+), 6 deletions(-)

Index: linux/drivers/usb/input/hid-core.c
===================================================================
--- linux.orig/drivers/usb/input/hid-core.c
+++ linux/drivers/usb/input/hid-core.c
@@ -509,12 +509,6 @@ void usbhid_close(struct hid_device *hid
  		usb_kill_urb(usbhid->urbin);
  }

-#define USB_VENDOR_ID_PANJIT		0x134c
-
-#define USB_VENDOR_ID_TURBOX		0x062a
-#define USB_DEVICE_ID_TURBOX_KEYBOARD	0x0201
-#define USB_VENDOR_ID_CIDC		0x1677
-
  /*
   * Initialize all reports
   */
@@ -546,6 +540,12 @@ void usbhid_init_reports(struct hid_devi
  		warn("timeout initializing reports");
  }

+#define USB_VENDOR_ID_PANJIT		0x134c
+
+#define USB_VENDOR_ID_TURBOX		0x062a
+#define USB_DEVICE_ID_TURBOX_KEYBOARD	0x0201
+#define USB_VENDOR_ID_CIDC		0x1677
+
  #define USB_VENDOR_ID_GTCO		0x078c
  #define USB_DEVICE_ID_GTCO_90		0x0090
  #define USB_DEVICE_ID_GTCO_100		0x0100
