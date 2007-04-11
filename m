From: Paul Walmsley <paul@booyaka.com>
Subject: [PATCH 6/6] usbhid: add configfs USB HID quirk configuration
Date: Wed, 11 Apr 2007 13:03:31 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0704111302070.28726@utopia.booyaka.com>
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

Add support for runtime USB HID quirk configuration via ConfigFS,
after the usbhid module has been loaded.  Also included is support for
dynamic quirk removal.


Signed-off-by: Paul Walmsley <paul@booyaka.com>

---
  drivers/hid/usbhid/Kconfig            |   20 +
  drivers/hid/usbhid/Makefile           |    2
  drivers/hid/usbhid/hid-core.c         |    9
  drivers/hid/usbhid/hid-quirks-cfgfs.c |  484 ++++++++++++++++++++++++++++++++++
  drivers/hid/usbhid/hid-quirks.c       |   33 ++
  include/linux/hid-quirks.h            |    5
  6 files changed, 552 insertions(+), 1 deletion(-)

Index: hid/drivers/hid/usbhid/Kconfig
===================================================================
--- hid.orig/drivers/hid/usbhid/Kconfig
+++ hid/drivers/hid/usbhid/Kconfig
@@ -96,6 +96,26 @@ config ZEROPLUS_FF
  	  Say Y here if you have a Zeroplus based game controller and want to
  	  enable force feedback for it.

+config USB_HID_CONFIGFS
+	bool "Enable runtime configuration of USB HID quirks via ConfigFS"
+	default n
+	depends on USB_HID
+	select CONFIGFS_FS
+	help
+	  Say Y here if you want to be able to add or modify USB HID quirks
+	  at runtime.  When ConfigFS is mounted, the directory
+	  "usbhid/quirks_runtime" will appear.	Making a directory
+	  here in the form "xxxx:yyyy" (where xxxx is the 16-bit USB
+	  vendor ID, and yyyy is the 16-bit USB product ID) will
+	  expose filenames underneath that correspond to different quirks.
+	  The files will contain a 1 if the quirk is enabled; 0 if disabled.
+	  Writing the corresponding digit to a file will either enable
+	  or disable that particular quirk.  A dynamically-created device
+	  directory may be removed via rmdir; this will remove the
+	  dynamic quirk created for that device.
+
+	  If unsure, say N.
+
  config USB_HIDDEV
  	bool "/dev/hiddev raw HID device support"
  	depends on USB_HID
Index: hid/drivers/hid/usbhid/Makefile
===================================================================
--- hid.orig/drivers/hid/usbhid/Makefile
+++ hid/drivers/hid/usbhid/Makefile
@@ -3,7 +3,7 @@
  #

  # Multipart objects.
-usbhid-objs	:= hid-core.o hid-quirks.o
+usbhid-objs	:= hid-core.o hid-quirks.o hid-quirks-cfgfs.o

  # Optional parts of multipart objects.

