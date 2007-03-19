From: Paul Walmsley <paul@booyaka.com>
Subject: [PATCH 3/7] usbhid: convert Wacom and Codemercs quirks to list
 entries
Date: Sun, 18 Mar 2007 22:21:57 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0703182039270.21893@utopia.booyaka.com>
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

Convert the existing Wacom and Codemercs quirks from
special-purpose code to quirks list entries with non-0xffff masks.

Signed-off-by: Paul Walmsley <paul@booyaka.com>

---
  dev/drivers/usb/input/hid-core.c |   14 ++++----------
  1 file changed, 4 insertions(+), 10 deletions(-)

Index: linux/dev/drivers/usb/input/hid-core.c
===================================================================
--- linux.orig/dev/drivers/usb/input/hid-core.c
+++ linux/dev/drivers/usb/input/hid-core.c
@@ -688,7 +688,6 @@ void usbhid_init_reports(struct hid_devi

  #define USB_VENDOR_ID_CODEMERCS		0x07c0
  #define USB_DEVICE_ID_CODEMERCS_IOW_FIRST	0x1500
-#define USB_DEVICE_ID_CODEMERCS_IOW_LAST	0x15ff

  #define USB_VENDOR_ID_DELORME		0x1163
  #define USB_DEVICE_ID_DELORME_EARTHMATE 0x0100
@@ -949,6 +948,10 @@ static const struct hid_blacklist {

  	{ USB_VENDOR_ID_CIDC, 0x0103, 0xffff, HID_QUIRK_IGNORE },

+	{ USB_VENDOR_ID_WACOM, 0x0000, 0x0000, HID_QUIRK_IGNORE },
+
+        { USB_VENDOR_ID_CODEMERCS, USB_DEVICE_ID_CODEMERCS_IOW_FIRST, 0xff00, HID_QUIRK_IGNORE },
+
  	{ 0, 0 }
  };

@@ -1174,15 +1177,6 @@ static struct hid_device *usb_hid_config
  	int n, len, insize = 0;
  	struct usbhid_device *usbhid;

-	/* Ignore all Wacom devices */
-	if (le16_to_cpu(dev->descriptor.idVendor) == USB_VENDOR_ID_WACOM)
-		return NULL;
-	/* ignore all Code Mercenaries IOWarrior devices */
-	if (le16_to_cpu(dev->descriptor.idVendor) == USB_VENDOR_ID_CODEMERCS)
-		if (le16_to_cpu(dev->descriptor.idProduct) >= USB_DEVICE_ID_CODEMERCS_IOW_FIRST &&
-		    le16_to_cpu(dev->descriptor.idProduct) <= USB_DEVICE_ID_CODEMERCS_IOW_LAST)
-			return NULL;
-
  	quirks = lookup_quirk(le16_to_cpu(dev->descriptor.idVendor),
  			      le16_to_cpu(dev->descriptor.idProduct));
