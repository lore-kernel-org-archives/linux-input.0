From: Paul Walmsley <paul@booyaka.com>
Subject: [PATCH 4/7] usbhid: clarify static quirk handling as 'squirks'
Date: Wed, 11 Apr 2007 00:50:08 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0704110034500.28726@utopia.booyaka.com>
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

Rename existing quirks handling code that operates over a static array
to "squirks" (short for static quirks) to differentate it from the
dynamically-allocated "extra" quirks that will be introduced in the
next patch.  Add an accessor function specifically for static quirks,
usbhid_exists_squirk().

Signed-off-by: Paul Walmsley <paul@booyaka.com>

---
  drivers/usb/input/hid-quirks.c |   39 ++++++++++++++++++++++++++++++++++++---
  1 file changed, 36 insertions(+), 3 deletions(-)

Index: dev/drivers/usb/input/hid-quirks.c
===================================================================
--- dev.orig/drivers/usb/input/hid-quirks.c
+++ dev/drivers/usb/input/hid-quirks.c
@@ -38,6 +38,8 @@
  #include <linux/hid-quirks.h>
  #include "usbhid.h"

+static struct hid_blacklist *usbhid_exists_squirk(const u16 idVendor, const u16 idProduct);
+

  #define USB_VENDOR_ID_PANJIT		0x134c

@@ -467,7 +469,7 @@ static struct hid_blacklist {
  u32 usbhid_lookup_any_quirk(const u16 idVendor, const u16 idProduct)
  {
  	u32 quirks = 0;
-	int n = 0;
+	struct hid_blacklist *ble = NULL;

  	/* Ignore all Wacom devices */
  	if (idVendor == USB_VENDOR_ID_WACOM)
@@ -478,11 +480,42 @@ u32 usbhid_lookup_any_quirk(const u16 id
  		    idProduct <= USB_DEVICE_ID_CODEMERCS_IOW_LAST)
  			return 0;

+	ble = usbhid_exists_squirk(idVendor, idProduct);
+	if (ble)
+		quirks = ble->quirks;
+
+	return quirks;
+}
+
+
+/* Static quirk accessor functions */
+
+/**
+ * usbhid_exists_squirk: return any static quirks for a USB HID device
+ * @idVendor: the 16-bit USB vendor ID, in native byteorder
+ * @idProduct: the 16-bit USB product ID, in native byteorder
+ *
+ * Description:
+ *     Given a USB vendor ID and product ID, return a pointer to
+ *     the hid_blacklist entry associated with that device.
+ *
+ * Returns: pointer if quirk found, or NULL if no quirks found.
+ */
+static struct hid_blacklist *usbhid_exists_squirk(const u16 idVendor,
+						  const u16 idProduct)
+{
+	struct hid_blacklist *ble = NULL;
+	int n = 0;
+
  	for (; hid_blacklist[n].idVendor; n++)
  		if (hid_blacklist[n].idVendor == idVendor &&
  		    hid_blacklist[n].idProduct == idProduct)
-			quirks = hid_blacklist[n].quirks;
+			ble = &hid_blacklist[n];

-	return quirks;
+	if (ble != NULL)
+		dbg("Found squirk 0x%x for USB HID vendor 0x%hx prod 0x%hx\n",
+		    ble->quirks, ble->idVendor, ble->idProduct);
+
+	return ble;
  }
