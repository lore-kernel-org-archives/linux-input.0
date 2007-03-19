From: Paul Walmsley <paul@booyaka.com>
Subject: [PATCH 1/7] usbhid: specify explicit size for hid_blacklist.quirks
Date: Sun, 18 Mar 2007 22:21:46 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0703182037050.21893@utopia.booyaka.com>
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

Explicitly specify the size of the hid_blacklist quirks member, to guard
against surprises on architectures where unsigned ints aren't 32 bits long.

Signed-off-by: Paul Walmsley <paul@booyaka.com>

---
  dev/drivers/usb/input/hid-core.c |    5 +++--
  1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux/dev/drivers/usb/input/hid-core.c
===================================================================
--- linux.orig/dev/drivers/usb/input/hid-core.c
+++ linux/dev/drivers/usb/input/hid-core.c
@@ -772,7 +772,7 @@ void usbhid_init_reports(struct hid_devi
  static const struct hid_blacklist {
  	__u16 idVendor;
  	__u16 idProduct;
-	unsigned quirks;
+	__u32 quirks;
  } hid_blacklist[] = {

  	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_DINOVO_EDGE, HID_QUIRK_DUPLICATE_USAGES },
@@ -1059,7 +1059,8 @@ static struct hid_device *usb_hid_config
  	struct usb_device *dev = interface_to_usbdev (intf);
  	struct hid_descriptor *hdesc;
  	struct hid_device *hid;
-	unsigned quirks = 0, rsize = 0;
+	__u32 quirks = 0;
+	unsigned rsize = 0;
  	char *rdesc;
  	int n, len, insize = 0;
  	struct usbhid_device *usbhid;