Index: hid/drivers/hid/usbhid/hid-core.c
===================================================================
--- hid.orig/drivers/hid/usbhid/hid-core.c
+++ hid/drivers/hid/usbhid/hid-core.c
@@ -51,6 +51,9 @@ static char *hid_types[] = {"Device", "P
  int usbhid_quirks_init(char **quirks_param);
  void usbhid_quirks_exit(void);

+int usbhid_cfgfs_init(void);
+void usbhid_cfgfs_exit(void);
+
  /*
   * Module parameters.
   */
@@ -1127,6 +1130,9 @@ static struct usb_driver hid_driver = {
  static int __init hid_init(void)
  {
  	int retval;
+	retval = usbhid_cfgfs_init();
+	if (retval)
+		goto usbhid_cfgfs_init_fail;
  	retval = usbhid_quirks_init(quirks_param);
  	if (retval)
  		goto usbhid_quirks_init_fail;
@@ -1144,6 +1150,8 @@ usb_register_fail:
  hiddev_init_fail:
  	usbhid_quirks_exit();
  usbhid_quirks_init_fail:
+	usbhid_cfgfs_exit();
+usbhid_cfgfs_init_fail:
  	return retval;
  }

@@ -1152,6 +1160,7 @@ static void __exit hid_exit(void)
  	usb_deregister(&hid_driver);
  	hiddev_exit();
  	usbhid_quirks_exit();
+	usbhid_cfgfs_exit();
  }

  module_init(hid_init);
Index: hid/include/linux/hid-quirks.h
===================================================================
--- hid.orig/include/linux/hid-quirks.h
+++ hid/include/linux/hid-quirks.h
@@ -8,6 +8,10 @@

  /*
   * HID device quirks.
+ *
+ * Any changes made to this list should also be applied to
+ * drivers/hid/usbhid/hid-quirks-cfgfs.c:hid_quirk_types[]
+ *
   */

  #define HID_QUIRK_INVERT			0x00000001
@@ -37,5 +41,6 @@
  u32 usbhid_lookup_quirk(const u16 idVendor, const u16 idProduct);

  int usbhid_modify_dquirk(const u16 idVendor, const u16 idProduct, const u32 quirks);
+int usbhid_remove_dquirk(const u16 idVendor, const u16 idProduct);

  #endif /* __HID_QUIRKS_H */
Index: hid/drivers/hid/usbhid/hid-quirks.c
===================================================================
--- hid.orig/drivers/hid/usbhid/hid-quirks.c
+++ hid/drivers/hid/usbhid/hid-quirks.c
@@ -652,6 +652,39 @@ int usbhid_modify_dquirk(const u16 idVen


  /**
+ * usbhid_remove_dquirk: remove a runtime HID quirk from memory.
+ * @idVendor: the 16-bit USB vendor ID, in native byteorder
+ * @idProduct: the 16-bit USB product ID, in native byteorder
+ *
+ * Returns: 0 OK, -ENOENT if the entry could not be found.
+ */
+int usbhid_remove_dquirk(const u16 idVendor, const u16 idProduct)
+{
+	struct quirks_list_struct *q, *temp;
+	int ret = -ENOENT;
+
+	WARN_ON(idVendor == 0);
+
+	down_write(&dquirks_rwsem);
+
+        list_for_each_entry_safe(q, temp, &dquirks_list, node) {
+		if (q->hid_bl_item.idVendor == idVendor &&
+		    q->hid_bl_item.idProduct == idProduct) {
+
+			list_del(&q->node);
+			kfree(q);
+			ret = 0;
+
+		}
+	}
+
+	up_write(&dquirks_rwsem);
+
+	return ret;
+}
+
+
+/**
   * usbhid_remove_all_dquirks: remove all runtime HID quirks from memory
   *
   * Description:
Index: hid/drivers/hid/usbhid/hid-quirks-cfgfs.c
===================================================================
--- /dev/null
+++ hid/drivers/hid/usbhid/hid-quirks-cfgfs.c
@@ -0,0 +1,484 @@
+/*
+ *  USB HID dynamic quirks ConfigFS support for Linux
+ *
+ *  Copyright (c) 2007 Paul Walmsley
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+#include <asm/types.h>        /* for u32, u16 */
+#include <linux/slab.h>       /* for kmalloc/kfree */
+#include <linux/kernel.h>     /* for ARRAY_SIZE */
+#include <linux/limits.h>     /* for NAME_MAX */
+#include <linux/configfs.h>
+
+#include <linux/hid.h>
+#include <linux/hid-debug.h>
+#include <linux/hid-quirks.h>
+#include "usbhid.h"
+
+#ifdef CONFIG_USB_HID_CONFIGFS
+
+/*
+ * ConfigFS attribute filenames for each HID quirk.  Any changes
+ * made here should also be applied to include/linux/hid-quirks.h.
+ */
+
+static struct hid_quirk_type {
+	u32 quirk;
+	struct configfs_attribute ca;
+} hid_quirk_types[] = {
+	{
+		.quirk = HID_QUIRK_INVERT,
+		.ca = {
+			.ca_name = "invert",
+			.ca_mode = S_IRUGO | S_IWUSR,
+			.ca_owner = THIS_MODULE,
+		},
+	},
+	{
+		.quirk = HID_QUIRK_NOTOUCH,
+		.ca = {
+			.ca_name = "notouch",
+			.ca_mode = S_IRUGO | S_IWUSR,
+			.ca_owner = THIS_MODULE,
+		},
+	},
+	{
+		.quirk = HID_QUIRK_IGNORE,
+		.ca = {
+			.ca_name = "ignore",
+			.ca_mode = S_IRUGO | S_IWUSR,
+			.ca_owner = THIS_MODULE,
+		},
+	},
+	{
+		.quirk = HID_QUIRK_NOGET,
+		.ca = {
+			.ca_name = "noget",
+			.ca_mode = S_IRUGO | S_IWUSR,
+			.ca_owner = THIS_MODULE,
+		},
+	},
+	{
+		.quirk = HID_QUIRK_HIDDEV,
+		.ca = {
+			.ca_name = "hiddev",
+			.ca_mode = S_IRUGO | S_IWUSR,
+			.ca_owner = THIS_MODULE,
+		},
+	},
+	{
+		.quirk = HID_QUIRK_BADPAD,
+		.ca = {
+			.ca_name = "badpad",
+			.ca_mode = S_IRUGO | S_IWUSR,
+			.ca_owner = THIS_MODULE,
+		},
+	},
+	{
+		.quirk = HID_QUIRK_MULTI_INPUT,
+		.ca = {
+			.ca_name = "multi_input",
+			.ca_mode = S_IRUGO | S_IWUSR,
+			.ca_owner = THIS_MODULE,
+		},
+	},
+	{
+		.quirk = HID_QUIRK_2WHEEL_MOUSE_HACK_7,
+		.ca = {
+			.ca_name = "2wheel_mouse_hack_7",
+			.ca_mode = S_IRUGO | S_IWUSR,
+			.ca_owner = THIS_MODULE,
+		},
+	},
+	{
+		.quirk = HID_QUIRK_2WHEEL_MOUSE_HACK_5,
+		.ca = {
+			.ca_name = "2wheel_mouse_hack_5",
+			.ca_mode = S_IRUGO | S_IWUSR,
+			.ca_owner = THIS_MODULE,
+		},
+	},
+	{
+		.quirk = HID_QUIRK_2WHEEL_MOUSE_HACK_ON,
+		.ca = {
+			.ca_name = "2wheel_mouse_hack_on",
+			.ca_mode = S_IRUGO | S_IWUSR,
+			.ca_owner = THIS_MODULE,
+		},
+	},
+	{
+		.quirk = HID_QUIRK_MIGHTYMOUSE,
+		.ca = {
+			.ca_name = "mightymouse",
+			.ca_mode = S_IRUGO | S_IWUSR,
+			.ca_owner = THIS_MODULE,
+		},
+	},
+	{
+		.quirk = HID_QUIRK_CYMOTION,
+		.ca = {
+			.ca_name = "cymotion",
+			.ca_mode = S_IRUGO | S_IWUSR,
+			.ca_owner = THIS_MODULE,
+		},
+	},
+	{
+		.quirk = HID_QUIRK_POWERBOOK_HAS_FN,
+		.ca = {
+			.ca_name = "powerbook_has_fn",
+			.ca_mode = S_IRUGO | S_IWUSR,
+			.ca_owner = THIS_MODULE,
+		},
+	},
+	{
+		.quirk = HID_QUIRK_POWERBOOK_FN_ON,
+		.ca = {
+			.ca_name = "powerbook_fn_on",
+			.ca_mode = S_IRUGO | S_IWUSR,
+			.ca_owner = THIS_MODULE,
+		},
+	},
+	{
+		.quirk = HID_QUIRK_INVERT_HWHEEL,
+		.ca = {
+			.ca_name = "invert_hwheel",
+			.ca_mode = S_IRUGO | S_IWUSR,
+			.ca_owner = THIS_MODULE,
+		},
+	},
+	{
+		.quirk = HID_QUIRK_POWERBOOK_ISO_KEYBOARD,
+		.ca = {
+			.ca_name = "powerbook_iso_keyboard",
+			.ca_mode = S_IRUGO | S_IWUSR,
+			.ca_owner = THIS_MODULE,
+		},
+	},
+	{
+		.quirk = HID_QUIRK_BAD_RELATIVE_KEYS,
+		.ca = {
+			.ca_name = "bad_relative_keys",
+			.ca_mode = S_IRUGO | S_IWUSR,
+			.ca_owner = THIS_MODULE,
+		},
+	},
+	{
+		.quirk = HID_QUIRK_SKIP_OUTPUT_REPORTS,
+		.ca = {
+			.ca_name = "skip_output_reports",
+			.ca_mode = S_IRUGO | S_IWUSR,
+			.ca_owner = THIS_MODULE,
+		},
+	},
+	{
+		.quirk = HID_QUIRK_IGNORE_MOUSE,
+		.ca = {
+			.ca_name = "ignore_mouse",
+			.ca_mode = S_IRUGO | S_IWUSR,
+			.ca_owner = THIS_MODULE,
+		},
+	},
+	{
+		.quirk = HID_QUIRK_SONY_PS3_CONTROLLER,
+		.ca = {
+			.ca_name = "sony_ps3_controller",
+			.ca_mode = S_IRUGO | S_IWUSR,
+			.ca_owner = THIS_MODULE,
+		},
+	},
+	{
+		.quirk = HID_QUIRK_LOGITECH_DESCRIPTOR,
+		.ca ={
+			.ca_name = "logitech_descriptor",
+			.ca_mode = S_IRUGO | S_IWUSR,
+			.ca_owner = THIS_MODULE,
+		},
+	},
+	{
+		.quirk = HID_QUIRK_DUPLICATE_USAGES,
+		.ca = {
+			.ca_name = "duplicate_usages",
+			.ca_mode = S_IRUGO | S_IWUSR,
+			.ca_owner = THIS_MODULE,
+		},
+	},
+	{
+		.quirk = HID_QUIRK_RESET_LEDS,
+		.ca = {
+			.ca_name = "reset_leds",
+			.ca_mode = S_IRUGO | S_IWUSR,
+			.ca_owner = THIS_MODULE,
+		},
+	},
+	{
+		.quirk = 0,
+	}
+};
+
+
+static int hid_parse_dev_fname(const char *name,
+			       u16 *idVendor,
+			       u16 *idProduct)
+{
+	char cmp_name[NAME_MAX];
+
+  	WARN_ON(sizeof(unsigned short) != 2);
+
+	WARN_ON(idVendor == NULL);
+	WARN_ON(idProduct == NULL);
+
+	if (strlen(name) != strlen("xxxx:yyyy")) {
+		dbg("Invalid name - cannot parse device directory name");
+		return -EINVAL;
+	}
+
+	if (sscanf(name, "%hx:%hx", idVendor, idProduct) != 2) {
+		dbg("Invalid name - cannot parse device directory name");
+		return -EINVAL;
+	}
+
+	snprintf(cmp_name, NAME_MAX, "%04hx:%04hx", *idVendor, *idProduct);
+
+	if (strcmp(cmp_name, name) != 0) {
+		dbg("Invalid name - cannot parse device directory name");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+
+static u32 find_quirk_bits_by_name(const char *name)
+{
+	int n;
+
+	for (n = 0; hid_quirk_types[n].quirk; n++)
+		if (strcmp(hid_quirk_types[n].ca.ca_name, name) == 0)
+			break;
+
+	return (hid_quirk_types[n].quirk) ? hid_quirk_types[n].quirk : 0;
+}
+
+
+/* "/usbhid/quirks_runtime/<device>" configfs code and data */
+
+
+struct device_cfgfs_group {
+	struct config_group group;
+	u16 idVendor;
+	u16 idProduct;
+};
+
+static struct device_cfgfs_group *to_device_cfgfs_group(struct config_item *item)
+{
+	return item ? container_of(to_config_group(item), struct device_cfgfs_group, group) : NULL;
+}
+
+static ssize_t device_cfgfs_show_attr(struct config_item *pitem,
+				      struct configfs_attribute *attr,
+				      char *page)
+{
+	u32 quirk, quirk_bits;
+	u16 idVendor, idProduct;
+
+	idVendor = to_device_cfgfs_group(pitem)->idVendor;
+	idProduct = to_device_cfgfs_group(pitem)->idProduct;
+	BUG_ON(idVendor == 0);
+
+	quirk_bits = find_quirk_bits_by_name(attr->ca_name);
+	BUG_ON(quirk_bits == 0);
+
+	quirk = usbhid_lookup_quirk(idVendor, idProduct) & quirk_bits;
+
+	page[0] = (quirk == 0) ? '0' : '1';
+
+	return 1;
+}
+
+
+static ssize_t device_cfgfs_store_attr(struct config_item *pitem,
+				       struct configfs_attribute *attr,
+				       const char *page, size_t len)
+{
+	u32 quirks, quirk_bits;
+	u16 idVendor, idProduct;
+
+	idVendor = to_device_cfgfs_group(pitem)->idVendor;
+	idProduct = to_device_cfgfs_group(pitem)->idProduct;
+	BUG_ON(idVendor == 0);
+
+	quirk_bits = find_quirk_bits_by_name(attr->ca_name);
+	BUG_ON(quirk_bits == 0);
+
+	quirks = usbhid_lookup_quirk(idVendor, idProduct);
+
+	if (page[0] == '0') {
+		quirks &= ~quirk_bits;
+	} else if (page[0] == '1') {
+		quirks |= quirk_bits;
+	} else {
+		dbg("Invalid quirks format");
+		return -EINVAL;
+	}
+
+	if (usbhid_modify_dquirk(idVendor, idProduct, quirks) != 0) {
+		dbg("Could not modify dquirks list");
+		return -EINVAL;
+	}
+
+	return len;
+}
+
+
+static void device_cfgfs_release(struct config_item *item)
+{
+	struct device_cfgfs_group *dg;
+
+	dg = to_device_cfgfs_group(item);
+
+	WARN_ON(dg->idVendor == 0);
+
+	usbhid_remove_dquirk(dg->idVendor, dg->idProduct);
+
+	kfree(dg);
+}
+
+
+static struct configfs_item_operations device_cfgfs_iops = {
+	.show_attribute  = &device_cfgfs_show_attr,
+	.store_attribute = &device_cfgfs_store_attr,
+	.release         = &device_cfgfs_release
+};
+
+static struct config_item_type device_cfgfs_itype = {
+	.ct_item_ops = &device_cfgfs_iops,
+	.ct_owner    = THIS_MODULE
+};
+
+
+/* "/usbhid/quirks_runtime" configfs code and data */
+
+/* Called upon device quirk add via mkdir() */
+static struct config_group *qrt_cfgfs_make_group(struct config_group *pgroup,
+						 const char *name)
+{
+	struct device_cfgfs_group *dg;
+	u16 idVendor, idProduct;
+
+	/* The directory name created here must match
+	 * a particular pattern: hex two-byte vendor ID, colon, hex
+	 * two-byte product ID. */
+	if (hid_parse_dev_fname(name, &idVendor, &idProduct) != 0)
+		return NULL;
+
+	dg = kzalloc(sizeof(struct device_cfgfs_group), GFP_KERNEL);
+	if (!dg) {
+		dbg("Cannot allocate struct device_cfgfs_group");
+		return NULL;
+	}
+
+	config_group_init_type_name(&dg->group, name, &device_cfgfs_itype);
+
+	dg->idVendor = idVendor;
+	dg->idProduct = idProduct;
+
+	return &dg->group;
+}
+
+
+static struct configfs_group_operations qrt_cfgfs_gops = {
+	.make_group = &qrt_cfgfs_make_group
+};
+
+static struct config_item_type qrt_cfgfs_type = {
+	.ct_group_ops = &qrt_cfgfs_gops,
+	.ct_owner     = THIS_MODULE,
+};
+
+static struct config_group qrt_cfgfs_group = {
+	.cg_item = {
+		.ci_namebuf = "quirks_runtime",
+		.ci_type    = &qrt_cfgfs_type
+	}
+};
+
+/* "/usbhid" cfgfs subsystem */
+
+static struct config_group *hid_cfgfs_default_groups[] = {
+	&qrt_cfgfs_group,
+	NULL
+};
+
+static struct config_item_type hid_cfgfs_itype = {
+	.ct_owner    = THIS_MODULE
+};
+
+static struct configfs_subsystem hid_cfgfs_subsys = {
+	.su_group = {
+		.cg_item = {
+			 .ci_namebuf = "usbhid",
+			 .ci_type = &hid_cfgfs_itype
+		 },
+		.default_groups = hid_cfgfs_default_groups
+	},
+};
+
+
+int usbhid_cfgfs_init(void)
+{
+	struct configfs_attribute **ca;
+	int err = 0;
+	int n = 0;
+
+	/*
+	 * Dynamically allocate ConfigFS attributes from
+	 * hid_quirk_types[]
+	 */
+
+	ca = kzalloc(sizeof(struct configfs_attribute *) *
+		     ARRAY_SIZE(hid_quirk_types), GFP_KERNEL);
+	if (!ca) {
+		dbg("Cannot allocate cfgfs attribute array");
+		return -ENOMEM;
+	}
+
+	for (; hid_quirk_types[n].quirk; n++)
+		ca[n] = &hid_quirk_types[n].ca;
+
+	device_cfgfs_itype.ct_attrs = ca;
+
+	/* standard configfs init follows */
+
+	config_group_init(&qrt_cfgfs_group);
+	config_group_init(&hid_cfgfs_subsys.su_group);
+	init_MUTEX(&hid_cfgfs_subsys.su_sem);
+	err = configfs_register_subsystem(&hid_cfgfs_subsys);
+	if (err) {
+		printk(KERN_ERR "Error %d while registering cfgfs subsystem\n",
+		       err);
+		kfree(ca);
+	}
+
+	return err;
+}
+
+void usbhid_cfgfs_exit(void)
+{
+	configfs_unregister_subsystem(&hid_cfgfs_subsys);
+	kfree(device_cfgfs_itype.ct_attrs);
+}
+
+#else
+
+int usbhid_cfgfs_init(void) { return 0; }
+void usbhid_cfgfs_exit(void) {}
+
+#endif /* CONFIG_USB_HID_CONFIGFS */
+
