From: Paul Walmsley <paul@booyaka.com>
Subject: [PATCH 5/6] usbhid: add 'quirks' module parameter
Date: Wed, 11 Apr 2007 13:09:41 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0704111308020.28726@utopia.booyaka.com>
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

Add a 'quirks' module parameter for the usbhid module, so users can
add or modify quirks at module load time.


Signed-off-by: Paul Walmsley <paul@booyaka.com>

---
  Documentation/kernel-parameters.txt |    8 ++++++
  drivers/hid/usbhid/hid-core.c       |   26 +++++++++++++++++++
  drivers/hid/usbhid/hid-quirks.c     |   47 ++++++++++++++++++++++++++++++++++++
  include/linux/hid-quirks.h          |    7 +++--
  4 files changed, 86 insertions(+), 2 deletions(-)

Index: hid/drivers/hid/usbhid/hid-core.c
===================================================================
--- hid.orig/drivers/hid/usbhid/hid-core.c
+++ hid/drivers/hid/usbhid/hid-core.c
@@ -47,6 +47,10 @@

  static char *hid_types[] = {"Device", "Pointer", "Mouse", "Device", "Joystick",
  				"Gamepad", "Keyboard", "Keypad", "Multi-Axis Controller"};
+
+int usbhid_quirks_init(char **quirks_param);
+void usbhid_quirks_exit(void);
+
  /*
   * Module parameters.
   */
@@ -56,6 +60,22 @@ module_param_named(mousepoll, hid_mousep
  MODULE_PARM_DESC(mousepoll, "Polling interval of mice");

  /*
+ * Quirks specified at module load time
+ */
+static char *quirks_param[MAX_USBHID_BOOT_QUIRKS] = { [ 0 ... (MAX_USBHID_BOOT_QUIRKS - 1) ] = NULL };
+
+/*
+ * Example of modload quirks usage: passing "quirks=0xcd5:0x1:0x4" at
+ * boot tells the USB HID driver to ignore (0x4) vendor ID 0x0cd5, product
+ * ID 0x0001.  HID quirk values are defined in include/linux/hid-quirks.h
+ */
+module_param_array_named(quirks, quirks_param, charp, NULL, 0444);
+MODULE_PARM_DESC(quirks, "Add/modify USB HID quirks by specifying "
+		 " quirks=vendorID:productID:quirks"
+		 " where vendorID, productID, and quirks are all in"
+		 " 0x-prefixed hex");
+
+/*
   * Input submission and I/O error handler.
   */

@@ -1107,6 +1127,9 @@ static struct usb_driver hid_driver = {
  static int __init hid_init(void)
  {
  	int retval;
+	retval = usbhid_quirks_init(quirks_param);
+	if (retval)
+		goto usbhid_quirks_init_fail;
  	retval = hiddev_init();
  	if (retval)
  		goto hiddev_init_fail;
@@ -1119,6 +1142,8 @@ static int __init hid_init(void)
  usb_register_fail:
  	hiddev_exit();
  hiddev_init_fail:
+	usbhid_quirks_exit();
+usbhid_quirks_init_fail:
  	return retval;
  }

@@ -1126,6 +1151,7 @@ static void __exit hid_exit(void)
  {
  	usb_deregister(&hid_driver);
  	hiddev_exit();
+	usbhid_quirks_exit();
  }

  module_init(hid_init);
Index: hid/drivers/hid/usbhid/hid-quirks.c
===================================================================
--- hid.orig/drivers/hid/usbhid/hid-quirks.c
+++ hid/drivers/hid/usbhid/hid-quirks.c
@@ -673,3 +673,50 @@ static void usbhid_remove_all_dquirks(vo
  }


+/* Module load/unload hooks for dquirks handling */
+
+/**
+ * usbhid_quirks_init: apply USB HID quirks specified at module load time
+ *
+ * Description:
+ *
+ *
+ * Returns: 0 OK, -error on failure.
+ */
+int usbhid_quirks_init(char **quirks_param)
+{
+	u16 idVendor, idProduct;
+	u32 quirks;
+	int n = 0, m;
+
+	for (; quirks_param[n] && n < MAX_USBHID_BOOT_QUIRKS; n++) {
+
+		m = sscanf(quirks_param[n], "0x%hx:0x%hx:0x%x",
+			   &idVendor, &idProduct, &quirks);
+
+		if (m != 3 ||
+		    usbhid_modify_dquirk(idVendor, idProduct, quirks) != 0) {
+			printk(KERN_WARNING
+			       "Could not parse HID quirk module param %s\n",
+			       quirks_param[n]);
+
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * usbhid_quirks_exit: release memory associated with dynamic_quirks
+ *
+ * Description:
+ *     Release all memory associated with dynamic quirks.  Called upon
+ *     module unload.
+ *
+ * Returns: nothing
+ */
+void usbhid_quirks_exit(void)
+{
+	usbhid_remove_all_dquirks();
+}
+
Index: hid/include/linux/hid-quirks.h
===================================================================
--- hid.orig/include/linux/hid-quirks.h
+++ hid/include/linux/hid-quirks.h
@@ -2,6 +2,11 @@
  #define __HID_QUIRKS_H

  /*
+ * Increase this if you need to configure more HID quirks at module load time
+ */
+#define MAX_USBHID_BOOT_QUIRKS 4
+
+/*
   * HID device quirks.
   */

@@ -33,6 +38,4 @@ u32 usbhid_lookup_quirk(const u16 idVend

  int usbhid_modify_dquirk(const u16 idVendor, const u16 idProduct, const u32 quirks);

-
-
  #endif /* __HID_QUIRKS_H */
Index: hid/Documentation/kernel-parameters.txt
===================================================================
--- hid.orig/Documentation/kernel-parameters.txt
+++ hid/Documentation/kernel-parameters.txt
@@ -1797,6 +1797,14 @@ and is between 256 and 4096 characters.
  	usbhid.mousepoll=
  			[USBHID] The interval which mice are to be polled at.

+	usbhid.quirks=
+			[USBHID] Add, modify, or remove USB HID device quirks.
+			The format is one or more strings of
+			vendorID:productID:quirks format; e.g.,
+			"usbhid.quirks=0xcd4:0x1:0x4" will add
+			a quirk 0x4 (or replace an existing quirk) for
+			vendor 0xcd4 product 0x1.
+
  	vdso=		[IA-32,SH]
  			vdso=1: enable VDSO (default)
  			vdso=0: disable VDSO mapping
