From: Paul Walmsley <paul@booyaka.com>
Subject: [PATCH 7/7] usbhid: add Kconfig option USBHID_PROC_FS
Date: Sun, 18 Mar 2007 22:22:16 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0703182044490.21893@utopia.booyaka.com>
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

Add a Kconfig option USBHID_PROC_FS that controls the appearance of 
/proc/usbhid/device_quirks.


Signed-off-by: Paul Walmsley <paul@booyaka.com>

---
  dev/drivers/usb/input/Kconfig |   26 ++++++++++++++++++++++++++
  1 file changed, 26 insertions(+)

Index: linux/dev/drivers/usb/input/Kconfig
===================================================================
--- linux.orig/dev/drivers/usb/input/Kconfig
+++ linux/dev/drivers/usb/input/Kconfig
@@ -27,6 +27,32 @@ config USB_HID
  comment "Input core support is needed for USB HID input layer or HIDBP support"
  	depends on USB_HID && INPUT=n

+config USBHID_PROC_FS
+	bool "Enable USBHID procfs support"
+	default y
+	depends on USB_HID && PROC_FS
+	help
+	  Say Y here if you want to be able to query and change the
+	  HID "blacklist" at runtime.  This enables the
+	  /proc/usbhid/device_quirks file, which contains a list of all
+	  active USB HID quirks.
+
+	  The list consists of four entries per quirk: a 16-bit USB vendor
+	  ID, a 16-bit USB product ID, a 16-bit product ID mask, and a 32-bit
+	  quirks field.  To update the quirks list, write a string to the
+	  file, e.g.:
+
+	  echo '0xcd4:0x1:0xffff:0x4' > /proc/usbhid/device_quirks
+
+	  If a quirk exists for this (vendor ID, product ID, product mask)
+	  combination, its quirk value will be replaced with 0x4; otherwise,
+ 	  a new quirk will be added.  Quirks may be removed from the list
+	  by using 0x0 for the quirks value.  Quirks values are defined in
+	  include/linux/hid.h.  Multiple product IDs can be covered by
+	  using other values for the product mask.
+
+	  If unsure, say Y.
+
  config USB_HIDINPUT_POWERBOOK
  	bool "Enable support for iBook/PowerBook special keys"
  	default n
